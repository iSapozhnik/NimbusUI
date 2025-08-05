//
//  SecondaryBadge+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Secondary Badge Previews

#Preview("Secondary Badge - Semantic Types") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            SecondaryBadge("Info", semanticType: .info)
            SecondaryBadge("Success", semanticType: .success)
            SecondaryBadge("Warning", semanticType: .warning)
            SecondaryBadge("Error", semanticType: .error)
        }
        
        HStack(spacing: 12) {
            SecondaryBadge("New", systemImage: "star.fill", semanticType: .info)
            SecondaryBadge("Complete", systemImage: "checkmark.circle.fill", semanticType: .success)
            SecondaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
            SecondaryBadge("Failed", systemImage: "xmark.circle.fill", semanticType: .error)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Secondary Badge - Control Sizes") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            SecondaryBadge("Large", semanticType: .info)
                .controlSize(.large)
            SecondaryBadge("Regular", semanticType: .success)
                .controlSize(.regular)
            SecondaryBadge("Small", semanticType: .warning)
                .controlSize(.small)
            SecondaryBadge("Mini", semanticType: .error)
                .controlSize(.mini)
        }
        
        // With icons
        HStack(spacing: 12) {
            SecondaryBadge("L", systemImage: "star.fill", semanticType: .info)
                .controlSize(.large)
            SecondaryBadge("R", systemImage: "star.fill", semanticType: .success)
                .controlSize(.regular)
            SecondaryBadge("S", systemImage: "star.fill", semanticType: .warning)
                .controlSize(.small)
            SecondaryBadge("M", systemImage: "star.fill", semanticType: .error)
                .controlSize(.mini)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Secondary Badge - Badge Types & Border Width") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            SecondaryBadge("Capsule", semanticType: .info)
                .capsule()
            
            SecondaryBadge("Rounded 4", semanticType: .success)
                .roundedRect(4)
            
            SecondaryBadge("Rounded 8", semanticType: .warning)
                .roundedRect(8)
            
            SecondaryBadge("Rounded 12", semanticType: .error)
                .roundedRect(12)
        }
        
        // With custom border width
        HStack(spacing: 12) {
            SecondaryBadge("Border 1", semanticType: .info)
                .capsule()
                .borderWidth(1)
            
            SecondaryBadge("Border 2", semanticType: .success)
                .roundedRect(6)
                .borderWidth(2)
            
            SecondaryBadge("Border 3", semanticType: .warning)
                .roundedRect(8)
                .borderWidth(3)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Secondary Badge - Custom Padding") {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            SecondaryBadge("Default", semanticType: .info)
                .capsule()
            
            SecondaryBadge("Custom", semanticType: .success)
                .roundedRect(6)
                .contentPadding(top: 8, leading: 16, bottom: 8, trailing: 16)
            
            SecondaryBadge("Uniform", semanticType: .warning)
                .roundedRect(8)
                .contentPadding(12)
        }
        
        // Extreme padding examples
        HStack(spacing: 12) {
            SecondaryBadge("Tight", semanticType: .info)
                .roundedRect(4)
                .contentPadding(2)
            
            SecondaryBadge("Spacious", semanticType: .success)
                .roundedRect(8)
                .contentPadding(top: 12, leading: 20, bottom: 12, trailing: 20)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Secondary Badge - Long Text") {
    VStack(spacing: 16) {
        SecondaryBadge("This is a very long badge text to test wrapping", semanticType: .info)
            .capsule()
        
        SecondaryBadge("Another long text example", semanticType: .success)
            .roundedRect(8)
            .borderWidth(2)
        
        SecondaryBadge("Custom Long", systemImage: "star.fill", semanticType: .warning)
            .roundedRect(6)
            .controlSize(.large)
            .contentPadding(top: 8, leading: 16, bottom: 8, trailing: 16)
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Primary vs Secondary Comparison") {
    VStack(spacing: 24) {
        VStack(spacing: 8) {
            Text("Primary Badges (Solid)")
                .font(.headline)
            HStack(spacing: 12) {
                PrimaryBadge("Info", semanticType: .info)
                PrimaryBadge("Success", semanticType: .success)
                PrimaryBadge("Warning", semanticType: .warning)
                PrimaryBadge("Error", semanticType: .error)
            }
        }
        
        VStack(spacing: 8) {
            Text("Secondary Badges (Outlined)")
                .font(.headline)
            HStack(spacing: 12) {
                SecondaryBadge("Info", semanticType: .info)
                SecondaryBadge("Success", semanticType: .success)
                SecondaryBadge("Warning", semanticType: .warning)
                SecondaryBadge("Error", semanticType: .error)
            }
        }
        
        VStack(spacing: 8) {
            Text("Mixed Styles")
                .font(.headline)
            HStack(spacing: 12) {
                PrimaryBadge("Primary", semanticType: .info)
                    .roundedRect(6)
                SecondaryBadge("Secondary", semanticType: .info)
                    .roundedRect(6)
                    .borderWidth(2)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Secondary Badge - Different Themes") {
    ScrollView {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Text("Nimbus Theme")
                    .font(.headline)
                secondaryBadgeGrid
                    .environment(\.nimbusTheme, NimbusTheme.default)
            }
            
            VStack(spacing: 8) {
                Text("Maritime Theme")
                    .font(.headline)
                secondaryBadgeGrid
                    .environment(\.nimbusTheme, MaritimeTheme())
            }
            
            VStack(spacing: 8) {
                Text("Custom Warm Theme")
                    .font(.headline)
                secondaryBadgeGrid
                    .environment(\.nimbusTheme, CustomWarmTheme())
            }
        }
        .padding()
    }
}

private var secondaryBadgeGrid: some View {
    VStack(spacing: 12) {
        HStack(spacing: 12) {
            SecondaryBadge("Info", semanticType: .info)
            SecondaryBadge("Success", semanticType: .success)
            SecondaryBadge("Warning", semanticType: .warning)
            SecondaryBadge("Error", semanticType: .error)
        }
        
        HStack(spacing: 12) {
            SecondaryBadge("New", systemImage: "star.fill", semanticType: .info)
                .roundedRect(6)
                .borderWidth(1.5)
            SecondaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                .roundedRect(6)
                .borderWidth(1.5)
            SecondaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                .roundedRect(6)
                .borderWidth(1.5)
            SecondaryBadge("Error", systemImage: "xmark.circle.fill", semanticType: .error)
                .roundedRect(6)
                .borderWidth(1.5)
        }
    }
}