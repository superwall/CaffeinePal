//
//  ProFeatures.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 7/14/25.
//


enum ProFeatures: String, Identifiable, CaseIterable, CustomStringConvertible {
    case appIcons = "Custom App Icons"
    case logging = "Caffeine Logging"
    case recipes = "Espresso Recipes"
    
    var id: Self { return self }
    
    var description: String {
        switch self {
        case .appIcons:
            "Customize your Home Screen."
        case .logging:
            "Easily log your espresso shots."
        case .recipes:
            "Access exclusive espresso recipes."
        }
    }
    
    var expandedDetails: String {
        switch self {
        case .appIcons:
            "Make Caffeine Pal stnad out in your most personable space - your Home Screen. Choose from three unqiue icons."
        case .logging:
            "Our super simple caffeine logging lets you quickly log espresso shots in a matter of seconds."
        case .recipes:
            "Unlock access to the world's most exlusive espresso based coffee drinks recipes. Create our signature drinks right at home!"
        }
    }
    
    var symbol: String {
        switch self {
        case .appIcons:
            "square.fill"
        case .logging:
            "checklist.checked"
        case .recipes:
            "book.pages.fill"
        }
    }
}
