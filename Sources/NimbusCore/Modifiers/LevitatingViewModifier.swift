//
//  LevitatingViewModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

/// Internal API - not intended for direct consumer use
public struct LevitatingViewModifier: ViewModifier {
    @State private var offset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var shadowRadius: CGFloat = 10.0
    @State private var tiltX: Double = 0
    @State private var tiltY: Double = 0
    
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .offset(offset)
//            .rotation3DEffect(.degrees(tiltX), axis: (x: 1, y: 0, z: 0))
//            .rotation3DEffect(.degrees(tiltY), axis: (x: 0, y: 1, z: 0))
            .shadow(color: .black.opacity(0.2), radius: shadowRadius, x: 0, y: 0)
            .onAppear {
                animateLevitating()
            }
    }
    
    private func animateLevitating() {
        let baseDuration: Double = 1.5
        let x = CGFloat.random(in: -12...12)
        let y = CGFloat.random(in: -12...12)
        let s = CGFloat.random(in: 0.95...1.05)
        let shadow = CGFloat.random(in: 8...16)
        let tiltX = Double.random(in: -4...4)
        let tiltY = Double.random(in: -4...4)
        
        withAnimation(.easeInOut(duration: baseDuration)) {
            offset = CGSize(width: x, height: y)
            scale = s
            shadowRadius = shadow
            self.tiltX = tiltX
            self.tiltY = tiltY
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + baseDuration) {
            animateLevitating()
        }
    }
}
