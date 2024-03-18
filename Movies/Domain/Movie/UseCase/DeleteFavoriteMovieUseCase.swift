//
//  DeleteFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//

import Foundation
import Combine

class DeleteFavoriteMovieUseCase {
    let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }

    func execute(idMovie: Int) -> AnyPublisher<Bool,ServiceError> {
        moviesRepository.deleteFavoriteMovieBy(identifier: idMovie)
    }
}
