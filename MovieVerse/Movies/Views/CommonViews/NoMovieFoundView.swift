//
//  NoMovieFoundView.swift
//  MovieVerse
//
//  Created by Mac on 03/09/2024.
//

import SwiftUI


struct NoMovieFoundView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 20) {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("No Movie Found")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Try searching for another movie.")
                .font(.body)
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(Color("BackgroundColor"))
        .foregroundColor(.white)
    }
}

#Preview {
    NoMovieFoundView()
}

