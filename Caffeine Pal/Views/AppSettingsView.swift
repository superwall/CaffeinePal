//
//  AppSettingsView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI
import StoreKit
import SuperwallKit

struct AppSettingsView: View {
    @Environment(CaffeineStore.self) private var store
    
    var body: some View {
        NavigationStack {
            ScrollView {
                switch store.hasCaffeinePalPro {
                case true:
                    CaffeineProMemberView()
                        .padding()
                case false:
                    MembershipView()
                        .padding()
                }
                AppIconsView()
                    .padding()
                TippingView()
                    .padding()
                AppInformationView()
                    .padding()
            }
            .navigationTitle("Settings")
        }
    }
}

struct CaffeineProMemberView: View {
    @State private var bounceCrown: Bool = false
    @State private var showManageSubs: Bool = false
    @State private var renewalInfo: String = ""
    
    var body: some View {
        VStack {
            Text("Membership")
                .font(.headline.weight(.bold))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .leading)
            VStack {
                HStack {
                    Text("You're on Pro")
                        .font(.title2.weight(.bold))
                    Spacer()
                    Image(systemName: "crown.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.brandingSecondary)
                        .padding(12)
                        .background {
                            Circle()
                                .foregroundStyle(Color.accentColor)
                        }
                        .symbolEffect(.bounce, value: bounceCrown)
                        .onAppear {
                            bounceCrown = true
                        }
                }
                Text("We're happy to have you. " + renewalInfo)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.bottom)
                Button("Manage Subscription") {
                    showManageSubs.toggle()
                }
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .buttonStyle(.bordered)
                .manageSubscriptionsSheet(isPresented: $showManageSubs)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(Color(uiColor: .systemGroupedBackground))
            }
        }
    }
}

struct MembershipView: View {
    @State private var bounceCrown: Bool = false
    @State private var showJoinPro: Bool = false
    
    var body: some View {
        VStack {
            Text("Membership")
                .font(.headline.weight(.bold))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .leading)
            VStack {
                HStack {
                    Text("Caffeine Pal Pro")
                        .font(.title.weight(.black))
                    Spacer()
                    Image(systemName: "crown.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.brandingSecondary)
                        .padding(12)
                        .background {
                            Circle()
                                .foregroundStyle(Color.accentColor)
                        }
                        .symbolEffect(.bounce, value: bounceCrown)
                        .onAppear {
                            bounceCrown = true
                        }
                }
                Text("Get the most out of Caffeine Pal. Join today and get these pro features:")
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           alignment: .leading)
                    .padding(.vertical)
                ForEach(ProFeatures.allCases) { feature in
                    HStack(alignment: .center, spacing: 0) {
                        Image(systemName: feature.symbol)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: 58, height: 58)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.blue)
                        VStack(alignment: .leading) {
                            Text(feature.rawValue)
                                .font(.headline.weight(.medium))
                            Text(feature.description)
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                        }
                        Spacer()
                    }
                    .padding(2)
                    .background {
                        RoundedRectangle(cornerRadius: 12.0)
                            .foregroundStyle(Color(uiColor: .systemBackground))
                    }
                }
                Button(action: {
                    Superwall.shared.register(placement: "caffeineLogged")
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
                .padding(.top, 32)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(Color(uiColor: .systemGroupedBackground))
            }
        }
    }
}

struct AppIconsView: View {
    @Environment(CaffeineStore.self) private var store
    
    enum AvailableIcons: String, Identifiable, CaseIterable, CustomStringConvertible {
        case primary = "AppIcon"
        case seconday = "SecondaryAppIcon"
        case tertiary = "TertiaryAppIcon"
        
        var id: Self { return self }
        
        var displayFileName: String {
            return self.rawValue + "-UI"
        }
        
        var bundleIconName: String? {
            switch self {
            case .primary:
                nil
            case .seconday:
                "SecondaryIcon"
            case .tertiary:
                "TertiaryIcon"
            }
        }
        
        var description: String {
            switch self {
            case .primary:
                "Default"
            case .seconday:
                "Tiel Coffee Cup"
            case .tertiary:
                "Vector Caffeine"
            }
        }
    }
    
    @State private var currentIcon: String? = UIApplication.shared.alternateIconName
    
