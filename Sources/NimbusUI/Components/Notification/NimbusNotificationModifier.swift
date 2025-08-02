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
    let onAction: (() -> Void)?
    let onDismiss: (() -> Void)?
    
    // Internal state for animations
    @State private var isNotificationVisible = false
    @State private var dismissTimer: Timer?
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isNotificationVisible {
                    VStack {
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
                        .padding(.horizontal, theme.notificationHorizontalPadding)
                        .transition(.asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        ))
                        
                        Spacer()
                    }
                    .padding(.top, theme.notificationTopPadding)
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
    
    private func showNotification() {
        // Cancel any existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        // Show the notification with animation
        withAnimation(theme.notificationShowAnimation) {
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
        
        // Hide the notification with animation
        withAnimation(theme.notificationHideAnimation) {
            isNotificationVisible = false
        }
        
        // Reset the binding after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}