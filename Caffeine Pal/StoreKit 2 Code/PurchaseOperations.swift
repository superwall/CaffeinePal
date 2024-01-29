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
    
    // Available Products
    private(set) var tips: [TippingView.AvailableTips : Product] = [:]
    private(set) var recipes: [EspressoDrink : Product] = [:]
    private(set) var subs: [Product] = []
    private(set) var hasCaffeinePalPro: Bool = false
    
    // Purchased Products
    private(set) var purchasedRecipes: [Product] = []
    private(set) var purchasedSubs: [Product] = []
    
    // MARK: Configure

    func configure() async throws {
        do {
            try await retrieveAllProducts()
        } catch {
            throw error
        }
        
        //TODO: Listen for transactions
    }
    
    // MARK: StoreKit Code
    
    func retrieveAllProducts() async throws {
        do {
            let products = try await Product.products(for: PurchaseOperations.tipProductIdentifiers)
            let allTips = TippingView.AvailableTips.allCases
            let allRecipes = EspressoDrink.all()
            
            for product in products {
                switch product.type {
                case .consumable:
                    if let tip = allTips.first(where: {
                        $0.skIdentifier == product.id
                    }) {
                        self.tips[tip] = product
                    } else {
                        print("Unknown product id: \(product.id)")
                    }
                case .nonConsumable:
                    if let recipe = allRecipes.first(where: {
                        $0.skIdentifier == product.id
                    }) {
                        self.recipes[recipe] = product
                    } else {
                        print("Unknown product id: \(product.id)")
                    }
                case .autoRenewable:
                    print("Auto renewable")
                case .nonRenewable:
                    print("Non renewable")
                default:
                    //Ignore this product.
                    print("Unknown product")
                }
            }
            
            print("Done!")
        } catch {
            print(error)
            throw error
        }
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
        
        
        // product.purchase() and switch over the result
    }
    
    func purchase(_ tip: TippingView.AvailableTips) async throws {
        guard let product = self.tips[tip] else {
            throw CaffeinePalStoreFrontError.productNotFound
        }
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let result):
                let verificationResult = try self.verifyPurchase(result)
                await updateUserPurchases()
                await verificationResult.finish()
            case .userCancelled:
                print("Cancelled")
            case .pending:
                print("Needs approval")
            @unknown default:
                fatalError()
            }
        } catch {
            throw error
        }
    }
    
    func purchasePro() async throws {
        // TODO: Implement
    }
    
    func restorePurchases() async throws {
        // TODO: Implement
    }
    
    // MARK: Private Functions
    
    private func verifyPurchase<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw CaffeinePalStoreFrontError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    private func updateUserPurchases() async {
        var recipes: [EspressoDrink] = []        
        let allRecipes = EspressoDrink.all()
        
        for await entitlement in Transaction.currentEntitlements {
            do {
                let verifiedPurchase = try verifyPurchase(entitlement)
                
                switch verifiedPurchase.productType {
                case .nonConsumable:
                    if let recipe = allRecipes.first(where: { $0.skIdentifier == verifiedPurchase.productID }) {
                        recipes.append(recipe)
                    } else {
                        print("Verified purchase couldn't be matched to local model.")
                    }
                case .autoRenewable:
                    self.hasCaffeinePalPro = true
                default:
                    break
                }
            } catch {
                print("Failing silently: Possible unverified purchase.")
            }
        }
    }
}

// MARK: Product Identifiers

extension PurchaseOperations {
    static var tipProductIdentifiers: [String] {
        get {
            ["small",
             "medium",
             "large",
             "irresponsible"].map { return "consumable.tip." + $0 }
        }
    }
    
    static var recipeProductIdentifiers: [String] {
        get {
            ["small",
             "medium",
             "large",
             "irresponsible"].map { return "nonconsumable.recipe." + $0 }
        }
    }
}

// MARK: Local Models to StoreKit values

extension TippingView.AvailableTips {
    var skIdentifier: String {
        let allIdentifiers = PurchaseOperations.tipProductIdentifiers
        
        switch self {
        case .small:
            return allIdentifiers.first(where: { $0.contains("small") }) ?? ""
        case .medium:
            return allIdentifiers.first(where: { $0.contains("medium") }) ?? ""
        case .large:
            return allIdentifiers.first(where: { $0.contains("large") }) ?? ""
        case .justCrazy:
            return allIdentifiers.first(where: { $0.contains("irresponsible") }) ?? ""
        }
    }
}

extension EspressoDrink {
    var skIdentifier: String {
        return "nonconsumable.recipe." + productSku
    }
}
