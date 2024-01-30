//
//  RecipesView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
import TipKit

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
                            Button(storefront.hasPurchased(drink) ? "View" : "Buy") {
                                handleSelectionFor(drink)
                            }
                            .foregroundStyle(Color.inverseLabel)
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                            .padding(.leading, 8)
                        }
                        .padding(.vertical)
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
                    PaywallView()
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

struct FeaturedEspressoDrinksView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    private let featured: [EspressoDrink] = [.affogato, .ristretto, .flatWhite]
    let onTap: (EspressoDrink) -> ()

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10.0) {
                ForEach(featured) { drink in
                    Image(drink.imageFile())
                        .resizable()
                        .aspectRatio(3.0 / 2.0, contentMode: .fit)
                        .containerRelativeFrame(.horizontal, 
                                                count: 1, spacing: 0)
                        .overlay(alignment: .bottom) {
                            HStack {
                                Text(drink.name)
                                    .fontWeight(.medium)
                                    .padding(.leading, 4)
                                Spacer()
                                Button(storefront.hasPurchased(drink) ? "View" : "Buy") {
                                    onTap(drink)
                                }
                                .foregroundStyle(Color.inverseLabel)
                                .buttonBorderShape(.capsule)
                                .buttonStyle(.borderedProminent)
                                .padding(.trailing, 4)
                            }
                            .padding(8)
                            .background {
                                Rectangle()
                                    .foregroundStyle(Material.thin)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
        }
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.horizontal, 16.0)
        .scrollIndicators(.hidden)
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
