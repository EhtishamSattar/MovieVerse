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
            if movies_Data.movies.isEmpty{
                VStack{
                    Spacer()
                    NoMovieFoundView(message: "No movie Found",subMessage: "Please Search movie by a good title name")
                    Spacer()
                }
                
            }else{
                LazyVStack{
                    ForEach(Array(movies_Data.movies.enumerated()), id: \.offset){ index, movie in
                        LSMovieCard(movies_Data: movies_Data,movie: movie, index: index)
                            .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                            .padding()
                    }
                }
                
            }
        }
        else{
            LazyVStack{
                ForEach(Array(movies_Data.searchedMovies.enumerated()), id: \.offset){ index, movie in
                    LSMovieCard(movies_Data: movies_Data,movie: movie, index: index)
                        .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    GlobalSearchContainer(movies_Data: MoviesViewModel())
}
