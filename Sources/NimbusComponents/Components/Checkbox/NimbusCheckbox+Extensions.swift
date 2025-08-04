//
//  NimbusCheckbox+Extensions.swift  
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 04.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Checkbox Convenience Methods

public extension View {
    /// Sets the stroke width for checkbox checkmarks
    /// - Parameter width: The stroke width to apply to checkbox checkmarks
    /// - Returns: A view with the specified checkbox stroke width applied
    func strokeWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusCheckboxStrokeWidth, width)
    }
    
    /// Sets the line cap style for checkbox checkmarks
    /// - Parameter cap: The line cap style to apply to checkbox checkmarks
    /// - Returns: A view with the specified checkbox line cap applied
    func lineCap(_ cap: CGLineCap) -> some View {
        environment(\.nimbusCheckboxLineCap, cap)
    }
    
    /// Sets the size for checkboxes
    /// - Parameter size: The size to apply to checkboxes
    /// - Returns: A view with the specified checkbox size applied
    func size(_ size: CGFloat) -> some View {
        environment(\.nimbusCheckboxSize, size)
    }
    
    /// Sets the corner radii for checkboxes
    /// - Parameter cornerRadii: The corner radii to apply to checkboxes
    /// - Returns: A view with the specified checkbox corner radii applied
    func cornerRadii(_ cornerRadii: RectangleCornerRadii) -> some View {
        environment(\.nimbusCheckboxCornerRadii, cornerRadii)
    }
    
    /// Sets the border width for checkboxes
    /// - Parameter width: The border width to apply to checkboxes
    /// - Returns: A view with the specified checkbox border width applied
    func borderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusCheckboxBorderWidth, width)
    }
    
    /// Configures stroke properties for checkbox checkmarks in one call
    /// - Parameters:
    ///   - width: The stroke width to apply
    ///   - cap: The line cap style to apply
    /// - Returns: A view with the specified stroke configuration applied
    func customStroke(width: CGFloat, cap: CGLineCap) -> some View {
        self
            .strokeWidth(width)
            .lineCap(cap)
    }
    
    /// Sets rounded corners for checkboxes using a single radius value
    /// - Parameter cornerRadius: The corner radius to apply to all corners
    /// - Returns: A view with the specified rounded corners applied
    func rounded(cornerRadius: CGFloat) -> some View {
        cornerRadii(RectangleCornerRadii(cornerRadius))
    }
    
    /// Sets square corners for checkboxes (corner radius of 0)
    /// - Returns: A view with square corners applied
    func square() -> some View {
        cornerRadii(RectangleCornerRadii(0))
    }
}