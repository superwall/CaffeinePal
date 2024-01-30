//
//  PaywallView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/25/24.
//

import SwiftUI

struct PaywallView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @State private var showError: Bool = false
    @State private var showWelcome: Bool = false
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
            ScrollView {
                switch showWelcome {
                case true:
                    WelcomeToProView()
                        .transition(.scale(scale: 0.8, anchor: .center)
                                    .combined(with: .opacity))
                case false:
                    PaywallFeatureListingView {
                        joinPro()
                    } onRestore: {
                        restore()
                    }
                    .transition(.scale(scale: 0.8, anchor: .center)
                                .combined(with: .opacity))
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 44)
            .padding(.vertical)
            .alert("Uh Oh!", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("We hit a problem, please try again.")
            }
        }
    }
    
    // MARK: Private Functions
    
    private func joinPro() {
        Task {
            do {
                if try await storefront.purchasePro() {
                    withAnimation {
                        showWelcome.toggle()
                    }
                }
            } catch {
                showError.toggle()
            }
        }
    }
    
    private func restore() {
        Task {
            do {
                try await storefront.restorePurchases()
                
                if storefront.hasCaffeinePalPro {
                    withAnimation {
                        showWelcome.toggle()
                    }
                }
            } catch {
                showError.toggle()
            }
        }
    }
}

struct PaywallFeatureListingView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @State private var showError: Bool = false
    
    let onJoinPro: () -> ()
    let onRestore: () -> ()
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Join Caffeine Pal Pro Today!")
                .font(.largeTitle.weight(.black))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            ForEach(ProFeatures.allCases) { feature in
                ExpandedFeatureView(feature: feature)
            }
            Button(action: {
                onJoinPro()
            }, label: {
                Text("Join Pro")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.white)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .center)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10.0)
                            .foregroundStyle(Color.blue)
                    }
            })
            Button(action: {
                onRestore()
            }, label: {
                Text("Restore Purchases")
                    .font(.headline.weight(.medium))
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .center)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10.0)
                            .foregroundStyle(Color(uiColor: .systemGroupedBackground))
                    }
            })
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

struct WelcomeToProView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            Text("You're in!")
                .font(.largeTitle.weight(.black))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            Text("Welcome to Caffeine Pal Pro.")
                .font(.title.weight(.bold))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            Text("You now have all pro features. Go make one of our custom espresso drinks with our walkthrough guides, or go log some coffee. We're happy to have you.")
                .foregroundStyle(Color(uiColor: .secondaryLabel))
                .font(.title2.weight(.semibold))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 32)
            Button("Let's Go!") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title3.weight(.semibold))
            .buttonBorderShape(.roundedRectangle(radius: 12.0))
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    PaywallView()
        .environment(PurchaseOperations())
}
