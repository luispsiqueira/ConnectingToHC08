//
//  GetData.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 07/11/24.
//

import SwiftUI

struct GetData: Codable {
    var ultrasonicDistance: Double
    var batteryCharge: Double
    var acceleration: Acceleration
    var gyro: Gyro
    var lineSensorData: [Int]
    var velocity: Velocity
    var distanceCovered: Double
    var robotState: Int
}
