//
//  MoviesDetailsView.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var movie : Movie
    //    var movieImage : URL?
    //    var title: String
    //    var overview: String
    //    var rating: Double
    //    var voteCount: Int
    //    var releaseDate: String
    //    var language: String
    //    var isAdult: Bool
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .background(ignoresSafeAreaEdges: .all)
            AsyncImage(url: movies_Data.getPosterImageURL(path: movie.poster_path)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }
            .frame(alignment : .top)
            
            
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Rating: \(String(format: "%.1f", movie.vote_average))/10")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("Votes: \(Int(movie.vote_count))")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
                
                HStack {
                    Text("Release Date: \(movie.release_date)")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("Language: \(movie.original_language)")
                        .font(.subheadline)
                }
                .padding(.horizontal)
                
                
                Text(movie.adult ? "Adult Movie" : "General Audience")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(movie.adult ? .red : .green)
                
                
                Text("Overview")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                
                Text(movie.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .navigationTitle(movie.original_title)
        
        
    }
    
}


//#Preview {
//    MovieDetailsView(
//        movie : Binding.constant(Movie(from: <#any Decoder#>)),
//        posterURL: URL(string: "https://picsum.photos/300"),
//        title: "Inception",
//        overview: "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a CEO.",
//        rating: 8.8,
//        voteCount: 10000,
//        releaseDate: "2010-07-16",
//        language: "English",
//        isAdult: false
//    )
//}


