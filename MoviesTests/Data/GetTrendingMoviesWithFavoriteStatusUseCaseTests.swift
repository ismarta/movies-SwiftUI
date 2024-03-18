//
//  GetTrendingMoviesWithFavoriteStatusUseCaseTests.swift
//  MoviesTests
//
//  Created by Marta on 14/3/24.
//

import XCTest
@testable import Movies

final class GetTrendingFaoritesMoviesWithSuccesTests: XCTestCase {
    func testGetTrendingMoviesWithFavoriteStatusUpdated() throws {
        //GIVEN
        let movie1 = MovieEntityMock.givenAMovie(identifier: 1)
        let movie2 = MovieEntityMock.givenAMovie(identifier: 2)
        let movie3 = MovieEntityMock.givenAMovie(identifier: 3)
        let movie4 = MovieEntityMock.givenAMovie(identifier: 4)
        let movie5 = MovieEntityMock.givenAMovie(identifier: 5)

        var movieFavorite1 = movie2
        movieFavorite1.isFavorite = true
        var movieFavorite2 = movie4
        movieFavorite2.isFavorite = true

        var callFinished = false
        var receivedValue: Bool = false
        var receivedError: Movies.ServiceError? = nil
        var moviesResult: [Movie] = []

        let trendingMovies = [movie1, movie2, movie3, movie4, movie5]
        let favoriteMovies = [movieFavorite1, movieFavorite2]
        let simulateError = false
        let moviesRepositoryMock = MoviesRepositoryMock(movies: trendingMovies, favoriteMovies: favoriteMovies, simulateError: simulateError)
        let getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase = GetTrendingMoviesWithFavoriteStatusUseCase(moviesRepository: moviesRepositoryMock)

        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        _ = getTrendingMoviesWithFavoriteStatusUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        callFinished = true
                    case .failure(let error):
                        receivedError = error
                    }
               }, receiveValue: { movies in
                   moviesResult = movies
                   receivedValue = true
               })
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertTrue(callFinished, "Solicitud completada exitosamente")
        XCTAssertNil(receivedError, "No ha ocurrido ningún error")
        XCTAssertTrue(receivedValue, "Se reciben películas con el stado de si es favorito o no actualizado")
        XCTAssertTrue(moviesRepositoryMock.getTrendingMoviesCalled)
        XCTAssertTrue(moviesRepositoryMock.getFavoriteMoviesCalled)
        XCTAssertFalse(moviesResult[0].isFavorite)
        XCTAssertTrue(moviesResult[1].isFavorite)
        XCTAssertFalse(moviesResult[2].isFavorite)
        XCTAssertTrue(moviesResult[3].isFavorite)
        XCTAssertFalse(moviesResult[4].isFavorite)
    }
    
    func testGetTrendingFavoritesMoviesWithFavoritesError() throws {
        //GIVEN
        let moviesResult: [Movie] = []
        let favoriteMovies: [Movie] = []
        let simulateError = false
        let simulateFavoriteError = true

        var callFinished = false
        var receivedValue: Bool = false
        var receivedError: Movies.ServiceError? = nil

        let moviesRepositoryMock = MoviesRepositoryMock(movies: moviesResult, favoriteMovies: favoriteMovies, simulateError: simulateError, simulateFavoriteError: simulateFavoriteError)
        let getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase = GetTrendingMoviesWithFavoriteStatusUseCase(moviesRepository: moviesRepositoryMock)

        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        _ = getTrendingMoviesWithFavoriteStatusUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        callFinished = true
                    case .failure(let error):
                        receivedError = error
                    }}, receiveValue: { movies in
                        receivedValue = true
                    })
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        XCTAssertFalse(callFinished, "Solicitud completada exitosamente")
        XCTAssertNotNil(receivedError, "TrendingMovies devuelve error")
        XCTAssertFalse(receivedValue, "Ha ocurrido un error, no se reciben películas")
    }

    func testGetTrendingFavoritesMoviesWithTrendingMoviesError() throws {
        //GIVEN
        let trendingMovies: [Movie] = []
        let favoriteMovies: [Movie] = []
        let simulateError = true
        let simulateFavoriteError = false

        var callFinished = false
        var receivedValue: Bool = false
        var receivedError: Movies.ServiceError? = nil

        let moviesRepositoryMock = MoviesRepositoryMock(movies: trendingMovies, favoriteMovies: favoriteMovies, simulateError: simulateError, simulateFavoriteError: simulateFavoriteError)
        let getTrendingMoviesWithFavoriteStatusUseCase: GetTrendingMoviesWithFavoriteStatusUseCase = GetTrendingMoviesWithFavoriteStatusUseCase(moviesRepository: moviesRepositoryMock)

        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        _ = getTrendingMoviesWithFavoriteStatusUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        callFinished = true
                    case .failure(let error):
                        receivedError = error
                    }}, receiveValue: { movies in
                        receivedValue = true
                    })
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertFalse(callFinished, "Solicitud completada exitosamente")
        XCTAssertNotNil(receivedError, "TrendingMovies devuelve error")
        XCTAssertFalse(receivedValue, "Ha ocurrido un error, no se reciben películas")
    }
}
