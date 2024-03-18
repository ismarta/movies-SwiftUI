//
//  GetTrendingMoviesWithFavoriteStatusUseCase.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//

import Foundation
import Combine

class GetTrendingMoviesWithFavoriteStatusUseCase {
    let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(timeWindow: String = "day", language: String = "en-US") -> AnyPublisher<[Movie],ServiceError> {
        let moviesPublisher = moviesRepository.getTrendingMovies(timeWindow: timeWindow, language: language)
        let favoritesPublisher = moviesRepository.getFavoriteMovies()
        return Publishers.CombineLatest(moviesPublisher, favoritesPublisher)
                .map { movies, favoriteMovies in
                    movies.updateFavoriteStatus(with: favoriteMovies)
                }.eraseToAnyPublisher()
    }
}
