//
//  UpComingMoviesView.swift
//  MovieVerse
//
//  Created by Mac on 10/09/2024.
//

import SwiftUI

struct UpComingMoviesView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(Array(movies_Data.upComingMovies.enumerated()), id: \.offset) { index, movie in
                    MovieCardScrollable(movies_Data: movies_Data, index: index, movie: movie)
                }
            }
            .padding(30)
            .background(Color("BackgroundColor"))
            .frame(maxHeight: 300)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 720)
    }
}

#Preview {
    UpComingMoviesView(movies_Data: MoviesViewModel())
}
