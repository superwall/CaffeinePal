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
            Text("Implement StoreView")
        }
    }
    
    
}

#Preview {
    AllProductsView()
        .environment(PurchaseOperations())
}
