//
//  MoviesListAssembler.swift
//  Movies
//
//  Created by Marta on 8/3/24.
//

import Foundation

protocol MoviesListAssembler: FavoritesAssembler {
    func resolve(router: AppRouter) -> MoviesListViewController
    func resolve(router: AppRouter) -> MoviesListViewModel
}

extension MoviesListAssembler {
    func resolve(router: AppRouter) -> MoviesListViewController {
        let moviesListViewController = MoviesListViewController(router: router, nibName: "MoviesListViewController", bundle: nil)
        moviesListViewController.viewModel = resolve(router: router)
        return moviesListViewController
    }

    func resolve(router: AppRouter) -> MoviesListViewModel {
        MoviesListViewModel(router: router, getTrendingMoviesWithFavoriteStatusUseCase: resolve(), saveFavoriteMovieUseCase: resolve(), deleteFavoriteMovieUseCase: resolve())
    }

    func resolve() -> GetTrendingMoviesWithFavoriteStatusUseCase {
        GetTrendingMoviesWithFavoriteStatusUseCase(moviesRepository: resolve())
    }
}

class MoviesListAssemblerInjection: MoviesListAssembler {}
