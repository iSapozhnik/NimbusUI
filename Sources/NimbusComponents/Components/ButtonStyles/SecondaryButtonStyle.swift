//
//  SecondaryButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI
import NimbusCore

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var envAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var envCornerRadii
    @Environment(\.nimbusMinHeight) private var envMinHeight
    @Environment(\.nimbusHorizontalPadding) private var envHorizontalPadding
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusElevation) private var envElevation
    @Environment(\.controlSize) private var controlSize
    
    // Button Label Configuration
    @Environment(\.nimbusButtonHasDivider) private var envHasDivider
    @Environment(\.nimbusButtonIconAlignment) private var envIconAlignment
    @Environment(\.nimbusButtonContentPadding) private var envContentPadding
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) private var envLabelContentPadding


    @State private var isHovering: Bool
    
    #if DEBUG
    @State private var debugIsPressed: Bool
    private let isDebugMode: Bool
    #endif
    
    // Default initializer
    public init() {
        self.isHovering = false
        #if DEBUG
        self.debugIsPressed = false
        self.isDebugMode = false
        #endif
    }

    #if DEBUG
        init(
            isHovering: Bool = false,
            isPressed: Bool = false
        ) {
            self.isHovering = isHovering
            self.debugIsPressed = isPressed
            self.isDebugMode = true
        }
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
        // Use environment values with theme fallbacks
        let finalCornerRadii = envCornerRadii ?? theme.buttonCornerRadii
        let finalHorizontalPadding = ControlSizeUtility.horizontalPadding(for: controlSize, theme: theme, override: envHorizontalPadding)
        let fontSize = ControlSizeUtility.fontSize(for: controlSize, theme: theme)
        let finalElevation = envElevation ?? theme.elevation
        
        // Auto-apply NimbusDividerLabelStyle to Labels when environment values are set
        let finalHasDivider = envHasDivider
        let finalIconAlignment = envIconAlignment
        let finalContentPadding = envContentPadding ?? envLabelContentPadding
        
        let content = configuration.label
            .modifier(AutoLabelDetectionModifier(
                hasDivider: finalHasDivider,
                iconAlignment: finalIconAlignment, 
                contentPadding: finalContentPadding,
                theme: theme
            ))
        
        #if DEBUG
        let effectiveIsPressed = isDebugMode ? debugIsPressed : configuration.isPressed
        #else
        let effectiveIsPressed = configuration.isPressed
        #endif
        
        return content
            .font(.system(size: fontSize, weight: .medium))
            .foregroundStyle(theme.primaryTextColor(for: colorScheme))
            .padding(.horizontal, finalHorizontalPadding)
            .modifier(NimbusAspectRatioModifier())
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: effectiveIsPressed,
                    fill: AnyShapeStyle(tint(configuration: configuration).fill),
                    hovering: AnyShapeStyle(tint(configuration: configuration).hover),
                    pressed: AnyShapeStyle(tint(configuration: configuration).press)
                )
            )
            .clipShape(.rect(cornerRadii: finalCornerRadii))
            .modifier(NimbusInnerShadowModifier())
            .clipShape(.rect(cornerRadii: finalCornerRadii))
            .modifier(NimbusShadowModifier(elevation: finalElevation))
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
