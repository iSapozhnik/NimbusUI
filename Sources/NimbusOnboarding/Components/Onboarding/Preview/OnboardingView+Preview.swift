//
//  OnboardingView+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI
import NimbusComponents

// MARK: - Previews

#if DEBUG
#Preview("Mixed Content Features") {
    let features: [AnyFeature] = [
        // Standard image feature
        AnyFeature.imageFeature(
            title: "Welcome to Launchy",
            description: "Fast and easy app launcher and switcher, with a lot of features and customization options",
            image: Image(systemName: "sparkles"),
            imageSize: 100
        ),
        
        // Icon feature with custom size
        AnyFeature.iconFeature(
            title: "Quick Search",
            description: "Find and launch any app instantly with powerful search and filtering capabilities.",
            systemName: "magnifyingglass",
            iconSize: 80
        ),
        
        // Custom gradient content
        AnyFeature(
            title: "Beautiful Design",
            description: "Experience a stunning interface with smooth gradients and modern animations."
        ) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 120, height: 120)
                .levitatingFeatureContent()
        },
        
        // Complex custom view with multiple elements
        AnyFeature(
            title: "Advanced Features",
            description: "Unlock powerful capabilities with our comprehensive feature set designed for productivity."
        ) {
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: "gear")
                        .foregroundColor(.blue)
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
                .font(.title)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 80, height: 40)
                    .overlay(
                        Text("Pro")
                            .font(.caption)
                            .bold()
                    )
            }
            .levitatingFeatureContent()
        },
        
        // Animated content
        AnyFeature(
            title: "Smooth Animations",
            description: "Enjoy fluid transitions and delightful micro-interactions throughout your workflow."
        ) {
            Circle()
                .fill(Color.green.gradient)
                .frame(width: 80, height: 80)
                .scaleFeatureContent(scale: 1.2, duration: 1.5)
        },
        
        // Simple icon feature
        AnyFeature.iconFeature(
            title: "Keyboard Shortcuts",
            description: "Boost your productivity by launching and switching apps using customizable keyboard shortcuts.",
            systemName: "command",
            iconSize: 70
        ),
        
        // Custom form feature with NimbusUI components
        AnyFeature(
            title: "Setup Your Account",
            description: "Complete your profile to personalize your experience and unlock all features."
        ) {
            FormContentView()
        },
        
        // Final feature with custom content
        AnyFeature(
            title: "Ready to Start?",
            description: "Join thousands of users who have transformed their productivity with our powerful tools."
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
            }
            .levitatingFeatureContent()
        }
    ]
    
    return OnboardingView(features: features)
        .environment(\.nimbusTheme, NimbusTheme())
}

#Preview("Image Features Only") {
    let imageFeatures: [AnyFeature] = [
        AnyFeature.imageFeature(
            title: "Organize Your Apps",
            description: "Effortlessly group your most-used applications into custom folders for even faster access.",
            image: Image(systemName: "folder")
        ),
        AnyFeature.imageFeature(
            title: "Customize",
            description: "Personalize your launcher with themes and shortcuts.",
            image: Image(systemName: "paintbrush")
        ),
        AnyFeature.imageFeature(
            title: "Light & Dark Mode",
            description: "Enjoy a beautiful interface that adapts to your system appearance, day or night.",
            image: Image(systemName: "moon.stars")
        )
    ]
    
    return OnboardingView(features: imageFeatures)
        .environment(\.nimbusTheme, NimbusTheme())
}

#Preview("Custom Views Only") {
    let customFeatures: [AnyFeature] = [
        AnyFeature(
            title: "Dashboard",
            description: "Monitor your productivity with beautiful charts and insights."
        ) {
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.blue)
                            .frame(width: 8, height: CGFloat.random(in: 20...60))
                    }
                }
                Text("Analytics")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        },
        
        AnyFeature(
            title: "Collaboration",
            description: "Work together seamlessly with real-time sharing and communication tools."
        ) {
            HStack(spacing: -8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill([Color.red, Color.green, Color.blue][index])
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
            }
        }
    ]
    
    return OnboardingView(features: customFeatures)
        .environment(\.nimbusTheme, NimbusTheme())
}

// MARK: - Custom Form Content View

private struct FormContentView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var company = ""
    
    var body: some View {
        VStack(spacing: 12) {
            // Header section
            VStack(alignment: .leading, spacing: 6) {
                Text("Create Your Profile")
                    .font(.headline)
                    .fontWeight(.semibold)
                Text("Enter your details to get started")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Input fields section
            VStack(spacing: 14) {
                NimbusTextField("Full Name", text: $fullName)
                    .controlSize(.regular)
            }
            
            // Action buttons section
            HStack(spacing: 12) {
                Button("Reset", role: .destructive) {}
                .buttonStyle(.accent)
                .controlSize(.small)
                
                Spacer()
                
                Button("Continue") {}
                .buttonStyle(.accent)
                .controlSize(.small)
            }
        }
        .padding(24)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 4)
        )
        .allowsHitTesting(false)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 320)
    }
}

#endif
