//
//  MovieManager.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//

import Foundation
import CoreData
import SwiftUI

class MovieManager: ObservableObject {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    // Check if a movie is present in Core Data
    func checkMovieIsPresent(movieId: Int32) -> Bool {
        let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error fetching movies: \(error)")
            return false
        }
    }
    
     //Create a new movie entry
    func createData(movie: MovieItem?) {
        if let movie = movie {
            if !checkMovieIsPresent(movieId: Int32(movie.id)) {
                //print("Creating movie...\(viewContext)")
                //MovieItem(movie)
                let entity = NSEntityDescription.entity(forEntityName: "MovieItem", in: viewContext)
                var newItem = MovieItem(entity: entity!, insertInto: viewContext)
                //var newItem = MovieItem(context: viewContext)
                //movieItem = movie
                newItem.timestamp = Date()
                newItem.id = Int32(movie.id)
                newItem.title = movie.title
                newItem.release_date = movie.release_date
                newItem.original_title = movie.original_title
                newItem.original_language = movie.original_language
                newItem.adult = movie.adult
                newItem.backdrop_path = movie.backdrop_path
                newItem.poster_path = movie.poster_path
                newItem.popularity = movie.popularity
                newItem.genre_ids = movie.genre_ids
                newItem.overview = movie.overview
                newItem.video = movie.video
                newItem.vote_count = Int32(movie.vote_count)
                newItem.vote_average = movie.vote_average
//                // Set other properties as needed
                print("after creating")
                
                do {
                    
                    try viewContext.save()
                } catch {
                    print("Error saving movie: \(error)")
                }
            }
        }
    }
    
    func getRecentlyViewedData() -> [MovieItem] {
        let fetchRequest: NSFetchRequest<MovieItem> = MovieItem.fetchRequest()
        var results : [MovieItem] = []
        do {
            results = try viewContext.fetch(fetchRequest)
            
        } catch {
            print("Error fetching movies: \(error)")
            
        }
        return results
    }
}
