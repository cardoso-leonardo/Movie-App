//
//  MovieManager.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//

import Foundation
import UIKit

protocol MovieManagerDelegate {
    func didUpdateMovies(_ manager: MovieManager, model: Movies)
    func didFailWithError(error: Error)
}

struct MovieManager {
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovies() {
        let url = URL(string:K.networking.fullURL)
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let e = error {
                delegate?.didFailWithError(error: e)
                return
            }
            if let data = data {
                if let safeData = parseJSON(data: data) {
                    delegate?.didUpdateMovies(self, model: safeData)
                }
            }
    
        }
        dataTask.resume()
        print("Fetching data")
    }
    
    
    func parseJSON(data: Data) -> Movies? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(Movies.self, from: data)
            return data
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
