//
//  DataView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 07/11/24.
//

import SwiftUI

struct DataView: View {
    
    @ObservedObject var bluetoothController: BluetoothController
    @StateObject private var viewController: DataViewController
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
        self._viewController = StateObject(wrappedValue: DataViewController(bluetoothController: bluetoothController))
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewController.selectedIndex) {
                CarDataDrawComponent(data: bluetoothController.data)
                    .tag(0)

                CarDataOrganizedComponent(data: bluetoothController.data)
                    .tag(1)

                CarDataComponent(data: bluetoothController.data)
                    .tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onChange(of: bluetoothController.valueReceived ?? "") { valueReceived in
                viewController.receiveValue(valueReceived)
            }
            .onReceive(viewController.timer) { _ in
                viewController.messageToSend = "#gj;"
                bluetoothController.sendData(viewController.messageToSend)
            }
            .navigationTitle("Dados")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Desconectar") {
                        viewController.showAlert = true
                    }.alert("Certeza que deseja desconectar o carrinho?", isPresented: $viewController.showAlert){
                        Button("Sim", role: .destructive) {bluetoothController.disconnect()}
                        Button("Cancelar", role: .cancel) {}
                    }
                }
            }
        }
    }
}

