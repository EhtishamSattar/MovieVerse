//
//  HomeView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    //@State var count = 0
    var imageUrl : URL?
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        //GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    let url = URL(string: "https://picsum.photos/300")
    var body: some View {
        NavigationView{
            VStack{
                //                SearchField(placeholderText: "Search Movie", searchText: $movies_Data.searchValue)
                //                    .onChange(of: movies_Data.debouncedSearchValue) {newValue in
                //                        print(newValue)
                //                        Task{
                //                            await movies_Data.getSearchMovieData(movieName: newValue)
                //                        }
                //                    }
                
                SearchField(placeholderText: "Search from Recently Viewed", searchText: $movies_Data.localSearchValue)
                    .onChange(of: movies_Data.debouncedLocalSearchValue){ newValue in
                        print(newValue)
                        // will change this method
                        movies_Data.getSearchedMoviesFromRecentlyViewed(movieName: newValue)                }
                Spacer()
                
                if movies_Data.movies.isEmpty {
                    NoMovieFoundView(message: "No Movie Found", subMessage: "Check you Internet Connection")
                    Spacer()
                }else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(movies_Data.movies.enumerated()), id: \.offset) { index, movie in
                                    MovieCardScrollable(movies_Data: movies_Data, index: index, movie: movie)
                                }
                            }
                            .padding(30)
                            .background(Color("BackgroundColor"))
                            .frame(maxHeight: 400)
                            
                        }
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity, maxHeight: 720)
                        
                        
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: [.sectionHeaders]
                        ) {
                            Section(header: ZStack {
                                Text("Movies")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.white)
                                    .background(Color("BackgroundColor"))
                                    .font(.headline.weight(.bold))
                                    .font(.largeTitle)
                            }) {
                                ForEach(Array(movies_Data.movies.enumerated()), id: \.offset) { index, movie in
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
                
            }
            .padding(.horizontal)
            .background(Color("BackgroundColor"))
        }
        
        
    }
}

#Preview {
    HomeView(movies_Data: MoviesViewModel())
}
