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
    
    var body: some View {
    
        HStack(spacing: 0) {
            if let movie = movie {
                if let moviePath = movie.poster_path {
                    AsyncImage(url: movies_Data.getPosterImageURL(path: moviePath )) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 150, maxHeight: 170)
                            .cornerRadius(10)
                        
                    } placeholder: {
                        ProgressView()
                            .foregroundColor(Color.white)
                            .padding()
                    }
                }else {
                    ProgressView()
                }
                
                
                VStack(alignment: .leading) {
                    if let title = movie.original_title {
                        Text(title)
                            .font(.headline)
                            .font(Font.headline.weight(.heavy))
                    }
                    Spacer()
                    HStack{
                        Text("Type: ")
                        Spacer()
                        Text("\(movie.adult ? "Adult" : "General")")
                            .italic()
                            .foregroundColor(movie.adult ? .red : .green)
                    }
                    .font(.caption)
                    
                    HStack{
                        Text("Rating")
                        Spacer()
                        Text("\(Int(movie.vote_average))")
                    }
                    .font(.caption)
                    
                    Text("\(String(describing: movie.release_date ?? "n/a"))")
                    
                    HStack{
                        Text("Total Votes")
                        Spacer()
                        Text("\(Int(movie.vote_count))")
                    }
                    .font(.caption)
                    
                }
                .padding(.horizontal, 10)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
            }
            
        }
        .background(Color("BackgrounColor"))
        .frame(maxWidth: .infinity, maxHeight: 150)
        .padding(.horizontal)
        .onAppear {
            print(movie!)
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

