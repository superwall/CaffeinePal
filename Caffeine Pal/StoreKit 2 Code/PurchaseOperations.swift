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
    
    // Purchased Products
    private(set) var purchasedRecipes: [EspressoDrink] = []
    private(set) var purchasedSubs: [Product] = []
    private(set) var hasCaffeinePalPro: Bool = false
    
    // Listen for transactions
    var transactionListener: Task<Void, Error>? = nil
    
    deinit {
        transactionListener?.cancel()
    }
    
    // MARK: Configure

    func configure() async throws {
        do {
            transactionListener = createTransactionTask()
            try await retrieveAllProducts()
            try await updateUserPurchases()
        } catch {
            throw error
        }
    }
    
    // MARK: StoreKit Code
    
    func retrieveAllProducts() async throws {
        do {
            let tipIdentifiers: [String] = PurchaseOperations.tipProductIdentifiers
            let recipeIdentifiers: [String] = PurchaseOperations.recipeProductIdentifiers
            let subIdentifiers: [String] = ["subscription.caffeinePalPro.annual"]
            let allIdentifiers: [String] = tipIdentifiers + recipeIdentifiers + subIdentifiers
            
            let products = try await Product.products(for: allIdentifiers)
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
                    self.subs.append(product)
                default:
                    print("Unknown product with identifier \(product.id)")
                }
            }
        } catch {
            print(error)
            throw error
        }
    }
    
    func hasPurchased(_ recipe: EspressoDrink) -> Bool {
        if hasCaffeinePalPro {
            return true
        }
        
        return purchasedRecipes.contains(recipe)
    }
    
    func purchase(_ recipe: EspressoDrink) async throws -> Bool {
        guard let product = self.recipes[recipe] else {
            throw CaffeinePalStoreFrontError.productNotFound
        }
        
        return try await purchaseProduct(product)
    }
    
    func purchase(_ tip: TippingView.AvailableTips) async throws -> Bool {
        guard let product = self.tips[tip] else {
            throw CaffeinePalStoreFrontError.productNotFound
        }
        
        return try await purchaseProduct(product)
    }
    
    func purchasePro() async throws -> Bool {
        guard let product = subs.first else {
            throw CaffeinePalStoreFrontError.productNotFound
        }
        
        return try await purchaseProduct(product)
    }
    
    func restorePurchases() async throws {
        do {
            try await AppStore.sync()
            try await updateUserPurchases()
        } catch {
            throw error
        }
    }
    
    // MARK: Private Functions
    
    private func purchaseProduct(_ product: Product) async throws -> Bool {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let result):
                let verificationResult = try self.verifyPurchase(result)
                try await updateUserPurchases()
                await verificationResult.finish()
                
                return true
            case .userCancelled:
                print("Cancelled")
            case .pending:
                print("Needs approval")
            @unknown default:
                fatalError()
            }
            
            return false
        } catch {
            throw error
        }
    }
    
    private func verifyPurchase<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw CaffeinePalStoreFrontError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    private func updateUserPurchases() async throws {
        let allRecipes = EspressoDrink.all()
        
        for await entitlement in Transaction.currentEntitlements {
            do {
                let verifiedPurchase = try verifyPurchase(entitlement)
                
                switch verifiedPurchase.productType {
                case .nonConsumable:
                    if let recipe = allRecipes.first(where: { $0.skIdentifier == verifiedPurchase.productID }) {
                        purchasedRecipes.append(recipe)
                    } else {
                        print("Verified purchase couldn't be matched to local model.")
                    }
                case .autoRenewable:
                    self.hasCaffeinePalPro = true
                    
                    if let subscription = subs.first(where: { $0.id == verifiedPurchase.productID }) {
                        purchasedSubs.append(subscription)
                    } else {
                        print("Verified subscription couldn't be matched to fetched subscription.")
                    }
                default:
                    break
                }
            } catch {
                print("Failing silently: Possible unverified purchase.")
                throw error
            }
        }
    }
    
    private func createTransactionTask() -> Task<Void, Error> {
        return Task.detached {
            for await update in Transaction.updates {
                do {
                    let transaction = try self.verifyPurchase(update)
                    try await self.updateUserPurchases()
                    await transaction.finish()
                } catch {
                    print("Transaction didn't pass verification - ignoring purchase.")
                }
            }
        }
    }
}

// MARK: Product Identifiers

extension PurchaseOperations {
    static var tipProductIdentifiers: [String] {
        get {
            return TippingView.AvailableTips.allCases.map { $0.skIdentifier }
        }
    }
    
    static var recipeProductIdentifiers: [String] {
        get {
            return EspressoDrink.all().map { $0.skIdentifier }
        }
    }
}

// MARK: Local Models to StoreKit values

extension TippingView.AvailableTips {
    var skIdentifier: String {
        return "consumable.tip." + self.shortDescription
    }
}

extension EspressoDrink {
    var skIdentifier: String {
        return "nonconsumable.recipe." + id
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
