//
//  SecondaryBorderedButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public struct SecondaryBorderedButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var animationFast
    @Environment(\.nimbusHorizontalPadding) private var horizontalPadding
    
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
        
        content
            .padding(.horizontal, horizontalPadding)
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
            .animation(animationFast, value: isHovering)
    }
}

@available(macOS 15.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    
    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme
    
    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
    VStack(alignment: .leading, spacing: 16) {
        Text("Enhanced SecondaryBordered API - Flexible Usage")
            .font(.headline)
            .padding(.bottom)
        
        Text("Plain Text Buttons (no changes needed)")
            .font(.subheadline)
            .foregroundColor(.secondary)
        HStack {
            Button("Normal") {}
                .buttonStyle(.secondaryBordered)
            Button("Save") {}
                .buttonStyle(.secondaryBordered)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(.secondaryBordered)
        }
        .frame(height: 40)
        
        Text("Label Buttons - Enhanced API")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top)
        
        HStack {
            Button(action: {}) {
                Label("Delete", systemImage: "trash")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonHasDivider, true) // Enhanced API - auto-applies divider
            
            Button(action: {}) {
                Label("Export", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonContentPadding, contentPadding) // Enhanced API - auto-applies with custom padding
        }
        .frame(height: 40)
        
        HStack {
            Button(action: {}) {
                Label("Download", systemImage: "arrow.down.circle")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
            
            Button(action: {}) {
                Label("Settings", systemImage: "gear")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
            .environment(\.nimbusButtonContentPadding, contentPadding)
        }
        .frame(height: 40)
        
        HStack {
            Button(action: {}) {
                Label("Previous", systemImage: "arrow.left")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonHasDivider, true) // Enhanced API - with divider
            .environment(\.nimbusButtonIconAlignment, .leading) // Enhanced API - leading icon (default)
            
            Button(action: {}) {
                Label("Next", systemImage: "arrow.right")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonHasDivider, true) // Enhanced API - with divider
            .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon
        }
        .frame(height: 40)
        
        HStack {
            Button(action: {}) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon, no divider
            
            Button(action: {}) {
                Label("Custom Padding", systemImage: "textformat")
            }
            .buttonStyle(.secondaryBordered)
            .environment(\.nimbusButtonContentPadding, 16) // Enhanced API - custom padding
        }
        .frame(height: 40)
    }
//    .padding()
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
