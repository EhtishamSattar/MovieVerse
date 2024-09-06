//
//  RecentlyViewedView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI
import CoreData

struct RecentlyViewedView: View {
    @ObservedObject var movies_Data : MoviesViewModel
    
    var body: some View {
        VStack{
            Text("Recently Viewed")
                .font(Font.headline.weight(.bold))
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            if movies_Data.recentlyViewedMovies.isEmpty {
                Spacer()
                VStack(alignment: .center) {
                    NoMovieFoundView(message: "No Video Recently Viewed",subMessage: "Please View a Movie First")
                }
                Spacer()
            }else {
                ScrollView(showsIndicators: false){
                    ForEach(movies_Data.recentlyViewedMovies, id: \.self) { movieItem in
                        LSMovieCard(movies_Data: movies_Data,movie: movieItem, count: $movies_Data.count)
                            .frame(maxWidth: .infinity, maxHeight: 300,alignment: .center)
                            .padding()
                    }
                    
                }
            }
        }
        .frame(maxHeight: .infinity)
//        .onAppear {
//            //recentlyViewedData = movieManager.getRecentlyViewedData()
//            movies_Data.getRecentlyViewedData()
//            //print(recentlyViewedData)
//        }
        .background(Color("BackgroundColor"))
        
        
        
    }
    
}

#Preview {
    RecentlyViewedView(movies_Data: MoviesViewModel()/*, movieManager: MovieManager()*/)
}
