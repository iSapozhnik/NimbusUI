//
//  NotificationHandleView+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
#Preview("Notification Handle States") {
    VStack(spacing: 40) {
        VStack(spacing: 8) {
            Text("Visible Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
        }
        
        VStack(spacing: 8) {
            Text("Hidden Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(false))
        }
        
        VStack(spacing: 8) {
            Text("Interactive Demo")
                .font(.headline)
            HandleDemoView()
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Custom Handle Styling") {
    VStack(spacing: 40) {
        VStack(spacing: 8) {
            Text("Default Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
        }
        
        VStack(spacing: 8) {
            Text("Larger Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
                .environment(\.nimbusNotificationHandleWidth, 48)
                .environment(\.nimbusNotificationHandleHeight, 6)
        }
        
        VStack(spacing: 8) {
            Text("More Visible Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
                .environment(\.nimbusNotificationHandleOpacityVisible, 0.6)
        }
        
        VStack(spacing: 8) {
            Text("Sharp Corners Handle")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
                .environment(\.nimbusNotificationHandleCornerRadius, 0)
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Handle in Notification Context") {
    VStack(spacing: 16) {
        NotificationWithHandleDemo()
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Dark Mode Compatibility") {
    VStack(spacing: 40) {
        VStack(spacing: 8) {
            Text("Light Mode")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
        }
        .environment(\.colorScheme, .light)
        
        VStack(spacing: 8) {
            Text("Dark Mode")
                .font(.headline)
            NotificationHandleView(isVisible: .constant(true))
        }
        .environment(\.colorScheme, .dark)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Demo Views

@available(macOS 15.0, *)
struct HandleDemoView: View {
    @State private var isVisible = false
    
    var body: some View {
        VStack(spacing: 16) {
            NotificationHandleView(isVisible: $isVisible)
            
            Button(isVisible ? "Hide Handle" : "Show Handle") {
                isVisible.toggle()
            }
            .buttonStyle(.primary)
        }
    }
}

@available(macOS 15.0, *)
struct NotificationWithHandleDemo: View {
    @State private var isHovering = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Notification with Handle")
                .font(.headline)
            
            VStack(spacing: 12) {
                // Handle appears at the top when hovering
                NotificationHandleView(isVisible: $isHovering)
                
                // Mock notification content
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.blue)
                    
                    Text("This notification shows a handle when you hover over it.")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button("Action") { }
                        .buttonStyle(.nimbusLink)
                    
                    Button {
                        // Dismiss action
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.close)
                }
                .padding(16)
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 8))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isHovering = hovering
                }
            }
            
            Text("Hover over the notification to see the handle")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
