//
//  SecondaryOutlineButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI
import NimbusCore

public struct SecondaryOutlineButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var envAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var envCornerRadii
    @Environment(\.nimbusHorizontalPadding) private var envHorizontalPadding
    @Environment(\.nimbusMinHeight) private var envMinHeight
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
        // Use environment values with theme fallbacks
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
        
        content
            .font(.system(size: fontSize, weight: .medium))
            .padding(.horizontal, finalHorizontalPadding)
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
            .animation(envAnimationFast, value: isHovering)
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
