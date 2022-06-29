//
//  ViewController.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    var results: [MovieModel] = []
    
    
    var movieManager = MovieManager()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        movieManager.fetchTrendingMovies()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: K.tableView.cellId)

        // Do any additional setup after loading the view.
    }


}

extension MovieViewController: MovieManagerDelegate {
    
    func didUpdateMovies(_ manager: MovieManager, model: Results) {
        DispatchQueue.main.async {
            self.results = model.results
            self.tableView.reloadData()
        }

        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableView.cellId, for: indexPath) as! MovieCell
        cell.movieTitleLabel.text = results[indexPath.row].title
        cell.releaseDateLabel.text = "Release Date: " + results[indexPath.row].release_date
        cell.scoreLabel.text = "Score:" + String(format: "%.2f", results[indexPath.row].vote_average)
        return cell
    }
    
    
}

