//
//  View+NimbusNotification.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

public extension View {
    /// Presents a notification overlay at the top of the view
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls notification visibility
    ///   - type: The semantic type of notification (info, success, warning, error)
    ///   - message: The text message to display
    ///   - actionText: Optional text for an action button
    ///   - iconAlignment: Vertical alignment of the icon relative to text content (.center, .baseline, .top)
    ///   - dismissBehavior: How the notification should be dismissed (.sticky or .temporary)
    ///   - onAction: Optional closure called when action button is tapped
    ///   - onDismiss: Optional closure called when notification is dismissed
    /// - Returns: A view with the notification overlay
    func nimbusNotification(
        isPresented: Binding<Bool>,
        type: NotificationType,
        message: String,
        actionText: String? = nil,
        iconAlignment: NotificationIconAlignment = .center,
        dismissBehavior: NotificationDismissBehavior = .sticky,
        onAction: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            NimbusNotificationModifier(
                isPresented: isPresented,
                type: type,
                message: message,
                actionText: actionText,
                iconAlignment: iconAlignment,
                dismissBehavior: dismissBehavior,
                onAction: onAction,
                onDismiss: onDismiss
            )
        )
    }
}