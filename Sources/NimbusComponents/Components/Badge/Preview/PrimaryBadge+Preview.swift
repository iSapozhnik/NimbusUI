//
//  PrimaryBadge+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Primary Badge Previews

#Preview("Primary Badge - Semantic Types") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            PrimaryBadge("Info", semanticType: .info)
            PrimaryBadge("Success", semanticType: .success)
            PrimaryBadge("Warning", semanticType: .warning)
            PrimaryBadge("Error", semanticType: .error)
        }
        
        HStack(spacing: 12) {
            PrimaryBadge("New", systemImage: "star.fill", semanticType: .info)
            PrimaryBadge("Complete", systemImage: "checkmark.circle.fill", semanticType: .success)
            PrimaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
            PrimaryBadge("Failed", systemImage: "xmark.circle.fill", semanticType: .error)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Primary Badge - Control Sizes") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            PrimaryBadge("Large", semanticType: .info)
                .controlSize(.large)
            PrimaryBadge("Regular", semanticType: .success)
                .controlSize(.regular)
            PrimaryBadge("Small", semanticType: .warning)
                .controlSize(.small)
            PrimaryBadge("Mini", semanticType: .error)
                .controlSize(.mini)
        }
        
        // With icons
        HStack(spacing: 12) {
            PrimaryBadge("L", systemImage: "star.fill", semanticType: .info)
                .controlSize(.large)
            PrimaryBadge("R", systemImage: "star.fill", semanticType: .success)
                .controlSize(.regular)
            PrimaryBadge("S", systemImage: "star.fill", semanticType: .warning)
                .controlSize(.small)
            PrimaryBadge("M", systemImage: "star.fill", semanticType: .error)
                .controlSize(.mini)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Primary Badge - Badge Types") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            PrimaryBadge("Capsule", semanticType: .info)
                .capsule()
            
            PrimaryBadge("Rounded 4", semanticType: .success)
                .roundedRect(4)
            
            PrimaryBadge("Rounded 8", semanticType: .warning)
                .roundedRect(8)
            
            PrimaryBadge("Rounded 12", semanticType: .error)
                .roundedRect(12)
        }
        
        // With custom padding
        HStack(spacing: 12) {
            PrimaryBadge("Default Padding", semanticType: .info)
                .capsule()
            
            PrimaryBadge("Custom Padding", semanticType: .success)
                .roundedRect(6)
                .contentPadding(top: 8, leading: 16, bottom: 8, trailing: 16)
            
            PrimaryBadge("Uniform Padding", semanticType: .warning)
                .roundedRect(8)
                .contentPadding(12)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Primary Badge - Long Text") {
    VStack(spacing: 16) {
        PrimaryBadge("This is a very long badge text to test wrapping", semanticType: .info)
            .capsule()
        
        PrimaryBadge("Another long text example", semanticType: .success)
            .roundedRect(8)
        
        PrimaryBadge("Custom Long", systemImage: "star.fill", semanticType: .warning)
            .roundedRect(6)
            .controlSize(.large)
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Primary Badge - Different Themes") {
    ScrollView {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text("Nimbus Theme")
                    .font(.headline)
                badgeGrid
                    .environment(\.nimbusTheme, NimbusTheme.default)
            }
            
            VStack(spacing: 8) {
                Text("Maritime Theme")
                    .font(.headline)
                badgeGrid
                    .environment(\.nimbusTheme, MaritimeTheme())
            }
            
            VStack(spacing: 8) {
                Text("Custom Warm Theme")
                    .font(.headline)
                badgeGrid
                    .environment(\.nimbusTheme, CustomWarmTheme())
            }
        }
        .padding()
    }
}

private var badgeGrid: some View {
    VStack(spacing: 12) {
        HStack(spacing: 12) {
            PrimaryBadge("Info", semanticType: .info)
            PrimaryBadge("Success", semanticType: .success)
            PrimaryBadge("Warning", semanticType: .warning)
            PrimaryBadge("Error", semanticType: .error)
        }
        
        HStack(spacing: 12) {
            PrimaryBadge("New", systemImage: "star.fill", semanticType: .info)
                .roundedRect(6)
            PrimaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                .roundedRect(6)
            PrimaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                .roundedRect(6)
            PrimaryBadge("Error", systemImage: "xmark.circle.fill", semanticType: .error)
                .roundedRect(6)
        }
    }
}