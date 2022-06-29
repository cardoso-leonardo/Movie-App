//
//  Constants.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//
import Foundation
struct K {
    struct networking {
        static let baseUrl = "https://api.themoviedb.org/3/trending/movie/week?api_key="
        static let apiKey = ""
        static let fullURL = baseUrl + apiKey
        static let imageUrl = "https://image.tmdb.org/t/p/original/"
    }
    
    struct tableView {
        static let cellId = "cell"
    }
}
