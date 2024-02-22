//
//  AllProductsView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/25/24.
//

import SwiftUI
import StoreKit

struct AllProductsView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            StoreView(ids: PurchaseOperations.allProductIdentifiers)
                .storeButton(.hidden, for: .cancellation)
                .productViewStyle(.compact)
                .bold()
                .navigationTitle("All Products")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", systemImage: "xmark.circle.fill") {
                            dismiss()
                        }
                    }
                }
        }
    }
    
    
}

#Preview {
    AllProductsView()
        .environment(PurchaseOperations())
}
