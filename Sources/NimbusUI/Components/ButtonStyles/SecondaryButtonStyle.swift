//
//  SecondaryButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
    @Environment(\.nimbusHorizontalPadding) private var overrideHorizontalPadding
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusElevation) private var overrideElevation
    @Environment(\.controlSize) private var controlSize
    
    // Button Label Configuration
    @Environment(\.nimbusButtonHasDivider) private var overrideHasDivider
    @Environment(\.nimbusButtonIconAlignment) private var overrideIconAlignment
    @Environment(\.nimbusButtonContentPadding) private var overrideContentPadding
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) private var overrideLabelContentPadding

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
        let horizontalPadding = ControlSizeUtility.horizontalPadding(for: controlSize, theme: theme, override: overrideHorizontalPadding)
        let fontSize = ControlSizeUtility.fontSize(for: controlSize, theme: theme)
        let elevation = overrideElevation ?? theme.elevation
        
        // Auto-apply NimbusDividerLabelStyle to Labels when environment values are set
        let content = configuration.label
            .modifier(AutoLabelDetectionModifier(
                hasDivider: overrideHasDivider,
                iconAlignment: overrideIconAlignment, 
                contentPadding: overrideContentPadding ?? overrideLabelContentPadding,
                theme: theme
            ))
        
        return content
            .font(.system(size: fontSize, weight: .medium))
            .foregroundStyle(theme.primaryTextColor(for: colorScheme))
            .padding(.horizontal, horizontalPadding)
            .modifier(NimbusAspectRatioModifier())
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: configuration.isPressed,
                    fill: AnyShapeStyle(tint(configuration: configuration).fill),
                    hovering: AnyShapeStyle(tint(configuration: configuration).hover),
                    pressed: AnyShapeStyle(tint(configuration: configuration).press)
                )
            )
            .clipShape(.rect(cornerRadii: cornerRadii))
            .modifier(NimbusShadowModifier(elevation: elevation))
            .modifier(NimbusInnerShadowModifier())
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
    
    private func tint(configuration: Configuration) -> ButtonAppearance {
        let baseColor = theme.secondaryBackgroundColor(for: colorScheme)
        let destructiveColor = theme.errorColor(for: colorScheme)
        
        let defaultAppearance = ButtonAppearance(
            fill: baseColor,
            hover: baseColor.darker(by: 0.05),
            press: baseColor.darker(by: 0.1)
        )
        let destructiveAppearance = ButtonAppearance(
            fill: destructiveColor.opacity(0.1),
            hover: destructiveColor.opacity(0.15),
            press: destructiveColor.opacity(0.2)
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


// MARK: - Auto Label Detection Modifier

private struct AutoLabelDetectionModifier: ViewModifier {
    let hasDivider: Bool?
    let iconAlignment: HorizontalAlignment?
    let contentPadding: CGFloat?
    let theme: NimbusTheming
    
    func body(content: Content) -> some View {
        // Apply NimbusDividerLabelStyle when any of the button label settings are configured
        if hasDivider != nil || iconAlignment != nil || contentPadding != nil {
            content
                .labelStyle(
                    NimbusDividerLabelStyle(
                        hasDivider: hasDivider ?? true,
                        iconAlignment: iconAlignment ?? .leading,
                        contentHorizontalPadding: contentPadding ?? theme.labelContentSpacing
                    )
                )
        } else {
            // No special label configuration, return content as-is
            content
        }
    }
}
