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
    var upComingMoviesUrl = Constants.upComingMoviesUrl
    
    func getMoviesData(pageNumber : Int) async throws -> MoviesData? {
        
        api_Url = api_Url + "&page=\(pageNumber)"
        
        
        guard let api_Url = URL(string: api_Url) else {
            throw NetworkError.badUrl
        }
        
        do {
            let decoder = JSONDecoder()
            
            let (data, response) = try await URLSession.shared.data(from: api_Url)
            print(response)
            
            guard let httpUrlResponse = response as? HTTPURLResponse , httpUrlResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            
            print("this is response..... ", response)
            
            if data.isEmpty {
                throw NetworkError.badDataResonse
            }
            let moviesData = try decoder.decode(MoviesData.self, from: data)
            return moviesData
            
        } catch {
            print("============",error)
            throw NetworkError.badServerResponse
            
        }
    
    }
    
    // take movie name as parameter and , default parameter pageNumber
    func getSearhedMovieData(name : String, _ pageNumber : Int = 1) async throws -> MoviesData? {
        
        searchApi_Url = searchApi_Url + "&query=\(name)&page=\(pageNumber)"
        
        guard let searchApi_Url = URL(string: searchApi_Url ) else {
            throw NetworkError.badUrl
        }
        
        do{
            
            let (data, response) = try await URLSession.shared.data(from: searchApi_Url)
            print(response)
            
            guard let httpUrlResponse = response as? HTTPURLResponse , httpUrlResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            
            if data.isEmpty {
                throw NetworkError.badDataResonse
            }
            
            let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
            return moviesData
            
        } catch {
            
            print(error)
            throw NetworkError.badServerResponse
        }
        
    }
    
    
    func fetchUpcomingMovies(pageNumber: Int) async throws -> MoviesData? {
        
        let urlString = upComingMoviesUrl + "&page=\(pageNumber)"
        
        guard let upComingMoviesUrl = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        
        do {
            
            let (data, response) = try await URLSession.shared.data(from: upComingMoviesUrl)
            
            /// as? is a type casting operator in Swift used for conditional type casting. return nil if there is possibility of casting failure
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.badServerResponse
            }
            
            if data.isEmpty {
                throw NetworkError.badDataResonse
            }
            
            let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
            return moviesData
            
        } catch {
            
            print("Error fetching movies: \(error.localizedDescription)")
            throw error
        }
    }
}
