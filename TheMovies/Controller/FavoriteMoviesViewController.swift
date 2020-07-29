//
//  FavoriteMoviesViewController.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteMoviesViewController: UIViewController {
            
    var stack = CoreDataStack.shared
    var favoriteMovie: [FavoriteMovie]?
    
    let handleFavoriteMovie = HandleFavoriteMovie()
    
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(show: true, onView: self.view)
        self.loadAllFavoriteMovies()
        self.favoriteMoviesTableView.reloadData()
    }
    
    private func loadAllFavoriteMovies() {
        do {
            try favoriteMovie = handleFavoriteMovie.fetchAllFavoriteMovies(entityName: FavoriteMovie.name, viewContext: stack.viewContext)
                                    
            self.favoriteMoviesTableView.reloadData()
        } catch {
            self.showAlert(title: "Error", message: "Error to load data!")
            self.showSpinner(show: false, onView: self.view)
        }
    }
    
    private func deleteFavoriteMovies(index: Int) -> Bool {
        do {
            return try handleFavoriteMovie.deleteFavoriteMovie(index: index, entityName: FavoriteMovie.name, viewContext: stack.viewContext)
        } catch {
            self.showAlert(title: "Error", message: "Error to load data!")
        }
        return false
    }        
}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.favoriteMovie != nil {
            return self.favoriteMovie!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteMoviesTableViewCell                               
        
        cell.favoriteMovieName.text = self.favoriteMovie?[indexPath.row].movieName
        cell.favoriteMovieSummary.text = self.favoriteMovie?[indexPath.row].movieDescription
        
        if let url = self.favoriteMovie?[indexPath.row].movieImage {
            if let imageUrl = URL(string: url) {
                cell.favoriteMovieImage.kf.setImage(with: imageUrl)
            }
        }
        self.showSpinner(show: false, onView: self.view)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*17/100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        newViewController.movieDetail = MovieDetail(movieName: self.favoriteMovie?[indexPath.item].movieName,
                                                movieImage: self.favoriteMovie?[indexPath.item].movieImage,
                                                movieDescription: self.favoriteMovie?[indexPath.item].movieDescription,
                                                articleLink: self.favoriteMovie?[indexPath.item].articleLink,
                                                articleButtonTitle: self.favoriteMovie?[indexPath.item].articleButtonTitle,
                                                publicationDate: self.favoriteMovie?[indexPath.item].publicationDate?.replacingOccurrences(of: "-", with: "/"),
                                                headline: self.favoriteMovie?[indexPath.item].headline)
        present(newViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showSpinner(show: true, onView: self.view)
            let isDeleted = deleteFavoriteMovies(index: indexPath.row)
            if isDeleted {
                self.favoriteMovie?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else {
                self.showAlert(title: "Error", message: "Error to delete data!")
            }
            self.showSpinner(show: false, onView: self.view)
        }
    }
    
}
