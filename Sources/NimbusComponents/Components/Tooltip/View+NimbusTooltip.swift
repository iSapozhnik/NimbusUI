//
//  View+NimbusTooltip.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI

public extension View {
    /// Presents a tooltip overlay with customizable content and positioning
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls tooltip visibility
    ///   - title: The main title text to display
    ///   - subtitle: Optional subtitle text to display below the title
    ///   - icon: Optional icon to display alongside the text
    ///   - position: The position where the tooltip should appear relative to the anchor view (.top by default)
    ///   - hoverDelay: Custom delay before showing tooltip on hover (uses theme default if nil)
    ///   - onDismiss: Optional closure called when tooltip is dismissed
    /// - Returns: A view with the tooltip overlay
    func nimbusTooltip(
        isPresented: Binding<Bool>,
        title: String,
        subtitle: String? = nil,
        icon: Image? = nil,
        position: TooltipPosition = .top,
        hoverDelay: TimeInterval? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            TooltipModifier(
                isPresented: isPresented,
                title: title,
                subtitle: subtitle,
                icon: icon,
                position: position,
                hoverDelay: hoverDelay,
                enableHover: false, // Manual control via binding
                onDismiss: onDismiss
            )
        )
    }
    
    /// Presents a tooltip overlay with hover-based activation and automatic timing
    ///
    /// - Parameters:
    ///   - title: The main title text to display
    ///   - subtitle: Optional subtitle text to display below the title
    ///   - icon: Optional icon to display alongside the text
    ///   - position: The position where the tooltip should appear relative to the anchor view (.top by default)
    ///   - hoverDelay: Custom delay before showing tooltip on hover (uses theme default if nil)
    /// - Returns: A view with hover-activated tooltip overlay
    func nimbusTooltip(
        _ title: String,
        subtitle: String? = nil,
        icon: Image? = nil,
        position: TooltipPosition = .top,
        hoverDelay: TimeInterval? = nil
    ) -> some View {
        modifier(
            HoverTooltipModifier(
                title: title,
                subtitle: subtitle,
                icon: icon,
                position: position,
                hoverDelay: hoverDelay
            )
        )
    }
    
    /// Presents a simple tooltip with just title text and hover activation
    ///
    /// - Parameters:
    ///   - title: The title text to display
    ///   - position: The position where the tooltip should appear relative to the anchor view (.top by default)
    ///   - hoverDelay: Custom delay before showing tooltip on hover (uses theme default if nil)
    /// - Returns: A view with hover-activated tooltip overlay
    func nimbusTooltip(
        _ title: String,
        position: TooltipPosition = .top,
        hoverDelay: TimeInterval? = nil
    ) -> some View {
        modifier(
            HoverTooltipModifier(
                title: title,
                subtitle: nil,
                icon: nil,
                position: position,
                hoverDelay: hoverDelay
            )
        )
    }
}