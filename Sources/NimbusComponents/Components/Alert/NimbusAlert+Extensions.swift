//
//  NimbusAlert+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Alert Configuration Extensions

public extension NimbusAlert {
    func withWidth(_ width: CGFloat) -> NimbusAlert {
        var alert = self
        alert.preferredWidth = width
        return alert
    }
}

// MARK: - Alert Action Builder

@resultBuilder
public struct NimbusAlertActionBuilder {
    public static func buildBlock(_ components: NimbusAlertAction...) -> [NimbusAlertAction] {
        components
    }
    
    public static func buildOptional(_ component: [NimbusAlertAction]?) -> [NimbusAlertAction] {
        component ?? []
    }
    
    public static func buildEither(first component: [NimbusAlertAction]) -> [NimbusAlertAction] {
        component
    }
    
    public static func buildEither(second component: [NimbusAlertAction]) -> [NimbusAlertAction] {
        component
    }
}

// MARK: - Enhanced Initializer with Action Builder

public extension NimbusAlert {
    init(
        style: NimbusAlertStyle,
        title: String,
        message: String? = nil,
        @NimbusAlertActionBuilder actions: () -> [NimbusAlertAction],
        @ViewBuilder customContent: () -> some View = { EmptyView() }
    ) {
        self.init(
            style: style,
            title: title,
            message: message,
            actions: actions(),
            customContent: customContent
        )
    }
}

// MARK: - Alert Action Convenience Methods

public extension NimbusAlertAction {
    static func `default`(_ title: String, action: @escaping () -> Void) -> NimbusAlertAction {
        NimbusAlertAction(title: title, style: .default, action: action)
    }
    
    static func primary(_ title: String, action: @escaping () -> Void) -> NimbusAlertAction {
        NimbusAlertAction(title: title, style: .primary, action: action)
    }
    
    static func destructive(_ title: String, action: @escaping () -> Void) -> NimbusAlertAction {
        NimbusAlertAction(title: title, style: .destructive, action: action)
    }
    
    static func cancel(_ title: String = "Cancel", action: @escaping () -> Void = {}) -> NimbusAlertAction {
        NimbusAlertAction(title: title, style: .default, action: action)
    }
    
    static func ok(_ title: String = "OK", action: @escaping () -> Void = {}) -> NimbusAlertAction {
        NimbusAlertAction(title: title, style: .primary, action: action)
    }
}

// MARK: - Theme Integration Extensions

public extension NimbusAlert {
    func themed(_ theme: NimbusTheming) -> some View {
        self.environment(\.nimbusTheme, theme)
    }
}

// MARK: - Internal Extensions

internal extension NimbusAlert {
    private struct PreferredWidthKey: EnvironmentKey {
        static let defaultValue: CGFloat = 400
    }
    
    var preferredWidth: CGFloat {
        get { 400 } // Default value
        set { } // This would need to be implemented with proper state management
    }
}