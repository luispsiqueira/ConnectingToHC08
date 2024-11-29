//
//  DataSquares.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 21/11/24.
//

import SwiftUI

struct DataSquares: View {
    var data: GetData
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 100)
                        .foregroundStyle(.gray)
                    
                    VStack(spacing: 8){
                        Text("Velocidade")
                            .bold()
                            .font(.system(size: 18))
                        
                        VStack {
                            Text("Atual: \(String(format: "%.2f", data.velocity.actual))")
                            Text("Desejada: \(String(format: "%.2f", data.velocity.average))")
                        }
                    }.padding(.bottom, 12)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.gray)
                        .frame(height: 100)
                    
                    VStack(spacing: 8){
                        Text("Distância")
                            .bold()
                            .font(.system(size: 18))
                        
                        VStack {
                            Text("Ultrassônica: \(String(format: "%.2f", data.ultrasonicDistance))")
                            Text("Percorrida: \(String(format: "%.2f", data.distanceCovered))")
                        }
                    }.padding(.bottom, 12)
                }
            }
            HStack(spacing: 8) {
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 100)
                        .foregroundStyle(.gray)
                    
                    VStack(spacing: 8){
                        Text("Giroscópio")
                            .bold()
                            .font(.system(size: 18))
                    
                        VStack {
                            Text("X: \(String(format: "%.2f", data.gyro.x))")
                            Text("Y: \(String(format: "%.2f", data.gyro.y))")
                            Text("Z: \(String(format: "%.2f", data.gyro.z))")
                        }
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(.gray)
                        .frame(height: 100)
                    
                    VStack{
                        Text("Aceleração")
                            .bold()
                            .font(.system(size: 18))
                        
                        Text("X: \(String(format: "%.2f", data.acceleration.x))")
                        Text("Y: \(String(format: "%.2f", data.acceleration.y))")
                        Text("Z: \(String(format: "%.2f", data.acceleration.z))")
                    }
                }
            }
        }.padding(.horizontal)
    }
}
