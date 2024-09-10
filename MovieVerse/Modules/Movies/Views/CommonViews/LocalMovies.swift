//
//  LocalMovies.swift
//  MovieVerse
//
//  Created by Mac on 10/09/2024.
//

import SwiftUI

struct LocalMovies: View {
    
    @ObservedObject var movies_Data: MoviesViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        //GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 10,
            pinnedViews: [.sectionHeaders]
        ) {
            Section(header:
                        HStack{
                Text("Movies")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color("BackgroundColor"))
                    .font(.headline.weight(.bold))
                    .font(.largeTitle)
            }
                .frame(maxWidth: .infinity)
                .background(Color("BackgroundColor"))
                    
            ) {
                
                // handle here the date ranged data
                
                if !movies_Data.localmovies.isEmpty {
                    ForEach(Array(movies_Data.localmovies.enumerated()), id: \.offset) { index, movie in
                        NavigationLink(destination: MovieDetailsView(movies_Data: movies_Data, movie: movie)) {
                            MovieCard(
                                movies_Data: movies_Data,
                                movieImage: movies_Data.getBackdropPath(path: movie.poster_path ?? ""),
                                title: movie.title ?? "none",
                                description: movie.overview ?? "none",
                                rating: movie.vote_average,
                                count: $movies_Data.count
                            )
                        }
                        
                    }
                }
                else {
                    
                    NoMovieFoundView(message: "No such Movie Found in Locals", subMessage: "")
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    LocalMovies(movies_Data: MoviesViewModel())
}
