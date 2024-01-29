//
//  IntakeView.swift
//  Caffeine Pal
//
//  Created by Jordan Morgan on 1/23/24.
//

import SwiftUI

struct IntakeView: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @Environment(CaffeineStore.self) private var store: CaffeineStore
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CaffeineGaugeView()
                    .padding(.bottom, 32)
                    .padding(.top)
                if store.amountOver > 0 {
                    AmountOverBannerView()
                        .padding()
                        .transition(.scale(scale: 0.8, anchor: .center))
                }
                QuickLogView()
                    .padding()
            }
            .animation(.spring, value: store.amountOver)
            .navigationTitle("Today's Caffeine")
        }
    }
}

struct CaffeineGaugeView: View {
    @Environment(CaffeineStore.self) private var store: CaffeineStore
    
    var body: some View {
        Text(String(store.todaysCaffeine))
            .font(.system(size: 54))
            .fontWeight(.bold)
            .frame(width: 200)
            .minimumScaleFactor(0.8)
            .padding(64)
            .background {
                Circle()
                    .foregroundStyle(Color(uiColor: .systemGray4))
                    .opacity(0.35)
            }
            .padding(34)
            .background {
                CircularProgressView(progress: store.amountIngested)
            }
    }
}

struct CircularProgressView: View {
    var progress: CGFloat
    var backgroundColor: Color = Color(uiColor: .systemGray4)
    private let lineWidth: Double = 20.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(backgroundColor)
                .opacity(0.6)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, 
                                           lineCap: .round))
                .foregroundColor(.blue)
                .rotationEffect(.degrees(-90))
                .animation(.spring, value: progress)
        }
        .padding()
    }
}

struct AmountOverBannerView: View {
    @Environment(CaffeineStore.self) private var store: CaffeineStore
    
    var body: some View {
        Text("\(store.formattedAmount(for: .amountOver)) over daily limit.")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   alignment: .center)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 16.0)
                    .foregroundStyle(Color.pink)
            }
    }
}

struct QuickLogView: View {
    @Environment(CaffeineStore.self) private var store: CaffeineStore
    
    var body: some View {
        GroupBox("Quick Log") {
            QuickAddButton(text: "Single Shot", amountToLog: 64)
            Divider()
            QuickAddButton(text: "Double Shot", amountToLog: 128)
            Divider()
            QuickAddButton(text: "Triple Shot", amountToLog: 192)
            
        }
    }
}

struct QuickAddButton: View {
    @Environment(PurchaseOperations.self) private var storefront: PurchaseOperations
    @Environment(CaffeineStore.self) private var store: CaffeineStore
    @State private var showPaywall: Bool = false
    
    let text: String
    let amountToLog: Double
    
    var body: some View {
        HStack {
            Text(text)
                .fontWeight(.medium)
            Spacer()
            Button("Log") {
                if storefront.hasCaffeinePalPro {
                    store.log(amountToLog)
                } else {
                    showPaywall.toggle()
                }
            }
            .foregroundStyle(Color.inverseLabel)
            .fontWeight(.bold)
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
        }
        .padding(.vertical, 6)
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }
}

#Preview {
    IntakeView()
        .environment(PurchaseOperations())
        .environment(CaffeineStore())
}
