//
//  Movie.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

struct Movie : Codable , Hashable {
    var adult : Bool
    var backdrop_path : String?
    var genre_ids : [Int]
    var id : Int
    var original_language : String
    var original_title : String
    var overview : String
    var popularity : Double
    var poster_path : String
    var release_date : String
    var title : String
    var video : Bool
    var vote_average : Double
    var vote_count : Double
    
}

//enum Language : String {
//    case .en = "en"
//    case .hi = "hi"
//}
