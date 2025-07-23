//
//  SecondaryProminentButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

public struct SecondaryProminentButtonStyle: ButtonStyle {
    struct Appearance {
        let fill: Color
        let hover: Color
        let press: Color
    }
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var animationFast
    @Environment(\.nimbusButtonCornerRadii) private var cornerRadii
    @Environment(\.nimbusMinHeight) private var minHeight
    @Environment(\.nimbusElevation) private var elevation
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
        configuration
            .label
            .foregroundStyle(.white)
            .padding(.horizontal, horizontalPadding)
            .modifier(NimbusAspectRatioModifier())
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
            .modifier(NimbusShadowModifier(elevation: elevation))
            .modifier(NimbusInnerShadowModifier())
            .modifier(
                NimbusGradientBorderModifier(
                    width: 1,
                    direction: .vertical
                )
            )
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
    
    private func tint(configuration: Configuration) -> Appearance {
        let color = theme.accentColor
        let destructiveColor = theme.errorColor
        
        let defaultAppearance = Appearance(
            fill: color,
            hover: color.darker(by: 0.1),
            press: color.darker(by: 0.25)
        )
        let destructiveAppearance = Appearance(
            fill: destructiveColor,
            hover: destructiveColor.darker(by: 0.1),
            press: destructiveColor.darker(by: 0.25)
        )
        if let role = configuration.role {
            switch role {
            case .cancel, .destructive:
                return destructiveAppearance
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
    
    @Previewable @Environment(\.nimbusLabelContentHorizontalSmallPadding) var contentPadding
    
    VStack(alignment: .leading) {
        HStack {
            Button("Ok") {}
                .buttonStyle(.secondaryProminent)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button("Delete", systemImage: "trash", role: .destructive) {}
                .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(NimbusDividerLabelStyle(contentHorizontalPadding: contentPadding))
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(NimbusDividerLabelStyle(contentHorizontalPadding: contentPadding))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false))
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            hasDivider: true,
                            iconAlignment: .trailing,
                            contentHorizontalPadding: contentPadding
                        )
                    )
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Next", systemImage: "arrow.right")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false, iconAlignment: .trailing))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
    }
    .padding()
}
