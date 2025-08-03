//
//  PrimaryButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {
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
    
    #if DEBUG
    @State private var debugIsPressed: Bool
    private let isDebugMode: Bool
    #endif
    
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
        let color = theme.primaryColor(for: colorScheme)
        let defaultAppearance = ButtonAppearance(
            fill: color,
            hover: color.darker(by: 0.1),
            press: color.darker(by: 0.25)
        )
        
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
        
        #if DEBUG
        let effectiveIsPressed = isDebugMode ? debugIsPressed : configuration.isPressed
        #else
        let effectiveIsPressed = configuration.isPressed
        #endif
        
        return content
            .bold()
            .font(.system(size: fontSize, weight: .semibold))
            .padding(.horizontal, horizontalPadding)
            .modifier(NimbusAspectRatioModifier())
            .opacity(isEnabled ? 1 : 0.5)
            .modifier(
                NimbusFilledModifier(
                    isHovering: isHovering,
                    isPressed: effectiveIsPressed,
                    fill: AnyShapeStyle(defaultAppearance.fill),
                    hovering: AnyShapeStyle(defaultAppearance.hover),
                    pressed: AnyShapeStyle(defaultAppearance.press)
                )
            )
            .clipShape(.rect(cornerRadii: cornerRadii))
            .modifier(NimbusInnerShadowModifier())
            .modifier(NimbusGradientBorderModifier(width: 1, direction: .vertical))
            .overlay {
                UnevenRoundedRectangle(cornerRadii: cornerRadii)
                    .strokeBorder(AnyShapeStyle(defaultAppearance.hover), lineWidth: 1)
            }
            .clipShape(.rect(cornerRadii: cornerRadii))
            .modifier(NimbusShadowModifier(elevation: elevation))
            .onHover { isHovering in
                self.isHovering = isHovering
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
