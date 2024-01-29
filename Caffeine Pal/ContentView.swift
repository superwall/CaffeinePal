//
//  ContentView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
    
struct ContentView: View {
    
    var body: some View {
        TabView {
            IntakeView()
                .tabItem {
                    TabIconView(symbolName: "chart.line.uptrend.xyaxis", text: "Intake")
                }
            RecipesView()
                .tabItem {
                    TabIconView(symbolName: "cup.and.saucer", text: "Coffee")
                }
            AppSettingsView()
                .tabItem {
                    TabIconView(symbolName: "gear", text: "Settings")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(CaffeineStore())
        .environment(PurchaseOperations())
}

// next up: Make recipe entries in StoreKit file
