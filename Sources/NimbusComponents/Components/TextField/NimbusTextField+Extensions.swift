//
//  NimbusTextField+Extensions.swift
//  NimbusUI
//
//  Created by AI Assistant on 07.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - NimbusTextField Convenience Modifiers

public extension NimbusTextField {
    /// Sets the text field content padding with EdgeInsets for maximum flexibility
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusTextFieldContentPadding, padding)
    }
    
    /// Sets the text field content padding with individual values
    func contentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusTextFieldContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform text field content padding
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusTextFieldContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
    
    /// Sets the text field border width
    func borderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusTextFieldBorderWidth, width)
    }
    
    /// Sets the text field corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusTextFieldCornerRadii, radii)
    }
    
    /// Sets the text field minimum height
    func minHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusTextFieldMinHeight, height)
    }
    
    /// Controls whether the text field has a border
    func bordered(_ bordered: Bool = true) -> some View {
        environment(\.nimbusIsBordered, bordered)
    }
    
    /// Controls whether the text field has a background
    func hasBackground(_ hasBackground: Bool = true) -> some View {
        environment(\.nimbusHasBackground, hasBackground)
    }
}

// MARK: - Generic View Extensions

public extension View {
    /// Sets the text field content padding for any text field component
    func textFieldContentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusTextFieldContentPadding, padding)
    }
    
    /// Sets the text field content padding with individual values for any text field component
    func textFieldContentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusTextFieldContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform text field content padding for any text field component
    func textFieldContentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusTextFieldContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
    
    /// Sets the text field border width for any text field component
    func textFieldBorderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusTextFieldBorderWidth, width)
    }
    
    /// Sets the text field corner radii for any text field component
    func textFieldCornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusTextFieldCornerRadii, radii)
    }
    
    /// Sets the text field minimum height for any text field component
    func textFieldMinHeight(_ height: CGFloat) -> some View {
        environment(\.nimbusTextFieldMinHeight, height)
    }
}