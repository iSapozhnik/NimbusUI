//
//  SecondaryBorderedButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct SecondaryBorderedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var animationFast
    @Environment(\.nimbusHorizontalPadding) private var horizontalPadding

    @State private var isHovering: Bool

    public init() {
        self.isHovering = false
    }

    #if DEBUG
        init(
            isHovering: Bool = false
        ) {
            self.isHovering = isHovering
        }
    #endif

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, horizontalPadding)
            .modifier(NimbusAspectRatioModifier())
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: configuration.isPressed,
                    fill: .quinary,
                    hovering: .quaternary.opacity(0.7),
                    pressed: .quaternary
                )
            )
            .modifier(NimbusBorderedModifier(isHovering: isHovering))
            .onHover { isHovering in
                self.isHovering = isHovering
            }
            .animation(animationFast, value: isHovering)
    }
}

@available(macOS 15.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        HStack {
            Button("Normal") {}
                .buttonStyle(.secondaryBordered)
        }
        .frame(height: 40)
            .padding()
    }
}
