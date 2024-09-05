//
//  MoviesDetailsView.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//

//import SwiftUI
//
//struct MovieDetailsView: View {
//    @ObservedObject var movies_Data : MoviesViewModel
//    var movie : Movie
//    @EnvironmentObject var movieManager: MovieManager
//
//
////    @State var firstAperance : Int = 0
//    //    var movieImage : URL?
//    //    var title: String
//    //    var overview: String
//    //    var rating: Double
//    //    var voteCount: Int
//    //    var releaseDate: String
//    //    var language: String
//    //    var isAdult: Bool
//
//    var body: some View {
//        ZStack{
//            Color("BackgroundColor")
//                //.background(ignoresSafeAreaEdges: .all)
//            AsyncImage(url: movies_Data.getBackdropPath(path: movie.backdrop_path )) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//                    .clipped()
//                    .cornerRadius(10)
//            } placeholder: {
//                ProgressView()
//                    .frame(height: 200)
//            }
//            .frame(width: 400, height: 800, alignment : .top)
//
//            VStack(alignment: .leading, spacing: 20) {
//                Spacer()
//                Text(movie.title)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.leading)
//
//                HStack {
//                    Text("Rating: \(String(format: "%.1f", movie.vote_average))/10")
//                        .font(.subheadline)
//
//                    Spacer()
//
//                    Text("Votes: \(Int(movie.vote_count))")
//                        .font(.subheadline)
//                }
//                .padding(.horizontal)
//
//
//                HStack {
//                    Text("Release Date: \(movie.release_date)")
//                        .font(.subheadline)
//
//                    Spacer()
//
//                    Text("Language: \(movie.original_language)")
//                        .font(.subheadline)
//                }
//                .padding(.horizontal)
//
//
//                Text(movie.adult ? "Adult Movie" : "General Audience")
//                    .font(.subheadline)
//                    .fontWeight(.bold)
//                    .foregroundColor(movie.adult ? .red : .green)
//
//
//                Text("Overview")
//                    .font(.title2)
//                    .fontWeight(.semibold)
//
//
//                Text(movie.overview)
//                    .font(.body)
//                    .multilineTextAlignment(.leading)
//
//            }
//            .padding(.horizontal, 40)
//            .padding(.bottom, 20)
//            .foregroundColor(.white)
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]),
//                    startPoint: .bottom,
//                    endPoint: .top
//                )
//            )
//            .frame(maxHeight: .infinity)
//        }
//        //.frame(maxWidth: .infinity,maxHeight: .infinity)
//        .navigationTitle(movie.original_title)
//        .onAppear {
////            let newMovie = Movie(id: Int32(Date().timeIntervalSince1970), title: movieTitle)
////                            movieManager.createData(movie: newMovie)
//            movieManager.createData(movie: movie)
//        }
//
//
//    }
//
//}


import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    var movie : MovieItem?
    @EnvironmentObject var movieManager: MovieManager
    
    var body: some View {
        VStack(alignment: .leading) {
            if let movie = movie {
                if let path = movie.backdrop_path {
                    AsyncImage(url: movies_Data.getBackdropPath(path: path )) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            //.aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                }else{
                    ProgressView()
                }
                HStack(spacing: 0) {
                    
                    AsyncImage(url: movies_Data.getBackdropPath(path: movie.poster_path )) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 150, maxHeight: .infinity)
                            .cornerRadius(20)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack {
                        Spacer() // Push the text to the bottom
                        Text(movie.original_title ?? "none")
                            .font(.title)
                            .font(Font.headline.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 0)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(.top, -120)
                .padding(.horizontal, 7)
                
                
                
                HStack(spacing: 5) {
                    Label("\(movie.release_date ?? "None")", systemImage: "calendar")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .accentColor(.white)
                    
                    Spacer()
                    Label("\(Int(movie.vote_average))", systemImage: "doc.fill")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Label("\(movie.adult ? "Adult Movie" : "General Audience")", systemImage: "person.fill")
                        .font(.subheadline)
                        .foregroundColor(movie.adult ? .red : .green)
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("About Movie")
                        .font(.title3)
                        .fontWeight(.bold)
                    HStack{
                        Text("Type:")
                            .foregroundColor(Color.white).opacity(0.8)
                        
                        Text("\(movie.adult ? "Adult Movie" : "General Audience")")
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(movie.adult ? .red : .green)
                    }
                    
                    Text(movie.overview ?? "None")
                        .font(.body)
                }
                .padding()
                
                Spacer()
            }
            
        }
        .foregroundColor(Color.white)
        .background(Color("BackgroundColor"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            //            let newMovie = Movie(id: Int32(Date().timeIntervalSince1970), title: movieTitle)
            //                            movieManager.createData(movie: newMovie)
            //if let movie = movie {
            if let movie = movie {
                            movieManager.createData(movie: movie)
                        }
        }
        //        .navigationBarItems(
        //            trailing: Button(action: {
        //
        //            }
        //                            )
        //            {
        //                Image(systemName: "bookmark")
        //                //                 onTapGesture {
        //                //                     isFavorite.toggle()
        //                //                 }
        //                    .foregroundColor(isFavorite ? .yellow : .white)
        //            }
        //        )
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


