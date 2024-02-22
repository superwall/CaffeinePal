//
//  SubscriptionView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 2/20/24.
//

import SwiftUI
import StoreKit

struct SubscriptionView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        SubscriptionStoreView(productIDs: PurchaseOperations.subProductIdentifiers) {
            ScrollView {
                VStack {
                    Text("Join Caffeine Pal Pro Today!")
                        .font(.largeTitle.weight(.black))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                    ForEach(ProFeatures.allCases) { feature in
                        ExpandedFeatureView(feature: feature)
                    }
                }
                .padding()
            }
            .containerBackground(Color(uiColor: .systemBackground).gradient,
                                 for: .subscriptionStoreFullHeight)
        }
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStoreButtonLabel(.action)
        .backgroundStyle(.thinMaterial)
        .onInAppPurchaseCompletion { (product: Product, result: Result<Product.PurchaseResult, Error>) in
            if case .success(.success(_)) = result {
                // StoreFront already processes this...
                // Simply dismiss
                dismiss()
            }
        }
    }
}

struct ExpandedFeatureView: View {
    let feature: ProFeatures
    @State private var bounce: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: feature.symbol)
                .font(.largeTitle)
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.blue)
                .symbolEffect(.bounce.byLayer, value: bounce)
                .onAppear {
                    let randomVal = Double.random(in: 0...1.5)
                    DispatchQueue.main.asyncAfter(deadline: .now() + randomVal) {
                        bounce.toggle()
                    }
                }
            Text(feature.rawValue)
                .font(.title2.weight(.medium))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text(feature.expandedDetails)
                .font(.subheadline.weight(.medium))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    SubscriptionView()
        .environment(PurchaseOperations())
}
