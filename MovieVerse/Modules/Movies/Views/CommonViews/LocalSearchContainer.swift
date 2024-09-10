//
//  LocalSearchContainer.swift
//  MovieVerse
//
//  Created by Mac on 06/09/2024.
//

import SwiftUI

struct LocalSearchContainer: View {
    
    @ObservedObject var movies_Data : MoviesViewModel
    
    var body: some View {
        
        DateRangedMoviesView(movies_Data: movies_Data)
        
        LocalMovies(movies_Data: movies_Data)
    }
}

#Preview {
    LocalSearchContainer(movies_Data: MoviesViewModel())
}
