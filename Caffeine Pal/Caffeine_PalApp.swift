//
//  Caffeine_PalApp.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
import TipKit
import SuperwallKit

@main
struct Caffeine_PalApp: App {
    @State private var store: CaffeineStore = .init()
 
    init() {
        Superwall.configure(apiKey: "pk_0ef0533ab1eb3b5843e8dc43d933c348b7eec42ee7592f9c")
        Superwall.shared.delegate = store
        setupTips()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await store.fetchTipAndEspressoRecipeProducts()
                }
        }
        .environment(store)
    }
}

// MARK: Private Functions

extension Caffeine_PalApp {
    private func setupTips() {
        try? Tips.resetDatastore()
        try? Tips.configure([
            .displayFrequency(.immediate),
            .datastoreLocation(.applicationDefault)
        ])
    }
}
