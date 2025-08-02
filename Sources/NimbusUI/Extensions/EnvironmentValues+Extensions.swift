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
    @Entry var nimbusCornerRadii: RectangleCornerRadii? = nil

    @Entry var nimbusTheme: NimbusTheming = NimbusTheme.default
    
    @Entry var nimbusAnimationFast: Animation? = nil
    
    @Entry var nimbusHasDividers: Bool = true
}

// MARK: Button

public extension EnvironmentValues {
    @Entry var nimbusButtonCornerRadii: RectangleCornerRadii? = nil
    @Entry var nimbusCompactButtonCornerRadii: RectangleCornerRadii? = nil
    
    @Entry var nimbusButtonMaterial: Material? = nil
    @Entry var nimbusButtonHighlightOnHover: Bool = true
    
    // Button Label Configuration
    @Entry var nimbusButtonHasDivider: Bool? = nil
    @Entry var nimbusButtonIconAlignment: HorizontalAlignment? = nil
    @Entry var nimbusButtonContentPadding: CGFloat? = nil
}

// MARK: View

public extension EnvironmentValues {
    @Entry var nimbusMinHeight: CGFloat? = nil
    @Entry var nimbusHorizontalPadding: CGFloat? = nil
    
    @Entry var nimbusIsBordered: Bool = true
    @Entry var nimbusHasBackground: Bool = true
    
    @Entry var nimbusAspectRatio: CGFloat?
    @Entry var nimbusAspectRatioContentMode: ContentMode? = .fit
    @Entry var nimbusAspectRatioHasFixedHeight: Bool = true
    @Entry var nimbusElevation: Elevation? = nil
}

// MARK: Labels

public extension EnvironmentValues {
    @Entry var nimbusLabelContentHorizontalMediumPadding: CGFloat? = nil
}

// MARK: List

public extension EnvironmentValues {
    @Entry var nimbusListItemCornerRadii: RectangleCornerRadii? = nil

    @Entry var nimbusListItemHeight: CGFloat? = nil
    @Entry var nimbusListItemHighlightOnHover: Bool = true

    @Entry var nimbusItemBeingHovered: Bool = false
    @Entry var nimbusListFixedHeightUntil: CGFloat? = nil
    
    @Entry var nimbusListRoundedTopCornerBehavior: ListRoundedCornerBehavior = .never
    @Entry var nimbusListRoundedBottomCornerBehavior: ListRoundedCornerBehavior = .never
    
    // List Container Configuration
    @Entry var nimbusListContentMarginsTop: CGFloat? = nil
    @Entry var nimbusListContentMarginsLeading: CGFloat? = nil
    @Entry var nimbusListContentMarginsBottom: CGFloat? = nil
    @Entry var nimbusListContentMarginsTrailing: CGFloat? = nil
    @Entry var nimbusListScrollDisabled: Bool = false
}
