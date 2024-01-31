//
//  Purchases.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/24/24.
//

import Foundation
import Observation
import StoreKit

@Observable
class PurchaseOperations {
    // Available Products
    private(set) var tips: [TippingView.AvailableTips : Product] = [:]
    private(set) var recipes: [EspressoDrink : Product] = [:]
    private(set) var subs: [Product] = []
    private(set) var hasCaffeinePalPro: Bool = false
    
    // Purchased Products
    private(set) var purchasedRecipes: [EspressoDrink] = []
    private(set) var purchasedSubs: [Product] = []
        
    // MARK: Configure

    func configure() async throws {

    }
    
    // MARK: StoreKit Code
    
    func retrieveAllProducts() async throws {

    }
    
    func hasPurchased(_ recipe: EspressoDrink) -> Bool {
        return false
    }
    
    func purchase(_ recipe: EspressoDrink) async throws -> Bool {
        return false
    }
    
    func purchase(_ tip: TippingView.AvailableTips) async throws -> Bool {
        return false
    }
    
    func purchasePro() async throws -> Bool {
        return false
    }
    
    func restorePurchases() async throws {
        
    }
    
    // MARK: Private Functions
    
    private func purchaseProduct(_ product: Product) async throws -> Bool {
        return false
    }
    
    private func updateUserPurchases() async throws {
        
    }
}


enum CaffeinePalStoreFrontError: Error {
    case productNotFound, failedVerification
}

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
