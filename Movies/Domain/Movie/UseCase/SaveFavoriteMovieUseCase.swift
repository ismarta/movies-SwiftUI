//
//  SaveFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//

import Foundation
import Combine

class SaveFavoriteMovieUseCase {
    let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(movie: Movie) -> AnyPublisher<Bool,ServiceError> {
        moviesRepository.saveFavoriteMovie(movie)
    }
}
