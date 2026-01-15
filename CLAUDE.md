# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Run

Open `Caffeine Pal.xcodeproj` in Xcode and build/run on an iOS 17.2+ simulator or device. The scheme is "Caffeine Pal".

StoreKit testing uses a local configuration file (`CaffinePalProducts.storekit`). Enable it in the scheme's Run/Options tab to test in-app purchases without App Store Connect.

## Architecture

Caffeine Pal is a SwiftUI iOS app demonstrating StoreKit 2 with Superwall for paywall management. It uses the Observation framework (`@Observable`) for state management.

### Key Components

**CaffeineStore** (`Store and Models/CaffeineStore.swift`)
- Central `@Observable` `@MainActor` class injected via `.environment()` at app root
- Manages caffeine tracking state, subscription status, and all IAP operations
- Implements `SuperwallDelegate` to handle subscription changes and purchase events
- Tracks three product types: consumables (tips), non-consumables (recipes), and subscriptions (Pro)

**Product Identifiers**
- Tips: `consumable.tip.[small|medium|large|irresponsible]`
- Recipes: `nonconsumable.recipe.[drinkId]` (15 espresso drinks)
- Subscriptions: `subscription.caffeinePalPro.[monthly|annual]`

**EspressoDrink** (`Store and Models/EspressoDrink.swift`)
- Static model for espresso drink catalog
- Contains `skIdentifier` computed property mapping to StoreKit product IDs
- Stores markdown recipes for each drink type

### Views Structure

- **ContentView**: TabView with three tabs (Intake, Coffee, Settings)
- **IntakeView**: Caffeine logging with circular progress gauge; uses `Superwall.shared.register(placement:)` to gate logging behind paywall
- **RecipesView**: Browse/purchase espresso recipes; uses TipKit for promotional tips
- **AppSettingsView**: Pro membership, alternate app icons, tip jar, app info

### Superwall Integration

Superwall handles subscription/paywall presentation. Key placements:
- `caffeineLogged`: Triggered when logging caffeine or tapping "Join Pro"
- `customIconSelected`: Triggered when selecting a locked app icon

Configure Superwall in `Caffeine_PalApp.swift` at launch with the API key.

## Dependencies

- **SuperwallKit**: Paywall management and subscription handling (SPM)
- **TipKit**: Native iOS tip display system
