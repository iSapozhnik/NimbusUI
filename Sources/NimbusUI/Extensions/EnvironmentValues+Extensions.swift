//
//  EnvironmentValues+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

// MARK: - Common

public extension EnvironmentValues {
    @Entry var nimbusAnimation: Animation = .smooth(duration: 0.2)
    @Entry var nimbusAnimationFast: Animation = .easeInOut(duration: 0.2)
}

// MARK: Button

public extension EnvironmentValues {
    @Entry var nimbusButtonCornerRadii: RectangleCornerRadii = .init(4)
    @Entry var nimbusCompactButtonCornerRadii: RectangleCornerRadii = .init(8)
    
    @Entry var nimbusButtonMaterial: Material? = nil
    @Entry var nimbusButtonHighlightOnHover: Bool = true
    
}

// MARK: View

public extension EnvironmentValues {
    @Entry var nimbusMinHeight: CGFloat = 30
    @Entry var nimbusHorizontalPadding: CGFloat = 8
    
    @Entry var nimbusIsBordered: Bool = true
    @Entry var nimbusHasBackground: Bool = true
    
    @Entry var nimbusAspectRatio: CGFloat?
    @Entry var nimbusAspectRatioContentMode: ContentMode? = .fit
    @Entry var nimbusAspectRatioHasFixedHeight: Bool = true
}

