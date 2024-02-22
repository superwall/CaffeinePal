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
        Text("TODO")
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
