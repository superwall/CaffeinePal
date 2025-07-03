//
//  CaffeineIntakeDisplayIntent.swift
//  Caffeine Pal
//
//  Created by Claude on 7/3/25.
//

import Foundation
import AppIntents
import SwiftUI

struct CaffeineIntakeDisplayIntent: AppIntent {
    static var title = LocalizedStringResource("Show Caffeine Intake")
    static var description = IntentDescription("Shows how much caffeine you've had today with options to log more.")
    
    func perform() async throws -> some IntentResult & ShowsSnippetIntent {
        let store = CaffeineStore.shared
        let formattedAmount = store.formattedAmount(for: .dailyIntake)
        
        return .result(
            snippetIntent: ShowCaffeineIntakeSnippetIntent(currentAmount: formattedAmount)
        )
    }
}

struct ShowCaffeineIntakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "Caffeine Intake Display"
    
    @Parameter(title: "Current Amount")
    var currentAmount: String
    
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        return .result(
            view: CaffeineIntakeSnippetView(currentAmount: currentAmount)
        )
    }
}

extension ShowCaffeineIntakeSnippetIntent {
    init(currentAmount: String) {
        self.currentAmount = currentAmount
    }
}

struct CaffeineIntakeSnippetView: View {
    let currentAmount: String
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text("Today's Caffeine")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(currentAmount)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            Button(intent: LogCaffeineSnippetIntent()) {
                Text("Log More Caffeine")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
