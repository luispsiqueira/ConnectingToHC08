//
//  CarDataDrawComponent.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 21/11/24.
//

import SwiftUI

struct CarDataDrawComponent: View {
    var data: GetData
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 64) {
                HStack {
                    if data.robotState == 0 {
                        Text("Estado: automático")
                    } else {
                        Text("Estado: manual")
                    }
                    Spacer()
                    BatteryComponent(battery: data.batteryCharge)
                }.padding(.horizontal)
                
                VStack(spacing: 24) {
                    VStack {
                        ZStack {
                            if #available(iOS 17.0, *) {
                                Rectangle()
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 120, height: 30)
                            }
                            HStack(spacing: 10) {
                                ForEach(data.lineSensorData, id: \.self) { item in
                                    Text("\(item)")
                                }
                            }
                        }.offset(y: 20)
                        Image(systemName: "car.top.radiowaves.front.fill")
                            .font(.system(size: 120))
//                            .foregroundStyle(.orange)
                    }.padding(.horizontal)
                    
                    DataSquares(data: data)
                }
            }
        }
    }
}

