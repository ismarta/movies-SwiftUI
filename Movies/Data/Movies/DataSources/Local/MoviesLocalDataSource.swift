//
//  MoviesLocalDataSource.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//

import Foundation
import Combine
import CoreData

class MoviesLocalDataSource: MoviesDataSource {
    func getTrendingMovies(timeWindow: String, language: String) -> AnyPublisher<[Movie], ServiceError> {
        Just([])
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }
    
    func saveFavoriteMovie(_ movie: Movie) -> AnyPublisher<Bool, ServiceError> {
        Future<Bool, ServiceError> { promise in
                DataController.shared.persistentContainer.performBackgroundTask { context in
                    do {
                        movie.insert(into: context)
                        try context.save()
                        promise(.success(true))
                    } catch {
                        promise(.failure(.unknown(error)))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getFavoriteMovies() -> AnyPublisher<[Movie], ServiceError> {
        Future<[Movie], ServiceError> { promise in
            DataController.shared.persistentContainer.performBackgroundTask { context  in
                let fetchRequest: NSFetchRequest<MovieLocalEntity> = MovieLocalEntity.fetchRequest()
                do {
                    let fetchedMoviesLocal = try context.fetch(fetchRequest)
                    let movies: [Movie] = fetchedMoviesLocal.compactMap {
                        return $0.transformToDomain()
                    }
                    promise(.success(movies))
                } catch {
                    promise(.failure(.unknown(error)))
                    fatalError("Failed to get favorites movies: \(error)")
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFavoriteMovieBy(identifier: Int) -> AnyPublisher<Bool, ServiceError> {
        Future<Bool, ServiceError> { promise in
            DataController.shared.persistentContainer.performBackgroundTask { context  in
                let fetchRequest: NSFetchRequest<MovieLocalEntity> = MovieLocalEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "identifier == \(identifier)")
                do {
                    let result = try context.fetch(fetchRequest)
                    if let movieLocal = result.first {
                        context.delete(movieLocal)
                        try context.save()
                        DispatchQueue.main.async {
                            promise(.success(true))
                        }
                    } else {
                        DispatchQueue.main.async {
                            promise(.success(false))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        promise(.failure(.unknown(error)))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension Movie {
    func insert(into context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<MovieLocalEntity> = MovieLocalEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == \(identifier)")
        let result = try? context.fetch(fetchRequest)
        guard let resultIsEmpty = result?.isEmpty else {return}
        if result == nil || resultIsEmpty {
            guard let entity = NSEntityDescription.entity(forEntityName: String(describing: MovieLocalEntity.self), in: context) else {return}
            let movieManagedObject = NSManagedObject(entity: entity, insertInto: context)
            movieManagedObject.setValue(identifier, forKey: "identifier")
            movieManagedObject.setValue(title, forKeyPath: "title")
            movieManagedObject.setValue(voteAverage, forKeyPath: "voteAverage")
            movieManagedObject.setValue(voteCount, forKeyPath: "voteCount")
            movieManagedObject.setValue(originalLanguage, forKeyPath: "originalLanguage")
            movieManagedObject.setValue(overview, forKeyPath: "overview")
        } else {
            print("Object exists!!")
        }
    }
}
