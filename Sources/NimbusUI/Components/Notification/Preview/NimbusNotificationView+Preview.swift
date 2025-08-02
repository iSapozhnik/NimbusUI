//
//  NimbusNotificationView+Preview.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations  
#Preview("All Notification Types") {
    VStack(spacing: 16) {
        // Info notification
        NimbusNotificationView(
            type: .info,
            message: "New feature coming soon! Prepare yourself for the release next month.",
            actionText: "Try again",
            onAction: { print("Info action tapped") },
            onDismiss: { print("Info dismissed") }
        )
        
        // Success notification
        NimbusNotificationView(
            type: .success,
            message: "Congratulations! Your payment is completed successfully.",
            actionText: "Check details",
            onAction: { print("Success action tapped") },
            onDismiss: { print("Success dismissed") }
        )
        
        // Warning notification
        NimbusNotificationView(
            type: .warning,
            message: "Action needed! Update payment information in your profile.",
            actionText: "Edit Profile",
            onAction: { print("Warning action tapped") },
            onDismiss: { print("Warning dismissed") }
        )
        
        // Error notification
        NimbusNotificationView(
            type: .error,
            message: "Something went wrong! We failed to complete your payment.",
            actionText: "Try again",
            onAction: { print("Error action tapped") },
            onDismiss: { print("Error dismissed") }
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Notification Without Action") {
    VStack(spacing: 16) {
        // Info notification without action
        NimbusNotificationView(
            type: .info,
            message: "This is a simple notification message without any action button.",
            onDismiss: { print("Info dismissed") }
        )
        
        // Success notification without action
        NimbusNotificationView(
            type: .success,
            message: "File uploaded successfully to your cloud storage.",
            onDismiss: { print("Success dismissed") }
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Long Message with Text Wrapping") {
    VStack(spacing: 16) {
        NimbusNotificationView(
            type: .warning,
            message: "This is a very long notification message that should wrap to multiple lines properly without truncation. It demonstrates the improved text wrapping implementation that allows notifications to expand vertically to accommodate longer content while maintaining proper layout with action buttons and ensuring readability.",
            actionText: "Fix Now",
            onAction: { print("Long message action tapped") },
            onDismiss: { print("Long message dismissed") }
        )
        
        NimbusNotificationView(
            type: .error,
            message: "Extremely long error message that tests the absolute limits of text wrapping functionality in notification components. This message is intentionally verbose to ensure that the component can handle edge cases where users provide exceptionally detailed notification content that spans multiple lines and requires proper vertical expansion.",
            actionText: "Retry",
            onAction: { print("Very long error action tapped") },
            onDismiss: { print("Very long error dismissed") }
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Icon Alignment Options") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Center Alignment (Default)")
                .font(.headline)
            NimbusNotificationView(
                type: .info,
                message: "This notification uses center alignment where the icon is centered relative to the entire text content. This is the default behavior.",
                actionText: "Learn More",
                iconAlignment: .center,
                onAction: { print("Center action") },
                onDismiss: { print("Center dismissed") }
            )
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Baseline Alignment")
                .font(.headline)
            NimbusNotificationView(
                type: .success,
                message: "This notification uses baseline alignment where the icon is positioned to align with the first line of text. This creates a more structured appearance for single-line messages.",
                actionText: "Confirm",
                iconAlignment: .baseline,
                onAction: { print("Baseline action") },
                onDismiss: { print("Baseline dismissed") }
            )
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Top Alignment")
                .font(.headline)
            NimbusNotificationView(
                type: .warning,
                message: "This notification uses top alignment where the icon is positioned at the top of the text content. This is useful for notifications with multiple lines where you want the icon to appear at the very beginning.",
                actionText: "Fix",
                iconAlignment: .top,
                onAction: { print("Top action") },
                onDismiss: { print("Top dismissed") }
            )
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Enhanced Color Contrast") {
    VStack(spacing: 16) {
        Text("Improved Color System (22% background opacity)")
            .font(.headline)
            .padding(.bottom, 8)
        
        NimbusNotificationView(
            type: .info,
            message: "Info notification with enhanced background opacity for better readability behind content.",
            actionText: "View",
            onAction: { print("Info action") },
            onDismiss: { print("Info dismissed") }
        )
        
        NimbusNotificationView(
            type: .success,
            message: "Success notification showing improved color hierarchy with darker icon and text variants.",
            actionText: "Continue",
            onAction: { print("Success action") },
            onDismiss: { print("Success dismissed") }
        )
        
        NimbusNotificationView(
            type: .warning,
            message: "Warning notification demonstrating enhanced contrast for better accessibility.",
            actionText: "Review",
            onAction: { print("Warning action") },
            onDismiss: { print("Warning dismissed") }
        )
        
        NimbusNotificationView(
            type: .error,
            message: "Error notification with improved semantic color usage for icons, text, and action links.",
            actionText: "Retry",
            onAction: { print("Error action") },
            onDismiss: { print("Error dismissed") }
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Presentation System Demo") {
    NotificationDemoView()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Demo View for Presentation System

@available(macOS 15.0, *)
struct NotificationDemoView: View {
    @State private var showInfo = false
    @State private var showSuccess = false
    @State private var showWarning = false
    @State private var showError = false
    @State private var showTemporary = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Notification System Demo")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 12) {
                Button("Show Info Notification") {
                    showInfo = true
                }
                .buttonStyle(.primaryDefault)
                
                Button("Show Success Notification") {
                    showSuccess = true
                }
                .buttonStyle(.primaryDefault)
                
                Button("Show Warning Notification") {
                    showWarning = true
                }
                .buttonStyle(.primaryDefault)
                
                Button("Show Error Notification") {
                    showError = true
                }
                .buttonStyle(.primaryDefault)
                
                Button("Show Temporary Notification (3s)") {
                    showTemporary = true
                }
                .buttonStyle(.secondaryProminent)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 400, height: 300)
        .nimbusNotification(
            isPresented: $showInfo,
            type: .info,
            message: "New feature coming soon! Prepare yourself for the release next month with enhanced icon alignment options.",
            actionText: "Try again",
            iconAlignment: .baseline,
            dismissBehavior: .sticky,
            onAction: { print("Info action tapped") },
            onDismiss: { print("Info dismissed") }
        )
        .nimbusNotification(
            isPresented: $showSuccess,
            type: .success,
            message: "Congratulations! Your payment is completed successfully.",
            actionText: "Check details",
            dismissBehavior: .sticky,
            onAction: { print("Success action tapped") },
            onDismiss: { print("Success dismissed") }
        )
        .nimbusNotification(
            isPresented: $showWarning,
            type: .warning,
            message: "Action needed! Update payment information in your profile.",
            actionText: "Edit Profile",
            dismissBehavior: .sticky,
            onAction: { print("Warning action tapped") },
            onDismiss: { print("Warning dismissed") }
        )
        .nimbusNotification(
            isPresented: $showError,
            type: .error,
            message: "Something went wrong! We failed to complete your payment.",
            actionText: "Try again",
            dismissBehavior: .sticky,
            onAction: { print("Error action tapped") },
            onDismiss: { print("Error dismissed") }
        )
        .nimbusNotification(
            isPresented: $showTemporary,
            type: .success,
            message: "This notification will auto-dismiss in 3 seconds!",
            dismissBehavior: .temporary(3.0),
            onDismiss: { print("Temporary notification dismissed") }
        )
    }
}