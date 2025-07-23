//
//  NimbusInnerShadowModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 22.07.25.
//

import SwiftUI

public struct NimbusInnerShadowModifier: ViewModifier {
    private let intensity: Double
    private let radius: CGFloat
    private let offsetY: CGFloat

    /// - Parameters:
    ///   - intensity: Opacity of the glare (0...1). Default is 0.25.
    ///   - radius: Blur radius for the glare. Default is 8.
    ///   - offsetY: Vertical offset for the glare. Default is 0.
    public init(intensity: Double = 0.25, radius: CGFloat = 8, offsetY: CGFloat = 0) {
        self.intensity = intensity
        self.radius = radius
        self.offsetY = offsetY
    }

    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.white.opacity(intensity), location: 0),
                            .init(color: Color.white.opacity(0), location: 0.7)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: geometry.size.height)
                    .blur(radius: radius)
                    .offset(y: offsetY)
                    .allowsHitTesting(false)
                }
            )
    }
}

// Usage: .modifier(NimbusInnerShadowModifier())

