//
//  Movie.swift
//  Movies
//
//  Created by Marta on 7/3/24.
//

import Foundation

struct Movie: Hashable, Codable {
    let identifier: Int
    let title: String
    let originalLanguage: String
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let imageBackdropPath: String?
    var isFavorite: Bool

    init(identifier: Int, title: String, originalLanguage: String, overview: String, voteAverage: Double, voteCount: Int, imageBackdropPath: String?, isFavorite: Bool) {
        self.identifier = identifier
        self.title = title
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.imageBackdropPath = imageBackdropPath
        self.isFavorite = isFavorite
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension MovieLocalEntity {
    func transformToDomain() -> Movie {
        Movie(identifier: Int(identifier), title: title ?? "" , originalLanguage: originalLanguage ?? "", overview: overview ?? "", voteAverage: voteAverage, voteCount: Int(voteCount), imageBackdropPath: imageBackdropPath, isFavorite: true)
    }
}

extension Sequence where Iterator.Element == Movie {
    func updateFavoriteStatus(with favoritesList: [Movie]) -> [Movie] {
        return map { movie in
            var movieCopy = movie
            if favoritesList.contains(movie) {
                movieCopy.isFavorite = true
            } else {
                movieCopy.isFavorite = false
            }
            return movieCopy
        }
    }
}
