//
//  NoMovieFoundView.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//

import SwiftUI


struct NoMovieFoundView: View {
    var message : String
    var subMessage : String
    var body: some View {
        VStack(alignment: .center,spacing: 20) {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("\(message)")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("\(subMessage)")
                .font(.body)
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(Color("BackgroundColor"))
        .foregroundColor(.white)
    }
}

#Preview {
    NoMovieFoundView(message: "No Movie Found", subMessage: "Try Searching for Another Movie")
}

