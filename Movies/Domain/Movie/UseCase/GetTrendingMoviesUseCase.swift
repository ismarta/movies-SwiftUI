//
//  GetTrendingMoviesUseCase.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation
import Combine

class GetTrendingMoviesUseCase {
    let moviesRepository: MoviesRepository

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func execute(timeWindow: String = "day", language: String = "en-US") -> AnyPublisher<[Movie],ServiceError> {
        moviesRepository.getTrendingMovies(timeWindow: timeWindow, language: language)
    }
}
