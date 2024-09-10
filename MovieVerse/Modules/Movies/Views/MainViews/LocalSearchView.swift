//
//  LocalSearchView.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

struct LocalSearchView: View {
   
    @ObservedObject var movies_Data : MoviesViewModel
    @State var searchValue : String = ""
    
    var body: some View {
        VStack{
            if  movies_Data.apiErrorMessage == "" {
                SearchField(placeholderText: "Search Movie", searchText: $movies_Data.searchValue)
                    .onChange(of: movies_Data.debouncedSearchValue) {newValue in
                        print(newValue)
                        Task{
                            await movies_Data.getSearchMovieData(movieName: newValue)
                        }
                    }
                
                ScrollView{
                    GlobalSearchContainer(movies_Data: movies_Data)
                }
                .background(Color("BackgroundColor"))
            }else {
                Spacer()
                NoMovieFoundView(message: movies_Data.apiErrorMessage, subMessage: "")
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                Spacer()
            }
        }
//        .onAppear(perform: {
//            print("---------------",movies_Data.apiErrorMessage.count)
//        })
    }
}

#Preview {
    LocalSearchView(movies_Data: MoviesViewModel())
}
