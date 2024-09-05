//
//  MovieItem+CoreDataProperties.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//
//

import Foundation
import CoreData


extension MovieItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var id: Int32
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int32
    @NSManaged public var genre_ids: [Int32]?
    @NSManaged public var timestamp: Date?

}

extension MovieItem : Identifiable {

}
