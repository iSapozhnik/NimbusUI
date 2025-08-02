//
//  NimbusTheming.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

// https://freiwald.dev/posts/custom-environment-colors/
// https://alexanderweiss.dev/blog/2025-01-19-effortless-swiftui-theming

/// A comprehensive theming protocol that defines all color tokens and styling properties
/// used throughout the NimbusUI design system.
public protocol NimbusTheming: Sendable {
    
    // MARK: - Brand Colors
    
    /// Primary brand color that adapts to light/dark color schemes
    func primaryColor(for scheme: ColorScheme) -> Color
    
    /// Secondary brand color that adapts to light/dark color schemes  
    func secondaryColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary brand color that adapts to light/dark color schemes
    func tertiaryColor(for scheme: ColorScheme) -> Color
    
    /// Accent color for highlights and interactive elements
    func accentColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Semantic Colors
    
    /// Error/danger color for destructive actions and error states
    func errorColor(for scheme: ColorScheme) -> Color
    
    /// Success color for positive feedback and completed states
    func successColor(for scheme: ColorScheme) -> Color
    
    /// Warning color for caution states and important notices
    func warningColor(for scheme: ColorScheme) -> Color
    
    /// Info color for informational messages and neutral feedback
    func infoColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Background Colors
    
    /// Primary background color for main content areas
    func backgroundColor(for scheme: ColorScheme) -> Color
    
    /// Secondary background color for cards, panels, and elevated surfaces
    func secondaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary background color for subtle backgrounds and disabled states
    func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Text Colors
    
    /// Primary text color for headings and main content
    func primaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Secondary text color for supporting text and descriptions
    func secondaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary text color for placeholders and disabled text
    func tertiaryTextColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Border Colors
    
    /// Primary border color for inputs, buttons, and separators
    func borderColor(for scheme: ColorScheme) -> Color
    
    /// Secondary border color for subtle divisions and nested elements
    func secondaryBorderColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Material & Styling
    
    /// Background material for blur effects and translucent surfaces
    var backgroundMaterial: Material? { get }
    
    /// Corner radii configuration for consistent rounded corners
    var cornerRadii: RectangleCornerRadii { get }
    
    // MARK: - Design Tokens
    
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
    
    /// Button corner radii configuration
    var buttonCornerRadii: RectangleCornerRadii { get }
    
    /// Compact button corner radii configuration
    var compactButtonCornerRadii: RectangleCornerRadii { get }
    
    /// List item corner radii configuration
    var listItemCornerRadii: RectangleCornerRadii { get }
    
    /// List item height configuration
    var listItemHeight: CGFloat { get }
    
    /// Label content spacing configuration
    var labelContentSpacing: CGFloat { get }
    
    /// Checkbox size configuration (24x24 default)
    var checkboxSize: CGFloat { get }
    
    /// Checkbox corner radii configuration
    var checkboxCornerRadii: RectangleCornerRadii { get }
    
    /// Checkbox border width configuration
    var checkboxBorderWidth: CGFloat { get }
    
    // MARK: - Scroller Design Tokens
    
    /// Scroller track width (thickness of the entire scroller)
    var scrollerWidth: CGFloat { get }
    
    /// Scroller knob width (thickness of the draggable knob)
    var scrollerKnobWidth: CGFloat { get }
    
    /// Scroller knob padding (space between knob and slot edges)
    var scrollerKnobPadding: CGFloat { get }
    
    /// Scroller slot corner radius
    var scrollerSlotCornerRadius: CGFloat { get }
    
    // Legacy scroller design tokens (keeping for backward compatibility)
    
    /// Scroller knob corner radius (auto-calculated from slot corner radius)
    var scrollerKnobCornerRadius: CGFloat { get }
    
    /// Scroller knob vertical inset
    var scrollerKnobInsetVertical: CGFloat { get }
    
    /// Scroller knob horizontal inset
    var scrollerKnobInsetHorizontal: CGFloat { get }
    
    /// Scroller slot inset
    var scrollerSlotInset: CGFloat { get }
    
    /// Scroller initial opacity
    var scrollerInitialOpacity: CGFloat { get }
    
    /// Scroller fade opacity
    var scrollerFadeOpacity: CGFloat { get }
    
    /// Scroller fade delay
    var scrollerFadeDelay: TimeInterval { get }
    
    /// Scroller animation duration
    var scrollerAnimationDuration: TimeInterval { get }
    
    /// Scroller slot visibility
    var scrollerShowSlot: Bool { get }
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
