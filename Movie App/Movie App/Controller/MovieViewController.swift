//
//  ViewController.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: Outlets e Vars
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var results: [MovieModel] = []
    var filteredResults: [MovieModel] = []
    var refreshControl = UIRefreshControl()
    var movieManager = MovieManager()
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate    = self
        movieManager.delegate = self
        tableView.dataSource  = self
        tableView.delegate    = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: K.tableView.cellId)
        tableView.keyboardDismissMode = .onDrag
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        movieManager.fetchMovies()
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        movieManager.fetchMovies()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow?.row
        if let resultVC = segue.destination as? MovieDetailController {
            resultVC.titleString = filteredResults[indexPath!].title
            resultVC.overviewString = filteredResults[indexPath!].overview
        }
    }
}

//MARK: MovieManagerDelegate
extension MovieViewController: MovieManagerDelegate {
    
    func didUpdateMovies(_ manager: MovieManager, model: Movies) {
        DispatchQueue.main.async {
            self.results = model.movies
            self.filteredResults  = model.movies
            self.tableView.reloadData()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: TableViewDataSource e Delegate
extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableView.cellId, for: indexPath) as! MovieCell
        cell.fetchPoster(path: filteredResults[indexPath.row].poster_path)
        cell.movieTitleLabel.text = filteredResults[indexPath.row].title
        cell.releaseDateLabel.text = "Release Date: " + filteredResults[indexPath.row].release_date
        cell.scoreLabel.text = "Score: " + String(format: "%.2f", filteredResults[indexPath.row].vote_average)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.tableView.movieDetailSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: SearchBarDelegate
extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredResults = []
        if searchText == "" {
            filteredResults = results
        } else {
            for movie in results {
                if movie.title.lowercased().contains(searchText.lowercased()) {
                    filteredResults.append(movie)
                }
            }
        }
        tableView.reloadData()
    }
    
}

