//
//  GlobalSearchContainer.swift
//  MovieVerse
//
//  Created by Mac on 06/09/2024.
//

import SwiftUI

struct GlobalSearchContainer: View {
   
    @ObservedObject var movies_Data : MoviesViewModel
    
    var body: some View {
        if movies_Data.searchedMovies.isEmpty {
            if movies_Data.searchValue.isEmpty {
                Text("Please search for a movie")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.green)
            }else {
                Text("No related movies to your search")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.red)
            }
            
            
            if movies_Data.movies.isEmpty {
                VStack{
                    Spacer()
                    NoMovieFoundView(message: "No movie Found",subMessage: "Please Search movie by a good title name")
                    Spacer()
                }
                
            }else{
                LazyVStack{
                    Text("Look at these movies")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.blue)
                        .font(.caption)
                        .padding(.horizontal)
                    ForEach(Array(movies_Data.movies.enumerated()), id: \.offset){ index, movie in
                        LSMovieCard(movies_Data: movies_Data,movie: movie, index: index)
                            .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                            .padding()
                    }
                }
                
            }
        }
        else{
            
            SearchMoviesView(movies_Data: movies_Data)
        }
    }
}

#Preview {
    GlobalSearchContainer(movies_Data: MoviesViewModel())
}
