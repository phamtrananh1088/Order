//
//  CircleProgressView.swift
//  Order
//
//  Created by anh on 2024/11/16.
//

import SwiftUI
import Combine

struct CircleProgressView: View {
    @State private var isSpinning = false
    var body: some View {
        Circle()
            .trim(from: 1/4, to: 1)
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .frame(width: 32, height: 32)
            .rotationEffect(Angle(degrees: isSpinning ? 360: 0))
            .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: isSpinning)
            .onAppear {
            isSpinning = true
            }
    }
}

struct LightingProgressView: View {
    @State private var currentTime = Date()
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @State private var index = 1
    private var rect: CGRect = CGRect(x: 0, y: 0, width: 33, height: 33)
    private var width: CGFloat { return rect.width / 3}
    private var height: CGFloat { return 3}
    private let cos45 = cos(Angle(degrees: 45).radians)
    
    init() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
    var body: some View {
        ZStack() {
            
            Capsule()
                .foregroundColor(index == 1 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .offset(x: rect.width / 3, y: 0)
            Capsule()
                .foregroundColor(index == 2 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: rect.width / 3 * cos45, y: rect.height / 3 * cos45)
            Capsule()
                .foregroundColor(index == 3 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 2 * 45))
                .offset(x: 0, y: rect.height / 3)
            Capsule()
                .foregroundColor(index == 4 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 3 * 45))
                .offset(x: -rect.width / 3 * cos45, y: rect.height / 3 * cos45)
            Capsule()
                .foregroundColor(index == 5 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 4 * 45))
                .offset(x: -rect.width / 3, y: 0)
            Capsule()
                .foregroundColor(index == 6 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 5 * 45))
                .offset(x: -rect.width / 3 * cos45, y: -rect.height / 3 * cos45)
            Capsule()
                .foregroundColor(index == 7 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 6 * 45))
                .offset(x: 0, y: -rect.height / 3)
            Capsule()
                .foregroundColor(index == 0 ? Color.black.opacity(0.8): Color.gray.opacity(0.8))
                .frame(width: width, height: height)
                .rotationEffect(Angle(degrees: 7 * 45))
                .offset(x: rect.width / 3 * cos45, y: -rect.height / 3 * cos45)
        }
        .onReceive(timer, perform: { _ in
            withAnimation (.linear(duration: 0.1)) {
                index = index + 1
                index = index % 8
            }
        })
    }
}
