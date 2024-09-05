//
//  LocalSearchView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct LocalSearchView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    @State var searchValue : String = ""
    var body: some View {
        VStack{
            SearchField(placeholderText: "Search from Recently Viewed", searchText: $movies_Data.localSearchValue)
                .onChange(of: movies_Data.debouncedLocalSearchValue){ newValue in
                    print(newValue)
                    movies_Data.getSearchedMoviesFromRecentlyViewed(movieName: newValue)                }
            
            if movies_Data.localmovies.isEmpty{
                Spacer()
                NoMovieFoundView(message: "No movie Found",subMessage: "View some Movie first to search for it in recently viewed")
                Spacer()
            }else{
                ScrollView(showsIndicators: false, content: {
                    ForEach(movies_Data.localmovies, id: \.self){ movie in
                        LSMovieCard(movies_Data: movies_Data,movie: movie)
                            .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                            .padding()
                    }
                })
            }
        }
        .background(Color("BackgroundColor"))
        .onAppear(perform: {
            movies_Data.getRecentlyViewedData()
        })
        //.frame(maxWidth: .infinity,maxHeight: .infinity)
        
        
    }
}

#Preview {
    LocalSearchView(movies_Data: MoviesViewModel())
}
