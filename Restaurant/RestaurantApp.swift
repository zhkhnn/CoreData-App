//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Aruzhan Zhakhan on 17.04.2023.
//

import SwiftUI

@main
struct RestaurantApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
