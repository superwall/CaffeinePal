//
//  GetCaffeineIntent.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 6/24/24.
//

import Foundation
import AppIntents
import SwiftUI

struct GetCaffeineIntent: AppIntent {
    static var title = LocalizedStringResource("Get Caffeine Intake")
    static var description = IntentDescription("Shows how much caffeine you've had today.")
        
    func perform() async throws -> some IntentResult & ReturnsValue<Double> & ProvidesDialog {
        let store = CaffeineStore.shared
        let amount = store.amountIngested
        let formattedAmount = store.formattedAmount(for: .dailyIntake)
        
        return .result(value: amount,
                       dialog: .init("You've had \(formattedAmount)."))
    }
}
