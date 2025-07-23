//
//  File.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

// https://freiwald.dev/posts/custom-environment-colors/
// https://alexanderweiss.dev/blog/2025-01-19-effortless-swiftui-theming

public protocol NimbusTheming {
    var accentColor: Color { get }
    var errorColor: Color { get }
    
    func primaryColor(for scheme: ColorScheme) -> Color
    var secondaryColor: Color { get }
    var tertiaryColor: Color { get }
    
    var primaryTextColor: Color { get }
    var secondaryTextColor: Color { get }
    var tertiaryTextColor: Color { get }
    
    var backgroundMaterial: Material? { get }
    
    var cornerRadii: RectangleCornerRadii { get }
}
