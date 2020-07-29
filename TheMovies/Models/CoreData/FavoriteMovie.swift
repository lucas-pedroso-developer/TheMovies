//
//  Movie.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation
import CoreData

@objc(FavoriteMovie)
public class FavoriteMovie: NSManagedObject {
    
    static let name = "FavoriteMovie"
    
    convenience init(movieName: String, movieImage: String, movieDescription: String, articleLink: String, articleButtonTitle: String, publicationDate: String, headline: String,  context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: FavoriteMovie.name, in: context) {
            self.init(entity: ent, insertInto: context)
            self.movieName = movieName
            self.movieImage = movieImage
            self.movieDescription = movieDescription
            self.articleLink = articleLink
            self.articleButtonTitle = articleButtonTitle
            self.publicationDate = publicationDate
            self.headline = headline
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
}
