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

// This module provides the NimbusUI onboarding system:
// - Beautiful onboarding flows with FluidGradient backgrounds
// - Smooth page navigation and transitions
// - Fixed dimensions for consistent presentation
// - Theme integration for customizable appearance
// - NSWindow integration for standalone display
// - Requires FluidGradient and SmoothGradient dependencies

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
        theme: (any NimbusTheming)? = nil
    ) -> OnboardingWindowController {
        let windowController = OnboardingWindowController(features: features, theme: theme)
        windowController.show()
        return windowController
    }
}
