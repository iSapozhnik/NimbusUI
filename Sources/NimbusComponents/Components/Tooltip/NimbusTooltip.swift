//
//  NimbusTooltip.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

/// A tooltip component that displays contextual information with optional title, subtitle, and icon
public struct NimbusTooltip: View {
    private let title: String
    private let subtitle: String?
    private let icon: Image?
    private let position: TooltipPosition
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Tooltip-specific environment values with theme fallbacks
    @Environment(\.nimbusTooltipBackgroundColor) private var backgroundColor
    @Environment(\.nimbusTooltipForegroundColor) private var foregroundColor
    @Environment(\.nimbusTooltipCornerRadii) private var cornerRadii
    @Environment(\.nimbusTooltipElevation) private var elevation
    @Environment(\.nimbusTooltipArrowSize) private var arrowSize
    @Environment(\.nimbusTooltipTitleFontWeight) private var titleFontWeight
    @Environment(\.nimbusTooltipSubtitleFontWeight) private var subtitleFontWeight
    @Environment(\.nimbusTooltipTitleFontSize) private var titleFontSize
    @Environment(\.nimbusTooltipSubtitleFontSize) private var subtitleFontSize
    @Environment(\.nimbusTooltipContentSpacing) private var contentSpacing
    @Environment(\.nimbusTooltipContentPadding) private var contentPadding
    @Environment(\.nimbusTooltipIconSpacing) private var iconSpacing
    @Environment(\.nimbusTooltipIconSize) private var iconSize
    
    public init(
        title: String,
        subtitle: String? = nil,
        icon: Image? = nil,
        position: TooltipPosition = .top
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.position = position
    }
    
    public var body: some View {
        // Main tooltip content
        contentView
            .padding(effectivePadding)
//            .frame(maxWidth: effectiveMaxWidth)
            .background(
                RoundedRectangle(cornerRadius: effectiveCornerRadii.topLeading, style: .continuous)
                    .fill(effectiveBackgroundColor)
            )
            .overlay(alignment: arrowAlignment) {
                // Arrow positioned at the edge of the tooltip
                arrow
            }
    }
    
    // MARK: - Private Views
    
    private var contentView: some View {
        HStack(spacing: effectiveIconSpacing) {
            if let icon = icon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: effectiveIconSize, height: effectiveIconSize)
                    .foregroundColor(effectiveForegroundColor)
            }
            
            VStack(alignment: .leading, spacing: effectiveContentSpacing) {
                Text(title)
                    .font(.system(size: effectiveTitleFontSize, weight: effectiveTitleFontWeight))
                    .foregroundColor(effectiveForegroundColor)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: effectiveSubtitleFontSize, weight: effectiveSubtitleFontWeight))
                        .foregroundColor(effectiveForegroundColor)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var arrow: some View {
        Triangle()
            .fill(effectiveBackgroundColor)
            .frame(width: effectiveArrowSize, height: effectiveArrowSize)
            .rotationEffect(position.arrowRotation)
            .offset(arrowOffset)
    }
    
    // MARK: - Private Computed Properties
    
    private var effectiveBackgroundColor: Color {
        backgroundColor ?? theme.tooltipBackgroundColor(for: colorScheme)
    }
    
    private var effectiveForegroundColor: Color {
        foregroundColor ?? theme.tooltipTextColor(for: colorScheme)
    }
    
    private var effectiveCornerRadii: RectangleCornerRadii {
        cornerRadii ?? theme.tooltipCornerRadii
    }
    
    private var effectiveElevation: Elevation {
        elevation ?? theme.tooltipElevation
    }
    
    private var effectivePadding: EdgeInsets {
        contentPadding ?? theme.tooltipContentPadding
    }
    
    private var effectiveArrowSize: CGFloat {
        arrowSize ?? theme.tooltipArrowSize
    }
    
    private var effectiveTitleFontWeight: Font.Weight {
        titleFontWeight ?? theme.tooltipTitleFontWeight
    }
    
    private var effectiveSubtitleFontWeight: Font.Weight {
        subtitleFontWeight ?? theme.tooltipSubtitleFontWeight
    }
    
    private var effectiveTitleFontSize: CGFloat {
        titleFontSize ?? theme.tooltipTitleFontSize
    }
    
    private var effectiveSubtitleFontSize: CGFloat {
        subtitleFontSize ?? theme.tooltipSubtitleFontSize
    }
    
    private var effectiveContentSpacing: CGFloat {
        contentSpacing ?? theme.tooltipContentSpacing
    }
    
    private var effectiveIconSpacing: CGFloat {
        iconSpacing ?? theme.tooltipIconSpacing
    }
    
    private var effectiveIconSize: CGFloat {
        iconSize ?? theme.tooltipIconSize
    }
    
    /// Returns the alignment for positioning the arrow at the tooltip edge
    private var arrowAlignment: Alignment {
        switch position {
        case .top:
            return .bottom // Arrow at bottom edge when tooltip is above
        case .bottom:
            return .top    // Arrow at top edge when tooltip is below
        case .leading:
            return .trailing // Arrow at trailing edge when tooltip is to the left
        case .trailing:
            return .leading  // Arrow at leading edge when tooltip is to the right
        }
    }
    
    private var arrowOffset: CGSize {
        let fullArrow = effectiveArrowSize
        
        switch position {
        case .top:
            // Arrow at bottom edge, push it FULLY outside the tooltip
            return CGSize(width: 0, height: fullArrow)
        case .bottom:
            // Arrow at top edge, push it FULLY outside the tooltip  
            return CGSize(width: 0, height: -fullArrow)
        case .leading:
            // Arrow at trailing edge, push it FULLY outside the tooltip
            return CGSize(width: fullArrow, height: 0)
        case .trailing:
            // Arrow at leading edge, push it FULLY outside the tooltip
            return CGSize(width: -fullArrow, height: 0)
        }
    }
}

// MARK: - Triangle Arrow Shape

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        // Create a wider-based triangle for better visual connection
        // The base should be wider than the height for better proportion
        let baseWidth = width * 2
        let centerX = width / 2
        let leftBase = centerX - baseWidth / 2
        let rightBase = centerX + baseWidth / 2
        
        // Start at the tip (pointing upward in default orientation)
        path.move(to: CGPoint(x: centerX, y: 0))
        // Draw to left base corner
        path.addLine(to: CGPoint(x: leftBase, y: height))
        // Draw to right base corner
        path.addLine(to: CGPoint(x: rightBase, y: height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Convenience Initializers

public extension NimbusTooltip {
    /// Creates a tooltip with only title text
    init(_ title: String, position: TooltipPosition = .top) {
        self.init(title: title, subtitle: nil, icon: nil, position: position)
    }
    
    /// Creates a tooltip with title and subtitle
    init(title: String, subtitle: String, position: TooltipPosition = .top) {
        self.init(title: title, subtitle: subtitle, icon: nil, position: position)
    }
    
    /// Creates a tooltip with title and icon
    init(title: String, icon: Image, position: TooltipPosition = .top) {
        self.init(title: title, subtitle: nil, icon: icon, position: position)
    }
}
