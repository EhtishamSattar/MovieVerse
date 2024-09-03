//
//  LocalSearchView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct LocalSearchView: View {
    @State var searchValue : String = ""
    var body: some View {
        SearchField(placeholderText: "Search Movie", searchText: $searchValue)
        
    }
}

#Preview {
    LocalSearchView()
}
