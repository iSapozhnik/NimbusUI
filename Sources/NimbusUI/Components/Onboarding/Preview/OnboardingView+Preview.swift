//
//  OnboardingView+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

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