    var body: some View {
        VStack {
            Text("App Icons")
                .font(.headline.weight(.bold))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .leading)
            ForEach(AvailableIcons.allCases) { icon in
                Button {
                    toggle(icon)
                } label: {
                    HStack {
                        Image(icon.displayFileName)
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        Text(icon.description)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: symbolFor(icon))
                            .font(.title)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color.blue)
                    }
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundStyle(Color(uiColor: .systemGroupedBackground))
                    }
                }
                .id(store.hasCaffeinePalPro)
            }
        }
    }
    
    // MARK: Private Functions
    
    private func symbolFor(_ icon: AvailableIcons) -> String {
        if store.hasCaffeinePalPro {
            return icon.bundleIconName == currentIcon ? "checkmark.circle.fill" :
                                                        "circle"
        } else {
            guard icon == .primary else {
                return "lock.circle.fill"
            }
            
            return "checkmark.circle.fill"
        }
    }
    
    private func toggle(_ icon: AvailableIcons) {
        guard store.hasCaffeinePalPro else {
            if icon != .primary {
                Superwall.shared.register(placement: "customIconSelected")
            }
            return
        }
        
        Task { @MainActor in
            do {
                try await UIApplication.shared.setAlternateIconName(icon.bundleIconName)
                self.currentIcon = icon.bundleIconName
            } catch {
                print("Unable to change icon: \(error.localizedDescription)")
            }
        }
    }
}

struct TippingView: View {
    @Environment(CaffeineStore.self) private var store
    
    enum AvailableTips: String, Identifiable, CaseIterable, CustomStringConvertible {
        case small = "Small Tip"
        case medium = "Medium Tip"
        case large = "Large Tip"
        case justCrazy = "Irresponsible Tip"
        
        var id: Self { return self }
        
        var description: String {
            switch self {
            case .small:
                "Just a small little thank you. Always nice to get."
            case .medium:
                "Okay, that's awesome! Thanks so much!"
            case .large:
                "Blown away! You are the best."
            case .justCrazy:
                "Completely empties your bank account."
            }
        }
        
        var emoji: String {
            switch self {
            case .small:
                "😀"
            case .medium:
                "😊"
            case .large:
                "🤯"
            case .justCrazy:
                "🫣"
            }
        }
        
        var shortDescription: String {
            switch self {
            case .small:
                "small"
            case .medium:
                "medium"
            case .large:
                "large"
            case .justCrazy:
                "irresponsible"
            }
        }
        
        func price(from store: CaffeineStore) -> String {
            guard let product = store.tipProduct(from: self) else {
                return ""
            }
            
            return product.localizedPrice
        }
    }
    
    @State private var showError: Bool = false
    @State private var showSuccess: Bool = false
    @State private var tipAmount: String = ""
    
    var body: some View {
        VStack {
            Text("Tips")
                .font(.headline.weight(.bold))
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .leading)
            ForEach(AvailableTips.allCases) { tip in
                HStack {
                    Text(tip.emoji)
                        .font(.title)
                        .foregroundStyle(Color.pink)
                        .padding(.trailing, 6)
                    VStack(alignment: .leading) {
                        Text(tip.rawValue)
                            .font(.headline)
                        Text(tip.description)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                            .fontWeight(.medium)
                    }
                    Spacer()
                    Button(tip.price(from: store)) {
                        buy(tip)
                    }
                    .foregroundStyle(Color.inverseLabel)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                }
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .foregroundStyle(Color(uiColor: .systemGroupedBackground))
                }
            }
        }
        .alert("Uh Oh!", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("We hit a problem, please try again.")
        }
        .alert("Thank you!", isPresented: $showSuccess) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("We'll put your tip for \(tipAmount) to good use ❤️.")
        }
    }
    
    // MARK: Private Functions
    
    private func buy(_ tip: AvailableTips) {
        Task {
            do {
                guard let tipProduct = store.tipProduct(from: tip) else {
                    showError.toggle()
                    return
                }
                
                try await store.purchase(tipProduct)
                tipAmount = tipProduct.localizedPrice
                showSuccess.toggle()
            } catch {
                showError.toggle()
            }
        }
    }
}

struct AppInformationView: View {
    private let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    
    var body: some View {
        HStack(spacing: 16) {
            Image("AppIcon-UI")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(width: 64, height: 64)
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                Text("Caffeine Pal")
                    .font(.subheadline.weight(.semibold))
                Text("v\(version)")
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Text("Enjoy your coffee ☕️")
                    .font(.caption2)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
            }
            .font(.caption)
            .foregroundColor(.primary)
        }
        .fixedSize()
    }
}
#Preview {
    AppSettingsView()
}
