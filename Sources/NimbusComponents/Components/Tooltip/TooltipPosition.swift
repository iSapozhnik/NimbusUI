//
//  TooltipPosition.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

/// Defines the position and arrow direction for tooltip presentation
public enum TooltipPosition: CaseIterable, Sendable {
    /// Tooltip appears above the anchor view with arrow pointing down
    case top
    /// Tooltip appears below the anchor view with arrow pointing up
    case bottom
    /// Tooltip appears to the left of the anchor view with arrow pointing right
    case leading
    /// Tooltip appears to the right of the anchor view with arrow pointing left
    case trailing
    
    /// Returns the alignment for the tooltip relative to the anchor view
    var alignment: Alignment {
        switch self {
        case .top:
            return .bottom
        case .bottom:
            return .top
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        }
    }
    
    /// Returns the offset for the tooltip including anchor view dimensions and spacing
    /// This ensures the tooltip doesn't overlap with the anchor view
    func offset(anchorSize: CGSize, arrowSize: CGFloat, spacing: CGFloat = 2) -> CGSize {
        // Calculate full clearance including anchor view size, arrow, and spacing
        switch self {
        case .top:
            // Position tooltip above: clear the full anchor height + arrow + spacing
            let clearance = anchorSize.height / 2 + arrowSize + spacing
            return CGSize(width: 0, height: -clearance)
        case .bottom:
            // Position tooltip below: clear the full anchor height + arrow + spacing
            let clearance = anchorSize.height / 2 + arrowSize + spacing
            return CGSize(width: 0, height: clearance)
        case .leading:
            // Position tooltip left: clear the full anchor width + arrow + spacing
            let clearance = anchorSize.width / 2 + arrowSize + spacing
            return CGSize(width: -clearance, height: 0)
        case .trailing:
            // Position tooltip right: clear the full anchor width + arrow + spacing
            let clearance = anchorSize.width / 2 + arrowSize + spacing
            return CGSize(width: clearance, height: 0)
        }
    }
    
    /// Legacy offset method for backward compatibility
    /// This ensures the tooltip doesn't overlap with the anchor view
    func offset(arrowSize: CGFloat, spacing: CGFloat = 2) -> CGSize {
        // Fallback with estimated anchor size if actual size not available
        let estimatedAnchorSize = CGSize(width: 100, height: 44) // Standard button size estimate
        return offset(anchorSize: estimatedAnchorSize, arrowSize: arrowSize, spacing: spacing)
    }
    
    /// Returns the rotation angle for the arrow
    var arrowRotation: Angle {
        switch self {
        case .top:
            return .degrees(180) // Arrow points down
        case .bottom:
            return .degrees(0)   // Arrow points up
        case .leading:
            return .degrees(90)  // Arrow points right
        case .trailing:
            return .degrees(270) // Arrow points left
        }
    }
    
    /// Returns true if the position is horizontal (leading/trailing)
    var isHorizontal: Bool {
        self == .leading || self == .trailing
    }
    
    /// Returns true if the position is vertical (top/bottom)
    var isVertical: Bool {
        self == .top || self == .bottom
    }
    
    // MARK: - Adaptive Positioning
    
    /// Determines the best tooltip position based on available screen space
    /// - Parameters:
    ///   - anchorFrame: The frame of the anchor view in global coordinates
    ///   - screenBounds: The screen bounds to calculate available space
    ///   - tooltipSize: The estimated size of the tooltip content
    ///   - preferredPosition: The originally requested position (fallback)
    /// - Returns: The optimal position to avoid content overlap
    static func adaptivePosition(
        anchorFrame: CGRect,
        screenBounds: CGRect,
        tooltipSize: CGSize,
        preferredPosition: TooltipPosition
    ) -> TooltipPosition {
        // Calculate available space in each direction
        let spaceAbove = anchorFrame.minY - screenBounds.minY
        let spaceBelow = screenBounds.maxY - anchorFrame.maxY
        let spaceLeft = anchorFrame.minX - screenBounds.minX
        let spaceRight = screenBounds.maxX - anchorFrame.maxX
        
        // Add buffer for arrow, spacing, and half the anchor size (since offset is from center)
        let verticalBuffer = (anchorFrame.height / 2) + 12 // anchor height/2 + arrow + spacing 
        let horizontalBuffer = (anchorFrame.width / 2) + 12 // anchor width/2 + arrow + spacing
        
        // Check if preferred position has enough space
        let preferredHasSpace: Bool
        switch preferredPosition {
        case .top:
            preferredHasSpace = spaceAbove >= tooltipSize.height + verticalBuffer
        case .bottom:
            preferredHasSpace = spaceBelow >= tooltipSize.height + verticalBuffer
        case .leading:
            preferredHasSpace = spaceLeft >= tooltipSize.width + horizontalBuffer
        case .trailing:
            preferredHasSpace = spaceRight >= tooltipSize.width + horizontalBuffer
        }
        
        // If preferred position has enough space, use it
        if preferredHasSpace {
            return preferredPosition
        }
        
        // Otherwise, find the position with the most available space
        let positions: [(TooltipPosition, CGFloat)] = [
            (.top, spaceAbove - tooltipSize.height - verticalBuffer),
            (.bottom, spaceBelow - tooltipSize.height - verticalBuffer),
            (.leading, spaceLeft - tooltipSize.width - horizontalBuffer),
            (.trailing, spaceRight - tooltipSize.width - horizontalBuffer)
        ]
        
        // Find position with maximum available space that fits
        let viablePositions = positions.filter { $0.1 >= 0 }
        
        if let bestPosition = viablePositions.max(by: { $0.1 < $1.1 }) {
            return bestPosition.0
        }
        
        // If no position fits perfectly, choose the one with the least overflow
        // Prioritize vertical positions (top/bottom) as they're usually better for readability
        let verticalPositions = positions.filter { $0.0.isVertical }
        let horizontalPositions = positions.filter { $0.0.isHorizontal }
        
        // Among vertical positions, prefer the one with more space
        if !verticalPositions.isEmpty {
            let bestVertical = verticalPositions.max { $0.1 < $1.1 }!
            return bestVertical.0
        }
        
        // Fall back to horizontal positions
        if !horizontalPositions.isEmpty {
            let bestHorizontal = horizontalPositions.max { $0.1 < $1.1 }!
            return bestHorizontal.0
        }
        
        // Ultimate fallback: return preferred position
        return preferredPosition
    }
    
    /// Calculates available space for a given position
    /// - Parameters:
    ///   - anchorFrame: The frame of the anchor view in global coordinates
    ///   - screenBounds: The screen bounds
    /// - Returns: Available space in points for this position
    func availableSpace(anchorFrame: CGRect, screenBounds: CGRect) -> CGFloat {
        switch self {
        case .top:
            return anchorFrame.minY - screenBounds.minY
        case .bottom:
            return screenBounds.maxY - anchorFrame.maxY
        case .leading:
            return anchorFrame.minX - screenBounds.minX
        case .trailing:
            return screenBounds.maxX - anchorFrame.maxX
        }
    }
}