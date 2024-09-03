//
//  BaseApi.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

class BaseApi {
    
    static var shared = BaseApi()
    
    private init () { }
    
    var api_Url = Constants.baseApiUrl
    var searchApi_Url = Constants.baseSearchApiUrl
    
    func getMoviesData(pageNumber : Int) async throws -> MoviesData? {
        api_Url = api_Url + "&page=\(pageNumber)"
        
        if let api_Url = URL(string: api_Url) {
            let (data, error) = try await URLSession.shared.data(from: api_Url)
            print(error)
            let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
            return moviesData
        }
        return nil
    }
    
    func getSearhedMovieData(name : String, _ pageNumber : Int = 1) async throws -> MoviesData? {
        searchApi_Url = searchApi_Url + "&query=\(name)&page=\(pageNumber)"
        
        if let searchApi_Url = URL(string: searchApi_Url) {
            let (data, error) = try await URLSession.shared.data(from: searchApi_Url)
            print(error)
            let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
            return moviesData
        }
        return nil
    }
}
