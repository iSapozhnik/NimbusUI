//
//  PrimaryDefaultButtonStyle 2.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct PrimaryProminentButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var animationFast
    @Environment(\.nimbusButtonCornerRadii) private var cornerRadii
    @Environment(\.nimbusMinHeight) private var minHeight

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
        configuration
            .label
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: .infinity)
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: configuration.isPressed,
                    fill: .secondary,
                    hovering: .primary.opacity(0.7),
                    pressed: .primary
                )
            )
            .foregroundStyle(Color.accentColor)
            .clipShape(.rect(cornerRadii: cornerRadii))
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
            Button("Prominent") {}
                .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
            .padding()
    }
}
