//
//  CarView.swift
//  Trade My Tesla
//
//  Created by Radu Petrisel on 01.09.2023.
//

import CoreML
import SwiftUI

struct CarView: View {
    private let models = ["Model 3", "Model S", "Model X"]
    private let premiumUpgrades = ["Installed", "Not Installed"]
    private let conditions = ["Poor", "OK", "Good", "Great"]
    
    @State private var model = 0
    @State private var premiumUpgrade = 0
    @State private var mileage = 10_000.0
    @State private var condition = 2
    
    private var tradeInValue: Double {
        if let cars = try? Cars(configuration: MLModelConfiguration()) {
            if let prediction = try? cars.prediction(model: Double(model), premium: Double(1 - premiumUpgrade), mileage: mileage, condition: Double(condition)) {
                return prediction.price
            }
        }
        
        return 0
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("MODEL")
                Picker("MODEL", selection: $model) {
                    ForEach(0..<3) {
                        Text(models[$0])
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack(alignment: .leading) {
                Text("PREMIUM UPGRADES")
                Picker("PREMIUM UPGRADES", selection: $premiumUpgrade) {
                    ForEach(0..<2) {
                        Text(premiumUpgrades[$0])
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("MILEAGE:")
                    Text(Measurement(value: mileage, unit: UnitLength.miles), format: .measurement(width: .abbreviated))
                }
                Slider(value: $mileage, in: 1...200_000)
            }
            
            VStack(alignment: .leading) {
                Text("CONDITION")
                Picker("CONDITION", selection: $condition) {
                    ForEach(0..<4) {
                        Text(conditions[$0])
                    }
                }
                .pickerStyle(.segmented)
            }
            
            VStack() {
                Text("Trade your Tesla for...")
                Text(tradeInValue, format: .currency(code: "USD").precision(.fractionLength(0)))
                    .font(.largeTitle)
            }
        }
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.teslaRed)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CarView()
        }
    }
}
