//
//  MovieInfoView.swift
//  Lab1
//
//  Created by Anna Berezhniak on 19.11.2020.
//  Copyright © 2020 Anna Berezhniak. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    var id = ""
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedMovie = loadMovieData(id: id)
        movieImageView.image = UIImage(named: selectedMovie.Poster)
        
        
        //let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Title: ")
        setColoredLabel(strToColor: "Title: ", movieAttribute: selectedMovie.Title, label: titleLabel)
        setColoredLabel(strToColor: "Year: ", movieAttribute: selectedMovie.Year, label: yearLabel)
        setColoredLabel(strToColor: "Genre: ", movieAttribute: selectedMovie.Genre!, label: genreLabel)
        
        setColoredLabel(strToColor: "Director: ", movieAttribute: selectedMovie.Director!, label: directorLabel)
        setColoredLabel(strToColor: "Actors: ", movieAttribute: selectedMovie.Actors!, label: actorsLabel)
        
        setColoredLabel(strToColor: "Country: ", movieAttribute: selectedMovie.Country!, label: countryLabel)
        setColoredLabel(strToColor: "Language: ", movieAttribute: selectedMovie.Language!, label: languageLabel)
        setColoredLabel(strToColor: "Production: ", movieAttribute: selectedMovie.Production!, label: productionLabel)
        setColoredLabel(strToColor: "Released: ", movieAttribute: selectedMovie.Released!, label: releasedLabel)
        setColoredLabel(strToColor: "Runtime: ", movieAttribute: selectedMovie.Runtime!, label: runtimeLabel)
        setColoredLabel(strToColor: "Awards: ", movieAttribute: selectedMovie.Awards!, label: awardsLabel)
        setColoredLabel(strToColor: "Rating: ", movieAttribute: selectedMovie.Rated!, label: ratingLabel)
        setColoredLabel(strToColor: "Plot: ", movieAttribute: selectedMovie.Plot!, label: plotLabel)
        
    }
    
    func loadMovieData(id: String) -> Movie {
        var movie: Movie
        //change it to your path appropriately
        let path = "/Users/lenasoroka/Desktop/Lab1/Lab1/PA4/" + id
        let fileURL = URL(fileURLWithPath: path).appendingPathExtension("txt")
        let data = try! Data(contentsOf: fileURL)
        movie = try! JSONDecoder().decode(Movie.self, from: data)
        return movie
    }
    
    func setColoredLabel(strToColor: String, movieAttribute: String, label: UILabel) {
        let color = UIColor.red
        let attrsString =  NSMutableAttributedString(string: strToColor + movieAttribute)
                
        // search for word occurrence
        let range = (strToColor + movieAttribute as NSString).range(of: strToColor)
        if (range.length > 0) {
            attrsString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        label.attributedText = attrsString
    }
    
}

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)

        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

    }

}
