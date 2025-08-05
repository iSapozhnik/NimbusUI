//
//  BadgeSemanticType.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
import NimbusCore

/// Defines semantic types for badge components with automatic color theming
public enum BadgeSemanticType: CaseIterable, Sendable {
    case info, success, warning, error
    
    /// Returns the background color for primary badges (solid background)
    func primaryBackgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        switch self {
        case .info:
            return theme.infoColor(for: scheme)
        case .success:
            return theme.successColor(for: scheme)
        case .warning:
            return theme.warningColor(for: scheme)
        case .error:
            return theme.errorColor(for: scheme)
        }
    }
    
    /// Returns the background color for secondary badges (transparent background)
    func secondaryBackgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let baseColor = primaryBackgroundColor(theme: theme, scheme: scheme)
        return baseColor.opacity(0.15)
    }
    
    /// Returns the text color for badges
    func textColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        switch self {
        case .info:
            return scheme == .dark ? theme.infoColor(for: scheme).lighter(by: 0.3) : theme.infoColor(for: scheme).darker(by: 0.2)
        case .success:
            return scheme == .dark ? theme.successColor(for: scheme).lighter(by: 0.3) : theme.successColor(for: scheme).darker(by: 0.2)
        case .warning:
            return scheme == .dark ? theme.warningColor(for: scheme).lighter(by: 0.3) : theme.warningColor(for: scheme).darker(by: 0.2)
        case .error:
            return scheme == .dark ? theme.errorColor(for: scheme).lighter(by: 0.3) : theme.errorColor(for: scheme).darker(by: 0.2)
        }
    }
    
    /// Returns the primary text color for primary badges (white/light text on solid background)
    func primaryTextColor(scheme: ColorScheme) -> Color {
        scheme == .dark ? Color.black : Color.white
    }
    
    /// Returns the border color for secondary badges
    func borderColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let baseColor = primaryBackgroundColor(theme: theme, scheme: scheme)
        return baseColor.opacity(0.3)
    }
}