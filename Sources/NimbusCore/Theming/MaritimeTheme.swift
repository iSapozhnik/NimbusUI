//
//  MaritimeTheme.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 01.08.25.
//

import SwiftUI

/// Professional maritime theme implementation using nautical-inspired colors.
/// This demonstrates a business-ready alternative to the warm CustomWarmTheme.
/// 
/// **Maritime Color Palette:**
/// - Red Pantone: #E63946 (vibrant red for errors/destructive actions)
/// - Honeydew: #F1FAEE (clean, crisp backgrounds)
/// - Non-photo Blue: #A8DADC (light supporting blue)
/// - Cerulean: #457B9D (primary maritime blue)
/// - Berkeley Blue: #1D3557 (deep navy for structure)
/// 
/// **Design Personality:**
/// - Professional and structured (8pt corner radius vs 12pt warm theme)
/// - Clean and nautical with crisp blues and whites
/// - Trustworthy and reliable for business applications
/// - High contrast for excellent readability
public struct MaritimeTheme: NimbusTheming, Sendable {
    public init() {}
    
    // MARK: - Brand Colors
    
    public func primaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#457B9D"), // Cerulean - professional maritime blue
            dark: Color(hex: "#5B8FB7"),  // Lighter for dark mode contrast
            scheme: scheme
        )
    }
    
    public func secondaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#A8DADC"), // Non-photo Blue - light supporting blue
            dark: Color(hex: "#8AC4C7"),  // Adjusted for dark mode
            scheme: scheme
        )
    }
    
    public func tertiaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#1D3557"), // Berkeley Blue - deep navy structure
            dark: Color(hex: "#2A4A72"),  // Lightened for dark mode readability
            scheme: scheme
        )
    }
    
    public func accentColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#E63946"), // Red Pantone - vibrant maritime signal
            dark: Color(hex: "#F04A58"),  // Brighter for dark mode visibility
            scheme: scheme
        )
    }
    
    // MARK: - Semantic Colors
    
    public func errorColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#E63946"), // Red Pantone - natural destructive mapping
            dark: Color(hex: "#F04A58"),  // Enhanced visibility in dark mode
            scheme: scheme
        )
    }
    
    public func successColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#2D8A57"), // Maritime signal green - nautical safety
            dark: Color(hex: "#3FA569"),  // Brighter for dark mode
            scheme: scheme
        )
    }
    
    public func warningColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#FF8500"), // Nautical amber - maritime caution
            dark: Color(hex: "#FF9A26"),  // Enhanced for dark mode
            scheme: scheme
        )
    }
    
    public func infoColor(for scheme: ColorScheme) -> Color {
        primaryColor(for: scheme) // Reuse cerulean for consistency
    }
    
    // MARK: - Background Colors
    
    public func backgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F1FAEE"), // Honeydew - clean, crisp base
            dark: Color(hex: "#0F1B1E"),  // Deep maritime dark
            scheme: scheme
        )
    }
    
    public func secondaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#E8F4F1"), // Honeydew tint for cards/panels
            dark: Color(hex: "#1A2B30"),  // Slightly lighter maritime dark
            scheme: scheme
        )
    }
    
    public func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#DCE9E5"), // Deeper honeydew tint
            dark: Color(hex: "#253A42"),  // Mid-tone maritime background
            scheme: scheme
        )
    }
    
    // MARK: - Text Colors
    
    public func primaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#1D3557"), // Berkeley Blue - strong maritime contrast
            dark: Color(hex: "#F1FAEE"),  // Honeydew for dark mode readability
            scheme: scheme
        )
    }
    
    public func secondaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#457B9D"), // Cerulean for supporting text
            dark: Color(hex: "#A8DADC"),  // Non-photo Blue for dark mode
            scheme: scheme
        )
    }
    
    public func tertiaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#6B92A8"), // Muted maritime blue
            dark: Color(hex: "#7B9FA5"),  // Balanced for dark mode
            scheme: scheme
        )
    }
    
    // MARK: - Border Colors
    
    public func borderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#A8DADC"), // Non-photo Blue for subtle borders
            dark: Color(hex: "#3D5A5E"),  // Maritime dark border
            scheme: scheme
        )
    }
    
    public func secondaryBorderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#C4E5E7"), // Very subtle honeydew-blue tint
            dark: Color(hex: "#2F4A52"),  // Subtle dark maritime border
            scheme: scheme
        )
    }
    
    // MARK: - Material & Styling
    
    public let backgroundMaterial: Material? = Material.thinMaterial
    public let cornerRadii = RectangleCornerRadii(8) // Structured feel vs 12pt warm theme
    
    // MARK: - Core Design Tokens (Required)
    
    public let animation = Animation.smooth(duration: 0.2)
    public let animationFast = Animation.easeInOut(duration: 0.1)
    public let minHeight: CGFloat = 30
    public let horizontalPadding: CGFloat = 8
    public let elevation = Elevation.low
    
    // MARK: - Component Token Overrides (Optional)
    // Maritime theme customizes scroller for a more compact, professional feel
    
    // Scroller customization for maritime style
    public var scrollerWidth: CGFloat { 14 }
    public var scrollerKnobWidth: CGFloat { 5 }
    public var scrollerKnobPadding: CGFloat { 1.5 }
    public var scrollerSlotCornerRadius: CGFloat { 3 }
    
    // Custom scroller timing for maritime theme
    public var scrollerInitialOpacity: CGFloat { 0.35 }
    public var scrollerFadeOpacity: CGFloat { 0.35 }
    public var scrollerFadeDelay: TimeInterval { 1.2 }
    public var scrollerAnimationDuration: TimeInterval { 0.12 }
    
    // Legacy overrides for maritime
    public var scrollerKnobInsetVertical: CGFloat { 5 }
    public var scrollerSlotInset: CGFloat { 2 }
}

extension MaritimeTheme {
    public static let `default` = MaritimeTheme()
}
