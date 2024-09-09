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
    
    //search Movies result
    @Published var searchedMovies : [MovieItem] = []
    
    // recently viewed movies
    @Published var recentlyViewedMovies : [MovieItem] = []
    
    @Published var upComingMovies : [MovieItem] = []
    // pages
    @Published var pageNumber : Int = 1
    @Published var count : Int = 0
   
    @Published var upComingPageNumber : Int = 1
    @Published var upComCount : Int = 0
    @Published var upComResults : Int = 0
    
    //Search Values
    @Published var searchValue = ""
    @Published var debouncedSearchValue = ""
    @Published var localSearchValue = ""
    @Published var debouncedLocalSearchValue = ""
    
    
    // Singleton Class shared instance
    let shared = BaseApi.shared
    var resultsSize = 20
    var movieManager = MovieManager()
    
    // Error message
    @Published var apiErrorMessage : String = ""
    
    // Initializing Data
    init() {
        // it is necessary to setup the debounce method on Class initialization
        setDebouncedSearchValue()
        setDebouncedLocalSearchValue()
        Task {
            //Async Calls
            await fetchServingMoviesData()
            await getUpcomingMovies()
        }
        getRecentlyViewedData()
        
    }
    
    // this is the starter data fetching function that every users will see when coming on first time
    func fetchServingMoviesData() async {
        
        do {
            count = 0
            pageNumber = 1
            searchedMovies = []
            if let data = try await shared.getMoviesData(pageNumber: self.pageNumber) {
                self.moviesData = data
                if let movies = data.results {
                    // Inititalizing movies
                    self.movies = movies
                    
                    //Initializing local movies with 20 data on app start
                    self.localmovies.insert(contentsOf: movies, at: localmovies.endIndex)
                }
            }
            apiErrorMessage = ""
        } catch {
            print("Failed to fetch movies data: \(error)")
            handleError(NetworkError.badServerResponse)
        }
    }
    
    
    // this function is for Data fetching based on pageNumber - Helps in Pagination
    func getMoviesData() async {
        
        do {
            print(count)
            let preheadCount = count + 4
            if preheadCount < moviesData.total_results {
                
                // print("iN IF")
                // > phly mery pas movie card ka onAppear count 16 miss kr rha tha is liye lgaya
                
                if preheadCount >= resultsSize * pageNumber {
                    pageNumber = preheadCount / resultsSize
                    print("fetching data for \(pageNumber)")
                    pageNumber = pageNumber + 1
                    
                    //await getMoviesData()
                    
                    if let data = try await shared.getMoviesData(pageNumber: self.pageNumber) {
                        self.moviesData = data
                        if let movies = data.results {
                            self.movies = self.movies + (moviesData.results ?? [])
                            self.localmovies.insert(contentsOf: movies, at: localmovies.endIndex)
                        }
                    }
                }
            }
            apiErrorMessage = ""
            
        } catch {
            print("Failed to fetch movies data: \(error)")
            handleError(NetworkError.badServerResponse)
        }
    }
    
    // Fetching Upcoming Movies Data
    func getUpcomingMovies() async {
        
        if !upComingMovies.isEmpty {
            //print("----", upComCount)
            let preheadCount = upComCount + 4
            print(upComCount)
            if preheadCount < upComResults {
                //print("innnnnn")
                if  preheadCount >= resultsSize * upComingPageNumber {
                    upComingPageNumber = upComingPageNumber + 1
                    //print("SGFSDGSDGSDXGDSDG",upComingPageNumber)
                    do {
                        if let data = try await shared.fetchUpcomingMovies(pageNumber: self.upComingPageNumber) {
                            //self.moviesData = data
                            upComCount = data.total_results
                            if let movies = data.results {
                                // Inititalizing movies
                                self.upComingMovies = self.upComingMovies + movies
                            }
                            print("Upcoming movies----",self.upComingMovies)
                        }
                    }catch {
                        //print("in view Model", error)
                        //fatalError("\(error)")
                        handleError(NetworkError.badServerResponse)
                    }
                }
                
            }
            apiErrorMessage = ""
            
        }else{
            do {
                if let data = try await shared.fetchUpcomingMovies(pageNumber: self.upComingPageNumber) {
                    //self.moviesData = data
                    upComResults = data.total_results
                    if let movies = data.results {
                        // Inititalizing movies
                        self.upComingMovies = movies
                    }
                    //print("Upcoming movies----",self.upComingMovies)
                }
                apiErrorMessage = ""
            }catch {
                print("in view Model", error)
                handleError(NetworkError.badServerResponse)
                //fatalError("\(error)")
            }
        }
        
        
        
    }
    
    
    // helper function to get PosterImage Url by appending path to base url
    func getPosterImageURL(path: String) -> URL? {
        
        return Constants.getImageURL(path: path, typeImage: .posterImage)
    }
    
    // helper function to get Backdrop Url by appending path to base url
    func getBackdropPath(path: String? ) -> URL? {
        
        if let path = path {
            return Constants.getImageURL(path: path, typeImage: .backDropImage)
            //return URL(string: Constants.ImageUrl + path)
        }
        return nil
        
    }
    
    // this function is not used - Previously used for pagination purpose
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
    
    // Debounced value for global Search text
    func setDebouncedSearchValue(){
        
        $searchValue
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchValue)
        
    }
    
    // Debounced value for local Search text
    func setDebouncedLocalSearchValue(){
        
        $localSearchValue
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedLocalSearchValue)
        
    }
    
    
    // function to search Movies from api , this is initializing the searchMovies again and again
    func getSearchMovieData(movieName: String) async {
        
        if !movieName.isEmpty {
            do {
                if let data = try await shared.getSearhedMovieData(name: movieName){
                    self.moviesData = data
                    self.searchedMovies = []
                    if let movies = data.results {
                        self.searchedMovies = self.searchedMovies + movies
                        //Appending Searched movies at the end of localmovies
                        //self.localmovies.insert(contentsOf: movies, at: self.localmovies.endIndex)
                    }
                }
            } catch {
                print("Failed to fetch movies data: \(error)")
            }
        }else {
            print("search empty")
            await fetchServingMoviesData()
        }
        
    }
    
    // This function brings the data from CoreData - I stored Recently Viewed movies in Core Data
    func getRecentlyViewedData(){
        
        recentlyViewedMovies = movieManager.getRecentlyViewedData()
        //localmovies = recentlyViewedMovies
    }
    
    // this function used in searching movie from the localmovies
    func searchMoviefromLocals(movieName: String) {
    
        if !movieName.isEmpty {
            localmovies.removeAll()
        
            for movie in movies {
                
                if let title = movie.title, title.contains(movieName) {
                    print("Appending movies")
                    localmovies.append(movie)
                } else if let originalTitle = movie.original_title, originalTitle.contains(movieName) {
                    print("Appending movies")
                    localmovies.append(movie)
                }
                
                
            }
            print("moviesss",localmovies)
        } else {
          //  localmovies.removeAll()
            localmovies = movies
        }
    }
    
    // Addding Data to Core Data
    func addMovieToRecentlyViewed(movie: MovieItem){
        
        movieManager.createData(movie: movie)
        getRecentlyViewedData()
    }
    
    
    // handling error
    func handleError(_ error: Error) {
            switch error {
            case NetworkError.badDataResonse:
                apiErrorMessage = "Bad Data."
            case NetworkError.badServerResponse:
                print("in it")
                apiErrorMessage = "Check Your Internet Connection."
                print("***",apiErrorMessage)
            case NetworkError.badUrl:
                apiErrorMessage = "Bad Url. Check your Url."
            default:
                apiErrorMessage = "Something went wrong!"
            }
        }
    
}
