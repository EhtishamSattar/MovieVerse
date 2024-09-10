//
//  HomeView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct HomeView: View {
   
    @ObservedObject var movies_Data : MoviesViewModel
    
    var body: some View {
        NavigationView{
            if movies_Data.apiErrorMessage != "" {
                NoMovieFoundView(message: movies_Data.apiErrorMessage, subMessage: "")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("BackgroundColor"))
            }else {
                VStack{
                    SearchField(placeholderText: "Search from Locals", searchText: $movies_Data.localSearchValue)
                        .onChange(of: movies_Data.debouncedLocalSearchValue){ newValue in
                            print(newValue)
                            movies_Data.searchMoviefromLocals(movieName: newValue)
                        }
                    Spacer()
                    
                    if movies_Data.movies.isEmpty {
                        NoMovieFoundView(message: "No Movie Found", subMessage: "Check you Internet Connection")
                        Spacer()
                    }else {
                        ScrollView(.vertical, showsIndicators: false) {
                            Text("Upcoming Movies")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                                .background(Color("BackgroundColor"))
                                .font(.headline.weight(.bold))
                                .font(.largeTitle)
                            
                            // Upcoming movie Container
                            UpComingMoviesView(movies_Data: movies_Data)
                            
                            // Local movies
                            LocalSearchContainer(movies_Data: movies_Data)
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                }
                .padding(.horizontal)
                .background(Color("BackgroundColor"))
            }
            
        }
    
    }
}

#Preview {
    HomeView(movies_Data: MoviesViewModel())
}
