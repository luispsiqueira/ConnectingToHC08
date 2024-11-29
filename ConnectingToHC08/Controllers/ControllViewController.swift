//
//  ControllViewController.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 25/10/24.
//

import SwiftUI

class ControllViewController: ObservableObject {
    @ObservedObject var bluetoothController: BluetoothController
    @Published var sendData = SendData(velocityTarget: 0.00, rightMotorSpeed: 0.00, robotMode: 0, leftMotorSpeed: 0.00)
    @Published var messageToSend: String = ""
    @Published var mode: Int = 0
    @Published var buttonsAreEnable: Bool = false
    @Published var showAlert: Bool = false
    @Published var velocityRightMotor: Double = 0.0
    @Published var velocityLeftMotor: Double = 0.0
    @Published var velocityTarget = VelocityTarget()
    @Published var someButtonIsBeenPressed: Int = 0
    @Published var selectedIndex: Int = 0
    @Published var factor: Double = 120.0
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
    }
    
    func changeValueAndSendToTheCar(_ parameter: Parameters, _ value: Double) {
        switch parameter{
        case .velocityTarget:
            sendData.velocityTarget = value
            sendValue("#sv", value)
        case .rightMotorSpeed:
            sendData.rightMotorSpeed = value
            sendValue("#sr", value)
        case .leftMotorSpeed:
            sendData.leftMotorSpeed = value
            sendValue("#sl", value)
        case .robotMode:
            sendData.robotMode = Int(value)
            sendValue("#sm", value)
        }
    }
    
    func sendValue(_ prefix: String, _ value: Double) {
        var dataToSend: String = ""
        if prefix == "#sm" {
            dataToSend = prefix + String(Int(value)) + ";"
        } else {
            dataToSend = prefix + String(value) + ";"
        }
        bluetoothController.sendData(dataToSend)
        print(dataToSend)
    }
    
    func activeManualMode() {
        changeValueAndSendToTheCar(.robotMode, 1)
        self.mode = 1
        self.buttonsAreEnable = true
    }
    
    func deactiveManualMode() {
        changeValueAndSendToTheCar(.leftMotorSpeed, 0.001)
        changeValueAndSendToTheCar(.rightMotorSpeed, 0.001)
        changeValueAndSendToTheCar(.robotMode, 0)
        self.mode = 0
        self.buttonsAreEnable = false
    }
    
    func forceStop() {
        changeValueAndSendToTheCar(.rightMotorSpeed, velocityRightMotor)
        changeValueAndSendToTheCar(.leftMotorSpeed, velocityLeftMotor)
    }
}
