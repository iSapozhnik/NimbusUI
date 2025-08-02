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
        let opacity = theme.notificationBackgroundOpacity
        
        switch self {
        case .info:
            return theme.infoColor(for: scheme).opacity(opacity)
        case .success:
            return theme.successColor(for: scheme).opacity(opacity)
        case .warning:
            return theme.warningColor(for: scheme).opacity(opacity)
        case .error:
            return theme.errorColor(for: scheme).opacity(opacity)
        }
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
        
        // In light mode, use darker variant for better contrast
        // In dark mode, use the base color for proper visibility
        return scheme == .light ? baseColor.darker(by: 0.15) : baseColor.darker(by: 0.25)
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
        
        // In light mode, use darker variant for better readability
        // In dark mode, use the base color for proper visibility
        return scheme == .light ? baseColor.darker(by: 0.5) : theme.primaryTextColor(for: .dark)
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
}
