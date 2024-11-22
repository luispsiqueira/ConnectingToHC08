//
//  BluetoothController.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 19/09/24.
//

import Foundation
import CoreBluetooth
import Combine
import SwiftUI

class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    private var centralManager: CBCentralManager!
    
    @Published var connectedPeripheral: CBPeripheral?
    @Published var discoveredPeripherals = [CBPeripheral]()
    @Published var isConnected = false
    @Published var isConnecting = false
    @Published var navegate = false
    @Published var bluetoothStatus: BluetoothStatus = .off
    @Published var valueReceived: String?
    public var writeCharacteristic: CBCharacteristic?
    @Published var allJSON: String = ""
    @Published var data = GetData(ultrasonicDistance: 0, batteryCharge: 0, acceleration: Acceleration(x: 0, y: 0, z: 0), gyro: Gyro(x: 0, y: 0), lineSensorData: [0,0,0,0,0], velocity: Velocity(actual: 0, average: 0), distanceCovered: 0, robotState: 0)
    
    @Published var appState: AppState?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        centralManagerDidUpdateState(centralManager)
    }
    
}

extension BluetoothController  {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            bluetoothStatus = BluetoothStatus.on
            
        case .poweredOff:
            resetReferences()
            bluetoothStatus = BluetoothStatus.off
            
        case .resetting:
            // Wait for next state update and consider logging interruption of Bluetooth service
            bluetoothStatus = BluetoothStatus.resetting
            
        case .unauthorized:
            // Alert user to enable Bluetooth permission in app Settings
            bluetoothStatus = BluetoothStatus.unathorized
            
        case .unsupported:
            // Alert user their device does not support Bluetooth and app will not work as expected
            bluetoothStatus = BluetoothStatus.unsupported
            
        case .unknown:
            // Wait for next state update
            bluetoothStatus = BluetoothStatus.unknown
            
        @unknown default:
            print("---Unknown default bluetooth state---")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripheralAlreadyRegistered(peripheral: peripheral){
            if peripheral.name != nil{
                discoveredPeripherals.append(peripheral)
            }
        }
    }
    
    func peripheralAlreadyRegistered(peripheral: CBPeripheral) -> Bool{
        return discoveredPeripherals.contains(peripheral)
    }
    
    func connect(peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
        self.isConnecting = false
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.connectedPeripheral = peripheral
        self.isConnected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navegate = true
        }
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Handle error
        print("WARNING: Connection failed")
    }
    
    func disconnect() {
        guard let peripheral = connectedPeripheral else {
            return
        }
        
        appState?.isConnected = false
        
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func resetReferences(){
        self.connectedPeripheral = nil
        self.discoveredPeripherals = []
        self.isConnected = false
        self.valueReceived = nil
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        resetReferences()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard peripheral.services != nil else {
            return
        }
        
        discoverCharacteristics(peripheral: peripheral)
    }
    
    func discoverCharacteristics(peripheral: CBPeripheral) {
        guard let services = peripheral.services else {
            return
        }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: "FFE1") && (characteristic.properties.contains(.write) || characteristic.properties.contains(.writeWithoutResponse)) {
                    writeCharacteristic = characteristic
                    print("Write characteristic found: \(characteristic.uuid)")
                }
                
                if characteristic.properties.contains(.notify) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            if let stringValue = String(data: value, encoding: .utf8) {
                if !stringValue.contains("\0") {
                    valueReceived = stringValue
                    allJSON += valueReceived ?? ""
                }
                if stringValue.contains(";") {
                    getDataFromJSON()
                    allJSON = ""
                }
            }
        }
    }
    
    func sendData(_ data: String) {
        guard isConnected else {
            print("Not connected to any peripheral.")
            return
        }
        
        if let dataToSend = data.data(using: .utf8) {
            if let characteristic = writeCharacteristic {
                connectedPeripheral!.writeValue(dataToSend, for: characteristic, type: .withoutResponse)
            } else {
                print("Write characteristic not found.")
            }
        } else {
            print("Failed to convert string to data.")
        }
    }
    
    func getDataFromJSON() {
        print(allJSON)
        allJSON.removeLast()
        guard let jsonData = allJSON.data(using: .utf8) else {
            print("Erro ao converter a string para Data")
            return
        }
        
        do {
            let dataFromJSON = try JSONDecoder().decode(GetData.self, from: jsonData)
            data.ultrasonicDistance = dataFromJSON.ultrasonicDistance
            data.batteryCharge = dataFromJSON.batteryCharge
            data.acceleration.x = dataFromJSON.acceleration.x
            data.acceleration.y = dataFromJSON.acceleration.y
            data.acceleration.z = dataFromJSON.acceleration.z
            data.gyro.x = dataFromJSON.gyro.x
            data.gyro.y = dataFromJSON.gyro.y
            data.lineSensorData = dataFromJSON.lineSensorData
            data.velocity.actual = dataFromJSON.velocity.actual
            data.velocity.average = dataFromJSON.velocity.average
            data.distanceCovered = dataFromJSON.distanceCovered
            data.robotState = dataFromJSON.robotState
        } catch {
            print("Erro ao decodificar JSON: \(error)")
        }
    }

}


