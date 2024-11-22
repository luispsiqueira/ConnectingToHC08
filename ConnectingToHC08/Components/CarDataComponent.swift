//
//  CarDataComponent.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 20/11/24.
//

import SwiftUI

struct CarDataComponent: View {
    var data: GetData
    var body: some View {
        List {
            Section(header: Text("Todos os dados do carro")) {
                HStack {
                    Text("Distância ultrassônica:")
                    Spacer()
                    Text("\(data.ultrasonicDistance)")
                }
                
                HStack {
                    Text("Distância percorrida:")
                    Spacer()
                    Text("\(data.distanceCovered)")
                }
                
                HStack {
                    Text("Aceleração em x:")
                    Spacer()
                    Text("\(data.acceleration.x)")
                }
                
                HStack {
                    Text("Aceleração em y:")
                    Spacer()
                    Text("\(data.acceleration.y)")
                }
                
                HStack {
                    Text("Aceleração em z:")
                    Spacer()
                    Text("\(data.acceleration.z)")
                }
                
                HStack {
                    Text("Giroscópio em x:")
                    Spacer()
                    Text("\(data.gyro.x)")
                }
                
                HStack {
                    Text("Giroscópio em y:")
                    Spacer()
                    Text("\(data.gyro.y)")
                }
                
                HStack {
                    Text("Sensor de linha:")
                    Spacer()
                    Text("\(data.lineSensorData)")
                }
                
                HStack {
                    Text("Velocidade atual:")
                    Spacer()
                    Text("\(data.velocity.actual)")
                }
                
                HStack {
                    Text("Velocidade desejada:")
                    Spacer()
                    Text("\(data.velocity.average)")
                }
                
                HStack {
                    Text("Bateria:")
                    Spacer()
                    Text("\(data.batteryCharge)")
                }
                
                HStack {
                    Text("Estado do robô:")
                    Spacer()
                    if data.robotState == 0 {
                        Text("Automático")
                    } else {
                        Text("Manual")
                    }
                }
            }
        }
    }
}


//var ultrasonicDistance: Double
//var batteryCharge: Double
//var acceleration: Acceleration
//var gyro: Gyro
//var lineSensorData: [Int]
//var velocity: Velocity
//var distanceCovered: Double
//var robotState: Int
