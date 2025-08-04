//
//  Button+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 04.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Button Convenience Modifiers

public extension Button {
    /// Sets the button corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusButtonCornerRadii, radii)
    }
    
    /// Sets the button minimum height
    func minHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusMinHeight, height)
    }
    
    /// Sets the button horizontal padding
    func horizontalPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusHorizontalPadding, padding)
    }
    
    /// Sets the button elevation (shadow depth)
    func elevation(_ elevation: Elevation) -> some View {
        environment(\.nimbusElevation, elevation)
    }
    
    /// Controls whether the button label should have a divider between icon and text
    func hasDivider(_ hasDivider: Bool) -> some View {
        environment(\.nimbusButtonHasDivider, hasDivider)
    }
    
    /// Sets the icon alignment for button labels (leading or trailing)
    func iconAlignment(_ alignment: HorizontalAlignment) -> some View {
        environment(\.nimbusButtonIconAlignment, alignment)
    }
    
    /// Sets the content padding for button labels (spacing between icon and text)
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusButtonContentPadding, padding)
    }
    
    /// Sets the aspect ratio for the button
    func aspectRatio(_ ratio: CGFloat, contentMode: ContentMode = .fit) -> some View {
        environment(\.nimbusAspectRatio, ratio)
            .environment(\.nimbusAspectRatioContentMode, contentMode)
    }
    
    /// Sets whether the button should have a fixed height when using aspect ratio
    func fixedHeight(_ fixed: Bool = true) -> some View {
        environment(\.nimbusAspectRatioHasFixedHeight, fixed)
    }
}

// MARK: - Convenience Combinations

public extension Button {
    /// Configures a button with common label settings for icon + text buttons
    func labelConfiguration(
        hasDivider: Bool = true,
        iconAlignment: HorizontalAlignment = .leading,
        contentPadding: CGFloat? = nil
    ) -> some View {
        self
            .environment(\.nimbusButtonHasDivider, hasDivider)
            .environment(\.nimbusButtonIconAlignment, iconAlignment)
            .environment(\.nimbusButtonContentPadding, contentPadding ?? 8)
    }
    
    /// Configures a button for icon-only usage (square aspect ratio)
    @ViewBuilder
    func iconOnly(size: CGFloat? = nil) -> some View {
        if let size = size {
            self
                .environment(\.nimbusAspectRatio, 1.0)
                .environment(\.nimbusAspectRatioContentMode, .fit)
                .environment(\.nimbusMinHeight, size)
        } else {
            self
                .environment(\.nimbusAspectRatio, 1.0)
                .environment(\.nimbusAspectRatioContentMode, .fit)
        }
    }
    
    /// Configures a button for wide banner usage (custom aspect ratio)
    func banner(aspectRatio ratio: CGFloat = 3.0) -> some View {
        self
            .environment(\.nimbusAspectRatio, ratio)
            .environment(\.nimbusAspectRatioContentMode, .fit)
            .environment(\.nimbusAspectRatioHasFixedHeight, true)
    }
}