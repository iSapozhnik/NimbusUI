//
//  NimbusToggle+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Toggle Convenience Methods

public extension View {
    /// Sets the knob size for toggles
    /// - Parameter size: The size to apply to toggle knobs (diameter for circular knobs)
    /// - Returns: A view with the specified toggle knob size applied
    func toggleKnobSize(_ size: CGFloat) -> some View {
        environment(\.nimbusToggleKnobSize, size)
    }
    
    /// Sets the padding around the toggle knob
    /// - Parameter padding: The padding to apply around toggle knobs inside the track
    /// - Returns: A view with the specified toggle knob padding applied
    func toggleKnobPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusToggleKnobPadding, padding)
    }
    
    /// Sets the toggle shape for both knob and track
    /// - Parameter shape: The toggle shape to apply
    /// - Returns: A view with the specified toggle shape applied
    func toggleShape(_ shape: NimbusToggleShape) -> some View {
        let shapeString: String
        switch shape {
        case .circle:
            shapeString = "circle"
        case .square:
            shapeString = "square"
        case .pill:
            shapeString = "pill"
        case .roundedRect(let radius):
            shapeString = "roundedRect(\(radius))"
        }
        return environment(\.nimbusToggleShape, shapeString)
    }
    
    /// Sets the toggle track width (overrides auto-calculated width)
    /// - Parameter width: The track width to apply to toggles
    /// - Returns: A view with the specified toggle track width applied
    func trackWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusToggleTrackWidth, width)
    }
    
    /// Sets the toggle track height (overrides auto-calculated height)
    /// - Parameter height: The track height to apply to toggles
    /// - Returns: A view with the specified toggle track height applied
    func trackHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusToggleTrackHeight, height)
    }
    
    /// Sets the animation spring for toggle knob movement
    /// - Parameter spring: The animation spring to apply to toggle transitions
    /// - Returns: A view with the specified toggle animation applied
    func toggleAnimation(_ spring: Animation) -> some View {
        environment(\.nimbusToggleAnimationSpring, spring)
    }
    
    /// Sets the spacing between toggle and text in toggle items
    /// - Parameter spacing: The spacing to apply between toggle and text
    /// - Returns: A view with the specified toggle item spacing applied
    func toggleItemSpacing(_ spacing: CGFloat) -> some View {
        environment(\.nimbusToggleItemSpacing, spacing)
    }
    
    /// Sets the spacing between title and subtitle in toggle items
    /// - Parameter spacing: The spacing to apply between title and subtitle text
    /// - Returns: A view with the specified toggle text spacing applied
    func toggleTextSpacing(_ spacing: CGFloat) -> some View {
        environment(\.nimbusToggleItemTextSpacing, spacing)
    }
    
    /// Sets the padding around toggle items
    /// - Parameter padding: The padding to apply around toggle items
    /// - Returns: A view with the specified toggle item padding applied
    func toggleItemPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusToggleItemPadding, padding)
    }
    
    /// Sets the minimum height for toggle items
    /// - Parameter height: The minimum height to apply to toggle items
    /// - Returns: A view with the specified toggle item minimum height applied
    func toggleItemMinHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusToggleItemMinHeight, height)
    }
}

// MARK: - Toggle Shape Convenience Methods

public extension View {
    /// Sets the toggle to use a circular knob and capsule track (traditional iOS style)
    /// - Returns: A view with circular toggle shape applied
    func circularToggle() -> some View {
        toggleShape(.circle)
    }
    
    /// Sets the toggle to use a square knob and rounded rectangle track
    /// - Returns: A view with square toggle shape applied
    func squareToggle() -> some View {
        toggleShape(.square)
    }
    
    /// Sets the toggle to use fully rounded knob and track (pill-shaped)
    /// - Returns: A view with pill toggle shape applied
    func pillToggle() -> some View {
        toggleShape(.pill)
    }
    
    /// Sets the toggle to use a rounded rectangle knob with specified corner radius
    /// - Parameter cornerRadius: The corner radius for the knob and track
    /// - Returns: A view with rounded rectangle toggle shape applied
    func roundedToggle(cornerRadius: CGFloat) -> some View {
        toggleShape(.roundedRect(cornerRadius))
    }
}

// MARK: - Toggle Animation Convenience Methods

public extension View {
    /// Sets the toggle to use a bouncy spring animation
    /// - Returns: A view with bouncy toggle animation applied
    func bouncyToggle() -> some View {
        toggleAnimation(.bouncy(duration: 0.4))
    }
    
    /// Sets the toggle to use a smooth spring animation
    /// - Returns: A view with smooth toggle animation applied
    func smoothToggle() -> some View {
        toggleAnimation(.spring(duration: 0.3, bounce: 0.2))
    }
    
    /// Sets the toggle to use a quick easeInOut animation
    /// - Returns: A view with quick toggle animation applied
    func quickToggle() -> some View {
        toggleAnimation(.easeInOut(duration: 0.2))
    }
}

// MARK: - Toggle Size Convenience Methods

public extension View {
    /// Configures toggle for large size usage
    /// - Returns: A view with large toggle configuration applied
    func largeToggle() -> some View {
        self
            .toggleKnobSize(24)
            .toggleKnobPadding(6)
    }
    
    /// Configures toggle for regular size usage (default)
    /// - Returns: A view with regular toggle configuration applied
    func regularToggle() -> some View {
        self
            .toggleKnobSize(20)
            .toggleKnobPadding(4)
    }
    
    /// Configures toggle for small size usage
    /// - Returns: A view with small toggle configuration applied
    func smallToggle() -> some View {
        self
            .toggleKnobSize(16)
            .toggleKnobPadding(3)
    }
    
    /// Configures toggle for mini size usage
    /// - Returns: A view with mini toggle configuration applied
    func miniToggle() -> some View {
        self
            .toggleKnobSize(12)
            .toggleKnobPadding(2)
    }
}

// MARK: - Toggle Configuration Combinations

public extension View {
    // Note: Complex configuration methods removed due to SwiftUI type system limitations
    // Users can chain individual methods like .toggleShape().toggleKnobSize().toggleKnobPadding()
}