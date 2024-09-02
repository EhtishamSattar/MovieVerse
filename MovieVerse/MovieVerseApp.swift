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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
