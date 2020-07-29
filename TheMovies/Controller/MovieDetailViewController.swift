//
//  MovieDetailViewController.swift
//  TheMovies
//
//  Created by Lucas Daniel on 28/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation
import CoreData

class MovieDetailViewController: UIViewController {
        
    var movieDetail: MovieDetail?
    var favoriteMovies: FavoriteMovie?
    var selectedIndexes = [IndexPath]()
    var insertedIndexPaths: [IndexPath]!
    var deletedIndexPaths: [IndexPath]!
    var updatedIndexPaths: [IndexPath]!
    var stack = CoreDataStack.shared
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovie>!
                    
    let handleFavoriteMovie = HandleFavoriteMovie()
        
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var publicationDate: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.fillFields()
        self.favoriteButton.layer.cornerRadius = self.view.frame.size.height*007/100/2
        self.loadAllFavoriteMovies()
    }
    
    private func fillFields() {
        if let movieName = self.movieDetail?.movieName {
            self.movieNameLabel.text = movieName
        } else {
            self.movieNameLabel.text = "No name"
        }
        
        if let movieDescription = self.movieDetail?.movieDescription {
            self.movieDescriptionTextView.text = movieDescription
        } else {
            self.movieDescriptionTextView.text = "No description"
        }
        
        if let articleButtonTitle = self.movieDetail?.articleButtonTitle {
            self.articleButton.setTitle(articleButtonTitle, for: .normal)
        } else {
            self.movieDescriptionTextView.text = "No article"
        }
        
        if let publicationDate = self.movieDetail?.publicationDate {
            self.publicationDate.text = "Publication Date: \(publicationDate)"
        } else {
            self.movieDescriptionTextView.text = "No date"
        }
        
        if let headline = self.movieDetail?.headline {
            self.headlineLabel.text = headline
        } else {
            self.headlineLabel.text = "No headline"
        }
        
        if let url = self.movieDetail?.movieImage {
            if let imageUrl = URL(string: url) {
                self.movieImage.kf.setImage(with: imageUrl)
            }
        }
    }
        
    private func loadAllFavoriteMovies() -> [FavoriteMovie]? {
        self.showSpinner(show: true, onView: self.view)
        var favoriteMovie: [FavoriteMovie]?
        do {
            try favoriteMovie = handleFavoriteMovie.fetchAllFavoriteMovies(entityName: FavoriteMovie.name, viewContext: stack.viewContext)
        } catch {
            self.showAlert(title: "Error", message: "Error to load data!")
            print("error")
        }
        self.showSpinner(show: false, onView: self.view)
        return favoriteMovie
    }
    
    func saveFavoriteMovies() {
        self.showSpinner(show: true, onView: self.view)
        let teste = FavoriteMovie(
                           movieName: (self.movieDetail?.movieName)!,
                           movieImage: (self.movieDetail?.movieImage)!,
                           movieDescription: (self.movieDetail?.movieDescription)!,
                           articleLink: (self.movieDetail?.articleLink)!,
                           articleButtonTitle: (self.movieDetail?.articleButtonTitle)!,
                           publicationDate: (self.movieDetail?.publicationDate)!,
                           headline: (self.movieDetail?.headline)!,
                           context: stack.viewContext)
        do {
            try stack.viewContext.save()
        } catch {
            self.showAlert(title: "Error", message: "Error to save data!")
        }
        self.showSpinner(show: false, onView: self.view)
    }
        
    @IBAction func showArticle(_ sender: UIButton) {
        if let articleLink = self.movieDetail?.articleLink {
            if let url = URL(string: articleLink) {
                UIApplication.shared.open(url)
            }
        } else {
            print("erro")
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
            
    @IBAction func share(_ sender: UIBarButtonItem) {
        var shareAll: [Any] = ["I want to share this movie with you!"]
        shareAll.append(self.movieNameLabel.text!)
        if let link = self.movieDetail?.articleLink {
            shareAll.append("Movie Article - \(link)")
        }        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func favorite(_ sender: UIButton) {
        sender.setImage(UIImage(named: "favorite"), for: .normal)
        saveFavoriteMovies()
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
