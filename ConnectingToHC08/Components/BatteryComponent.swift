//
//  BatteryComponent.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 21/11/24.
//

import SwiftUI

struct BatteryComponent: View {
    var battery: Double
    var body: some View {
        if battery > 75 {
            HStack(spacing: 4) {
                Image(systemName: "battery.100percent")
                Text("\(Int(battery))%")
            }
        } else if battery > 50 {
            HStack(spacing: 4) {
                Image(systemName: "battery.75percent")
                Text("\(Int(battery))%")
            }
        } else if battery > 25 {
            HStack(spacing: 4) {
                Image(systemName: "battery.50percent")
                Text("\(Int(battery))%")
            }
        } else if battery > 0 {
            HStack(spacing: 4) {
                Image(systemName: "battery.25percent")
                Text("\(Int(battery))%")
            }
        } else {
            HStack(spacing: 4) {
                Image(systemName: "battery.0percent")
                Text("\(Int(battery))%")
            }
        }
    }
}
