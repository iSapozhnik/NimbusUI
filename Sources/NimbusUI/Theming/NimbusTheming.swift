//
//  NimbusTheming.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

// https://freiwald.dev/posts/custom-environment-colors/
// https://alexanderweiss.dev/blog/2025-01-19-effortless-swiftui-theming

/// A comprehensive theming protocol that defines core design tokens and color systems
/// for the NimbusUI design system. Component-specific tokens are provided through
/// protocol extensions with sensible defaults that can be optionally overridden.
public protocol NimbusTheming: Sendable {
    
    // MARK: - Brand Colors (Required)
    
    /// Primary brand color that adapts to light/dark color schemes
    func primaryColor(for scheme: ColorScheme) -> Color
    
    /// Secondary brand color that adapts to light/dark color schemes  
    func secondaryColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary brand color that adapts to light/dark color schemes
    func tertiaryColor(for scheme: ColorScheme) -> Color
    
    /// Accent color for highlights and interactive elements
    func accentColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Semantic Colors (Required)
    
    /// Error/danger color for destructive actions and error states
    func errorColor(for scheme: ColorScheme) -> Color
    
    /// Success color for positive feedback and completed states
    func successColor(for scheme: ColorScheme) -> Color
    
    /// Warning color for caution states and important notices
    func warningColor(for scheme: ColorScheme) -> Color
    
    /// Info color for informational messages and neutral feedback
    func infoColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Background Colors (Required)
    
    /// Primary background color for main content areas
    func backgroundColor(for scheme: ColorScheme) -> Color
    
    /// Secondary background color for cards, panels, and elevated surfaces
    func secondaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary background color for subtle backgrounds and disabled states
    func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Text Colors (Required)
    
    /// Primary text color for headings and main content
    func primaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Secondary text color for supporting text and descriptions
    func secondaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary text color for placeholders and disabled text
    func tertiaryTextColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Border Colors (Required)
    
    /// Primary border color for inputs, buttons, and separators
    func borderColor(for scheme: ColorScheme) -> Color
    
    /// Secondary border color for subtle divisions and nested elements
    func secondaryBorderColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Core Design Tokens (Required)
    
    /// Background material for blur effects and translucent surfaces
    var backgroundMaterial: Material? { get }
    
    /// Corner radii configuration for consistent rounded corners
    var cornerRadii: RectangleCornerRadii { get }
    
    /// Animation configuration for standard transitions
    var animation: Animation { get }
    
    /// Fast animation configuration for quick interactions
    var animationFast: Animation { get }
    
    /// Minimum height for interactive elements
    var minHeight: CGFloat { get }
    
    /// Standard horizontal padding for components
    var horizontalPadding: CGFloat { get }
    
    /// Default elevation level for components
    var elevation: Elevation { get }
}

// MARK: - Button Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Button corner radii configuration
    var buttonCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// Compact button corner radii configuration
    var compactButtonCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// Label content spacing configuration
    var labelContentSpacing: CGFloat { 6 }
}

// MARK: - List Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// List item corner radii configuration
    var listItemCornerRadii: RectangleCornerRadii { RectangleCornerRadii(2) }
    
    /// List item height configuration
    var listItemHeight: CGFloat { 44 }
}

// MARK: - Checkbox Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Checkbox size configuration (16x16 default)
    var checkboxSize: CGFloat { 16 }
    
    /// Checkbox corner radii configuration
    var checkboxCornerRadii: RectangleCornerRadii { RectangleCornerRadii(4) }
    
    /// Checkbox border width configuration
    var checkboxBorderWidth: CGFloat { 1 }
    
    /// Checkbox item spacing configuration (spacing between checkbox and text)
    var checkboxItemSpacing: CGFloat { 12 }
    
    /// Checkbox item text spacing configuration (spacing between title and subtitle)
    var checkboxItemTextSpacing: CGFloat { 4 }
    
    /// Checkbox item padding configuration
    var checkboxItemPadding: CGFloat { 16 }
    
    /// Checkbox item minimum height configuration
    var checkboxItemMinHeight: CGFloat { 44 }
}

// MARK: - Scroller Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Scroller track width (thickness of the entire scroller)
    var scrollerWidth: CGFloat { 16 }
    
    /// Scroller knob width (thickness of the draggable knob)
    var scrollerKnobWidth: CGFloat { 6 }
    
    /// Scroller knob padding (space between knob and slot edges)
    var scrollerKnobPadding: CGFloat { 2 }
    
    /// Scroller slot corner radius
    var scrollerSlotCornerRadius: CGFloat { 4 }
    
    /// Scroller slot visibility
    var scrollerShowSlot: Bool { true }
    
    // MARK: - Computed Scroller Properties
    
    /// Scroller knob corner radius (auto-calculated from knob width and padding)
    var scrollerKnobCornerRadius: CGFloat {
        (scrollerKnobWidth - scrollerKnobPadding) / 2
    }
    
    // MARK: - Legacy Scroller Properties (Backward Compatibility)
    
    /// Scroller knob vertical inset
    var scrollerKnobInsetVertical: CGFloat { 6 }
    
    /// Scroller knob horizontal inset
    var scrollerKnobInsetHorizontal: CGFloat { 3 }
    
    /// Scroller slot inset
    var scrollerSlotInset: CGFloat { 3 }
    
    /// Scroller initial opacity
    var scrollerInitialOpacity: CGFloat { 0.3 }
    
    /// Scroller fade opacity
    var scrollerFadeOpacity: CGFloat { 0.3 }
    
    /// Scroller fade delay
    var scrollerFadeDelay: TimeInterval { 1.0 }
    
    /// Scroller animation duration
    var scrollerAnimationDuration: TimeInterval { 0.1 }
}

// MARK: - Convenience Methods

public extension NimbusTheming {
    /// Gets the primary color for the current environment's color scheme
    func primaryColor(from environment: EnvironmentValues) -> Color {
        primaryColor(for: environment.colorScheme)
    }
    
    /// Gets the secondary color for the current environment's color scheme
    func secondaryColor(from environment: EnvironmentValues) -> Color {
        secondaryColor(for: environment.colorScheme)
    }
    
    /// Gets the error color for the current environment's color scheme
    func errorColor(from environment: EnvironmentValues) -> Color {
        errorColor(for: environment.colorScheme)
    }
    
    /// Gets the background color for the current environment's color scheme
    func backgroundColor(from environment: EnvironmentValues) -> Color {
        backgroundColor(for: environment.colorScheme)
    }
}
