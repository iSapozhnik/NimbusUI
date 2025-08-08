//
//  View+ComponentConvenience.swift
//  NimbusComponents
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Theme & General Configuration

public extension View {
    /// Sets the Nimbus theme for all components
    /// - Parameter theme: The theme conforming to NimbusTheming protocol
    /// - Returns: A view with the specified theme applied
    func nimbusTheme(_ theme: NimbusTheming) -> some View {
        environment(\.nimbusTheme, theme)
    }
    
    /// Sets a custom corner radius for supported components
    /// - Parameter radius: The corner radius to apply
    /// - Returns: A view with the specified corner radius applied
    func cornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusCornerRadii, RectangleCornerRadii(radius))
    }
    
    /// Sets a custom elevation level for shadows
    /// - Parameter elevation: The elevation level from the Elevation enum
    /// - Returns: A view with the specified elevation applied
    func elevation(_ elevation: Elevation) -> some View {
        environment(\.nimbusElevation, elevation)
    }
}

// MARK: - Button Configuration

public extension View {
    /// Sets the corner radius for buttons
    /// - Parameter radius: The corner radius to apply to buttons
    /// - Returns: A view with the specified button corner radius applied
    func buttonCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(radius))
    }
    
    /// Sets the horizontal padding for buttons
    /// - Parameter padding: The horizontal padding to apply to buttons
    /// - Returns: A view with the specified button padding applied
    func buttonPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusHorizontalPadding, padding)
    }
    
    /// Sets the minimum height for buttons
    /// - Parameter height: The minimum height to apply to buttons
    /// - Returns: A view with the specified button height applied
    func buttonHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusMinHeight, height)
    }
    
    /// Sets the material effect for buttons
    /// - Parameter material: The SwiftUI Material to apply to buttons
    /// - Returns: A view with the specified button material applied
    func buttonMaterial(_ material: Material) -> some View {
        environment(\.nimbusButtonMaterial, material)
    }
    
    /// Controls whether buttons highlight on hover
    /// - Parameter highlight: Whether buttons should highlight on hover
    /// - Returns: A view with the specified button hover behavior
    func buttonHighlightOnHover(_ highlight: Bool) -> some View {
        environment(\.nimbusButtonHighlightOnHover, highlight)
    }
    
    /// Sets the border width for outline button styles
    /// - Parameter width: The border width to apply to outline buttons
    /// - Returns: A view with the specified button border width applied
    func buttonBorderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusButtonBorderWidth, width)
    }
}

// MARK: - Button Label Configuration

public extension View {
    /// Controls whether button labels show a divider between icon and text
    /// - Parameter hasDivider: Whether to show a divider in button labels
    /// - Returns: A view with the specified button label divider setting
    func buttonLabelDivider(_ hasDivider: Bool) -> some View {
        environment(\.nimbusButtonHasDivider, hasDivider)
    }
    
    /// Sets the icon alignment for button labels
    /// - Parameter alignment: The horizontal alignment for button label icons
    /// - Returns: A view with the specified button label icon alignment
    func buttonLabelIconAlignment(_ alignment: HorizontalAlignment) -> some View {
        environment(\.nimbusButtonIconAlignment, alignment)
    }
    
    /// Sets the content padding for button labels
    /// - Parameter padding: The content padding for button labels
    /// - Returns: A view with the specified button label content padding
    func buttonLabelContentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusButtonContentPadding, padding)
    }
}

// MARK: - Aspect Ratio Configuration

public extension View {
    /// Sets an aspect ratio constraint for buttons
    /// - Parameters:
    ///   - ratio: The aspect ratio (width/height)
    ///   - contentMode: How the content should fit within the aspect ratio
    /// - Returns: A view with the specified aspect ratio applied
    func aspectRatio(_ ratio: CGFloat, contentMode: ContentMode = .fit) -> some View {
        environment(\.nimbusAspectRatio, ratio)
            .environment(\.nimbusAspectRatioContentMode, contentMode)
    }
    
    /// Sets whether the aspect ratio constraint should use fixed height
    /// - Parameter fixedHeight: Whether the height should be fixed
    /// - Returns: A view with the specified aspect ratio height behavior
    func aspectRatioFixedHeight(_ fixedHeight: Bool) -> some View {
        environment(\.nimbusAspectRatioHasFixedHeight, fixedHeight)
    }
}

// MARK: - Checkbox Configuration

public extension View {
    /// Sets the size for checkboxes
    /// - Parameter size: The size to apply to checkboxes
    /// - Returns: A view with the specified checkbox size applied
    func checkboxSize(_ size: CGFloat) -> some View {
        environment(\.nimbusCheckboxSize, size)
    }
    
    /// Sets the corner radius for checkboxes
    /// - Parameter radius: The corner radius to apply to checkboxes
    /// - Returns: A view with the specified checkbox corner radius applied
    func checkboxCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusCheckboxCornerRadii, RectangleCornerRadii(radius))
    }
    
    /// Sets the border width for checkboxes
    /// - Parameter width: The border width to apply to checkboxes
    /// - Returns: A view with the specified checkbox border width applied
    func checkboxBorderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusCheckboxBorderWidth, width)
    }
    
    /// Sets the spacing between checkbox and content in checkbox items
    /// - Parameter spacing: The spacing to apply between checkbox and content
    /// - Returns: A view with the specified checkbox item spacing applied
    func checkboxItemSpacing(_ spacing: CGFloat) -> some View {
        environment(\.nimbusCheckboxItemSpacing, spacing)
    }
    
    /// Sets the stroke width for checkbox checkmarks
    /// - Parameter width: The stroke width to apply to checkbox checkmarks
    /// - Returns: A view with the specified checkbox stroke width applied
    func checkboxStrokeWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusCheckboxStrokeWidth, width)
    }
    
    /// Sets the line cap style for checkbox checkmarks
    /// - Parameter cap: The line cap style to apply to checkbox checkmarks
    /// - Returns: A view with the specified checkbox line cap applied
    func checkboxLineCap(_ cap: CGLineCap) -> some View {
        environment(\.nimbusCheckboxLineCap, cap)
    }
}

// MARK: - List Configuration

public extension View {
    /// Sets the corner radius for list items
    /// - Parameter radius: The corner radius to apply to list items
    /// - Returns: A view with the specified list item corner radius applied
    func listItemCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusListItemCornerRadii, RectangleCornerRadii(radius))
    }
    
    /// Sets the height for list items
    /// - Parameter height: The height to apply to list items
    /// - Returns: A view with the specified list item height applied
    func listItemHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusListItemHeight, height)
    }
    
    /// Controls whether list items highlight on hover
    /// - Parameter highlight: Whether list items should highlight on hover
    /// - Returns: A view with the specified list item hover behavior
    func listItemHighlightOnHover(_ highlight: Bool) -> some View {
        environment(\.nimbusListItemHighlightOnHover, highlight)
    }
}
