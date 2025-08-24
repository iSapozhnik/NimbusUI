//
//  NimbusAlert.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

public struct NimbusAlert: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusAlertCornerRadii) private var cornerRadii
    
    internal let style: NimbusAlertStyle
    internal let title: LocalizedStringKey
    internal let message: LocalizedStringKey?
    internal let actions: [NimbusAlertAction]
    internal let customContent: AnyView?
    private let onResponse: ((NSApplication.ModalResponse) -> Void)?
    
    public init(
        style: NimbusAlertStyle,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = [],
        onResponse: ((NSApplication.ModalResponse) -> Void)? = nil,
        @ViewBuilder customContent: () -> some View = { EmptyView() }
    ) {
        self.style = style
        self.title = title
        self.message = message
        self.actions = actions
        self.onResponse = onResponse
        
        let content = customContent()
        if content is EmptyView {
            self.customContent = nil
        } else {
            self.customContent = AnyView(content)
        }
    }
    
    private var effectiveCornerRadii: RectangleCornerRadii {
        cornerRadii ?? theme.alertCornerRadii
    }
    
    public var body: some View {
        ZStack {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Image(systemName: style.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(style.iconColor(for: theme, colorScheme: colorScheme))
                    .frame(width: 24, height: 24)
                
                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(theme.primaryTextColor(for: colorScheme))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let message = message {
                        Text(message)
                            .font(.body)
                            .foregroundStyle(theme.secondaryTextColor(for: colorScheme))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let customContent = customContent {
                        customContent
                    }
                    
                    if !actions.isEmpty {
                        HStack(spacing: 12) {
                            ForEach(Array(actions.enumerated()), id: \.offset) { index, action in
                                Group {
                                    switch action.style {
                                    case .default:
                                        Button(action.title) {
                                            action.action()
                                            onResponse?(.cancel)
                                        }
                                        .buttonStyle(.secondaryOutline)
                                    case .primary:
                                        Button(action.title) {
                                            action.action()
                                            onResponse?(.OK)
                                        }
                                        .buttonStyle(.primaryOutline)
                                    case .destructive:
                                        Button(action.title, role: .destructive) {
                                            action.action()
                                            onResponse?(.cancel)
                                        }
                                        .buttonStyle(.secondaryOutline)
                                    }
                                }
                                .controlSize(.mini)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .modifier(
                NimbusBackgroundEffectModifier(
                    material: .menu,
                    blendingMode: .behindWindow
                )
            )
            .clipShape(.rect(cornerRadii: effectiveCornerRadii))
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 8)
            
            windowBorder()
        }
    }
    
    func windowBorder() -> some View {
        ZStack {
            UnevenRoundedRectangle(cornerRadii: effectiveCornerRadii)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)

            UnevenRoundedRectangle(cornerRadii: effectiveCornerRadii)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
                .mask(alignment: .top) {
                    LinearGradient(
                        colors: [
                            .white,
                            .clear
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 30)
                }
        }
    }
}

// MARK: - Convenience Initializers

public extension NimbusAlert {
    static func info(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = []
    ) -> NimbusAlert {
        NimbusAlert(
            style: .info,
            title: title,
            message: message,
            actions: actions
        )
    }
    
    static func success(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = []
    ) -> NimbusAlert {
        NimbusAlert(
            style: .success,
            title: title,
            message: message,
            actions: actions
        )
    }
    
    static func warning(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = []
    ) -> NimbusAlert {
        NimbusAlert(
            style: .warning,
            title: title,
            message: message,
            actions: actions
        )
    }
    
    static func error(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = []
    ) -> NimbusAlert {
        NimbusAlert(
            style: .error,
            title: title,
            message: message,
            actions: actions
        )
    }
}

// MARK: - Common Alert Configurations

public extension NimbusAlert {
    static func confirmDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> NimbusAlert {
        NimbusAlert(
            style: .info,
            title: title,
            message: message,
            actions: [
                NimbusAlertAction(title: cancelTitle, style: .default, action: onCancel),
                NimbusAlertAction(title: confirmTitle, style: .primary, action: onConfirm)
            ]
        )
    }
    
    static func destructiveDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        destructiveTitle: String = "Delete",
        cancelTitle: String = "Cancel",
        onDestroy: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> NimbusAlert {
        NimbusAlert(
            style: .warning,
            title: title,
            message: message,
            actions: [
                NimbusAlertAction(title: cancelTitle, style: .default, action: onCancel),
                NimbusAlertAction(title: destructiveTitle, style: .destructive, action: onDestroy)
            ]
        )
    }
    
    static func okDialog(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        style: NimbusAlertStyle = .info,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> NimbusAlert {
        NimbusAlert(
            style: style,
            title: title,
            message: message,
            actions: [
                NimbusAlertAction(title: okTitle, style: .primary, action: onOK)
            ]
        )
    }
}
