//
//  TabBarView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 07/11/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var bluetoothController: BluetoothController
    
    init(bluetoothController: BluetoothController) {
        self.bluetoothController = bluetoothController
    }
    
    var body: some View {
        TabView(selection: $appState.tabSelection) {
            DataView(bluetoothController: bluetoothController)
                .tabItem {
                    VStack {
                        Image(systemName: "list.clipboard.fill")
                        Text("Dados")
                            .font(.headline)
                    }
                }
                .tag(0)
                .environmentObject(appState)
            
            ControllView(bluetoothController: bluetoothController)
                .tabItem {
                    VStack {
                        Image(systemName: "gamecontroller.fill")
                        Text("Controle")
                            .font(.headline)
                    }
                }
                .tag(1)
                .environmentObject(appState)
          
        }
    }
}

//#Preview {
//    TabBarView(blueToothController: <#BluetoothController#>)
//        .environmentObject(AppState())
//}
