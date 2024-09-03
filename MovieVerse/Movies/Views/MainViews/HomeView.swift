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
                SearchField(placeholderText: "Search Movie", searchText: $movies_Data.searchValue)
                    .onChange(of: movies_Data.debouncedSearchValue) {newValue in
                        print(newValue)
                        Task{
                            await movies_Data.getSearchMovieData(movieName: newValue)
                        }
                    }
                Spacer()
                
                if movies_Data.movies.isEmpty {
                    NoMovieFoundView()
                    Spacer()
                }else {
                    ScrollView(showsIndicators: false){
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
                                    //                            Array(...): The ForEach loop in SwiftUI requires the data to conform to RandomAccessCollection, so we wrap the enumerated sequence with Array(...) to satisfy this requirement.
                                    //                            id: \.offset: We use the offset (the index returned by enumerated()) as the unique identifier for each item in the loop. This is needed for SwiftUI to differentiate between views.
                                    
                                    
                                    ForEach(Array(movies_Data.movies.enumerated()) , id: \.offset) {index,movie in
                                        
                                        NavigationLink {
                                            MovieDetailsView(movies_Data: movies_Data ,movie: movie)
                                        } label: {
                                            MovieCard(movies_Data: movies_Data,movieImage : movies_Data.getPosterImageURL(path: movie.poster_path) ?? nil ,title: movie.title, description: movie.overview, rating: movie.vote_average, count: $movies_Data.count)
                                        }

                                        
                                    }
                                    
                                    
                                }
                                
                            })
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
