//
//  MoviesApi.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation
import Combine

enum MoviesApi {
    case getTrendingMovies(Int, String, String)

    var method: String {
        switch self {
        case .getTrendingMovies:
            return "GET"
        }
    }

    var pathParams: String {
        switch self {
        case .getTrendingMovies(_, let timeWindow, _):
            return "/trending/movie/\(timeWindow)"
        }
    }

    var queryParams: String {
        switch self {
        case .getTrendingMovies(let page, _, let language):
            return "?page=\(page)&language=\(language)"
        }
    }

    func buildRequestPublisher(requestPublisher: RequestableProtocol = RequestPublisher()) -> AnyPublisher<MoviesResponseRemoteEntity, ServiceError>  {
        let urlString = "https://api.themoviedb.org/3"+pathParams+queryParams
        return requestPublisher.get(fromURL: urlString)
    }
}
