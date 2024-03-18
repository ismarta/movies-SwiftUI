//
//  RequestPublisher.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation
import Combine

protocol RequestableProtocol {
    func get<T: Codable>(fromURL urlString: String) -> AnyPublisher<T, ServiceError>
}

class RequestPublisher: RequestableProtocol {
    private var urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func get<T: Codable>(fromURL urlString: String) -> AnyPublisher<T, ServiceError> {
        let urlStringWithApiKey = urlString.appendApiKey(ApiDetails.apiKey)
        guard let url = URL(string: urlStringWithApiKey) else {
            return Fail<T, ServiceError>(error: .url(URLError(URLError.Code.badURL))).eraseToAnyPublisher()
        }
        return getData(fromURL: getRequest(from: url))
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                print("ERROR::\(error)")
                return .decode
            }
            .eraseToAnyPublisher()
    }

    private func getRequest(from url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(ApiDetails.apiReadAccessToken)", forHTTPHeaderField: "Authorization")
        return request
    }

    func getData(fromURL request: URLRequest) -> AnyPublisher<Data, ServiceError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .map { 
                return $0.data
            }
            .mapError {
                error in
                .url(error)}
            .eraseToAnyPublisher()
    }
}

enum ServiceError: Error {
    case url(URLError?)
    case decode
    case unknown(Error)
    case defaultError
}
