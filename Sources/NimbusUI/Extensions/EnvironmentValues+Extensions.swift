//
//  EnvironmentValues+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public enum Elevation: Int, CaseIterable, Hashable, Sendable {
    case none = 0
    case low
    case medium
    case high
    case extreme
}

// MARK: - Common

public extension EnvironmentValues {
    @Entry var nimbusCornerRadii: RectangleCornerRadii = .init(12)

    @Entry var nimbusTheme: NimbusTheming = NimbusTheme.default
    
    @Entry var nimbusAnimation: Animation = .smooth(duration: 0.2)
    @Entry var nimbusAnimationFast: Animation = .easeInOut(duration: 0.1)
    
    @Entry var nimbusHasDividers: Bool = true
}

// MARK: Button

public extension EnvironmentValues {
    @Entry var nimbusButtonCornerRadii: RectangleCornerRadii = .init(12)
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
    @Entry var nimbusElevation: Elevation = .low
}

// MARK: Labels

public extension EnvironmentValues {
    @Entry var nimbusLabelIconContentSpacing: CGFloat = 4
    @Entry var nimbusLabelContentHorizontalSmallPadding: CGFloat = 2
    @Entry var nimbusLabelContentHorizontalMediumPadding: CGFloat = 6
}

// MARK: List

public extension EnvironmentValues {
    @Entry var nimbusListItemCornerRadii: RectangleCornerRadii = .init(2)

    @Entry var nimbusListItemHeight: CGFloat = 44
    @Entry var nimbusListItemHighlightOnHover: Bool = true

    @Entry var nimbusItemBeingHovered: Bool = false
    @Entry var nimbusListFixedHeightUntil: CGFloat? = nil
    
    @Entry var nimbusListRoundedTopCornerBehavior: ListRoundedCornerBehavior = .never
    @Entry var nimbusListRoundedBottomCornerBehavior: ListRoundedCornerBehavior = .never

}
