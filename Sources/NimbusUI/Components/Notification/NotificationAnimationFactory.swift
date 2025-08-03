//
//  NotificationAnimationFactory.swift
//  NimbusUI
//
//  Created by Claude Code on 03.08.25.
//

import SwiftUI

/// Factory for creating notification animations, transitions, and positioning configurations
/// based on the selected presentation style
struct NotificationAnimationFactory {
    
    /// Returns the appropriate SwiftUI transition for the given presentation style
    /// - Parameter style: The presentation style to create a transition for
    /// - Returns: An AnyTransition configured for the style
    static func transition(for style: NotificationPresentationStyle) -> AnyTransition {
        switch style {
        case .slideFromTop:
            return .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            )
            
        case .fadeIn:
            return .opacity
            
        case .slideFromBottom:
            return .asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .move(edge: .bottom).combined(with: .opacity)
            )
            
        case .slideFromLeading:
            return .asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            )
            
        case .slideFromTrailing:
            return .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .trailing).combined(with: .opacity)
            )
            
        case .bounce:
            // Bounce uses the same movement as slideFromTop but with different animation timing
            return .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            )
            
        case .scale:
            return .asymmetric(
                insertion: .scale(scale: 0.8).combined(with: .opacity),
                removal: .scale(scale: 0.8).combined(with: .opacity)
            )
        }
    }
    
    /// Returns the appropriate overlay alignment for positioning the notification
    /// - Parameter style: The presentation style to get alignment for
    /// - Returns: Alignment value for the overlay positioning
    static func overlayAlignment(for style: NotificationPresentationStyle) -> Alignment {
        switch style {
        case .slideFromTop, .bounce:
            return .top
        case .slideFromBottom:
            return .top  // Changed from .bottom - we'll use spacer layout for bottom positioning
        case .slideFromLeading:
            return .top  // Changed from .leading - we'll use spacer layout for leading positioning
        case .slideFromTrailing:
            return .top  // Changed from .trailing - we'll use spacer layout for trailing positioning
        case .fadeIn, .scale:
            return .center
        }
    }
    
    /// Returns the show animation for the given style and theme
    /// - Parameters:
    ///   - style: The presentation style
    ///   - theme: The current theme for animation preferences
    /// - Returns: Animation configuration for showing the notification
    static func showAnimation(for style: NotificationPresentationStyle, theme: NimbusTheming) -> Animation {
        switch style {
        case .slideFromTop, .slideFromBottom, .slideFromLeading, .slideFromTrailing:
            return theme.notificationShowAnimation
            
        case .fadeIn:
            return theme.animationFast
            
        case .bounce:
            return theme.notificationBounceAnimation
            
        case .scale:
            return theme.notificationScaleAnimation
        }
    }
    
    /// Returns the hide animation for the given style and theme
    /// - Parameters:
    ///   - style: The presentation style
    ///   - theme: The current theme for animation preferences
    /// - Returns: Animation configuration for hiding the notification
    static func hideAnimation(for style: NotificationPresentationStyle, theme: NimbusTheming) -> Animation {
        switch style {
        case .slideFromTop, .slideFromBottom, .slideFromLeading, .slideFromTrailing:
            return theme.notificationHideAnimation
            
        case .fadeIn:
            return theme.animationFast
            
        case .bounce:
            return theme.notificationHideAnimation
            
        case .scale:
            return theme.notificationScaleAnimation
        }
    }
    
    /// Returns the appropriate padding configuration for the notification content
    /// based on the presentation style and overlay alignment
    /// - Parameters:
    ///   - style: The presentation style
    ///   - theme: The current theme for padding values
    /// - Returns: EdgeInsets for content padding
    static func contentPadding(for style: NotificationPresentationStyle, theme: NimbusTheming) -> EdgeInsets {
        switch style {
        case .slideFromTop, .bounce:
            return EdgeInsets(
                top: theme.notificationTopPadding,
                leading: theme.notificationHorizontalPadding,
                bottom: 0,
                trailing: theme.notificationHorizontalPadding
            )
            
        case .slideFromBottom:
            return EdgeInsets(
                top: 0,
                leading: theme.notificationHorizontalPadding,
                bottom: theme.notificationTopPadding,
                trailing: theme.notificationHorizontalPadding
            )
            
        case .slideFromLeading:
            return EdgeInsets(
                top: theme.notificationTopPadding,
                leading: theme.notificationHorizontalPadding,
                bottom: 0,
                trailing: theme.notificationHorizontalPadding
            )
            
        case .slideFromTrailing:
            return EdgeInsets(
                top: theme.notificationTopPadding,
                leading: theme.notificationHorizontalPadding,
                bottom: 0,
                trailing: theme.notificationHorizontalPadding
            )
            
        case .fadeIn, .scale:
            return EdgeInsets(
                top: theme.notificationTopPadding,
                leading: theme.notificationHorizontalPadding,
                bottom: theme.notificationTopPadding,
                trailing: theme.notificationHorizontalPadding
            )
        }
    }
    
    /// Determines if the notification should use a spacer for layout
    /// - Parameter style: The presentation style
    /// - Returns: Boolean indicating if spacer should be used
    static func shouldUseSpacerLayout(for style: NotificationPresentationStyle) -> Bool {
        switch style {
        case .slideFromTop, .bounce:
            return true  // Uses VStack with Spacer() for top alignment
        case .slideFromBottom:
            return true  // Uses VStack with Spacer() for bottom alignment (spacer on top)
        case .slideFromLeading, .slideFromTrailing:
            return true  // Uses HStack with Spacer() for side alignment
        case .fadeIn, .scale:
            return false // Uses center alignment without spacers
        }
    }
}
