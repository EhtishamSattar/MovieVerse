//
//  MoviesViewModel.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

class MoviesViewModel : ObservableObject {
    @Published var moviesData : MoviesData = MoviesData()
    
    let shared = BaseApi.shared
    init() {
        Task {
            await getMoviesData()
        }
    }

    func getMoviesData() async {
        do {
            if let data = try await shared.getMoviesData() {
                self.moviesData = data
            }
        } catch {
            print("Failed to fetch movies data: \(error)")
        }
    }

    func getPosterImageURL(path: String) -> URL? {
        return URL(string: Constants.posterImageUrl + path)
    }



}
