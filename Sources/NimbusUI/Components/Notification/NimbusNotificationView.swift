//
//  NimbusNotificationView.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

public struct NimbusNotificationView: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Configuration
    let type: NotificationType
    let message: String
    let actionText: String?
    let iconAlignment: NotificationIconAlignment
    let onAction: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    public init(
        type: NotificationType,
        message: String,
        actionText: String? = nil,
        iconAlignment: NotificationIconAlignment = .center,
        onAction: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.type = type
        self.message = message
        self.actionText = actionText
        self.iconAlignment = iconAlignment
        self.onAction = onAction
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        HStack(alignment: alignmentForIcon, spacing: 12) {
            // Icon with simplified logic
            iconView
            
            // Message with proper text wrapping
            messageView
            
            Spacer()
            
            // Action Link Button (if provided)
            if let actionText = actionText, let onAction = onAction {
                Button(actionText, action: onAction)
                    .buttonStyle(LinkButtonStyle(semanticColor: type.actionColor(theme: theme, scheme: colorScheme)))
            }
            
            // Close Button
            Button {
                onDismiss?()
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(CloseButtonStyle())
        }
        .padding(theme.notificationPadding)
        .frame(minHeight: theme.notificationMinHeight)
        .background(type.backgroundColor(theme: theme, scheme: colorScheme))
        .clipShape(.rect(cornerRadii: theme.notificationCornerRadii))
        .modifier(NimbusShadowModifier(elevation: .medium))

    }
    
    /// Computes the HStack alignment based on icon alignment preference
    private var alignmentForIcon: VerticalAlignment {
        switch iconAlignment {
        case .center:
            return .center
        case .baseline:
            return .firstTextBaseline
        case .top:
            return .top
        }
    }
    
    @ViewBuilder
    private var iconView: some View {
        Image(systemName: type.systemIcon)
            .font(.system(size: theme.notificationIconSize, weight: .medium))
            .foregroundStyle(type.iconColor(theme: theme, scheme: colorScheme))
            .frame(width: theme.notificationIconSize, height: theme.notificationIconSize)
    }
    
    @ViewBuilder
    private var messageView: some View {
        Text(message)
            .font(.system(size: 14, weight: .regular))
            .foregroundStyle(type.textColor(theme: theme, scheme: colorScheme))
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}
