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
                Spacer()
                NoMovieFoundView(message: "No movie Found",subMessage: "View some Movie first to search for it in recently viewed")
                Spacer()
            }else{
                LazyVStack{
                    ForEach(movies_Data.movies, id: \.self){ movie in
                        LSMovieCard(movies_Data: movies_Data,movie: movie, count: $movies_Data.count)
                            .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                            .padding()
                    }
                }
                
            }
        }
        else{
            LazyVStack{
                ForEach(movies_Data.searchedMovies, id: \.self){ movie in
                    LSMovieCard(movies_Data: movies_Data,movie: movie, count: $movies_Data.count)
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
