//
//  LogEspressoIntent.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 6/25/24.
//

import Foundation
import AppIntents
import WidgetKit

struct LogEspressoIntent: AppIntent {
    static var title = LocalizedStringResource("Log Espresso Shot")
    static var description = IntentDescription("Logs some espresso.")
    
    @Dependency var store: CaffeineStore
    
    @Parameter(title: "Shots")
    var shots: EspressoShot?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Logs \(\.$shots) of caffeine")
    }
    
    init() {}
    
    init(shots: EspressoShot) {
        self.shots = shots
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        if shots == nil {
            shots = try await $shots.requestValue(.init(stringLiteral: "How many shots of espresso are you drinking?"))
        }
        
        await store.log(espressoShot: shots!)
        let val = await "Logged \(store.formattedAmount(.init(value: Double(shots!.rawValue), unit: .milligrams)))."
        
        // Refresh widgets
        WidgetCenter.shared.reloadAllTimelines()
        
        return .result(dialog: .init(stringLiteral: val))
    }
}
