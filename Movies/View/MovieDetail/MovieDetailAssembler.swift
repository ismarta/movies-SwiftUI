//
//  MovieDetailAssembler.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation

protocol MovieDetailAssembler: FavoritesAssembler {
    func resolve(router: AppRouter, movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) -> MovieDetailViewController
    func resolve(ui: MovieDetailUI, movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) -> MovieDetailPresenter
}

extension MovieDetailAssembler {
    func resolve(router: AppRouter, movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) -> MovieDetailViewController {
        let movieDetailViewController = MovieDetailViewController(router: router, nibName: "MovieDetailViewController", bundle: nil)
        movieDetailViewController.presenter = resolve(ui: movieDetailViewController, movie: movie, favoriteStatusDelegate: favoriteStatusDelegate)

        return movieDetailViewController
    }

    func resolve(ui: MovieDetailUI, movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) -> MovieDetailPresenter {
        let presenter = MovieDetailPresenter(ui: ui, movie: movie, saveFavoriteMovieUseCase: resolve(), deleteFavoriteMovieUseCase: resolve())
        presenter.favoriteStatusDelegate = favoriteStatusDelegate
        return presenter
    }
}

class MovieDetailAssemblerInjection: MovieDetailAssembler {}
