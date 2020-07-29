//
//  HttpGet.swift
//  TheMovies
//
//  Created by Lucas Daniel on 27/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation

public protocol HttpGet {
    func get(url: String, completion: @escaping (Result<Data?, HttpError>) -> ())
}
