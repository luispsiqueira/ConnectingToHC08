//
//  ConnectingToHC08App.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 19/09/24.
//

import SwiftUI

@main
struct ConnectingToHC08App: App {
    let persistenceController = PersistenceController.shared
    @State var isConnected: Bool = false
    @StateObject var appState = AppState()
    @ObservedObject var bluetoothController = BluetoothController()

    var body: some Scene {
        WindowGroup {
//            if !isConnected {
//                BluetoothConnectingView(bluetoothController: bluetoothController)
//                    .environmentObject(appState)
//                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            } else {
//                TabBarView(bluetoothController: bluetoothController)
//                    .accentColor(.orange)
//                    .environmentObject(appState)
//            }
            
            TabBarView(bluetoothController: bluetoothController)
                .accentColor(.orange)
                .environmentObject(appState)
        }
        .onChange(of: bluetoothController.isConnected) { x in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isConnected = x
            }
        }
    }
}
