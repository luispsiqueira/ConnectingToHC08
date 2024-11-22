//
//  DataViewController.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 07/11/24.
//

import SwiftUI

class DataViewController: ObservableObject {
    @ObservedObject var bluetoothController: BluetoothController
    @Published var valueReceived: String = ""
    @Published var messageToSend: String = ""
    @Published var showAlert: Bool = false
    @Published var selectedIndex = 0
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
    }
    
    func receiveValue(_ value: String) {
        valueReceived = value
        checkNextAction(self.valueReceived)
    }
    
    func checkNextAction(_ value: String) {
        
    }
}
