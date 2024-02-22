//
//  RecipesView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
import TipKit
import StoreKit

struct RecipesView: View {
    fileprivate enum ModalOption: Identifiable {
        case recipe(EspressoDrink)
        case paywall
        
        var id: String {
            switch self {
            case .recipe(let espressoDrink):
                return espressoDrink.id
            case .paywall:
                return "paywall"
            }
        }
    }
    
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @State private var tip: RecipeTip? = nil
    @State private var modalSelection: ModalOption? = nil
    @State private var showError: Bool = false
    @State private var showSuccess: Bool = false
    @State private var purchasedRecipe: EspressoDrink = .empty
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let purchaseTip = tip {
                    TipView(purchaseTip, arrowEdge: .none)
                        .padding(.horizontal)
                }
                Text("This Week's Specials")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top)
                FeaturedEspressoDrinksView { drink in
                    handleSelectionFor(drink)
                }
                .padding(.vertical)
                Text("Espresso Coffee")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top)
                GroupBox {
                    ForEach(EspressoDrink.all()) { drink in
                        ZStack {
                            switch storefront.hasPurchased(drink) {
                            case true:
                                PurchasedReceipeView(drink: drink) {
                                    handleSelectionFor(drink)
                                }
                            case false:
                                ProductView(id: drink.skIdentifier)
                                    .bold()
                                    .productViewStyle(.compact)
                            }
                        }
                        .animation(.smooth, value: storefront.hasPurchased(drink))
                        .padding(6)
                        Divider()
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .navigationTitle("Coffee Menu")
            .sheet(item: $modalSelection) { selection in
                switch selection {
                case .recipe(let drink):
                    ViewReceipeView(drink: drink)
                case .paywall:
                    SubscriptionView()
                }
            }
            .alert("Uh Oh!", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("We hit a problem, please try again.")
            }
            .alert("New Recipe Added", isPresented: $showSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Now you can make \(purchasedRecipe.name) anytime.")
            }
        }
        .onAppear {
            setTipPriceString()
        }
    }
    
    // MARK: Private Functions
    
    private func setTipPriceString() {
        if let firstRecipeProduct = storefront.recipes.values.first {
            self.tip = .init(price: firstRecipeProduct.displayPrice)
        }
    }
    
    private func handleSelectionFor(_ recipe: EspressoDrink) {
        guard storefront.hasCaffeinePalPro || storefront.hasPurchased(recipe) else {
            buy(drink: recipe)
            return
        }
        
        modalSelection = .recipe(recipe)
    }
    
    private func buy(drink: EspressoDrink) {
        Task {
            do {
                if try await storefront.purchase(drink) {
                    purchasedRecipe = drink
                    showSuccess.toggle()
                }
            } catch {
                showError.toggle()
            }
        }
    }
}

struct PurchasedReceipeView: View {
    let drink: EspressoDrink
    let onTap: () -> ()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(drink.name)
                    .font(.headline)
                    .padding(.bottom, 4)
                Text(drink.description)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Button("View") {
                onTap()
            }
            .foregroundStyle(Color.inverseLabel)
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .padding(.leading, 8)
        }
    }
}

struct FeaturedEspressoDrinksView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    private let featured: [EspressoDrink] = [.affogato, .ristretto, .flatWhite]
    let onTap: (EspressoDrink) -> ()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10.0) {
                ForEach(featured) { drink in
                    ZStack {
                        switch storefront.hasPurchased(drink) {
                        case true:
                            PurchasedFeatureDrinkView(drink: drink) { _ in
                                onTap(drink)
                            }
                        case false:
                            ProductView(id: drink.skIdentifier) {
                                Image(drink.imageFile())
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .productViewStyle(.large)
                        }
                    }
                    .padding()
                    .aspectRatio(3.0 / 2.0, contentMode: .fit)
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    .background(.background.secondary, in: .rect(cornerRadius: 16))
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.horizontal, 16.0)
        .scrollIndicators(.hidden)
    }
}

struct PurchasedFeatureDrinkView: View {
    let drink: EspressoDrink
    let onTap: (EspressoDrink) -> ()
    
    var body: some View {
        Image(drink.imageFile())
            .resizable()
            .overlay(alignment: .bottom) {
                HStack {
                    Text(drink.name)
                        .fontWeight(.medium)
                        .padding(.leading, 4)
                    Spacer()
                    Button("View") {
                        onTap(drink)
                    }
                    .foregroundStyle(Color.inverseLabel)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .padding(.trailing, 4)
                }
                .padding(8)
                .background(.thinMaterial)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct RecipeTip: Tip {
    private var price: String
    
    init(price: String) {
        self.price = price
    }
    
    var title: Text {
        Text("Our Signature Recipes")
    }
    
    var message: Text? {
        Text("Make espresso drinks like never before. Each of our secret espresso recipes are available for purchase for \(price).")
    }
    
    var image: Image? {
        Image(systemName: "cup.and.saucer.fill")
    }
}

#Preview {
    RecipesView()
        .environment(PurchaseOperations())
}
