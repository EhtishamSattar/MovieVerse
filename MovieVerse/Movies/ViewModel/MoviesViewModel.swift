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
    // globaly Search movie in movies
    @Published var movies : [MovieItem] = []
    
    //locally searched movies in localmovies
    @Published var localmovies : [MovieItem] = []
    
    @Published var pageNumber : Int = 1
    @Published var count : Int = 0
    var resultsSize = 20
    @Published var searchValue = ""
    @Published var debouncedSearchValue = ""
    @Published var localSearchValue = ""
    @Published var debouncedLocalSearchValue = ""
    var movieManager = MovieManager()
    @Published var recentlyViewedMovies : [MovieItem] = []
    
    // Singleton Class shared instance
    let shared = BaseApi.shared
    
    init() {
        // it is necessary to setup the debounce method on Class initialization
        setDebouncedSearchValue()
        setDebouncedLocalSearchValue()
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
        return Constants.getImageURL(path: path, typeImage: .backDropImage)
    }
    
    func getBackdropPath(path: String? ) -> URL? {
        if let path = path {
            return Constants.getImageURL(path: path, typeImage: .backDropImage)
            //return URL(string: Constants.ImageUrl + path)
        }
        return nil
        
    }

    func loadMoreData() async {
        //print("\(moviesData.total_results)-- \(count)")
        
        Task{
            let preheadCount = count + 4
            if preheadCount < moviesData.total_results {
                
                // print("iN IF")
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
    
    func setDebouncedLocalSearchValue(){
        $localSearchValue
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedLocalSearchValue)
                      
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
    
    func getRecentlyViewedData(){
        recentlyViewedMovies = movieManager.getRecentlyViewedData()
        localmovies = recentlyViewedMovies
    }
    
    func getSearchedMoviesFromRecentlyViewed(movieName: String) {
        // Check if the movie name is not empty
        if !movieName.isEmpty {
            // Clear the local movies array before adding new search results
            localmovies.removeAll()

            // Loop through the recently viewed movies
            for movie in recentlyViewedMovies {
                // Check if either title or original_title contains the search string
                if let title = movie.title, title.contains(movieName) {
                    print("Appending movies")
                    localmovies.append(movie)
                } else if let originalTitle = movie.original_title, originalTitle.contains(movieName) {
                    print("Appending movies")
                    localmovies.append(movie)
                }

            }
        } else {
            // If search term is empty, show all recently viewed movies
            localmovies.removeAll()
            localmovies = recentlyViewedMovies
        }
    }


}
