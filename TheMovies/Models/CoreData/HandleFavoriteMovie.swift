//
//  HandleFavoriteMovie.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation
import CoreData

class HandleFavoriteMovie {
    func fetchAllFavoriteMovies(_ predicate: NSPredicate? = nil, entityName: String, sorting: NSSortDescriptor? = nil, viewContext: NSManagedObjectContext) throws -> [FavoriteMovie]? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fr.predicate = predicate
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let favoriteMovie = try viewContext.fetch(fr) as? [FavoriteMovie] else {
            return nil
        }
        return favoriteMovie
    }
    
    func deleteFavoriteMovie(index: Int, _ predicate: NSPredicate? = nil, entityName: String, sorting: NSSortDescriptor? = nil, viewContext: NSManagedObjectContext) throws -> Bool {
            let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fr.predicate = predicate
            if let sorting = sorting {
                fr.sortDescriptors = [sorting]
            }
            guard let favoriteMovie = try viewContext.fetch(fr) as? [FavoriteMovie] else {
                return false
            }
        
            viewContext.delete(favoriteMovie[index])
            do {
                
                try viewContext.save()
            } catch {
                return false
            }
            return true
    }
}
