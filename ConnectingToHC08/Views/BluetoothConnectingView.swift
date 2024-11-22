//
//  BluetoothConnectingView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 19/09/24.
//

import SwiftUI

struct BluetoothConnectingView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var bluetoothController: BluetoothController
    @State private var callNextView: Bool = false
    @State private var path = NavigationPath()
    @State private var isMovingUp: Bool = false
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader{ geometry in
                ZStack {
//                    Image("background")
//                        .resizable(resizingMode: .stretch)
//                        .ignoresSafeArea(.all)
                    
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "car.front.waves.down")
                                .foregroundStyle(.orange)
                                .font(.system(size: 90))
                                .offset(y: isMovingUp ? -20 : 0)
                                .animation(
                                    .easeInOut(duration: 0.8)
                                    .repeatForever(autoreverses: true),
                                    value: isMovingUp
                                )
                                .onAppear {
                                    isMovingUp.toggle()
                                }
                            
                            if bluetoothController.isConnected {
                                HStack {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.green)
                                        .font(.largeTitle)
                                    
                                    Text("Connected")
                                        .font(.largeTitle)
                                        .onAppear{
                                            if !callNextView {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    //                                                path.append(NavigationDestination.controllView)
                                                }
                                                //                                            callNextView = true
                                            }
                                        }
                                }
                            } else {
                                
                                HStack {
                                    Image(systemName: "x.circle")
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                    
                                    Text("Desconectado")
                                        .font(.largeTitle)
                                }
                                
                                Text("Clique no botão para conectar com o carrinho")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            bluetoothController.isConnecting = true
                            for peripheral in bluetoothController.discoveredPeripherals{
                                if peripheral.name == "Luis's iPad"{
                                    bluetoothController.connect(peripheral: peripheral)
                                }
                            }
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.orange)
                                    .frame(height: 60)
                                
                                if bluetoothController.isConnecting {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                } else {
                                    Text("Conectar")
                                        .bold()
                                        .accentColor(.black)
                                }
                            }
                        })
                    }
                    .padding()
                    .navigationTitle("Conexão")
                }
                .navigationDestination(for: NavigationDestination.self) { destination in
                    switch destination {
                    case .controllView:
                        ControllView(bluetoothController: bluetoothController)
                    case .bluetoothConnectingView:
                        BluetoothConnectingView(bluetoothController: bluetoothController)
                    }
                }
                .onAppear {
                    callNextView = false
                }
            }
        }
    }
}

enum NavigationDestination: Hashable {
    case controllView
    case bluetoothConnectingView
}
