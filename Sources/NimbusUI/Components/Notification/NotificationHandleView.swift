//
//  NotificationHandleView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

/// A subtle drag indicator component that appears when notifications are hovered.
/// Designed to mimic iOS Control Center handle style with smooth fade animations.
public struct NotificationHandleView: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusNotificationHandleWidth) private var overrideWidth
    @Environment(\.nimbusNotificationHandleHeight) private var overrideHeight
    @Environment(\.nimbusNotificationHandleCornerRadius) private var overrideCornerRadius
    @Environment(\.nimbusNotificationHandleOpacityVisible) private var overrideOpacityVisible
    @Environment(\.nimbusNotificationHandleOpacityHidden) private var overrideOpacityHidden
    @Environment(\.nimbusNotificationHandleFadeAnimation) private var overrideFadeAnimation
    
    /// Controls the visibility of the handle with smooth animations
    @Binding private var isVisible: Bool
    
    /// Creates a notification handle view with the specified visibility binding.
    /// - Parameter isVisible: A binding that controls when the handle appears/disappears
    public init(isVisible: Binding<Bool>) {
        self._isVisible = isVisible
    }
    
    public var body: some View {
        let width = overrideWidth ?? theme.notificationHandleWidth
        let height = overrideHeight ?? theme.notificationHandleHeight
        let cornerRadius = overrideCornerRadius ?? theme.notificationHandleCornerRadius
        let opacityVisible = overrideOpacityVisible ?? theme.notificationHandleOpacityVisible
        let opacityHidden = overrideOpacityHidden ?? theme.notificationHandleOpacityHidden
        let fadeAnimation = overrideFadeAnimation ?? theme.notificationHandleFadeAnimation
        
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(theme.notificationHandleColor(for: colorScheme))
            .frame(width: width, height: height)
            .opacity(isVisible ? opacityVisible : opacityHidden)
            .animation(fadeAnimation, value: isVisible)
    }
}
