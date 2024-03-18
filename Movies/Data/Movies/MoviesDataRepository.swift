//
//  MoviesDataRepository.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation
import Combine

class MoviesDataRepository: MoviesRepository {
    let moviesRemoteDataSource: MoviesRemoteDataSource
    let moviesLocalDataSource: MoviesLocalDataSource

    init(moviesRemoteDataSource: MoviesRemoteDataSource, moviesLocalDataSource: MoviesLocalDataSource) {
        self.moviesRemoteDataSource = moviesRemoteDataSource
        self.moviesLocalDataSource = moviesLocalDataSource
    }

    func getTrendingMovies(timeWindow: String, language: String) -> AnyPublisher<[Movie], ServiceError> {
        moviesRemoteDataSource.getTrendingMovies(timeWindow: timeWindow, language: language)
    }

    func saveFavoriteMovie(_ movie: Movie) ->  AnyPublisher<Bool, ServiceError>
    {
        moviesLocalDataSource.saveFavoriteMovie(movie)
    }

    func getFavoriteMovies() ->  AnyPublisher<[Movie], ServiceError> {
        moviesLocalDataSource.getFavoriteMovies()
    }

    func deleteFavoriteMovieBy(identifier: Int) ->  AnyPublisher<Bool, ServiceError> {
        moviesLocalDataSource.deleteFavoriteMovieBy(identifier: identifier)
    }
}
