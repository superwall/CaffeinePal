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
    
    @Dependency var store: CaffeineStore
    
    func perform() async throws -> some IntentResult & ReturnsValue<Double>  & ShowsSnippetIntent {
        let amount = await store.amountIngested
        
        print("Get caffeine intent fired")
        
        return .result(value: amount,
                       snippetIntent: ShowCaffeineIntakeSnippetIntent())
    }
}

struct ShowCaffeineIntakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "Caffeine Snippet"
    
    @Dependency var store: CaffeineStore
    
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        print("Firing up ShowCaffeineIntakeSnippetIntent")
        return .result(view: CaffeineIntakeSnip(store: store))
                
    }
}

struct CaffeineIntakeSnip: View {
    let store: CaffeineStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Todays Caffine:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(store.formattedAmount())
                .font(.title2)
            Button(intent: LogShotIntent()) {
                Text("Log Single Shot")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .padding(12)
        .background(Color(uiColor: .secondarySystemBackground).gradient)
        .clipShape(.containerRelative)
    }
}

struct LogShotIntent: AppIntent {
    static let title: LocalizedStringResource = "Log Caffeine Amount"
    static let isDiscoverable: Bool = false
    
//    @Parameter
//    var amount: Int
    
//    @Dependency
//    var store: CaffeineStore
    
    func perform() async throws -> some IntentResult {
        print("Firing intent")
        //store.log(Double(self.amount))
        return .result()
    }
}
//
//extension LogShotIntent {
//    init(amount: Int) {
//        self.amount = amount
//    }
//}

#Preview {
    CaffeineIntakeSnip(store: .init())
}
