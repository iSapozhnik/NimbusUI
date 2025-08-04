//
//  PrimaryOutlineButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI
import NimbusCore

public struct PrimaryOutlineButtonStyle: ButtonStyle {
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
    
    // Default initializer
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
            fill: .clear,
            hover: color.opacity(0.1),
            press: color.opacity(0.2)
        )
        
        // Use environment values with theme fallbacks
        let finalCornerRadii = envCornerRadii ?? theme.buttonCornerRadii
        let finalHorizontalPadding = ControlSizeUtility.horizontalPadding(for: controlSize, theme: theme, override: envHorizontalPadding)
        let fontSize = ControlSizeUtility.fontSize(for: controlSize, theme: theme)
        
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
        
        return content
            .font(.system(size: fontSize, weight: .medium))
            .foregroundStyle(tint(configuration: configuration))
            .padding(.horizontal, finalHorizontalPadding)
            .modifier(NimbusAspectRatioModifier())
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
            .overlay {
                UnevenRoundedRectangle(cornerRadii: finalCornerRadii)
                    .strokeBorder(tint(configuration: configuration), lineWidth: 1)
            }
            .clipShape(.rect(cornerRadii: finalCornerRadii))
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
    
    private func tint(configuration: Configuration) -> Color {
        let color = theme.primaryColor(for: colorScheme)
        let destructiveColor = theme.errorColor(for: colorScheme)
        
        if let role = configuration.role {
            switch role {
            case .cancel, .destructive:
                return destructiveColor
            default:
                return color
            }
        } else {
            return color
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
