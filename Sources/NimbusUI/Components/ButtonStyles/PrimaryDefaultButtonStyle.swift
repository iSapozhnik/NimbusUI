//
//  NimbusButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct PrimaryDefaultButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusElevation) private var overrideElevation

    
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
        let color = theme.primaryColor(for: colorScheme)
        let defaultAppearance = ButtonAppearance(
            fill: color,
            hover: color.darker(by: 0.1),
            press: color.darker(by: 0.25)
        )
        
        let cornerRadii = overrideCornerRadii ?? theme.buttonCornerRadii
        let minHeight = overrideMinHeight ?? theme.minHeight
        let elevation = overrideElevation ?? theme.elevation
        
        return configuration
            .label
            .bold()
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: .infinity)
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: configuration.isPressed,
                    fill: AnyShapeStyle(defaultAppearance.fill),
                    hovering: AnyShapeStyle(defaultAppearance.hover),
                    pressed: AnyShapeStyle(defaultAppearance.press)
                )
            )
            .clipShape(.rect(cornerRadii: cornerRadii))
            .modifier(NimbusShadowModifier(elevation: elevation))
            .modifier(NimbusInnerShadowModifier())
            .modifier(NimbusGradientBorderModifier(width: 1, direction: .vertical))
            .overlay {
                UnevenRoundedRectangle(cornerRadii: cornerRadii)
                    .strokeBorder(AnyShapeStyle(defaultAppearance.hover), lineWidth: 1)
            }
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
}

@available(macOS 15.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    VStack {
        HStack {
            Button("Normal") {}
                .buttonStyle(.primaryDefault)
        }
        .frame(height: 40)
            .padding()
    }
}
