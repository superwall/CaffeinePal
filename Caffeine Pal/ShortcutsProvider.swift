//
//  ShortcutsProvider.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 6/25/24.
//

import Foundation
import AppIntents

struct ShortcutsProvider: AppShortcutsProvider {
    static var shortcutTileColor: ShortcutTileColor {
        return .lightBlue
    }
    
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: GetCaffeineIntent(),
                    phrases: ["Get caffeine in \(.applicationName)", 
                              "See caffeine in \(.applicationName)",
                              "Show me much caffeine I've had in \(.applicationName)",
                              "Show my caffeine intake in \(.applicationName)"],
                    shortTitle: "Get Caffeine Intake",
                    systemImageName: "cup.and.saucer.fill")
        AppShortcut(intent: LogEspressoIntent(),
                    phrases: ["Log caffeine in \(.applicationName)",
                              "Log espresso shots in \(.applicationName)"],
                    shortTitle: "Log Espresso",
                    systemImageName: "cup.and.saucer.fill")
    }
}
