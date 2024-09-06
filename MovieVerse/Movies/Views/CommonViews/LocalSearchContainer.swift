//
//  LocalSearchContainer.swift
//  MovieVerse
//
//  Created by Mac on 06/09/2024.
//

import SwiftUI

struct LocalSearchContainer: View {
    @ObservedObject var movies_Data : MoviesViewModel
    
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
            Section(header: ZStack {
                Text("Movies")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color("BackgroundColor"))
                    .font(.headline.weight(.bold))
                    .font(.largeTitle)
            }) {
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
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    LocalSearchContainer(movies_Data: MoviesViewModel())
}
