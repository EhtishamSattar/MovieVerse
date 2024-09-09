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
    
    //    func getMoviesData(pageNumber : Int) async throws -> MoviesData? {
    //        api_Url = api_Url + "&page=\(pageNumber)"
    //
    //        if let api_Url = URL(string: api_Url) {
    //
    //                let decoder = JSONDecoder()
    ////                guard let contextKey = CodingUserInfoKey.context else {
    ////                    fatalError("Failed to retrieve context key.")
    ////                }
    ////                decoder.userInfo[contextKey] =  PersistenceController.shared.container.viewContext
    //
    //            let (data, error) = try await URLSession.shared.data(from: api_Url)
    //            print(error)
    //
    //            print("this is error ..... ", error)
    //
    //            let moviesData = try decoder.decode(MoviesData.self, from: data)
    //            return moviesData
    //        }
    //        return nil
    //    }
    
    func getMoviesData(pageNumber : Int) async throws -> MoviesData? {
        api_Url = api_Url + "&page=\(pageNumber)"
        
        
        guard let api_Url = URL(string: api_Url) else {
            throw NetworkError.badUrl
        }
        
        do {
            let decoder = JSONDecoder()
            //                guard let contextKey = CodingUserInfoKey.context else {
            //                    fatalError("Failed to retrieve context key.")
            //                }
            //                decoder.userInfo[contextKey] =  PersistenceController.shared.container.viewContext
            
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
    
    //    func fetchUpcomingMovies(pageNumber: Int) async throws -> MoviesData?  {
    //        upComingMoviesUrl = upComingMoviesUrl + "&page=\(pageNumber)"
    //        //print(upComingMoviesUrl)
    //        if let upComingMoviesUrl = URL(string: upComingMoviesUrl) {
    //            let (data, response) = try await URLSession.shared.data(from: upComingMoviesUrl)
    //
    //            //print("status...",error.status)
    //            if  response.statusCode == 200 {
    //                let moviesData = try JSONDecoder().decode(MoviesData.self, from: data)
    //
    //                return moviesData
    //            }
    //
    //        }
    //        return nil
    //    }
    func fetchUpcomingMovies(pageNumber: Int) async throws -> MoviesData? {
        // Use a local constant for URL construction to avoid side effects
        let urlString = upComingMoviesUrl + "&page=\(pageNumber)"
        
        // Safely unwrap the URL
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
