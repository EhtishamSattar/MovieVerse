////
////  BaseApi.swift
////  MovieVerse
////
////  Created by Mac on 02/09/2024.
////
//
//import Foundation
//
//class BaseApi {
//    
//    static var shared = BaseApi()
//    
//    private init () { }
//    
//    var api_Url = Constants.baseApiUrl
//    var searchApi_Url = Constants.baseSearchApiUrl
//    var upComingMoviesUrl = Constants.upComingMoviesUrl
//
//    // General Fetch Function
//    func fetchMovies(pageNumber : Int, api_Url: String) async throws -> MoviesData? {
//        
//        guard let api_Url = URL(string: api_Url) else {
//            throw NetworkError.badUrl
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            
//            let (data, response) = try await URLSession.shared.data(from: api_Url)
//            print(response)
//            
//            guard let httpUrlResponse = response as? HTTPURLResponse , httpUrlResponse.statusCode == 200 else {
//                throw NetworkError.badServerResponse
//            }
//            
//            print("this is response..... ", response)
//            
//            if data.isEmpty {
//                throw NetworkError.badDataResonse
//            }
//            let moviesData = try decoder.decode(MoviesData.self, from: data)
//            return moviesData
//            
//        } catch {
//            print("============",error)
//            throw NetworkError.badServerResponse
//            
//        }
//        
//    }
//     
//    func getMoviesData(pageNumber : Int) async throws -> MoviesData? {
//        
//        api_Url = api_Url + "&page=\(pageNumber)"
//        do {
//            return try await fetchMovies(pageNumber: pageNumber, api_Url: api_Url)
//        } catch {
//            print(error)
//        }
//        return nil
//    
//    }
//    
//    // take movie name as parameter and , default parameter pageNumber
//    func getSearhedMovieData(name : String, _ pageNumber : Int = 1) async throws -> MoviesData? {
//        
//        searchApi_Url = searchApi_Url + "&query=\(name)&page=\(pageNumber)"
//        
//        do {
//            return try await fetchMovies(pageNumber: pageNumber, api_Url: searchApi_Url)
//        } catch {
//            print(error)
//        }
//        return nil
//        
//    }
//    
//    // fetching upcoming movies
//    func fetchUpcomingMovies(pageNumber: Int) async throws -> MoviesData? {
//        
//        upComingMoviesUrl = upComingMoviesUrl + "&page=\(pageNumber)"
//        
//        do {
//            return try await fetchMovies(pageNumber: pageNumber, api_Url: upComingMoviesUrl)
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//}


//MARK: Code on Integrating Alamofire
import Foundation
import Alamofire

class BaseApi {
    
    static var shared = BaseApi()
    
    private init () { }
    
    // General Fetch Function using Alamofire
    func fetchMovies(router: ServiceRouter) async throws -> MoviesData? {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(router)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: MoviesData.self) { response in
                    switch response.result {
                    case .success(let moviesData):
                        continuation.resume(returning: moviesData)
                    case .failure(let error):
                        print("Error fetching data:", error)
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    // Get Movies Data
    func getMoviesData(pageNumber: Int) async throws -> MoviesData? {
        do {
            return try await fetchMovies(router: .getMovies(pageNumber))
        } catch {
            print("Error:", error)
            throw error
        }
    }
    
    // Search Movies by Name
    func getSearhedMovieData(name: String, pageNumber: Int = 1) async throws -> MoviesData? {
        do {
            return try await fetchMovies(router: .searchMovies(name))
        } catch {
            print("Error:", error)
            throw error
        }
    }
    
    // Fetch Upcoming Movies
    func fetchUpcomingMovies(pageNumber: Int) async throws -> MoviesData? {
        do {
            return try await fetchMovies(router: .getUpcomingMovies(pageNumber))
        } catch {
            print("Error:", error)
            throw error
        }
    }
}

