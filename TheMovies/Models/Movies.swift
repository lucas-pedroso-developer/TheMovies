//
//  Movies.swift
//  TheMovies
//
//  Created by Lucas Daniel on 27/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation

struct Movies : Model {
    let status : String?
    let copyright : String?
    let has_more : Bool?
    let num_results : Int?
    let results : [Results]?
}
