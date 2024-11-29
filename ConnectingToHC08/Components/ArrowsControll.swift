//
//  ArrowsControll.swift
//  ConnectingToHC08
//
//  Created by Luis Silva on 07/11/24.
//

import SwiftUI

struct ArrowsControll: View {
    @Binding var buttonsAreEnable: Bool
    @Binding var velocityRightMotor: Double
    @Binding var velocityLeftMotor: Double
    @Binding var velocitytarget: VelocityTarget
    @State var isMovingFoward: Bool = true
    @Binding var someButtonIsBeenPressed: Int
    @Binding var factor: Double
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: -20) {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isMovingFoward = true
                    }, label: {
                        Image(systemName: "arrowshape.up.circle")
                            .font(.system(size: geometry.size.width/4))
                    })
                    .disabled(!buttonsAreEnable)
                    .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
                        if isPressing {
                            velocityLeftMotor = Double(Int(velocitytarget.left * factor / 120))
                            velocityRightMotor = Double(Int(velocitytarget.right * factor / 120))
                            someButtonIsBeenPressed += 1
                        } else {
                            velocityLeftMotor = 0
                            velocityRightMotor =  0
                            someButtonIsBeenPressed -= 1
                        }
                    }) {}
                    
                    Spacer()
                }
                HStack {
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrowshape.left.circle")
                        .font(.system(size: geometry.size.width/4))
                    })
                    .disabled(!buttonsAreEnable)
                    .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
                        if isPressing {
                            if isMovingFoward {
                                velocityLeftMotor = 0
                                velocityRightMotor = Double(Int(velocitytarget.right * factor / 120))
                                someButtonIsBeenPressed += 1
                            } else {
                                velocityLeftMotor = 0
                                velocityRightMotor = Double(Int(-velocitytarget.right * factor / 120))
                                someButtonIsBeenPressed += 1
                            }
                        } else {
                            velocityLeftMotor = 0
                            velocityRightMotor =  0
                            someButtonIsBeenPressed -= 1
                        }
                    }) {}
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrowshape.right.circle")
                        .font(.system(size: geometry.size.width/4))
                    })
                    .disabled(!buttonsAreEnable)
                    .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
                        if isPressing {
                            if isMovingFoward {
                                velocityLeftMotor = Double(Int(velocitytarget.left * factor / 120))
                                velocityRightMotor = 0
                                someButtonIsBeenPressed += 1
                            } else {
                                velocityLeftMotor = Double(Int(-velocitytarget.left * factor / 120))
                                velocityRightMotor = 0
                                someButtonIsBeenPressed += 1
                            }
                        } else {
                            velocityLeftMotor = 0
                            velocityRightMotor =  0
                            someButtonIsBeenPressed -= 1
                        }
                    }) {}
                    
                    Spacer()
                }
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isMovingFoward = false
                    }, label: {
                        Image(systemName: "arrowshape.down.circle")
                            .font(.system(size: geometry.size.width/4))
                    })
                    .disabled(!buttonsAreEnable)
                    .onLongPressGesture(minimumDuration: .infinity, pressing: { isPressing in
                        if isPressing {
                            velocityLeftMotor = Double(Int(-velocitytarget.left * factor / 120))
                            velocityRightMotor = Double(Int(-velocitytarget.right * factor / 120))
                            someButtonIsBeenPressed += 1
                        } else {
                            velocityLeftMotor = 0
                            velocityRightMotor =  0
                            someButtonIsBeenPressed -= 1
                        }
                    }) {}
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
