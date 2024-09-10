//
//  RecentlyViewedMoviesView.swift
//  MovieVerse
//
//  Created by Mac on 10/09/2024.
//

import SwiftUI

struct RecentlyViewedMoviesView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(Array(movies_Data.recentlyViewedMovies.enumerated()), id: \.offset) { index,movieItem in
                
                NavigationLink {
                    MovieDetailsView(movies_Data: movies_Data, movie: movieItem)
                } label: {
                    LSMovieCard(movies_Data: movies_Data,movie: movieItem, index: index)
                        .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                        .padding(.vertical)
                }

                
            }
            
        }
    }
}

#Preview {
    RecentlyViewedMoviesView(movies_Data: MoviesViewModel())
}
