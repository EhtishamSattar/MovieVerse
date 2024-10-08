//
//  LSMovieCard.swift
//  MovieVerse
//
//  Created by Mac on 04/09/2024.
//

import SwiftUI

struct LSMovieCard: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var movie : MovieItem?
    var index : Int
    var body: some View {
    
        NavigationLink {
            MovieDetailsView(movies_Data: movies_Data,movie: movie)
        } label: {
            HStack(spacing: 0) {
                if let movie = movie {
                    if let moviePath = movie.poster_path {
                        AsyncImage(url: movies_Data.getBackdropPath(path: moviePath )) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 150, maxHeight: 170)
                                .cornerRadius(20)
                            
                        } placeholder: {
                            ProgressView()
                                .tint(.white)
                                .padding()
                        }
                    }else {
                        ProgressView()
                            .tint(.white)
                            .padding()
                    }
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        if let title = movie.original_title {
                            Text(title)
                                .font(.title2)
                                .font(Font.headline.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        
                        Label("\(movie.adult ? "Adult" : "General")", systemImage: "person.fill")
                            .font(.subheadline)
                            .foregroundColor(movie.adult ? .red : .green)
                            .accentColor(.white)
                        
                        
                        Label("\(Int(movie.vote_average))", systemImage: "doc.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Label("\(movie.release_date ?? "None")", systemImage: "calendar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .accentColor(.white)
                       
                        
                        Label("\(movie.vote_count)", systemImage: "bookmark")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .accentColor(.white)
                        
                    }
                    //.padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    
                }
                Spacer()
                
            }
            .background(Color("BackgrounColor"))
            .frame(maxWidth: .infinity, maxHeight: 150)
            .padding(.horizontal)
            .onAppear(perform: {
                movies_Data.count = index
                //print(count)
                Task{
                    await movies_Data.getMoviesData()
                }
            })
        }
        }

        
}


//#Preview {
//    LSMovieCard(movies_Data: MoviesViewModel())
//}


//#Preview {
//    LSMovieCard(movies_Data: MoviesViewModel(), movie:
//                    Movie(adult: false, genre_ids: [1,3,4], id: 2324, original_language: "en", original_title: "jdbssk", overview: "String", popularity: 234.4, poster_path: "String", release_date: "String", title: "String", video: true, vote_average: 8.99, vote_count: 23.33)
//    )
//}

