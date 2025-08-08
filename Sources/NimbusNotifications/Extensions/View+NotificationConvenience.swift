//
//  View+NotificationConvenience.swift
//  NimbusNotifications
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Notification Handle Configuration

public extension View {
    /// Sets the width for notification handles
    /// - Parameter width: The width to apply to notification handles
    /// - Returns: A view with the specified notification handle width applied
    func notificationHandleWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusNotificationHandleWidth, width)
    }
    
    /// Sets the height for notification handles
    /// - Parameter height: The height to apply to notification handles
    /// - Returns: A view with the specified notification handle height applied
    func notificationHandleHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusNotificationHandleHeight, height)
    }
    
    /// Sets the corner radius for notification handles
    /// - Parameter radius: The corner radius to apply to notification handles
    /// - Returns: A view with the specified notification handle corner radius applied
    func notificationHandleCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusNotificationHandleCornerRadius, radius)
    }
    
    /// Sets the opacity values for notification handles
    /// - Parameters:
    ///   - visible: The opacity when the handle is visible
    ///   - hidden: The opacity when the handle is hidden
    /// - Returns: A view with the specified notification handle opacity values applied
    func notificationHandleOpacity(visible: Double, hidden: Double) -> some View {
        environment(\.nimbusNotificationHandleOpacityVisible, visible)
            .environment(\.nimbusNotificationHandleOpacityHidden, hidden)
    }
    
    /// Sets the fade animation for notification handles
    /// - Parameter animation: The animation to use for handle fading
    /// - Returns: A view with the specified notification handle fade animation applied
    func notificationHandleFadeAnimation(_ animation: Animation) -> some View {
        environment(\.nimbusNotificationHandleFadeAnimation, animation)
    }
}
