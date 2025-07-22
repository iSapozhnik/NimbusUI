//
//  PrimaryDefaultButtonStyle 2.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct PrimaryProminentButtonStyle: ButtonStyle {
    struct Appearence {
        let fill: Color
        let hover: Color
        let press: Color
    }
    
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
                    fill: AnyShapeStyle(tint(configuration: configuration).fill),
                    hovering: AnyShapeStyle(tint(configuration: configuration).hover),
                    pressed: AnyShapeStyle(tint(configuration: configuration).press),
                )
            )
            .clipShape(.rect(cornerRadii: cornerRadii))
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
    
    private func tint(configuration: Configuration) -> Appearence {
        let defaultAppearance = Appearence(
            fill: .accentColor,
            hover: Color.accentColor.darker(by: 0.1),
            press: Color.accentColor.darker(by: 0.25)
        )
        if let role = configuration.role {
            switch role {
            case .cancel, .destructive:
                return Appearence(
                    fill: .red,
                    hover: Color.red.darker(by: 0.1),
                    press: Color.red.darker(by: 0.25)
                )
            default:
                return defaultAppearance
            }
        } else {
            return defaultAppearance
        }
    }
}

@available(macOS 15.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        HStack {
            Button("Prominent") {}
                .buttonStyle(.primaryProminent)
            Button("Prominent", role: .destructive) {}
                .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
            .padding()
    }
}
