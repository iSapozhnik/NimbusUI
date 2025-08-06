//
//  NimbusToggleShape.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI

extension NimbusToggleShape {
    
    /// Returns the appropriate knob shape for the given size
    public func knobShape(for size: CGFloat) -> AnyShape {
        switch self {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(Rectangle())
        case .roundedRect(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
    
    /// Returns the appropriate track shape based on the knob shape and dimensions
    public func trackShape(
        knobSize: CGFloat,
        knobPadding: CGFloat,
        trackWidth: CGFloat,
        trackHeight: CGFloat
    ) -> AnyShape {
        switch self {
        case .circle:
            // Traditional iOS style - capsule track for circular knob
            return AnyShape(Capsule())
        case .square:
            // Subtle rounding for square knobs to soften the appearance
            return AnyShape(Rectangle())
        case .roundedRect(let cornerRadius):
            // Match the knob corner radius but account for padding
            let trackCornerRadius = cornerRadius + knobPadding
            return AnyShape(RoundedRectangle(cornerRadius: trackCornerRadius))
        }
    }
    
    /// Calculates the recommended track width based on knob size and padding
    public func recommendedTrackWidth(knobSize: CGFloat, knobPadding: CGFloat) -> CGFloat {
        switch self {
        case .circle:
            // Traditional toggle ratio - track width should be about 1.8x knob diameter
            return knobSize * 1.8 + (knobPadding * 2)
        case .square, .roundedRect:
            // Slightly wider for non-circular shapes to provide good travel distance
            return knobSize * 2.0 + (knobPadding * 2)
        }
    }
    
    /// Calculates the track height based on knob size and padding
    public func trackHeight(knobSize: CGFloat, knobPadding: CGFloat) -> CGFloat {
        return knobSize + (knobPadding * 2)
    }
    
    /// Returns the horizontal travel distance for the knob animation
    public func knobTravelDistance(
        trackWidth: CGFloat,
        knobSize: CGFloat,
        knobPadding: CGFloat
    ) -> CGFloat {
        return trackWidth - knobSize - (knobPadding * 2)
    }
    
    /// Returns the default corner radius for the knob shape (used internally)
    var defaultCornerRadius: CGFloat {
        switch self {
        case .circle:
            return 0
        case .square:
            return 0
        case .roundedRect(let cornerRadius):
            return cornerRadius
        }
    }
}
