//
//  ContentView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 19/09/24.
//

//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}

import SwiftUI

struct ContentView: View {
    @ObservedObject var bluetoothController = BluetoothController()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                //MARK: - Disconnect or Connect title
                VStack{
                    HStack{
                        Spacer()
                        if bluetoothController.isConnected{
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                                .font(.largeTitle)
                            
                            Text("Connected")
                                .font(.largeTitle)
                        }else{
                            Image(systemName: "x.circle")
                                .foregroundColor(.red)
                                .font(.largeTitle)
                            
                            Text("Disconnected")
                                .font(.largeTitle)
                        }
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        if !bluetoothController.isConnected{
                            Text("Tap on the device name to connect")
                                .font(.body)
                        }
                        Spacer()
                    }
                }
                
                //MARK: - Bluetooth status label
                HStack{
                    Text("Bluetooth status:")
                        .font(.headline)
                        .padding(.leading)
                    
                    Text("\(bluetoothController.bluetoothStatus.rawValue)")
                        .font(.body)
                    
                    Spacer()
                    
                }.padding(.top)
                
                //MARK: - List with bluetooth devices found
                    //This list is only shown if the bluetooth isn't connect
                if !bluetoothController.isConnected{
                    List(bluetoothController.discoveredPeripherals, id: \.self) { peripheral in
                        Button(action: {
                            bluetoothController.connect(peripheral: peripheral)
                        }) {
                            ZStack{
                                //Created rectangle so that if tapped on anywere of the element on the list, the action will happen
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: geometry.size.width)
                                
                                HStack{
                                    Text(peripheral.name ?? "Unknown name")
                                        .font(.body)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    //MARK: - Information of the connected device
                        //These informations are only shown if the device is connected
                }else{
                    VStack{
                        HStack{
                            Text("Connected on:")
                                .font(.headline)
                                .padding(.leading)
                                .padding(.vertical)
                            
                            Text("\(bluetoothController.connectedPeripheral?.name ?? "Unknown name")")
                                .font(.body)
                            
                            Spacer()
                        }
                        
                        HStack{
                            Text("Value received:")
                                .font(.headline)
                                .padding(.leading)
                            
                            Text("\(bluetoothController.valueReceived ?? "Nothing received yet")")
                                .font(.body)
                            
                            Spacer()
                        }
                        
                        HStack{
//                            TextField(text: <#T##Binding<String>#>, label: <#T##() -> View#>)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {
                            bluetoothController.disconnect()
                        }) {
                            Text("Disconnect")
                                .font(.body)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
