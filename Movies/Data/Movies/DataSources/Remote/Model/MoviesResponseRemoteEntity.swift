//
//  Movie.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation

public struct MoviesResponseRemoteEntity: Codable {
    let page: Int
    let results: [MovieRemoteEntity]
}
