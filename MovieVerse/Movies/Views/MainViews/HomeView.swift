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
    //var imageUrl : URL?
    
    //let url = URL(string: "https://picsum.photos/300")
    var body: some View {
        NavigationView{
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
                        // Upcoming movie Container
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
                        //.padding(.vertical, 8)
                        .frame(maxWidth: .infinity, maxHeight: 720)
                        
                        LocalSearchContainer(movies_Data: movies_Data)
                        
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
