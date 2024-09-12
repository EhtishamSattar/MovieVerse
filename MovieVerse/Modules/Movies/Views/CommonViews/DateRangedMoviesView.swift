//
//  DateRangedMoviesView.swift
//  MovieVerse
//
//  Created by Mac on 10/09/2024.
//

import SwiftUI

struct DateRangedMoviesView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    @State var showSheet = false
    
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
                Text("Movies in Date Range")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color("BackgroundColor"))
                    .font(.headline.weight(.bold))
                    .font(.largeTitle)
                Spacer()
                Button {
                    print("Calender clicked")
                    showSheet = true
                } label: {
                    Image(systemName: "calendar")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .background(Color("BackgroundColor"))
                        .padding(.horizontal)
                    
                }
            }
                .frame(maxWidth: .infinity)
                .background(Color("BackgroundColor"))
                    
            ) {
                
                // handle here the date ranged data
                
                if !movies_Data.dateRangeMovies.isEmpty {
                    ForEach(Array(movies_Data.dateRangeMovies.enumerated()), id: \.offset) { index, movie in
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
                    
                    Text("Please select a valid date range")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $showSheet, content: {
            DateRangePickerAlert(movies_Data: movies_Data, isPresented: $showSheet)
                .background(Color("BackgroundColor"))
                .foregroundColor(.white)
                .frame(maxWidth: 400,minHeight: 400)
            
            
            
        })
    }
}

#Preview {
    DateRangedMoviesView(movies_Data: MoviesViewModel())
}
