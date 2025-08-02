//
//  NimbusTheme.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

/// Default implementation of NimbusTheming with modern, accessible colors
/// that work well in both light and dark color schemes.
public struct NimbusTheme: NimbusTheming, Sendable {
    public init() {}
    
    // MARK: - Brand Colors
    
    public func primaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.4, green: 0.6, blue: 1.0),
            dark: Color(red: 0.5, green: 0.7, blue: 1.0),
            scheme: scheme
        )
    }
    
    public func secondaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.5, green: 0.5, blue: 0.5),
            dark: Color(red: 0.7, green: 0.7, blue: 0.7),
            scheme: scheme
        )
    }
    
    public func tertiaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.7, green: 0.7, blue: 0.7),
            dark: Color(red: 0.5, green: 0.5, blue: 0.5),
            scheme: scheme
        )
    }
    
    public func accentColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: .accentColor,
            dark: .accentColor,
            scheme: scheme
        )
    }
    
    // MARK: - Semantic Colors
    
    public func errorColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.9, green: 0.3, blue: 0.3),
            dark: Color(red: 1.0, green: 0.4, blue: 0.4),
            scheme: scheme
        )
    }
    
    public func successColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.2, green: 0.7, blue: 0.3),
            dark: Color(red: 0.3, green: 0.8, blue: 0.4),
            scheme: scheme
        )
    }
    
    public func warningColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 1.0, green: 0.6, blue: 0.0),
            dark: Color(red: 1.0, green: 0.7, blue: 0.2),
            scheme: scheme
        )
    }
    
    public func infoColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.2, green: 0.6, blue: 0.9),
            dark: Color(red: 0.4, green: 0.7, blue: 1.0),
            scheme: scheme
        )
    }
    
    // MARK: - Background Colors
    
    public func backgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 1.0, green: 1.0, blue: 1.0),
            dark: Color(red: 0.1, green: 0.1, blue: 0.1),
            scheme: scheme
        )
    }
    
    public func secondaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.97, green: 0.97, blue: 0.97),
            dark: Color(red: 0.15, green: 0.15, blue: 0.15),
            scheme: scheme
        )
    }
    
    public func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.94, green: 0.94, blue: 0.94),
            dark: Color(red: 0.2, green: 0.2, blue: 0.2),
            scheme: scheme
        )
    }
    
    // MARK: - Text Colors
    
    public func primaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.1, green: 0.1, blue: 0.1),
            dark: Color(red: 0.95, green: 0.95, blue: 0.95),
            scheme: scheme
        )
    }
    
    public func secondaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.4, green: 0.4, blue: 0.4),
            dark: Color(red: 0.7, green: 0.7, blue: 0.7),
            scheme: scheme
        )
    }
    
    public func tertiaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.6, green: 0.6, blue: 0.6),
            dark: Color(red: 0.5, green: 0.5, blue: 0.5),
            scheme: scheme
        )
    }
    
    // MARK: - Border Colors
    
    public func borderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.8, green: 0.8, blue: 0.8),
            dark: Color(red: 0.3, green: 0.3, blue: 0.3),
            scheme: scheme
        )
    }
    
    public func secondaryBorderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(red: 0.9, green: 0.9, blue: 0.9),
            dark: Color(red: 0.25, green: 0.25, blue: 0.25),
            scheme: scheme
        )
    }
    
    // MARK: - Material & Styling
    
    public let backgroundMaterial: Material? = Material.thinMaterial
    public let cornerRadii = RectangleCornerRadii(8)
    
    // MARK: - Design Tokens
    
    public let animation = Animation.smooth(duration: 0.2)
    public let animationFast = Animation.easeInOut(duration: 0.1)
    public let minHeight: CGFloat = 30
    public let horizontalPadding: CGFloat = 8
    public let elevation = Elevation.low
    public let buttonCornerRadii = RectangleCornerRadii(8)
    public let compactButtonCornerRadii = RectangleCornerRadii(8)
    public let listItemCornerRadii = RectangleCornerRadii(2)
    public let listItemHeight: CGFloat = 44
    public let labelContentSpacing: CGFloat = 6
    public let checkboxSize: CGFloat = 16
    public let checkboxCornerRadii = RectangleCornerRadii(4)
    public let checkboxBorderWidth: CGFloat = 1
    
    // MARK: - Scroller Design Tokens
    
    // Core scroller dimensions
    public let scrollerWidth: CGFloat = 16
    public let scrollerKnobWidth: CGFloat = 6
    public let scrollerKnobPadding: CGFloat = 2
    public let scrollerSlotCornerRadius: CGFloat = 4
    public let scrollerShowSlot: Bool = true
    
    // Auto-calculated knob corner radius (based on knob width and padding)
    public var scrollerKnobCornerRadius: CGFloat {
        (scrollerKnobWidth - scrollerKnobPadding) / 2
    }
    
    // Legacy properties (keeping for backward compatibility)
    public let scrollerKnobInsetVertical: CGFloat = 6
    public let scrollerKnobInsetHorizontal: CGFloat = 3
    public let scrollerSlotInset: CGFloat = 3
    public let scrollerInitialOpacity: CGFloat = 0.3
    public let scrollerFadeOpacity: CGFloat = 0.3
    public let scrollerFadeDelay: TimeInterval = 1.0
    public let scrollerAnimationDuration: TimeInterval = 0.1
}

extension NimbusTheme {
    public static let `default` = NimbusTheme()
}
