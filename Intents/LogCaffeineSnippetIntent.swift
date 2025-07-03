//
//  LogCaffeineSnippetIntent.swift
//  Caffeine Pal
//
//  Created by Claude on 7/3/25.
//

import Foundation
import AppIntents
import SwiftUI

struct LogCaffeineSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "Log Caffeine Amount"
    
    @Parameter(title: "Amount to Log")
    var amountToLog: Double
    
    init() {
        self.amountToLog = 0.0
    }
    
    init(amountToLog: Double) {
        self.amountToLog = amountToLog
    }
    
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        return .result(
            view: LogCaffeineSnippetView(amountToLog: amountToLog)
        )
    }
}

struct LogCaffeineSnippetView: View {
    let amountToLog: Double
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Log Caffeine")
                .font(.headline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button(intent: DecrementCaffeineIntent(currentAmount: amountToLog)) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .disabled(amountToLog <= 0)
                
                Text("\(Int(amountToLog)) mg")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(minWidth: 80)
                
                Button(intent: IncrementCaffeineIntent(currentAmount: amountToLog)) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
            
            Button(intent: ConfirmLogCaffeineIntent(amountToLog: amountToLog)) {
                Text("Log \(Int(amountToLog)) mg")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(amountToLog > 0 ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }
            .disabled(amountToLog <= 0)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

struct IncrementCaffeineIntent: AppIntent {
    static var title = LocalizedStringResource("Increment Caffeine")
    static var description = IntentDescription("Increases the caffeine amount by 10mg.")
    
    @Parameter(title: "Current Amount")
    var currentAmount: Double
    
    func perform() async throws -> some IntentResult & ShowsSnippetIntent {
        let newAmount = currentAmount + 10.0
        return .result(
            snippetIntent: LogCaffeineSnippetIntent(amountToLog: newAmount)
        )
    }
}

extension IncrementCaffeineIntent {
    init(currentAmount: Double) {
        self.currentAmount = currentAmount
    }
}

struct DecrementCaffeineIntent: AppIntent {
    static var title = LocalizedStringResource("Decrement Caffeine")
    static var description = IntentDescription("Decreases the caffeine amount by 10mg.")
    
    @Parameter(title: "Current Amount")
    var currentAmount: Double
    
    func perform() async throws -> some IntentResult & ShowsSnippetIntent {
        let newAmount = max(0.0, currentAmount - 10.0)
        return .result(
            snippetIntent: LogCaffeineSnippetIntent(amountToLog: newAmount)
        )
    }
}

extension DecrementCaffeineIntent {
    init(currentAmount: Double) {
        self.currentAmount = currentAmount
    }
}

struct ConfirmLogCaffeineIntent: AppIntent {
    static var title = LocalizedStringResource("Confirm Log Caffeine")
    static var description = IntentDescription("Logs the specified amount of caffeine.")
    
    @Parameter(title: "Amount to Log")
    var amountToLog: Double
    
    func perform() async throws -> some IntentResult & ShowsSnippetIntent & ProvidesDialog {
        guard amountToLog > 0 else {
            return .result(
                dialog: .init("Please select an amount greater than 0mg."),
                snippetIntent: LogCaffeineSnippetIntent(amountToLog: 0.0)
            )
        }
        
        let store = CaffeineStore.shared
        store.log(amountToLog)
        
        let newFormattedAmount = store.formattedAmount(for: .dailyIntake)
        
        return .result(
            dialog: .init("Logged \(Int(amountToLog))mg of caffeine. Your total is now \(newFormattedAmount)."),
            snippetIntent: ShowCaffeineIntakeSnippetIntent(currentAmount: newFormattedAmount)
        )
    }
}

extension ConfirmLogCaffeineIntent {
    init(amountToLog: Double) {
        self.amountToLog = amountToLog
    }
}
