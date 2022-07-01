//
//  MovieModel.swift
//  Movie App
//
//  Created by Leonardo Cardoso on 28/06/22.
//

import Foundation

struct Movies: Codable {
    let movies: [MovieModel]
}

struct MovieModel: Codable {
    let title: String
    let overview: String
    let release_date: String
    let vote_average: Double
    let poster_path: String
}
