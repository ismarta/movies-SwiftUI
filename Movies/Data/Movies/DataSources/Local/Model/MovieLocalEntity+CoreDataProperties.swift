//
//  MovieLocalEntity+CoreDataProperties.swift
//  Movies
//
//  Created by Marta on 12/3/24.
//
//

import Foundation
import CoreData

@objc(MovieLocal)
extension MovieLocalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieLocalEntity> {
        return NSFetchRequest<MovieLocalEntity>(entityName: "MovieLocalEntity")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var imageBackdropPath: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int32

}

extension MovieLocalEntity : Identifiable {

}
