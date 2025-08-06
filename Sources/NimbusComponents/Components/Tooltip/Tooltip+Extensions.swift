//
//  Tooltip+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Tooltip Convenience Modifiers for NimbusTooltip Component

public extension NimbusTooltip {
    // MARK: - Core Customization
    
    /// Sets the tooltip corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusTooltipCornerRadii, radii)
    }
    
    /// Sets the tooltip elevation level for shadows
    func elevation(_ level: Elevation) -> some View {
        environment(\.nimbusTooltipElevation, level)
    }
    
    /// Sets the tooltip padding around content
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusTooltipContentPadding, padding)
    }
    
    /// Sets the tooltip arrow size
    func arrowSize(_ size: CGFloat) -> some View {
        environment(\.nimbusTooltipArrowSize, size)
    }
    
    /// Sets the tooltip offset distance from anchor view
    func offsetDistance(_ distance: CGFloat) -> some View {
        environment(\.nimbusTooltipOffsetDistance, distance)
    }
    
    // MARK: - Typography Configuration
    
    /// Sets the tooltip title font weight
    func titleFontWeight(_ weight: Font.Weight) -> some View {
        environment(\.nimbusTooltipTitleFontWeight, weight)
    }
    
    /// Sets the tooltip subtitle font weight
    func subtitleFontWeight(_ weight: Font.Weight) -> some View {
        environment(\.nimbusTooltipSubtitleFontWeight, weight)
    }
    
    /// Sets the tooltip title font size
    func titleFontSize(_ size: CGFloat) -> some View {
        environment(\.nimbusTooltipTitleFontSize, size)
    }
    
    /// Sets the tooltip subtitle font size
    func subtitleFontSize(_ size: CGFloat) -> some View {
        environment(\.nimbusTooltipSubtitleFontSize, size)
    }
    
    // MARK: - Spacing Configuration
    
    /// Sets the spacing between title and subtitle
    func contentSpacing(_ spacing: CGFloat) -> some View {
        environment(\.nimbusTooltipContentSpacing, spacing)
    }
    
    /// Sets the spacing between icon and text content
    func iconSpacing(_ spacing: CGFloat) -> some View {
        environment(\.nimbusTooltipIconSpacing, spacing)
    }
    
    /// Sets the tooltip icon size
    func iconSize(_ size: CGFloat) -> some View {
        environment(\.nimbusTooltipIconSize, size)
    }
    
    // MARK: - Animation Configuration
    
    /// Sets the hover delay before showing tooltip
    func hoverDelay(_ delay: TimeInterval) -> some View {
        environment(\.nimbusTooltipHoverDelay, delay)
    }
    
    /// Sets the animation for tooltip appearance
    func showAnimation(_ animation: Animation) -> some View {
        environment(\.nimbusTooltipShowAnimation, animation)
    }
    
    /// Sets the animation for tooltip disappearance
    func hideAnimation(_ animation: Animation) -> some View {
        environment(\.nimbusTooltipHideAnimation, animation)
    }
    
    // MARK: - Convenience Combinations
    
    /// Configures typography for both title and subtitle
    func typography(
        titleWeight: Font.Weight? = nil,
        subtitleWeight: Font.Weight? = nil,
        titleSize: CGFloat? = nil,
        subtitleSize: CGFloat? = nil
    ) -> some View {
        var result = AnyView(self)
        
        if let titleWeight = titleWeight {
            result = AnyView(result.environment(\.nimbusTooltipTitleFontWeight, titleWeight))
        }
        if let subtitleWeight = subtitleWeight {
            result = AnyView(result.environment(\.nimbusTooltipSubtitleFontWeight, subtitleWeight))
        }
        if let titleSize = titleSize {
            result = AnyView(result.environment(\.nimbusTooltipTitleFontSize, titleSize))
        }
        if let subtitleSize = subtitleSize {
            result = AnyView(result.environment(\.nimbusTooltipSubtitleFontSize, subtitleSize))
        }
        
        return result
    }
    
    /// Configures spacing for content and icon
    func spacing(content: CGFloat? = nil, icon: CGFloat? = nil) -> some View {
        var result = AnyView(self)
        
        if let contentSpacing = content {
            result = AnyView(result.environment(\.nimbusTooltipContentSpacing, contentSpacing))
        }
        if let iconSpacing = icon {
            result = AnyView(result.environment(\.nimbusTooltipIconSpacing, iconSpacing))
        }
        
        return result
    }
}

// MARK: - Generic Tooltip Convenience Extensions for Any View

public extension View {
    // MARK: - Tooltip Position Shortcuts
    
    /// Sets tooltip position to top
    func tooltipPosition(_ position: TooltipPosition) -> some View {
        // This is handled by the view modifier, but we provide a consistent API
        self
    }
    
    // MARK: - Tooltip Customization
    
    /// Sets the tooltip background color
    func tooltipBackgroundColor(_ color: Color) -> some View {
        environment(\.nimbusTooltipBackgroundColor, color)
    }
    
    /// Sets the tooltip foreground color
    func tooltipForegroundColor(_ color: Color) -> some View {
        environment(\.nimbusTooltipForegroundColor, color)
    }
    
    /// Sets the tooltip corner radii for any tooltip
    func tooltipCornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusTooltipCornerRadii, radii)
    }
    
    /// Sets the tooltip elevation for any tooltip
    func tooltipElevation(_ level: Elevation) -> some View {
        environment(\.nimbusTooltipElevation, level)
    }
    
    /// Sets the tooltip padding for any tooltip
    func tooltipPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusTooltipContentPadding, padding)
    }
    
    /// Sets the tooltip arrow size for any tooltip
    func tooltipArrowSize(_ size: CGFloat) -> some View {
        environment(\.nimbusTooltipArrowSize, size)
    }
    
    /// Sets the tooltip offset distance for any tooltip
    func tooltipOffsetDistance(_ distance: CGFloat) -> some View {
        environment(\.nimbusTooltipOffsetDistance, distance)
    }
    
    /// Sets the tooltip hover delay for any tooltip
    func tooltipHoverDelay(_ delay: TimeInterval) -> some View {
        environment(\.nimbusTooltipHoverDelay, delay)
    }
    
    // MARK: - Combined Configuration
    
    /// Configures multiple tooltip properties at once
    func tooltipConfiguration(
        cornerRadii: RectangleCornerRadii? = nil,
        elevation: Elevation? = nil,
        padding: EdgeInsets? = nil,
        hoverDelay: TimeInterval? = nil,
        adaptivePositioning: Bool? = nil
    ) -> some View {
        var result = AnyView(self)
        
        if let cornerRadii = cornerRadii {
            result = AnyView(result.environment(\.nimbusTooltipCornerRadii, cornerRadii))
        }
        if let elevation = elevation {
            result = AnyView(result.environment(\.nimbusTooltipElevation, elevation))
        }
        if let padding = padding {
            result = AnyView(result.environment(\.nimbusTooltipContentPadding, padding))
        }
        if let hoverDelay = hoverDelay {
            result = AnyView(result.environment(\.nimbusTooltipHoverDelay, hoverDelay))
        }
        if let adaptivePositioning = adaptivePositioning {
            result = AnyView(result.environment(\.nimbusTooltipAdaptivePositioning, adaptivePositioning))
        }
        
        return result
    }
    
    // MARK: - Adaptive Positioning Configuration
    
    /// Enables adaptive positioning for tooltips
    func adaptivePositioning(_ enabled: Bool = true) -> some View {
        environment(\.nimbusTooltipAdaptivePositioning, enabled)
    }
}
