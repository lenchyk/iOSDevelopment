//
//  ViewController.swift
//  Lab1
//
//  Created by Anna Berezhniak on 09.10.2020.
//

import UIKit

class MoviesListViewController: UIViewController{
    
    var movieOverview = MovieOverview()
    var moviesFilter = [Movie]() // for filtered search result
    
    var refreshControl = UIRefreshControl()
    var search = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
            
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always

        
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        let buttonAdd = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addMovie))
        buttonAdd.setTitleTextAttributes([
                                            NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 35)!], for: .normal)
        self.navigationItem.rightBarButtonItem = buttonAdd
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    @objc func updateTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func addMovie() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewMovieViewController") as! AddNewMovieViewController
        vc.addingDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // swiping for deleting
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeDelete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in self.tableView.performBatchUpdates({
            self.movieOverview.removeMovie(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }, completion: { (result) in success(true)
        })
        }
        swipeDelete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        let conf = UISwipeActionsConfiguration(actions: [swipeDelete])
        conf.performsFirstActionWithFullSwipe = false
        return conf
    }
}

extension MoviesListViewController: PassData {
    func passData(titleNew: String, typeNew: String, yearNew: String) {
        movieOverview.addNewMovie(title: titleNew, year: yearNew, type: typeNew)
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch() {
            // if there is no items found while searching
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                             width: self.tableView.bounds.size
                                                                .width,
                                                             height:
                                                                tableView.bounds.size.height))
            noDataLabel.text = "No Results Found."
            noDataLabel.textColor = UIColor.red
            noDataLabel.textAlignment = .center
            self.tableView.backgroundView  = noDataLabel
            self.tableView.backgroundColor = UIColor.white
            noDataLabel.isHidden = true
            
            if (self.movieOverview.moviesFiltered.count == 0)
                {
                    noDataLabel.isHidden = false
                }
            return movieOverview.moviesFiltered.count
        }
        return movieOverview.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var movie: Movie
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if isSearch() {
            movie = movieOverview.moviesFiltered[indexPath.row]
        } else {
            movie = movieOverview.movies[indexPath.row]
        }
        cell.setMovie(movie: movie)
        return cell
    }
    
    // navigation from main movieTableView to movieInfoView about selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController
        vc?.id = movieOverview.movies[indexPath.row].imdbID // transporting the id to the new view controller
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // if search list is empty
    func searchBarIsEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    
    //if search is active and it is not empty - we are searching
    func isSearch() -> Bool {
        return search.isActive && !searchBarIsEmpty()
    }
    
    // function for searching a specific movie
    func searchMovie(text: String) {
        movieOverview.filterMovies(text: text)
        tableView.reloadData()
    }
}

extension MoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchMovie(text: searchController.searchBar.text!)
    }
}
