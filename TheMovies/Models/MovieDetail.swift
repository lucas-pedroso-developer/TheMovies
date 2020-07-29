//
//  Movie.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation

struct MovieDetail: Model {
    let movieName: String?
    let movieImage: String?
    let movieDescription: String?
    let articleLink: String?
    let articleButtonTitle: String?
    let publicationDate: String?
    let headline: String?
    
    init(movieName: String?, movieImage: String?, movieDescription: String?, articleLink: String?, articleButtonTitle: String?, publicationDate: String?, headline: String?) {
        self.movieName = movieName
        self.movieImage = movieImage
        self.movieDescription = movieDescription
        self.articleLink = articleLink
        self.articleButtonTitle = articleButtonTitle
        self.publicationDate = publicationDate
        self.headline = headline
    }    
}
