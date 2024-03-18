//
//  MoviesListViewModelTests.swift
//  MoviesTests
//
//  Created by Marta on 17/3/24.
//

import XCTest
@testable import Movies

final class MoviesListViewModelTests: XCTestCase {
    func testShowEmptyView() {
        //GIVEN
        let moviesListViewModel = getMoviesListViewModel(moviesResult: [], simulateError: false)
        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        moviesListViewModel.loadMovies()
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertEqual(moviesListViewModel.statusView, StatusView.error(MoviesListViewModel.emptyViewMessage, nil))
    }

    func testShowMoviesListView() {
        //GIVEN
        let moviesResult = [MovieEntityMock.givenAMovie(identifier: 1),MovieEntityMock.givenAMovie(identifier: 2), MovieEntityMock.givenAMovie(identifier: 3)]
        let moviesListViewModel = getMoviesListViewModel(moviesResult: moviesResult, simulateError: false)
        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        moviesListViewModel.loadMovies()
            XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertEqual(moviesListViewModel.statusView, StatusView.success)
        XCTAssertEqual(moviesListViewModel.movies.count, moviesResult.count)
    }
    func testShowErrorView() {
        //GIVEN
        let moviesResult: [Movie] = []
        let moviesListViewModel = getMoviesListViewModel(moviesResult: moviesResult, simulateError: true)
        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        moviesListViewModel.loadMovies()
            XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertEqual(moviesListViewModel.statusView, StatusView.error(MoviesListViewModel.errorViewMessage, MoviesListViewModel.retryButtonText))
       }

    private func getMoviesListViewModel(moviesResult: [Movie] = [], simulateError: Bool = false) -> MoviesListViewModel {
        let appRouterMock = AppRouterMock(navigationController: UINavigationController())
        let moviesRepositoryMock = MoviesRepositoryMock(movies: moviesResult, simulateError: simulateError)
        let getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase = GetTrendingMoviesWithFavoriteStatusUseCase(moviesRepository: moviesRepositoryMock)
        let saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase = SaveFavoriteMovieUseCase(moviesRepository: moviesRepositoryMock)
        let deleteFavoriteMovieUseCase: DeleteFavoriteMovieUseCase = DeleteFavoriteMovieUseCase(moviesRepository: moviesRepositoryMock)
        let moviesListViewModel = MoviesListViewModel(router: appRouterMock, getTrendingMoviesWithFavoriteStatusUseCase: getTrendingMoviesWithFavoriteStatusUseCase, saveFavoriteMovieUseCase: saveFavoriteMovieUseCase, deleteFavoriteMovieUseCase: deleteFavoriteMovieUseCase)
            return moviesListViewModel
    }
}
