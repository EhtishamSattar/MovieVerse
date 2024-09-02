//
//  SearchBar.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct SearchField: View {
    var placeholderText : String
    @Binding var searchText : String
    var body: some View {
        
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("SearchBarColor"))
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .shadow(radius: 5)
        // used prompt to give the textfield's text a color
            .overlay(
                TextField(placeholderText, text: $searchText, prompt: Text(placeholderText)
                            .foregroundColor(.white))
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
                    .opacity(0.8)

            )
            .padding(.horizontal, 8)
        
    }
    
}


#Preview {
    SearchField(placeholderText: "Search Movie", searchText: Binding.constant(""))
}
