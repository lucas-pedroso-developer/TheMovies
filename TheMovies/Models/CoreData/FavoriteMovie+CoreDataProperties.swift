//
//  Movie+CoreDataProperties.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation
import CoreData

extension FavoriteMovie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }
            
    @NSManaged public var movieName: String?
    @NSManaged public var movieImage: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var articleLink: String?
    @NSManaged public var articleButtonTitle: String?
    @NSManaged public var publicationDate: String?
    @NSManaged public var headline: String?
}

extension FavoriteMovie {
    
    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: FavoriteMovie)
    
    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: FavoriteMovie)
    
    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)
    
    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)
    
}
