//
//  CaffeineStore.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import Foundation
import Observation
import SuperwallKit

@MainActor
@Observable
class CaffeineStore {
    enum FormattedAmount {
        case dailyIntake, amountOver
    }
    
    let formatter: MeasurementFormatter = {
        let f = MeasurementFormatter()
        f.unitOptions = .providedUnit
        f.numberFormatter.maximumFractionDigits = 2
        return f
    }()
    
    var dailyLimit: Double = 300.0
    
    private var _todaysCaffeine: Double = 0.0 {
        didSet {
            let proposedValue = (_todaysCaffeine/dailyLimit) * 1.0
            
            if proposedValue > 1.0 {
                amountIngested = 1.0
            } else {
                amountIngested = (_todaysCaffeine/dailyLimit) * 1.0
            }
            
            if _todaysCaffeine > dailyLimit {
                amountOver = (_todaysCaffeine - dailyLimit)
            } else {
                amountOver = 0.0
            }
        }
    }
    
    func todaysCaffeine() -> Double {
        return _todaysCaffeine
    }
    
    private(set) var amountIngested: Double = 0.0
    private(set) var amountOver: Double = 0.0
    private(set) var hasCaffeinePalPro: Bool = false
    private(set) var tipProducts: Set<StoreProduct> = .init()
    private(set) var espressoProducts: Set<StoreProduct> = .init()
    private(set) var purchasedEspressoRecipes: Set<EspressoDrink> = .init()
    
    // MARK: Functions
    
    func log(_ amount: Double) {
        _todaysCaffeine += amount
    }
    
    func formattedAmount(for value: FormattedAmount = .dailyIntake) -> String {
        switch value {
        case .dailyIntake:
            return formattedAmount(.init(value: self.todaysCaffeine(), unit: .milligrams))
        case .amountOver:
            return formattedAmount(.init(value: self.amountOver, unit: .milligrams))
        }
    }
    
    func formattedAmount(_ amount: Measurement<UnitMass>) -> String {
        return formatter.string(from: amount)
    }
}

// MARK: Superwall Delegate and Single IAP Functions

extension CaffeineStore: SuperwallDelegate {
    func subscriptionStatusDidChange(from oldValue: SubscriptionStatus,
                                     to newValue: SubscriptionStatus) {
        switch newValue {
        case .unknown:
            self.hasCaffeinePalPro = false
        case .inactive:
            self.hasCaffeinePalPro = false
        case .active(_):
            // If you have multiple entitlements, you'd check those here.
            self.hasCaffeinePalPro = true
        }
    }
    
    func handleSuperwallEvent(withInfo eventInfo: SuperwallEventInfo) {
        switch eventInfo.event {
        case .appLaunch:
            self.hasCaffeinePalPro = Superwall.shared.subscriptionStatus.isActive
        case .nonRecurringProductPurchase(product: let p, paywallInfo: _):
            // Add the espresso product to the purchase history
            if CaffeineStore.recipeProductIdentifiers.contains(p.id),
               let espressoModel = EspressoDrink.all().first(where: { p.id == $0.skIdentifier }) {
                self.purchasedEspressoRecipes.insert(espressoModel)
            }
        default:
            print("Superwall event: \(eventInfo.event)")
        }
    }
    
    // These are consumable and non-consumable products. You could also
    // Add each product into the Superwall dashboard as well.
    func fetchTipAndEspressoRecipeProducts() async {
        let tipIdentifiers: [String] = CaffeineStore.tipProductIdentifiers
        let recipeIdentifiers: [String] = CaffeineStore.recipeProductIdentifiers
        
        self.tipProducts = await Superwall.shared.products(for: Set(tipIdentifiers))
        self.espressoProducts = await Superwall.shared.products(for: Set(recipeIdentifiers))
        
        // Update purchases
        await checkPurchasedEspressoRecipes()
    }
    
    func purchase(_ product: StoreProduct) async throws {
        let result = await Superwall.shared.purchase(product)
        
        switch result {
        case .cancelled:
            throw CaffeinePalStoreFrontError.cancelled
        case .purchased:
            // In `handleSuperwallEvent` delegate method, we'll check if an espresso recipe was
            // Purchased and if it was, we'll add it to the purchased drinks set.
            print("Purchased product \(product.productIdentifier)")
        case .pending:
            throw CaffeinePalStoreFrontError.pending
        case .failed(let error):
            throw error
        }
    }
    
    func hasPurchased(_ espressoRecipe: EspressoDrink) -> Bool {
        return purchasedEspressoRecipes.contains(espressoRecipe) || hasCaffeinePalPro
    }
    
    private func checkPurchasedEspressoRecipes() async {
        for espressoProduct in self.espressoProducts {
            guard let resultingTransaction = await espressoProduct.sk2Product?.latestTransaction else {
                // The customer hasn't purchased this product.
                continue
            }
            
            guard case .verified(let transaction) = resultingTransaction else {
                // Transaction couldn't be verified, skip this product
                continue
            }
            
            guard let modelRepresentation = EspressoDrink.all().first(where: { $0.skIdentifier == transaction.productID }) else {
                // Couldn't find local model representation of a product.
                continue
            }
            
            purchasedEspressoRecipes.insert(modelRepresentation)
        }
    }
}

// MARK: Local Models to StoreKit values

extension CaffeineStore {
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
    
    func tipProduct(from tip: TippingView.AvailableTips) -> StoreProduct? {
        let tip = self.tipProducts.first { $0.productIdentifier == tip.skIdentifier }
        return tip
    }
    
    func espressoProduct(from espresso: EspressoDrink) -> StoreProduct? {
        let espresso = self.espressoProducts.first { $0.productIdentifier == espresso.skIdentifier }
        return espresso
    }
}

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
    case productNotFound, failedVerification, pending, cancelled
}
