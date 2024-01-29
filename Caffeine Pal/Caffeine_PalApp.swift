//
//  Caffeine_PalApp.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
import TipKit

@main
struct Caffeine_PalApp: App {
    @State private var store: CaffeineStore = .init()
    @State private var purchases: PurchaseOperations = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    setupTips()
                    await fetchProducts()
                }
        }
        .environment(store)
        .environment(purchases)
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
    
    private func fetchProducts() async {
        do {
            try await purchases.configure()
        } catch {
            print(error)
        }
    }
}
