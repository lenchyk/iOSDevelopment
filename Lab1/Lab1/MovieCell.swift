//
//  MovieCell.swift
//  Lab1
//
//  Created by Anna Berezhniak on 08.11.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import UIKit


class MovieCell: UITableViewCell {
     
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    
    func setMovie(movie: Movie) {
        
        if movie.Title.isEmpty {
            movieNameLabel.text = "No name"
        }
        else {
            movieNameLabel.text = movie.Title
        }
        // when there is no poster or type or year (which can happen)
        if movie.Poster.isEmpty {
            movieImageView.image = UIImage(named: "notFound.jpg")
            movie.Poster = "notFound.jpg"
        }
        else {
            movieImageView.image = UIImage(named: movie.Poster)
        }
        if movie.Year.isEmpty {
            movieYearLabel.text = "Year unknown"
        }
        else {
            movieYearLabel.text = movie.Year
        }
        if movie.Type.isEmpty {
            movieTypeLabel.text = "Type unknown"
        }
        else {
            movieTypeLabel.text = movie.Type
        }
    }
    
}
