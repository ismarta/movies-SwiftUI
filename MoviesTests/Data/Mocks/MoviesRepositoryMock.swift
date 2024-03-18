//
//  MoviesRepositoryMock.swift
//  MoviesTests
//
//  Created by Marta on 8/3/24.
//

import Foundation
import Combine
@testable import Movies

class MoviesRepositoryMock: MoviesRepository {
    let movies: [Movie]
    let favoriteMovies: [Movie]
    let simulateError: Bool
    let simulateFavoriteError: Bool
    var getTrendingMoviesCalled = false
    var getFavoriteMoviesCalled = false
    var saveFavorieMovieCalled = false
    var deleteFavoriteMovieCalled = false

    init(movies: [Movie], favoriteMovies: [Movie] = [], simulateError: Bool, simulateFavoriteError: Bool = false) {
        self.movies = movies
        self.simulateError = simulateError
        self.favoriteMovies = favoriteMovies
        self.simulateFavoriteError = simulateFavoriteError
    }

    func getTrendingMovies(timeWindow: String, language: String) -> AnyPublisher<[Movies.Movie], Movies.ServiceError> {
        getTrendingMoviesCalled = true
        if simulateError {
            return Fail(error: Movies.ServiceError.decode)
                .eraseToAnyPublisher()
        } else {
            return Just(movies)
                .setFailureType(to: Movies.ServiceError.self)
                .eraseToAnyPublisher()
        }
    }

    func saveFavoriteMovie(_ movie: Movies.Movie) -> AnyPublisher<Bool, Movies.ServiceError> {
        saveFavorieMovieCalled = true
        return Just(true)
            .setFailureType(to: Movies.ServiceError.self)
            .eraseToAnyPublisher()
    }

    func getFavoriteMovies() -> AnyPublisher<[Movies.Movie], Movies.ServiceError> {
        getFavoriteMoviesCalled = true
        if simulateFavoriteError {
            return Fail(error: Movies.ServiceError.decode)
                .eraseToAnyPublisher()
        } else {
            return Just(favoriteMovies)
                .setFailureType(to: Movies.ServiceError.self)
                .eraseToAnyPublisher()
        }
    }

    func deleteFavoriteMovieBy(identifier: Int) -> AnyPublisher<Bool, Movies.ServiceError> {
        deleteFavoriteMovieCalled = true
        return Just(true)
            .setFailureType(to: Movies.ServiceError.self)
            .eraseToAnyPublisher()
    }
}
