//
//  connect4joyApp.swift
//  connect4joy
//
//  Created by Petros Dhespollari on 15/10/23.
//

import SwiftUI
import SwiftData

@main
struct connect4joyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                GameSelectionView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
