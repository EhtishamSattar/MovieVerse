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
    
    func getMoviesData() async throws -> MoviesData? {
        if let api_Url = api_Url {
            let (data, error) = try await URLSession.shared.data(from: api_Url)
            print(error)
            let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
            return moviesData
        }
        return nil
    }
}
