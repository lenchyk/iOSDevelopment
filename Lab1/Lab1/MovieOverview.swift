//
//  MovieOverview.swift
//  Lab1
//
//  Created by Anna Berezhniak on 22.11.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import Foundation

//class for description whole movie list with its functions
class MovieOverview {
    var movies = [Movie]()
    var moviesFiltered = [Movie]()
    
    init() {
        movies = loadMovieCellData()
    }
    
    func filterMovies(text: String) {
        moviesFiltered.removeAll()
        
        moviesFiltered = movies.filter({ (movie) -> Bool in
            return movie.Title.lowercased().contains(text.lowercased())
        })
    }
    
    func loadMovieCellData() -> [Movie]{
        guard let path = Bundle.main.path(forResource: "MoviesList", ofType: "txt") else { return [] }
        let url = URL(fileURLWithPath: path)
        // array of Movie structures
        var movies = [Movie]()
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(Response.self, from: data)
            movies = response.Search
            
        } catch {
            print(error)
        }
        return movies
    }
    
    // adding new movie using new screen view
    func addNewMovie(title: String, year: String, type: String) {
        let movie = Movie(Title: title, Year: year, Type: type)
        movies.insert(movie, at: 0)
    }
    
    func removeMovie(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
    }

}
