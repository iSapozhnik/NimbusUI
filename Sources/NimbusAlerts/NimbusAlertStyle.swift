//
//  NimbusAlertStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

public enum NimbusAlertStyle {
    case info
    case success
    case warning
    case error
    
    public var icon: String {
        switch self {
        case .info:
            return "info.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .error:
            return "xmark.circle.fill"
        }
    }
    
    public func iconColor(for theme: NimbusTheming, colorScheme: ColorScheme) -> Color {
        switch self {
        case .info:
            return theme.accentColor(for: colorScheme)
        case .success:
            return theme.successColor(for: colorScheme)
        case .warning:
            return theme.warningColor(for: colorScheme)
        case .error:
            return theme.errorColor(for: colorScheme)
        }
    }
}

public enum NimbusAlertPresentationMode {
    case normal
    case modal
}

public struct NimbusAlertButton {
    public let title: LocalizedStringKey
    public let role: ButtonRole?
    public let action: () -> Void
    
    public init(
        _ title: LocalizedStringKey,
        role: ButtonRole? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.role = role
        self.action = action
    }
}

