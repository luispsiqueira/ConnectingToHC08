//
//  SendData.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 25/10/24.
//

import SwiftUI

struct SendData: Codable {
    var velocityTarget: Double
    var rightMotorSpeed: Double
    var robotMode: Int
    var leftMotorSpeed: Double
}

