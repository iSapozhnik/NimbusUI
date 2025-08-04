//
//  CustomWarmTheme.swift
//  NimbusCore
//
//  Created by Claude on 04.08.25.
//

import SwiftUI

/// Example custom theme implementation using warm, friendly colors.
/// This demonstrates how to implement the NimbusTheming protocol with your brand colors.
public struct CustomWarmTheme: NimbusTheming, Sendable {
    public init() {}
    
    // MARK: - Brand Colors
    
    public func primaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F1D1A7"),
            dark: Color(hex: "#EAC393"),  
            scheme: scheme
        )
    }
    
    public func secondaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#D6B88E"), 
            dark: Color(hex: "#C4A67C"),  
            scheme: scheme
        )
    }
    
    public func tertiaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#BFA673"),
            dark: Color(hex: "#A89463"),
            scheme: scheme
        )
    }
    
    public func accentColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#5584E4"),
            dark: Color(hex: "#4A73CC"),
            scheme: scheme
        )
    }
    
    // MARK: - Semantic Colors
    
    public func errorColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#EE7671"),
            dark: Color(hex: "#E85C57"),
            scheme: scheme
        )
    }
    
    public func successColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#82C091"),
            dark: Color(hex: "#6FAA7E"),
            scheme: scheme
        )
    }
    
    public func warningColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F4B942"),
            dark: Color(hex: "#E6A538"),
            scheme: scheme
        )
    }
    
    public func infoColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#5DADE2"),
            dark: Color(hex: "#5499CC"),
            scheme: scheme
        )
    }
    
    // MARK: - Background Colors
    
    public func backgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#FDF8F1"),
            dark: Color(hex: "#1A1A1A"),
            scheme: scheme
        )
    }
    
    public func secondaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F8F3EC"),
            dark: Color(hex: "#2A2A2A"),
            scheme: scheme
        )
    }
    
    public func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F3EEE7"),
            dark: Color(hex: "#3A3A3A"),
            scheme: scheme
        )
    }
    
    // MARK: - Text Colors
    
    public func primaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#2D3748"),
            dark: Color(hex: "#F7FAFC"),
            scheme: scheme
        )
    }
    
    public func secondaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#718096"),
            dark: Color(hex: "#CBD5E0"),
            scheme: scheme
        )
    }
    
    public func tertiaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#A0AEC0"),
            dark: Color(hex: "#A0AEC0"),
            scheme: scheme
        )
    }
    
    // MARK: - Border Colors
    
    public func borderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#E2E8F0"),
            dark: Color(hex: "#4A5568"),
            scheme: scheme
        )
    }
    
    public func secondaryBorderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#CBD5E0"),
            dark: Color(hex: "#2D3748"),
            scheme: scheme
        )
    }
    
    // MARK: - Core Design Tokens
    
    public var backgroundMaterial: Material? { .regularMaterial }
    
    public var cornerRadii: RectangleCornerRadii {
        RectangleCornerRadii(12)
    }
    
    public var animation: Animation {
        .easeInOut(duration: 0.3)
    }
    
    public var animationFast: Animation {
        .easeInOut(duration: 0.2)
    }
    
    public var minHeight: CGFloat { 44 }
    
    public var horizontalPadding: CGFloat { 20 }
    
    public var elevation: Elevation { .medium }
}