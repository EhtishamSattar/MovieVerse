//
//  MoviesViewModel.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import Foundation

@MainActor
class MoviesViewModel : ObservableObject {
    @Published var moviesData : MoviesData = MoviesData()
    @Published var movies : [Movie] = []
    @Published var pageNumber : Int = 1
    @Published var count : Int = 0
    var resultsSize = 20
    @Published var searchValue = ""
    @Published var debouncedSearchValue = ""
    
    // Singleton Class shared instance
    let shared = BaseApi.shared
    
    init() {
        // it is necessary to setup the debounce method on Class initialization
        setDebouncedSearchValue()
        Task {
            await getMoviesData()
        }
    }

    func getMoviesData() async {
        do {
            if let data = try await shared.getMoviesData(pageNumber: self.pageNumber) {
                self.moviesData = data
                if let movies = data.results {
                    self.movies = self.movies + movies
                }
            }
        } catch {
            print("Failed to fetch movies data: \(error)")
        }
    }

    func getPosterImageURL(path: String) -> URL? {
        return URL(string: Constants.posterImageUrl + path)
    }

    func loadMoreData() async {
        print("\(moviesData.total_results)-- \(count)")
        
        Task{
            let preheadCount = count + 4
            if preheadCount < moviesData.total_results {
                print("iN IF")
                
                // > phly mery pas movie card ka onAppear count 16 miss kr rha tha is liye lgaya
                
                if preheadCount >= resultsSize * pageNumber {
                    pageNumber = preheadCount / resultsSize
                    print("fetching data for \(pageNumber)")
                    pageNumber = pageNumber + 1
                    await getMoviesData()
                }
            }
            
        }
        
    }
    
    func setDebouncedSearchValue(){
        $searchValue
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchValue)
                      
    }

    func getSearchMovieData(movieName: String) async {
        if !movieName.isEmpty {
            do {
                if let data = try await shared.getSearhedMovieData(name: movieName){
                    self.moviesData = data
                    self.movies = []
                    if let movies = data.results {
                        self.movies = self.movies + movies
                    }
                }
            } catch {
                print("Failed to fetch movies data: \(error)")
            }
        }else {
            print("search empty")
            await getMoviesData()
        }
        
    }

}
