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
        
        print("😎 Get caffeine intent fired")
        
        return .result(value: amount,
                       snippetIntent: ShowCaffeineIntakeSnippetIntent())
    }
}

struct ShowCaffeineIntakeSnippetIntent: SnippetIntent {
    static let title: LocalizedStringResource = "Caffeine Snippet"
    
    @Dependency var store: CaffeineStore
    
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let current = await store.amountIngested
        print("😎 Firing up ShowCaffeineIntakeSnippetIntent - ingested \(current)")
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
                .font(.title)
                .contentTransition(.numericText())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 12)
            Spacer()
            Text("Quick Log:")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            HStack {
                Button(intent: LogShotIntent(amount: EspressoShot.single.rawValue)) {
                    Text("Single")
                }
                Spacer()
                Button(intent: LogShotIntent(amount: EspressoShot.double.rawValue)) {
                    Text("Double")
                }
                Spacer()
                Button(intent: LogShotIntent(amount: EspressoShot.triple.rawValue)) {
                    Text("Triple")
                }
            }
            .buttonStyle(IntentScaleButtonStyle())
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
    
    @Parameter
    var amount: Int
    
    @Dependency
    var store: CaffeineStore
    
    func perform() async throws -> some IntentResult {
        let current = await store.formattedAmount()
        print("😎 Firing intent with \(self.amount) and current is \(current)")
        await store.log(Double(amount))
        let new = await store.formattedAmount()
        print("😎 Returning from intent and current is \(new)")
        return .result()
    }
}

extension LogShotIntent {
    init(amount: Int) {
        self.amount = amount
    }
}

struct IntentScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.86 : 1.0)
            .animation(.easeInOut(duration: 0.24), value: configuration.isPressed)
        }
}

#Preview {
    CaffeineIntakeSnip(store: .init())
}
