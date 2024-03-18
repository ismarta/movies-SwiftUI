//
//  URLRequest+Extension.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation

extension String {
    func appendApiKey(_ apiKey: String) -> String {
        guard var urlComponents = URLComponents(string: self) else {
            return self
        }
        if urlComponents.queryItems != nil {
            let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
            urlComponents.queryItems?.append(apiKeyQueryItem)
        } else {
            urlComponents.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        }
        if let finalURL = urlComponents.url?.absoluteString {
            return finalURL
        } else {
            return self
        }
    }
}
