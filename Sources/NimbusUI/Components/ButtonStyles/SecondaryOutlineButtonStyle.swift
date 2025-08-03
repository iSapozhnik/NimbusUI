//
//  SecondaryOutlineButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct SecondaryOutlineButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var animationFast
    @Environment(\.nimbusHorizontalPadding) private var overrideHorizontalPadding
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
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
        // Auto-apply NimbusDividerLabelStyle to Labels when environment values are set
        let content = configuration.label
            .modifier(AutoLabelDetectionModifier(
                hasDivider: overrideHasDivider,
                iconAlignment: overrideIconAlignment, 
                contentPadding: overrideContentPadding ?? overrideLabelContentPadding,
                theme: theme
            ))
        
        let minHeight = ControlSizeUtility.height(for: controlSize, theme: theme, override: overrideMinHeight)
        let horizontalPadding = ControlSizeUtility.horizontalPadding(for: controlSize, theme: theme, override: overrideHorizontalPadding)
        let fontSize = ControlSizeUtility.fontSize(for: controlSize, theme: theme)
        
        content
            .font(.system(size: fontSize, weight: .medium))
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: .infinity)
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
