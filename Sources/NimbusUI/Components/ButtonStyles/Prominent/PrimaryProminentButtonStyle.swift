//
//  PrimaryDefaultButtonStyle 2.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct PrimaryProminentButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
    @Environment(\.nimbusElevation) private var overrideElevation
    @Environment(\.nimbusHorizontalPadding) private var overrideHorizontalPadding
    @Environment(\.colorScheme) private var colorScheme

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
        let cornerRadii = overrideCornerRadii ?? theme.buttonCornerRadii
        let minHeight = overrideMinHeight ?? theme.minHeight
        let elevation = overrideElevation ?? theme.elevation
        let horizontalPadding = overrideHorizontalPadding ?? theme.horizontalPadding
        
        configuration
            .label
            .bold()
            .foregroundStyle(.white)
            .padding(.horizontal, horizontalPadding)
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
            .modifier(NimbusShadowModifier(elevation: elevation))
            .modifier(NimbusInnerShadowModifier())
            .modifier(NimbusGradientBorderModifier(width: 1, direction: .vertical))
            .overlay {
                UnevenRoundedRectangle(cornerRadii: cornerRadii)
                    .strokeBorder(AnyShapeStyle(tint(configuration: configuration).hover), lineWidth: 1)
            }
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
    
    private func tint(configuration: Configuration) -> ButtonAppearance {
        let color = theme.accentColor(for: colorScheme)
        let destructiveColor = theme.errorColor(for: colorScheme)
        
        let defaultAppearance = ButtonAppearance(
            fill: color,
            hover: color.darker(by: 0.1),
            press: color.darker(by: 0.25)
        )
        let destructiveAppearance = ButtonAppearance(
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

    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme

    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
    VStack {
        HStack {
            Button("Ok") {}
                .buttonStyle(.primaryProminent)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button("Delete", systemImage: "trash", role: .destructive) {}
                .buttonStyle(.primaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            contentHorizontalPadding: contentPadding
                        )
                    )
            }
            .buttonStyle(.primaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            contentHorizontalPadding: contentPadding
                        )
                    )

            }
            .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            hasDivider: false,
                            contentHorizontalPadding: contentPadding
                        )
                    )
            }
            .buttonStyle(.primaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            hasDivider: false,
                            contentHorizontalPadding: contentPadding
                        )
                    )

            }
            .buttonStyle(.primaryProminent)
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
            .buttonStyle(.primaryProminent)
            Button(role: .none, action: {}) {
                Label("Next", systemImage: "arrow.right")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            hasDivider: false,
                            iconAlignment: .trailing,
                            contentHorizontalPadding: contentPadding
                        )
                    )

            }
            .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
    }
    .padding()
}
