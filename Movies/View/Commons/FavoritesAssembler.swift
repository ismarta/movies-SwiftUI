//
//  FavoritesAssembler.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation

protocol FavoritesAssembler {
    func resolve() -> SaveFavoriteMovieUseCase
    func resolve() -> DeleteFavoriteMovieUseCase
    func resolve() -> MoviesDataRepository
    func resolve() -> MoviesRemoteDataSource
    func resolve() -> MoviesLocalDataSource
}


extension FavoritesAssembler {
    func resolve() -> SaveFavoriteMovieUseCase {
        SaveFavoriteMovieUseCase(moviesRepository: resolve())
    }

    func resolve() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(moviesRepository: resolve())
    }

    func resolve() -> MoviesDataRepository {
        MoviesDataRepository(moviesRemoteDataSource: resolve(), moviesLocalDataSource: resolve())
    }

    func resolve() -> MoviesRemoteDataSource {
        MoviesRemoteDataSource()
    }

    func resolve() -> MoviesLocalDataSource {
        MoviesLocalDataSource()
    }
}
