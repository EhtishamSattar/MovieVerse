//
//  HomeView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    @State var searchValue : String = ""
    var imageUrl : URL?
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        //GridItem(.flexible(), spacing: 6, alignment: nil),
    ]
    
    let url = URL(string: "https://picsum.photos/300")
    var body: some View {
        VStack{
            SearchField(placeholderText: "Search Movie", searchText: $searchValue)
            Spacer()
            ScrollView{
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 10,
                    pinnedViews: [.sectionHeaders],
                    content: {
                        Section(header: ZStack {
                            Text("Movies")
                                .padding()
                                .frame(maxWidth: .infinity ,alignment: .leading)
                                .foregroundColor(.white)
                                .background(Color("BackgroundColor"))
                                .font(Font.headline.weight(.bold))
                                .font(.largeTitle)
                        }
                            
                        ) {
                            ForEach(movies_Data.moviesData.results , id: \.self) {movie in
                                
                                MovieCard(movieImage : movies_Data.getPosterImageURL(path: movie.poster_path) ?? nil ,title: movie.title, description: movie.overview, rating: movie.vote_average)
                            }
                        }
                        
                    })
            }
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    HomeView(movies_Data: MoviesViewModel())
}
