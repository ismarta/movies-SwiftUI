//
//  MovieMock.swift
//  MoviesTests
//
//  Created by Marta on 11/3/24.
//

import Foundation
@testable import Movies

class MovieEntityMock {
    static let FAKE_IDENTIFIER = 10
    static let FAKE_TITLE = "movie_title"
    static let FAKE_ORIGINAL_LANGUAGE = "en"
    static let FAKE_OVERVIEW = "overview_text"
    static let FAKE_VOTE_AVERAGE = 8.0
    static let FAKE_VOTE_COUNT = 2000
    static let FAKE_IMAGE_BACKDROP_PATH = "image_path"
    static let FAKE_IS_FAVORITE = false

    static func givenAMovie(identifier: Int = MovieEntityMock.FAKE_IDENTIFIER) -> Movie {
        return Movie(identifier: identifier,
                     title: MovieEntityMock.FAKE_TITLE,
                     originalLanguage: MovieEntityMock.FAKE_ORIGINAL_LANGUAGE,
                     overview: MovieEntityMock.FAKE_OVERVIEW,
                     voteAverage: MovieEntityMock.FAKE_VOTE_AVERAGE,
                     voteCount: MovieEntityMock.FAKE_VOTE_COUNT,
                     imageBackdropPath:MovieEntityMock.FAKE_IMAGE_BACKDROP_PATH, isFavorite: MovieEntityMock.FAKE_IS_FAVORITE)
    }
}

