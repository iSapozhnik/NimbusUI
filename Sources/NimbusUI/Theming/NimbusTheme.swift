//
//  DefaultNimbusTheme.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

public struct NimbusTheme: NimbusTheming, Sendable {
    public let accentColor = Color.accentColor
    public let errorColor = Color.red
    
    public func primaryColor(for scheme: ColorScheme) -> Color {
        Color.primaryColor(light: Color(red: 0.4, green: 0.6, blue: 1.0),
                           dark: Color(red: 0.2, green: 0.3, blue: 0.8),
                           scheme: scheme)
    }
    
    public let secondaryColor = Color("SecondaryColor")
    public let tertiaryColor = Color("TertiaryColor")
    
    public let primaryTextColor = Color("PrimaryTextColor")
    public let secondaryTextColor = Color("SecondaryTextColor")
    public let tertiaryTextColor = Color("TertiaryTextColor")
    
    public let backgroundMaterial: Material? = Material.thinMaterial
    
    public let cornerRadii = RectangleCornerRadii.init(8)
}

extension NimbusTheme {
    public static let `default` = NimbusTheme()
}
