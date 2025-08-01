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
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.nimbusButtonCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
    @Environment(\.nimbusElevation) private var overrideElevation
    @Environment(\.nimbusHorizontalPadding) private var overrideHorizontalPadding
    @Environment(\.colorScheme) private var colorScheme
    
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
        let minHeight = overrideMinHeight ?? theme.minHeight
        let elevation = overrideElevation ?? theme.elevation
        let horizontalPadding = overrideHorizontalPadding ?? theme.horizontalPadding
        
        // Auto-apply NimbusDividerLabelStyle to Labels when environment values are set
        let content = configuration.label
            .modifier(AutoLabelDetectionModifier(
                hasDivider: overrideHasDivider,
                iconAlignment: overrideIconAlignment, 
                contentPadding: overrideContentPadding ?? overrideLabelContentPadding,
                theme: theme
            ))
        
        content
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
        let color = theme.accentColor(for: colorScheme)
        let destructiveColor = theme.errorColor(for: colorScheme)
        
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
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview {
    
    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme
    
    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
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
    .environment(\.nimbusTheme, NimbusTheme())
    .padding()
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
