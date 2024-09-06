//
//  constant.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

// https://api.themoviedb.org/3/movie/popular?api_key=2869a4ca70a9ba43c2c594b9310f0c75&page=2

struct Constants {
    /// My api key
    static let baseApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=2869a4ca70a9ba43c2c594b9310f0c75"
    
    ///Faheem Bhai's url
//    static let baseApiUrl = "https://api.themoviedb.org/3/search/movie?api_key=e5ea3092880f4f3c25fbc537e9b37dc1"
    
    
    static let baseSearchApiUrl = "https://api.themoviedb.org/3/search/movie?api_key=2869a4ca70a9ba43c2c594b9310f0c75"
    static let ImageUrl = "https://image.tmdb.org/t/p/w500/"
    static let upComingMoviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=e5ea3092880f4f3c25fbc537e9b37dc1"
    
    
    enum Image {
        case posterImage
        case backDropImage
        
    }
    
    static func getImageURL(path: String,typeImage: Image) -> URL? {
        switch typeImage {
        case .posterImage:
            return URL(string: "https://image.tmdb.org/t/p/w92/" + path)
        case .backDropImage:
            return URL(string: "https://image.tmdb.org/t/p/w500/" + path)
        }
    }
    
}

