//
//  MoviesRepository.swift
//  Movies
//
//  Created by Marta on 6/3/24.
//

import Foundation
import Combine

protocol MoviesRepository {
    func getTrendingMovies(timeWindow: String, language: String) -> AnyPublisher<[Movie], ServiceError>
    func saveFavoriteMovie(_ movie: Movie) ->  AnyPublisher<Bool, ServiceError>
    func getFavoriteMovies() ->  AnyPublisher<[Movie], ServiceError>
    func deleteFavoriteMovieBy(identifier: Int) ->  AnyPublisher<Bool, ServiceError>
}
