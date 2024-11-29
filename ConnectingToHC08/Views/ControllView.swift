//
//  ControllView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 19/09/24.
//

import SwiftUI

struct ControllView: View {
    
    @ObservedObject var bluetoothController: BluetoothController
    @StateObject private var viewController: ControllViewController
    @Environment(\.dismiss) private var dismiss
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
        self._viewController = StateObject(wrappedValue: ControllViewController(bluetoothController: bluetoothController))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    
                    HStack {
                        Spacer()
                        BatteryComponent(battery: bluetoothController.data.batteryCharge)
                    }.padding(.horizontal)
                    
                    TabView(selection: $viewController.selectedIndex) {
                        DataSquares(data: bluetoothController.data)
                            .tag(0)
                        
                        ChangeVelocityTarget(velocityTarget: $viewController.factor)
                            .background(.clear, in: .rect(cornerRadius: 10))
                            .tag(1)
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                    .offset(y: -40)
                    
                    Spacer()
                    
                    ArrowsControll(buttonsAreEnable: $viewController.buttonsAreEnable, velocityRightMotor: $viewController.velocityRightMotor, velocityLeftMotor: $viewController.velocityLeftMotor, velocitytarget: $viewController.velocityTarget, someButtonIsBeenPressed: $viewController.someButtonIsBeenPressed, factor: $viewController.factor)
                    
                    Spacer()
                    
                }
                .blur(radius: viewController.mode == 0 ? 5 : 0)
                .disabled(viewController.mode == 0)
                .onChange(of: viewController.velocityRightMotor) { _ in
                    viewController.changeValueAndSendToTheCar(.rightMotorSpeed, viewController.velocityRightMotor)
                }
                .onChange(of: viewController.velocityLeftMotor) { _ in
                    viewController.changeValueAndSendToTheCar(.leftMotorSpeed, viewController.velocityLeftMotor)
                }
                .onChange(of: viewController.bluetoothController.data.velocity.actual) { velocity in
                    if viewController.mode == 1 && viewController.someButtonIsBeenPressed == 0 && velocity > 10 {
                        viewController.forceStop()
                    }
                }
                .onChange(of: viewController.bluetoothController.data.velocity.average) { velocity in
                    if viewController.mode == 1 && viewController.someButtonIsBeenPressed == 0 && velocity > 10 {
                        viewController.forceStop()
                    }
                }
//                .onChange(of: viewController.factor) { _ in
//                    viewController.changeValueAndSendToTheCar(.velocityTarget, 120 * viewController.factor)
//                }
                .navigationTitle("Controle")
                .toolbar {
                    if viewController.mode == 1 {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Automático") {
                                if viewController.mode == 1 {
                                    viewController.deactiveManualMode()
                                }
                            }
                        }
                    }
                }
                
                if viewController.mode ==  0 {
                    
                    Button(action:{
                        if viewController.mode == 0 {
                            viewController.activeManualMode()
                        } else if viewController.mode == 1 {
                            viewController.deactiveManualMode()
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.orange)
                                .frame(height: 60)
                            
                            if viewController.mode == 0 {
                                Text("Ativar modo manual")
                                    .bold()
                                    .accentColor(.black)
                            } else {
                                Text("Destivar modo manual")
                                    .bold()
                                    .accentColor(.black)
                            }
                        }
                    })
                    .padding(.horizontal)
                }
            }
        }
    }
}

//#Preview {
//    ControllView()
//}
