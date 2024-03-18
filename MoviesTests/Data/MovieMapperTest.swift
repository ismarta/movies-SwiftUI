//
//  MovieMapperTest.swift
//  MoviesTests
//
//  Created by Marta on 11/3/24.
//

import XCTest
@testable import Movies

final class MovieMapperTest: XCTestCase {
    func testTransformToDomainShouldGetMoviesWhenExecuted() throws {
        //GIVEN
        let movieRemoteEntity = MovieRemoteEntityMock.givenAMovie()
        //WHEN
        let movie = movieRemoteEntity.transformToDomain()
        //THEN
        XCTAssertEqual(movie.identifier, MovieRemoteEntityMock.FAKE_IDENTIFIER)
        XCTAssertEqual(movie.title, MovieRemoteEntityMock.FAKE_TITLE)
        XCTAssertEqual(movie.originalLanguage, MovieRemoteEntityMock.FAKE_ORIGINAL_LANGUAGE)
        XCTAssertEqual(movie.voteAverage, MovieRemoteEntityMock.FAKE_VOTE_AVERAGE)
        XCTAssertEqual(movie.voteCount, MovieRemoteEntityMock.FAKE_VOTE_COUNT)
        XCTAssertEqual(movie.imageBackdropPath, MovieRemoteEntityMock.FAKE_IMAGE_BACKDROP_PATH)
    }
}
