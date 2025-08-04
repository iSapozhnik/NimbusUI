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
// These environment values are internal APIs used by convenience methods.
// They are not intended for direct use by library consumers.

public extension EnvironmentValues {
    @Entry var nimbusCornerRadii: RectangleCornerRadii? = nil

    @Entry var nimbusTheme: NimbusTheming = NimbusTheme.default
    
    @Entry var nimbusAnimationFast: Animation? = nil
    
    @Entry var nimbusHasDividers: Bool = true
}

// MARK: Button
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusButtonCornerRadii: RectangleCornerRadii? = nil
    @Entry var nimbusCompactButtonCornerRadii: RectangleCornerRadii? = nil
    
    @Entry var nimbusButtonMaterial: Material? = nil
    @Entry var nimbusButtonHighlightOnHover: Bool = true
    
    // Button Label Configuration
    @Entry var nimbusButtonHasDivider: Bool? = nil
    @Entry var nimbusButtonIconAlignment: HorizontalAlignment? = nil
    @Entry var nimbusButtonContentPadding: CGFloat? = nil
    
    // Button Border Configuration
    @Entry var nimbusButtonBorderWidth: CGFloat? = nil
}

// MARK: View
// Internal APIs for convenience methods - not for direct consumer use

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
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusLabelContentHorizontalMediumPadding: CGFloat? = nil
}

// MARK: List
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusListItemCornerRadii: RectangleCornerRadii? = nil

    @Entry var nimbusListItemHeight: CGFloat? = nil
    @Entry var nimbusListItemHighlightOnHover: Bool = true

    @Entry var nimbusItemBeingHovered: Bool = false
    @Entry var nimbusListFixedHeightUntil: CGFloat? = nil
    
    @Entry var nimbusListRoundedTopCornerBehavior: ListRoundedCornerBehavior = .never
    @Entry var nimbusListRoundedBottomCornerBehavior: ListRoundedCornerBehavior = .never

}

// MARK: Checkbox
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusCheckboxSize: CGFloat? = nil
    @Entry var nimbusCheckboxCornerRadii: RectangleCornerRadii? = nil
    @Entry var nimbusCheckboxBorderWidth: CGFloat? = nil
    @Entry var nimbusCheckboxItemSpacing: CGFloat? = nil
    @Entry var nimbusCheckboxItemTextSpacing: CGFloat? = nil
    @Entry var nimbusCheckboxItemPadding: CGFloat? = nil
    @Entry var nimbusCheckboxItemMinHeight: CGFloat? = nil
}

// MARK: Notification Handle
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusNotificationHandleWidth: CGFloat? = nil
    @Entry var nimbusNotificationHandleHeight: CGFloat? = nil
    @Entry var nimbusNotificationHandleCornerRadius: CGFloat? = nil
    @Entry var nimbusNotificationHandleOpacityVisible: Double? = nil
    @Entry var nimbusNotificationHandleOpacityHidden: Double? = nil
    @Entry var nimbusNotificationHandleFadeAnimation: Animation? = nil
}

// MARK: Scroller
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    // Core scroller dimensions
    @Entry var nimbusScrollerWidth: CGFloat? = nil
    @Entry var nimbusScrollerKnobWidth: CGFloat? = nil
    @Entry var nimbusScrollerKnobPadding: CGFloat? = nil
    @Entry var nimbusScrollerSlotCornerRadius: CGFloat? = nil
    @Entry var nimbusScrollerShowScrollerSlot: Bool? = nil
    
    // Legacy properties (keeping for backward compatibility)
    @Entry var nimbusScrollerKnobCornerRadius: CGFloat? = nil
    @Entry var nimbusScrollerKnobInsetVertical: CGFloat? = nil
    @Entry var nimbusScrollerKnobInsetHorizontal: CGFloat? = nil
    @Entry var nimbusScrollerSlotInset: CGFloat? = nil
    @Entry var nimbusScrollerInitialOpacity: CGFloat? = nil
    @Entry var nimbusScrollerFadeOpacity: CGFloat? = nil
    @Entry var nimbusScrollerFadeDelay: TimeInterval? = nil
    @Entry var nimbusScrollerAnimationDuration: TimeInterval? = nil
}
