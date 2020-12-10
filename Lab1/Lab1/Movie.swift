//
//  Movie.swift
//  Lab1
//
//  Created by Anna Berezhniak on 07.11.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import Foundation
import UIKit

class Movie: Codable {
    var Title: String
    var Year: String
    var imdbID: String
    var `Type`: String
    var Poster: String
    var Rated: String?
    var Released: String?
    var Runtime : String?
    var Genre : String?
    var Director: String?
    var Writer: String?
    var Actors: String?
    var Plot: String?
    var Language: String?
    var Country: String?
    var Awards: String?
    var imdbRating: String?
    var imdbVotes: String?
    var Production: String?
    
    init(Title: String,
         Year: String,
         Rated: String = "",
         Released: String = "",
         Runtime: String = "",
         Genre: String = "",
         Director: String = "",
         Writer: String = "",
         Actors: String = "",
         Plot: String = "",
         Language: String = "",
         Country: String = "",
         Awards: String = "",
         Poster: String = "",
         imdbRating: String = "",
         imdbVotes: String = "",
         imdbID: String = "",
         Type: String,
         Production: String = ""){

        self.Title = Title
        self.Year = Year
        self.Rated = Rated
        self.Released = Released
        self.Runtime = Runtime
        self.Genre = Genre
        self.Director = Director
        self.Writer = Writer
        self.Actors = Actors
        self.Plot = Plot
        self.Language = Language
        self.Country = Country
        self.Awards = Awards
        self.Poster = Poster
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.Type = Type
        self.Production = Production
    }

}
