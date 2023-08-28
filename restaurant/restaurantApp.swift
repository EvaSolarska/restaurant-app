//
//  restaurantApp.swift
//  restaurant
//
//  Created by Ewa Solarska on 28/08/2023.
//

import SwiftUI

@main
struct restaurantApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
