//
//  MoviesData.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

struct MoviesData : Codable {
    var page : Int = 0
    var results : [Movie]? = []
    var total_pages : Int = 0
    var total_results : Int = 0
}
