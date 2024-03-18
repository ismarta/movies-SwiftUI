//
//  GetFavoriteMoviesUseCase.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//

import Foundation
import Combine

class GetFavoriteMoviesUseCase {
    let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute() -> AnyPublisher<[Movie],ServiceError> {
        moviesRepository.getFavoriteMovies()
    }
}
