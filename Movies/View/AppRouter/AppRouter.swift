//
//  AppRouter.swift
//  Movies
//
//  Created by Marta on 13/3/24.
//

import Foundation
import UIKit

class AppRouter {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showInitialScreen() {
        let moviesListViewController: MoviesListViewController = MoviesListAssemblerInjection().resolve(router: self)
        navigationController.setViewControllers([moviesListViewController], animated: false)
    }

    func showMovieDetailScreen(with movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) {
        let movieDetailViewController: MovieDetailViewController = MovieDetailAssemblerInjection().resolve(router: self, movie: movie, favoriteStatusDelegate: favoriteStatusDelegate)
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
    
}
