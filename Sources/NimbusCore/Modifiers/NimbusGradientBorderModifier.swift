//
//  NimbusGradientBorderModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 22.07.25.
//

import SwiftUI

public struct NimbusGradientBorderModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusButtonCornerRadii) private var overrideCornerRadii
    
    public enum Direction {
        case vertical, horizontal
    }

    private let width: CGFloat
    private let direction: Direction

    public init(width: CGFloat = 1, direction: Direction = .vertical) {
        self.width = width
        self.direction = direction
    }

    public func body(content: Content) -> some View {
        let cornerRadii = overrideCornerRadii ?? theme.buttonCornerRadii
//        content
//            .clipShape(.rect(cornerRadii: cornerRadii))
//            .background {
//                let gradient = LinearGradient(
//                    gradient: Gradient(stops: [
//                        .init(color: Color.white, location: 0),
//                        .init(color: Color.white.opacity(0), location: 1)
//                    ]),
//                    startPoint: direction == .vertical ? .top : .leading,
//                    endPoint: direction == .vertical ? .bottom : .trailing
//                )
//                UnevenRoundedRectangle(cornerRadii: cornerRadii)
//                    .strokeBorder(gradient, lineWidth: width)
//            }
//        
        content
            .overlay(
                GeometryReader { geometry in
                    let gradient = LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.white.opacity(0.25), location: 0),
                            .init(color: Color.white.opacity(0), location: 1)
                        ]),
                        startPoint: direction == .vertical ? .top : .leading,
                        endPoint: direction == .vertical ? .bottom : .trailing
                    )
                    UnevenRoundedRectangle(cornerRadii: cornerRadii)
                        .strokeBorder(gradient, lineWidth: width)
                        
                }
            )
            
    }
}

// Usage: .modifier(NimbusGradientBorderModifier(width: 2, direction: .horizontal)) 
