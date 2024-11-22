//
//  CarDataOrganizedComponent.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 21/11/24.
//

import SwiftUI

struct CarDataOrganizedComponent: View {
    var data: GetData
    var body: some View {
        List {
            Section(header: Text("Sensores")) {
                HStack {
                    Text("Sensor de linha:")
                    Spacer()
                    Text("\(data.lineSensorData)")
                }
            }
            
            Section(header: Text("Distâncias")) {
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
            }
            
            Section(header: Text("Velocidades")) {
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
            }
            
            Section(header: Text("Aceleração")) {
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
            }
            
            Section(header: Text("Giroscópio")) {
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
            }
            
            Section(header: Text("Status do sistema")) {
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
        } .padding(.bottom, 30)
    }
}
