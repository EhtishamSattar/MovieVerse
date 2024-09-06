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
    let coreDataStack = CoreDataStack.shared
    @StateObject var moviesData : MoviesViewModel = MoviesViewModel()
    @StateObject private var movieManager = MovieManager()
    
    init() {
        
        // Tab bar Customization
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "BackgroundColor")

        appearance.stackedLayoutAppearance.selected.iconColor = .blue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // Navbar Customization
        let Navappearance = UINavigationBarAppearance()
        Navappearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        Navappearance.backgroundColor = UIColor(named: "BackgroundColor") 

        Navappearance.backgroundEffect = UIBlurEffect(style: .regular)
        Navappearance.backgroundColor = UIColor.clear
        
        UINavigationBar.appearance().standardAppearance = Navappearance
        UINavigationBar.appearance().scrollEdgeAppearance = Navappearance
    }

    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                
                
                TabView {
                    HomeView(movies_Data: moviesData)
                        .tabItem {
                            Label("Home", systemImage: "house")
                                .foregroundColor(.white)
                        }
                        .background(Color("BackgroundColor"))
                        .environmentObject(movieManager)
                    
                    LocalSearchView(movies_Data: moviesData)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                                .foregroundColor(.white)
                        }
                        .background(Color("BackgroundColor"))
                        //.environmentObject(movieManager)
                    
                    RecentlyViewedView(movies_Data: moviesData/*, movieManager: movieManager*/)
                        .tabItem {
                            Label("Recently Viewed", systemImage: "clock.arrow.circlepath")
                                .foregroundColor(.white)
                        }
                        .background(Color("BackgroundColor"))
                    
                }
            }
        }
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        //.environmentObject(movieDb)
        //            ContentView()
        //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}


//#Preview {
//    MovieVerseApp() as! any View
//}
