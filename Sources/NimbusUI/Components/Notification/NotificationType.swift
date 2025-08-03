//
//  NotificationType.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

public enum NotificationType: CaseIterable, Sendable {
    case info, success, warning, error
    
    var systemIcon: String {
        switch self {
        case .info:
            return "info.circle"
        case .success:
            return "checkmark.circle"
        case .warning:
            return "exclamationmark.triangle"
        case .error:
            return "xmark.circle"
        }
    }
    
    func backgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let color: Color
        switch self {
        case .info:
            color = theme.infoColor(for: scheme)
        case .success:
            color = theme.successColor(for: scheme)
        case .warning:
            color = theme.warningColor(for: scheme)
        case .error:
            color = theme.errorColor(for: scheme)
        }
        return color.mix(with: .white, by: 0.5)
    }
    
    func iconColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let baseColor: Color
        switch self {
        case .info:
            baseColor = theme.infoColor(for: scheme)
        case .success:
            baseColor = theme.successColor(for: scheme)
        case .warning:
            baseColor = theme.warningColor(for: scheme)
        case .error:
            baseColor = theme.errorColor(for: scheme)
        }
        
        return baseColor.darker(by: 0.5)
    }
    
    func textColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let baseColor: Color
        switch self {
        case .info:
            baseColor = theme.infoColor(for: scheme)
        case .success:
            baseColor = theme.successColor(for: scheme)
        case .warning:
            baseColor = theme.warningColor(for: scheme)
        case .error:
            baseColor = theme.errorColor(for: scheme)
        }
        
        return baseColor.darker(by: 0.5)
    }
    
    func actionColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let baseColor: Color
        switch self {
        case .info:
            baseColor = theme.infoColor(for: scheme)
        case .success:
            baseColor = theme.successColor(for: scheme)
        case .warning:
            baseColor = theme.warningColor(for: scheme)
        case .error:
            baseColor = theme.errorColor(for: scheme)
        }
        
        // In light mode, use slightly darker variant for action links
        // In dark mode, use the base color for proper visibility
        return scheme == .light ? baseColor.darker(by: 0.1) : baseColor.darker(by: 0.25)
    }
    
    func borderColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        let backgroundColor = self.backgroundColor(theme: theme, scheme: scheme)
        // Return a border color that's darker than the background
        return backgroundColor.darker(by: 0.2)
    }
}
