//
//  Purchases.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/24/24.
//

import Foundation
import Observation

@Observable
class PurchaseOperations {
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
    
    var hasCaffeinePalPro: Bool = false
    
    // MARK: StoreKit Code
    
    func retrieveAllProducts() async throws {
        // TODO: Implement
    }
    
    func hasPurchased(_ recipe: EspressoDrink) -> Bool {
        if hasCaffeinePalPro {
            return true
        }
        
        // TODO: Implement
        return false
    }
    
    func purchase(_ recipe: EspressoDrink) async throws {
        // TODO: Implement
    }
    
    func purchase(_ tip: TippingView.AvailableTips) async throws {
        // TODO: Implement
    }
    
    func purchasePro() async throws {
        // TODO: Implement
    }
    
    func restorePurchases() async throws {
        // TODO: Implement
    }
}
