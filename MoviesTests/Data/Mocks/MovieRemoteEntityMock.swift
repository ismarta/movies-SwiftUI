//
//  MovieRemoteEntityMock.swift
//  MoviesTests
//
//  Created by Marta on 11/3/24.
//

import Foundation
@testable import Movies

class MovieRemoteEntityMock {
    static let FAKE_IDENTIFIER = 10
    static let FAKE_TITLE = "movie_title"
    static let FAKE_ORIGINAL_LANGUAGE = "en"
    static let FAKE_OVERVIEW = "overview_text"
    static let FAKE_VOTE_AVERAGE = 8.0
    static let FAKE_VOTE_COUNT = 2000
    static let FAKE_IMAGE_BACKDROP_PATH = "image_path"

    static func givenAMovie(identifier: Int = MovieRemoteEntityMock.FAKE_IDENTIFIER) -> MovieRemoteEntity {
        return MovieRemoteEntity(id: identifier,
                                 title: MovieEntityMock.FAKE_TITLE,
                                 original_language: MovieEntityMock.FAKE_ORIGINAL_LANGUAGE,
                                 overview: MovieEntityMock.FAKE_OVERVIEW,
                                 vote_average: MovieEntityMock.FAKE_VOTE_AVERAGE,
                                 vote_count: MovieEntityMock.FAKE_VOTE_COUNT,
                                 backdrop_path:MovieEntityMock.FAKE_IMAGE_BACKDROP_PATH)
    }
}

