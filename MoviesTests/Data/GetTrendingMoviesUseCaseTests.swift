//
//  GetTrendingMoviesUseCaseTests.swift
//  MoviesTests
//
//  Created by Marta on 11/3/24.
//

import XCTest
@testable import Movies

final class GetTrendingMoviesUseCaseTests: XCTestCase {
    func testGetTrendingMoviesSuccess() throws {
        //GIVEN
        let moviesResult = [MovieEntityMock.givenAMovie(identifier: 1),MovieEntityMock.givenAMovie(identifier: 2), MovieEntityMock.givenAMovie(identifier: 3)]
        let simulateError = false
        let moviesRepositoryMock = MoviesRepositoryMock(movies: moviesResult, simulateError: simulateError)
        let getTrendingMoviesUseCase: GetTrendingMoviesUseCase = GetTrendingMoviesUseCase(moviesRepository: moviesRepositoryMock)

        var callFinished = false
        var receivedValue: Bool = false
        var receivedError: Movies.ServiceError? = nil

        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        _ = getTrendingMoviesUseCase.execute()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                            case .finished:
                                callFinished = true
                            case .failure(let error):
                                receivedError = error
                            }},
                          receiveValue: { movies in
                            receivedValue = true
                    })
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertTrue(moviesRepositoryMock.getTrendingMoviesCalled)
        XCTAssertTrue(callFinished, "Solicitud completada exitosamente")
        XCTAssertNil(receivedError, "No se ha recibido ningún error")
        XCTAssertTrue(receivedValue, "Se han recibido películas")
    }

    func testGetTrendingMoviesError() throws {
        //GIVEN
        let moviesResult = [MovieEntityMock.givenAMovie(identifier: 1),MovieEntityMock.givenAMovie(identifier: 2), MovieEntityMock.givenAMovie(identifier: 3)]
        let simulateError = true
        let moviesRepositoryMock = MoviesRepositoryMock(movies: moviesResult, simulateError: simulateError)
        let getTrendingMoviesUseCase: GetTrendingMoviesUseCase = GetTrendingMoviesUseCase(moviesRepository: moviesRepositoryMock)

        var callFinished = false
        var receivedValue: Bool = false
        var receivedError: Movies.ServiceError? = nil

        let expectation = XCTestExpectation(description: "Se espera que la operación asíncrona se complete")
        //WHEN
        _ = getTrendingMoviesUseCase.execute()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                            case .finished:
                                callFinished = true
                            case .failure(let error):
                                receivedError = error
                            }},
                          receiveValue: { movies in
                            receivedValue = true
                    })
        XCTWaiter().wait(for: [expectation], timeout: 3.0)
        //THEN
        XCTAssertTrue(moviesRepositoryMock.getTrendingMoviesCalled)
        XCTAssertFalse(callFinished, "Solicitud completada exitosamente")
        XCTAssertNotNil(receivedError, "No se ha recibido ningún error")
        XCTAssertFalse(receivedValue, "Se han recibido películas")
    }
}
