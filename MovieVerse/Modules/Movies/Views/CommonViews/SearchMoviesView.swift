//
//  SearchMoviesView.swift
//  MovieVerse
//
//  Created by Mac on 10/09/2024.
//

import SwiftUI

struct SearchMoviesView: View {
    
    @ObservedObject var movies_Data : MoviesViewModel
    
    var body: some View {
        LazyVStack{
            ForEach(Array(movies_Data.searchedMovies.enumerated()), id: \.offset){ index, movie in
                LSMovieCard(movies_Data: movies_Data,movie: movie, index: index)
                    .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                    .padding()
            }
        }
    }
}

#Preview {
    SearchMoviesView(movies_Data: MoviesViewModel())
}
