//
//  Badge+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Badge Convenience Modifiers for PrimaryBadge

public extension PrimaryBadge {
    /// Sets the badge shape type
    func badgeType(_ type: BadgeType) -> some View {
        environment(\.nimbusBadgeType, type)
    }
    
    /// Sets the badge border width
    func borderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusBadgeBorderWidth, width)
    }
    
    /// Sets the badge content padding with EdgeInsets for maximum flexibility
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusBadgeContentPadding, padding)
    }
    
    /// Sets the badge content padding with individual values
    func contentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform badge content padding
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
    
    /// Convenience method to set capsule shape
    func capsule() -> some View {
        environment(\.nimbusBadgeType, .capsule)
    }
    
    /// Convenience method to set rounded rectangle shape with custom radius
    func roundedRect(_ radius: CGFloat) -> some View {
        environment(\.nimbusBadgeType, .roundedRect(radius))
    }
}

// MARK: - Badge Convenience Modifiers for SecondaryBadge

public extension SecondaryBadge {
    /// Sets the badge shape type
    func badgeType(_ type: BadgeType) -> some View {
        environment(\.nimbusBadgeType, type)
    }
    
    /// Sets the badge border width
    func borderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusBadgeBorderWidth, width)
    }
    
    /// Sets the badge content padding with EdgeInsets for maximum flexibility
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusBadgeContentPadding, padding)
    }
    
    /// Sets the badge content padding with individual values
    func contentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform badge content padding
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
    
    /// Convenience method to set capsule shape
    func capsule() -> some View {
        environment(\.nimbusBadgeType, .capsule)
    }
    
    /// Convenience method to set rounded rectangle shape with custom radius
    func roundedRect(_ radius: CGFloat) -> some View {
        environment(\.nimbusBadgeType, .roundedRect(radius))
    }
}

// MARK: - Generic Badge Convenience Extensions

public extension View {
    /// Sets the badge shape type for any badge component
    func badgeType(_ type: BadgeType) -> some View {
        environment(\.nimbusBadgeType, type)
    }
    
    /// Sets the badge border width for any badge component (different name to avoid conflicts)
    func badgeBorderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusBadgeBorderWidth, width)
    }
    
    /// Sets the badge content padding for any badge component
    func badgeContentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusBadgeContentPadding, padding)
    }
    
    /// Sets the badge content padding with individual values for any badge component
    func badgeContentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform badge content padding for any badge component
    func badgeContentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
    
    /// Sets the badge content padding with EdgeInsets for any badge component
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusBadgeContentPadding, padding)
    }
    
    /// Sets the badge content padding with individual values for any badge component
    func contentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform badge content padding for any badge component
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusBadgeContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
}