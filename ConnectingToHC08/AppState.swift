//
//  AppState.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 25/10/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var tabSelection: Int = 0
}
