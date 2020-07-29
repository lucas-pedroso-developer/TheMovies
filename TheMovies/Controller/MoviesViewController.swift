//
//  ViewController.swift
//  TheMovies
//
//  Created by Lucas Daniel on 27/07/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class MoviesViewController: UIViewController {

    var movies: Movies?
    var moviesArray = [Results?]()
    var moviesArrayFiltered = [Results?]()
    var searchController: UISearchController!
    var searchActive : Bool = false
    var isFinalToLoad : Bool = false
            
    let service = PokedexService()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner(show: true, onView: self.view)
        self.getmovies(url: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=&api-key=JBzDusoqkuiMuax3qUcGrQMZPR0Cc1Vs")
    }
    
    func getmovies(url: String) {
        self.showSpinner(show: true, onView: self.view)
        service.get(url: url) { result in
            switch result {
            case .success(let data):
                if data != nil {
                    self.movies = data?.toModel()
                    self.moviesCollectionView.reloadData()
                } else {
                    self.showAlert(title: "Error", message: "No has data!")
                    self.showSpinner(show: false, onView: self.view)
                }
            case .failure(let error):
                print("erro")
                self.showAlert(title: "Error", message: "Error when getting movies!")
                self.showSpinner(show: false, onView: self.view)
            }
        }
    }
            
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.results?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width //- padding
        return CGSize(width: collectionViewSize/2.1, height: collectionViewSize/2.1)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "cell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
        
        if let name = self.movies?.results?[indexPath.item].display_title {
            cell.movieName.text = name
        }
        if let url = self.movies?.results?[indexPath.item].multimedia?.src {
            if let imageUrl = URL(string: url) {
                cell.movieImage.kf.setImage(with: imageUrl)
            }
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        self.showSpinner(show: false, onView: self.view)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        newViewController.movieDetail = MovieDetail(movieName: self.movies?.results?[indexPath.item].display_title,
                                                movieImage: self.movies?.results?[indexPath.item].multimedia?.src,
                                                movieDescription: self.movies?.results?[indexPath.item].summary_short,
                                                articleLink: self.movies?.results?[indexPath.item].link?.url,
                                                articleButtonTitle: self.movies?.results?[indexPath.item].link?.suggested_link_text,
                                                publicationDate: self.movies?.results?[indexPath.item].publication_date?.replacingOccurrences(of: "-", with: "/"),
                                                headline: self.movies?.results?[indexPath.item].headline)
        present(newViewController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }

}

extension MoviesViewController: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {}
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            self.getmovies(url: "https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=\(searchBar.text!.replacingOccurrences(of: " ", with: "&"))&api-key=JBzDusoqkuiMuax3qUcGrQMZPR0Cc1Vs")
        }
    }
}
