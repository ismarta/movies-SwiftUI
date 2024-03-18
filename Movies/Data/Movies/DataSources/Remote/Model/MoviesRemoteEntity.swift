//
//  MoviesRemoteEntity.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation

struct MovieRemoteEntity: Codable {
    let id: Int
    let title: String
    let original_language: String
    let overview: String
    let vote_average: Double
    let vote_count: Int
    let backdrop_path: String?
}

extension MovieRemoteEntity {
    func transformToDomain() -> Movie {
        Movie(identifier: id, title: title, originalLanguage: original_language, overview: overview, voteAverage: vote_average, voteCount: vote_count, imageBackdropPath: backdrop_path, isFavorite: false)
    }
}

extension Sequence where Iterator.Element == MovieRemoteEntity {
    func transformToDomain() -> [Movie] {
        compactMap { $0.transformToDomain() }
    }
}
