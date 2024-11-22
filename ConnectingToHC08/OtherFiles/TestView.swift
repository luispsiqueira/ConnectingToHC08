//
//  TestView.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 20/11/24.
//

import SwiftUI

struct PagingView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            Text("Tela 1")
            Text("opa")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                .tag(0)

            Text("Tela 2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
                .tag(1)

            Text("Tela 3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .tag(2)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always)) // Para personalizar as bolinhas
    }
}

struct PagingView_Previews: PreviewProvider {
    static var previews: some View {
        PagingView()
    }
}
