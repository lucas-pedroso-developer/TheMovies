//
//  DataExtensions.swift
//  TheMovies
//
//  Created by Lucas Daniel on 27/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }        
}
