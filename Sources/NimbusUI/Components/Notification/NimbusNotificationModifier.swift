//
//  NimbusNotificationModifier.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

struct NimbusNotificationModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    
    // Notification configuration
    @Binding var isPresented: Bool
    let type: NotificationType
    let message: String
    let actionText: String?
    let iconAlignment: NotificationIconAlignment
    let dismissBehavior: NotificationDismissBehavior
    let presentationStyle: NotificationPresentationStyle
    let onAction: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    // Internal state for animations
    @State private var isNotificationVisible = false
    @State private var dismissTimer: Timer?
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: NotificationAnimationFactory.overlayAlignment(for: presentationStyle)) {
                if isNotificationVisible {
                    notificationContainer
                        .transition(NotificationAnimationFactory.transition(for: presentationStyle))
                        .ignoresSafeArea(edges: .horizontal)
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    showNotification()
                } else {
                    dismissNotification()
                }
            }
            .onAppear {
                if isPresented {
                    showNotification()
                }
            }
    }
    
    @ViewBuilder
    private var notificationContainer: some View {
        let contentPadding = NotificationAnimationFactory.contentPadding(for: presentationStyle, theme: theme)
        let shouldUseSpacerLayout = NotificationAnimationFactory.shouldUseSpacerLayout(for: presentationStyle)
        
        if shouldUseSpacerLayout {
            spacerBasedLayout(contentPadding: contentPadding)
        } else {
            centeredLayout(contentPadding: contentPadding)
        }
    }
    
    @ViewBuilder
    private func spacerBasedLayout(contentPadding: EdgeInsets) -> some View {
        switch presentationStyle {
        case .slideFromTop, .bounce:
            VStack {
                notificationView
                Spacer()
            }
            .padding(contentPadding)
            
        case .slideFromBottom:
            VStack {
                Spacer()
                notificationView
            }
            .padding(contentPadding)
            
        case .slideFromLeading:
            HStack {
                notificationView
                Spacer()
            }
            .padding(contentPadding)
            
        case .slideFromTrailing:
            HStack {
                Spacer()
                notificationView
            }
            .padding(contentPadding)
            
        default:
            // Fallback - should not be reached for spacer-based layouts
            notificationView
                .padding(contentPadding)
        }
    }
    
    @ViewBuilder
    private func centeredLayout(contentPadding: EdgeInsets) -> some View {
        notificationView
            .padding(contentPadding)
    }
    
    private var notificationView: some View {
        NimbusNotificationView(
            type: type,
            message: message,
            actionText: actionText,
            iconAlignment: iconAlignment,
            onAction: onAction,
            onDismiss: {
                dismissNotification()
                onDismiss?()
            }
        )
    }
    
    private func showNotification() {
        // Cancel any existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        // Show the notification with style-appropriate animation
        let showAnimation = NotificationAnimationFactory.showAnimation(for: presentationStyle, theme: theme)
        withAnimation(showAnimation) {
            isNotificationVisible = true
        }
        
        // Set up auto-dismiss timer if needed
        if case .temporary(let duration) = dismissBehavior {
            dismissTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
                dismissNotification()
            }
        }
    }
    
    private func dismissNotification() {
        // Cancel any existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        // Hide the notification with style-appropriate animation
        let hideAnimation = NotificationAnimationFactory.hideAnimation(for: presentationStyle, theme: theme)
        withAnimation(hideAnimation) {
            isNotificationVisible = false
        }
        
        // Reset the binding after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}