//
//  ChangeVelocityTarget.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 21/11/24.
//

import SwiftUI

struct ChangeVelocityTarget: View {
    @Binding var velocityTarget: Double
    @State var velocity = 120.0
    var body: some View {
        HStack(spacing: 0) {
            CustomView($velocity)
        }
        .onChange(of: velocity) { _ in
            velocityTarget = velocity / 120
        }
    }
    
    @ViewBuilder
    private func CustomView(_ velocityTarget: Binding<Double>) -> some View {
        PickerViewWithoutIndicator(selection: $velocity) {
            ForEach(0...120, id: \.self){ value in
                Text("\(value)")
                    .tag(value)
            }
        }
        .overlay {
            Text("Velocidade alvo: ")
                .font(.callout)
                .lineLimit(1)
                .offset(x: -100)
        }
    }
}

#Preview {
    ControllView(bluetoothController: BluetoothController())
}


struct PickerViewWithoutIndicator<Content: View, Selection: Hashable>: View {
    @Binding var selection: Selection
    @ViewBuilder var content: Content
    @State private var isHidden: Bool = false
    var body: some View {
        Picker("", selection: $selection) {
            if !isHidden {
                RemovePickerIndicator {
                    isHidden = true
                }
//            } else {
                content
            }
        }
        .pickerStyle(.wheel)
    }
}



fileprivate
struct RemovePickerIndicator: UIViewRepresentable {
    var result: () -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let pickerView = view.pickerView {
                if pickerView.subviews.count >= 2 {
                    pickerView.subviews[1].backgroundColor = .clear
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
}


fileprivate
extension UIView {
    var pickerView: UIPickerView? {
        if let view = superview as? UIPickerView {
            return view
        }
        
        return superview?.pickerView
    }
}
