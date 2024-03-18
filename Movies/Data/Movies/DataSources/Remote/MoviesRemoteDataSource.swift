//
//  MoviesRemoteDataSource.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation
import Combine

class MoviesRemoteDataSource: MoviesDataSource {
    func getTrendingMovies(timeWindow: String, language: String) -> AnyPublisher<[Movie], ServiceError>  {
        let publisher: AnyPublisher<MoviesResponseRemoteEntity, ServiceError> = MoviesApi.getTrendingMovies(1, timeWindow, language).buildRequestPublisher()
        let transformedPublisher = publisher.map { response in
            return response.results.transformToDomain()
        }
        return transformedPublisher.eraseToAnyPublisher()
    }

    func saveFavoriteMovie(_ movie: Movie) -> AnyPublisher<Bool, ServiceError> {
        Just(false)
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }

    func getFavoriteMovies() -> AnyPublisher<[Movie], ServiceError> {
        Just([])
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }

    func deleteFavoriteMovieBy(identifier: Int) -> AnyPublisher<Bool, ServiceError> {
        Just(false)
            .setFailureType(to: ServiceError.self)
            .eraseToAnyPublisher()
    }
}
