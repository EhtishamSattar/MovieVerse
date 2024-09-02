//
//  MovieVerseApp.swift
//  MovieVerse
//
//  Created by Mac on 02/09/2024.
//

import SwiftUI

@main
struct MovieVerseApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var moviesData : MoviesViewModel = MoviesViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "white")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "ThemeColor") ?? UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(movies_Data: moviesData)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .background(Color("BackgroundColor"))
                
                LocalSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .background(Color("BackgroundColor"))
                
                RecentlyViewedView()
                    .tabItem {
                        Label("Recently Viewed", systemImage: "clock.arrow.circlepath")
                    }
                    .background(Color("BackgroundColor"))
                
                
            }
        }
        //            ContentView()
        //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}


//#Preview {
//    MovieVerseApp() as! any View
//}
