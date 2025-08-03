//
//  NotificationPresentationStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

/// Defines how notifications are presented and animated on screen
public enum NotificationPresentationStyle: CaseIterable, Sendable {
    /// Slides in from the top edge (default behavior - maintains backward compatibility)
    case slideFromTop
    
    /// Fades in/out with pure opacity transition
    case fadeIn
    
    /// Slides in from the bottom edge
    case slideFromBottom
    
    /// Slides in from the leading (left) edge
    case slideFromLeading
    
    /// Slides in from the trailing (right) edge
    case slideFromTrailing
    
    /// Spring bounce animation from top with enhanced elasticity
    case bounce
    
    /// Scales up from center point combined with fade effect
    case scale
    
    /// Human-readable name for the presentation style
    public var displayName: String {
        switch self {
        case .slideFromTop:
            return "Slide from Top"
        case .fadeIn:
            return "Fade In"
        case .slideFromBottom:
            return "Slide from Bottom"
        case .slideFromLeading:
            return "Slide from Leading"
        case .slideFromTrailing:
            return "Slide from Trailing"
        case .bounce:
            return "Bounce"
        case .scale:
            return "Scale"
        }
    }
}
