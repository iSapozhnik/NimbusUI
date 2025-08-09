//
//  NimbusOnboarding.swift
//  NimbusOnboarding
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI
@_exported import NimbusCore
@_exported import NimbusComponents
import FluidGradient
import SmoothGradient

/// A namespace for onboarding-related functionality.
public enum NimbusOnboarding {
    /// Shows an onboarding window with the provided features.
    /// - Parameters:
    ///   - features: Array of onboarding features to display
    ///   - theme: Optional custom theme (defaults to NimbusTheme.default)
    /// - Returns: Window controller for manual management if needed
    @discardableResult
    public static func show(
        features: [AnyFeature], 
        theme: any NimbusTheming = NimbusTheme.default
    ) -> OnboardingWindowController {
        let windowController = OnboardingWindowController(features: features, theme: theme)
        windowController.show()
        return windowController
    }
}
