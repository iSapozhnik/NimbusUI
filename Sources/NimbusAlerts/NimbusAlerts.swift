//
//  NimbusAlerts.swift
//  NimbusAlerts
//
//  Created by Ivan Sapozhnik on 25.08.25.
//

import SwiftUI
@_exported import NimbusCore
@_exported import NimbusComponents

// This module provides the NimbusUI Alert system:
// - Modal and window-based alert presentation
// - Semantic alert styles (info, success, warning, error)
// - Full theming integration and customization
// - Both global window alerts and in-app modal alerts
// - SwiftUI View extension API for easy integration

// Re-export core types for convenience
public typealias NimbusTheming = NimbusCore.NimbusTheming
public typealias Elevation = NimbusCore.Elevation