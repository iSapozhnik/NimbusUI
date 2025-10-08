//
//  NimbusAlert.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore
import NimbusComponents

public struct NimbusAlert: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusAlertCornerRadii) private var cornerRadii
    
    internal let style: NimbusAlertStyle
    internal let title: LocalizedStringKey
    internal let message: LocalizedStringKey?
    internal let actions: [NimbusAlertButton]
    internal let customContent: AnyView?
    internal let presentationMode: NimbusAlertPresentationMode
    internal let onDismiss: () -> Void
    
    public init(
        style: NimbusAlertStyle = .info,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertButton] = [],
        presentationMode: NimbusAlertPresentationMode = .modal,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder customContent: () -> some View = { EmptyView() }
    ) {
        self.style = style
        self.title = title
        self.message = message
        self.actions = actions
        self.presentationMode = presentationMode
        self.onDismiss = onDismiss
        
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
                            AlertButton(
                                action: action,
                                index: index,
                                totalActions: actions.count,
                                onDismiss: onDismiss
                            )
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
                blendingMode: presentationMode == .modal ? .withinWindow : .behindWindow
            )
        )
        .clipShape(.rect(cornerRadii: effectiveCornerRadii))
        .overlay {
            windowBorder()
        }
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 8)
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

// MARK: - AlertButton Helper View

private struct AlertButton: View {
    let action: NimbusAlertButton
    let index: Int
    let totalActions: Int
    let onDismiss: () -> Void
    
    private var keyboardShortcut: KeyboardShortcut? {
        // Cancel role always gets escape key
        if action.role == .cancel {
            return .cancelAction
        }
        // Last non-cancel button gets return key (primary action)
        else if index == totalActions - 1 && action.role != .cancel {
            return .defaultAction
        }
        // Other buttons get no keyboard shortcut
        else {
            return nil
        }
    }
    
    var body: some View {
        let isPrimaryAction = index == totalActions - 1 && action.role != .cancel
        
        Group {
            if isPrimaryAction {
                Button {
                    action.action()
                    onDismiss()
                } label: {
                    Text(action.title)
                }
                .buttonStyle(.primaryOutline)
                .controlSize(.mini)
                .keyboardShortcut(keyboardShortcut)
            } else {
                Button {
                    action.action()
                    onDismiss()
                } label: {
                    Text(action.title)
                }
                .buttonStyle(.secondaryOutline)
                .controlSize(.mini)
                .keyboardShortcut(keyboardShortcut)
            }
        }
    }
}

