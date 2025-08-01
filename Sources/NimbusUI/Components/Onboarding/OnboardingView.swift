//
//  SwiftUIView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI
import FluidGradient
import SmoothGradient

/// A model representing a single onboarding feature page.
public struct Feature: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let image: Image
    
    public init(
        title: String,
        description: String,
        image: Image
    ) {
        self.title = title
        self.description = description
        self.image = image
    }
}

/// A reusable onboarding view for macOS, displaying a sequence of features with page control and navigation.
public struct OnboardingView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) private var overrideContentPadding
    @Environment(\.nimbusAnimationFast) private var overrideFastAnimation
    
    public let features: [Feature]
    @State private var currentIndex: Int = 0
    
    public init(features: [Feature]) {
        self.features = features
    }
    
    public var body: some View {
        let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
        let fastAnimation = overrideFastAnimation ?? theme.animationFast
        
        ZStack {
            FluidGradient(blobs: [.red, .green, .blue],
                          highlights: [.yellow, .orange, .purple],
                          speed: 1,
                          blur: 0.75)
            .overlay(
                LinearGradient(
                    gradient: .smooth(from: theme.backgroundColor(for: colorScheme).opacity(0), to: theme.backgroundColor(for: colorScheme), curve: .easeInOut), // ⬅️
                            startPoint: .top,
                            endPoint: .bottom
                    )
            )
            .overlay(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 24) {
                    FeaturePageView(feature: features[currentIndex])
                        
                    Spacer()
                    PageControlView(currentIndex: currentIndex, total: features.count)
                    HStack {
                        Button(action: {
                            withAnimation(fastAnimation) {
                                if currentIndex < features.count - 1 {
                                    currentIndex += 1
                                }
                            }
                        }) {
                            let isLast = currentIndex == features.count - 1
                            Label(isLast ? "Finish" : "Continue", systemImage: isLast ? "checkmark" : "arrow.right")
                                .labelStyle(
                                    NimbusDividerLabelStyle(
                                        hasDivider: true,
                                        iconAlignment: .trailing,
                                        contentHorizontalPadding: contentPadding
                                    )
                                )
                        }
                        .buttonStyle(.primaryProminent)
                        .frame(height: 40)
                        .modifier(NimbusAspectRatioModifier())
                        Spacer()
                    }
                }
                .padding(80)
            }
        }
        .frame(width: 600, height: 560)
    }
}

#if DEBUG
#Preview {
    let features = [
        Feature(
            title: "Welcome to Launchy",
            description: "Fast and easy app launcher and switcher, with a lot of features and customization options",
            image: Image(systemName: "sparkles")
        ),
        Feature(
            title: "Organize Your Apps",
            description: "Effortlessly group your most-used applications into custom folders for even faster access. Keep your workspace tidy and find what you need in an instant.",
            image: Image(systemName: "folder")
        ),
        Feature(
            title: "Customize",
            description: "Personalize your launcher with themes and shortcuts.",
            image: Image(systemName: "paintbrush")
        ),
        Feature(
            title: "Quick Search",
            description: "Find and launch any app instantly with powerful search and filtering capabilities.",
            image: Image(systemName: "magnifyingglass")
        ),
        Feature(
            title: "Keyboard Shortcuts",
            description: "Boost your productivity by launching and switching apps using customizable keyboard shortcuts.",
            image: Image(systemName: "command")
        ),
        Feature(
            title: "Seamless Integration",
            description: "Integrates smoothly with your workflow and supports drag-and-drop for easy app management.",
            image: Image(systemName: "arrow.triangle.branch")
        ),
        Feature(
            title: "Light & Dark Mode",
            description: "Enjoy a beautiful interface that adapts to your system appearance, day or night.",
            image: Image(systemName: "moon.stars")
        )
    ]
    return OnboardingView(features: features)
        .environment(\.nimbusTheme, NimbusTheme())
}
#endif
