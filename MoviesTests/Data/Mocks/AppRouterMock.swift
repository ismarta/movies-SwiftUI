//
//  AppRouterMock.swift
//  MoviesTests
//
//  Created by ApiKey on 17/3/24.
//

import Foundation
@testable import Movies

class AppRouterMock: AppRouter {
    var showMovieDetailScreenCall = false
    override func showMovieDetailScreen(with movie: Movie, favoriteStatusDelegate: FavoriteStatusDelegate) {
        showMovieDetailScreenCall = true
    }
}
