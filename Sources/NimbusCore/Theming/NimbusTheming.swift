//
//  NimbusTheming.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI
import AppKit

// https://freiwald.dev/posts/custom-environment-colors/
// https://alexanderweiss.dev/blog/2025-01-19-effortless-swiftui-theming

/// A comprehensive theming protocol that defines core design tokens and color systems
/// for the NimbusUI design system. Component-specific tokens are provided through
/// protocol extensions with sensible defaults that can be optionally overridden.
public protocol NimbusTheming: Sendable {
    
    // MARK: - Brand Colors (Required)
    
    /// Primary brand color that adapts to light/dark color schemes
    func primaryColor(for scheme: ColorScheme) -> Color
    
    /// Secondary brand color that adapts to light/dark color schemes  
    func secondaryColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary brand color that adapts to light/dark color schemes
    func tertiaryColor(for scheme: ColorScheme) -> Color
    
    /// Accent color for highlights and interactive elements
    func accentColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Semantic Colors (Required)
    
    /// Error/danger color for destructive actions and error states
    func errorColor(for scheme: ColorScheme) -> Color
    
    /// Success color for positive feedback and completed states
    func successColor(for scheme: ColorScheme) -> Color
    
    /// Warning color for caution states and important notices
    func warningColor(for scheme: ColorScheme) -> Color
    
    /// Info color for informational messages and neutral feedback
    func infoColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Background Colors (Required)
    
    /// Primary background color for main content areas
    func backgroundColor(for scheme: ColorScheme) -> Color
    
    /// Secondary background color for cards, panels, and elevated surfaces
    func secondaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary background color for subtle backgrounds and disabled states
    func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Text Colors (Required)
    
    /// Primary text color for headings and main content
    func primaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Secondary text color for supporting text and descriptions
    func secondaryTextColor(for scheme: ColorScheme) -> Color
    
    /// Tertiary text color for placeholders and disabled text
    func tertiaryTextColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Border Colors (Required)
    
    /// Primary border color for inputs, buttons, and separators
    func borderColor(for scheme: ColorScheme) -> Color
    
    /// Secondary border color for subtle divisions and nested elements
    func secondaryBorderColor(for scheme: ColorScheme) -> Color
    
    // MARK: - Core Design Tokens (Required)
    
    /// Background material for blur effects and translucent surfaces
    var backgroundMaterial: Material? { get }
    
    /// Corner radii configuration for consistent rounded corners
    var cornerRadii: RectangleCornerRadii { get }
    
    /// Animation configuration for standard transitions
    var animation: Animation { get }
    
    /// Fast animation configuration for quick interactions
    var animationFast: Animation { get }
    
    /// Minimum height for interactive elements
    var minHeight: CGFloat { get }
    
    /// Standard horizontal padding for components
    var horizontalPadding: CGFloat { get }
    
    /// Default elevation level for components
    var elevation: Elevation { get }
}

// MARK: - Button Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Button corner radii configuration
    var buttonCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// Compact button corner radii configuration
    var compactButtonCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// Label content spacing configuration
    var labelContentSpacing: CGFloat { 6 }
    
    /// Link button font weight configuration
    var linkButtonFontWeight: Font.Weight { .medium }
    
    /// Close button size configuration (24x24 default)
    var closeButtonSize: CGFloat { 24 }
    
    /// Close button icon size configuration (14pt default)
    var closeButtonIconSize: CGFloat { 14 }
    
    /// Button border width for outline button styles (1px default)
    var buttonBorderWidth: CGFloat { 1 }
    
    // MARK: - ControlSize-Specific Button Metrics (Optional with Defaults)
    
    /// Button height for .extraLarge controlSize (60px default)
    var buttonHeightExtraLarge: CGFloat? { nil }
    
    /// Button height for .large controlSize (52px default)
    var buttonHeightLarge: CGFloat? { nil }
    
    /// Button height for .regular controlSize (44px default)
    var buttonHeightRegular: CGFloat? { nil }
    
    /// Button height for .small controlSize (36px default)
    var buttonHeightSmall: CGFloat? { nil }
    
    /// Button height for .mini controlSize (28px default)
    var buttonHeightMini: CGFloat? { nil }
    
    /// Button horizontal padding for .extraLarge controlSize (28px default)
    var buttonPaddingExtraLarge: CGFloat? { nil }
    
    /// Button horizontal padding for .large controlSize (24px default)
    var buttonPaddingLarge: CGFloat? { nil }
    
    /// Button horizontal padding for .regular controlSize (20px default)
    var buttonPaddingRegular: CGFloat? { nil }
    
    /// Button horizontal padding for .small controlSize (16px default)
    var buttonPaddingSmall: CGFloat? { nil }
    
    /// Button horizontal padding for .mini controlSize (12px default)
    var buttonPaddingMini: CGFloat? { nil }
    
    /// Button font size for .extraLarge controlSize (19pt default)
    var buttonFontSizeExtraLarge: CGFloat? { nil }
    
    /// Button font size for .large controlSize (17pt default)
    var buttonFontSizeLarge: CGFloat? { nil }
    
    /// Button font size for .regular controlSize (15pt default)
    var buttonFontSizeRegular: CGFloat? { nil }
    
    /// Button font size for .small controlSize (13pt default)
    var buttonFontSizeSmall: CGFloat? { nil }
    
    /// Button font size for .mini controlSize (11pt default)
    var buttonFontSizeMini: CGFloat? { nil }
}

// MARK: - List Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// List item corner radii configuration
    var listItemCornerRadii: RectangleCornerRadii { RectangleCornerRadii(2) }
    
    /// List item height configuration
    var listItemHeight: CGFloat { 44 }
}

// MARK: - Checkbox Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Checkbox size configuration (16x16 default)
    var checkboxSize: CGFloat { 16 }
    
    /// Checkbox corner radii configuration
    var checkboxCornerRadii: RectangleCornerRadii { RectangleCornerRadii(4) }
    
    /// Checkbox border width configuration
    var checkboxBorderWidth: CGFloat { 1 }
    
    /// Checkbox checkmark stroke width configuration
    var checkboxStrokeWidth: CGFloat { 1.5 }
    
    /// Checkbox checkmark line cap configuration  
    var checkboxLineCap: CGLineCap { .round }
    
    /// Checkbox item spacing configuration (spacing between checkbox and text)
    var checkboxItemSpacing: CGFloat { 12 }
    
    /// Checkbox item text spacing configuration (spacing between title and subtitle)
    var checkboxItemTextSpacing: CGFloat { 4 }
    
    /// Checkbox item padding configuration
    var checkboxItemPadding: CGFloat { 16 }
    
    /// Checkbox item minimum height configuration
    var checkboxItemMinHeight: CGFloat { 44 }
}

// MARK: - Toggle Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Toggle knob size configuration (diameter for circular knobs)
    var toggleKnobSize: CGFloat { 20 }
    
    /// Toggle knob padding configuration (space around knob inside track)
    var toggleKnobPadding: CGFloat { 4 }
    
    /// Toggle shape configuration (will be converted to NimbusToggleShape)
    var toggleDefaultShapeStyle: NimbusToggleShape { .circle }
    
    /// Toggle track width override (nil uses auto-calculated width based on shape)
    var toggleTrackWidth: CGFloat? { nil }
    
    /// Toggle track height override (nil uses auto-calculated height based on knob + padding)
    var toggleTrackHeight: CGFloat? { nil }
    
    /// Toggle animation spring configuration for knob movement
    var toggleAnimationSpring: Animation { .bouncy(duration: 0.4) }
    
    /// Toggle item spacing configuration (spacing between toggle and text)
    var toggleItemSpacing: CGFloat { 12 }
    
    /// Toggle item text spacing configuration (spacing between title and subtitle)
    var toggleItemTextSpacing: CGFloat { 4 }
    
    /// Toggle item padding configuration (around entire item)
    var toggleItemPadding: CGFloat { 8 }
    
    /// Toggle item minimum height configuration
    var toggleItemMinHeight: CGFloat { 44 }
}

// MARK: - Badge Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Badge content padding configuration
    var badgeContentPadding: EdgeInsets { EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8) }
    
    /// Badge border width configuration
    var badgeBorderWidth: CGFloat { 1.0 }
    
}

// MARK: - Scroller Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Scroller track width (thickness of the entire scroller)
    var scrollerWidth: CGFloat { 16 }
    
    /// Scroller knob width (thickness of the draggable knob)
    var scrollerKnobWidth: CGFloat { 6 }
    
    /// Scroller knob padding (space between knob and slot edges)
    var scrollerKnobPadding: CGFloat { 2 }
    
    /// Scroller slot corner radius
    var scrollerSlotCornerRadius: CGFloat { 4 }
    
    /// Scroller slot visibility
    var scrollerShowSlot: Bool { true }
    
    // MARK: - Computed Scroller Properties
    
    /// Scroller knob corner radius (auto-calculated from knob width and padding)
    var scrollerKnobCornerRadius: CGFloat {
        (scrollerKnobWidth - scrollerKnobPadding) / 2
    }
    
    // MARK: - Legacy Scroller Properties (Backward Compatibility)
    
    /// Scroller knob vertical inset
    var scrollerKnobInsetVertical: CGFloat { 6 }
    
    /// Scroller knob horizontal inset
    var scrollerKnobInsetHorizontal: CGFloat { 3 }
    
    /// Scroller slot inset
    var scrollerSlotInset: CGFloat { 3 }
    
    /// Scroller initial opacity
    var scrollerInitialOpacity: CGFloat { 0.3 }
    
    /// Scroller fade opacity
    var scrollerFadeOpacity: CGFloat { 0.3 }
    
    /// Scroller fade delay
    var scrollerFadeDelay: TimeInterval { 1.0 }
    
    /// Scroller animation duration
    var scrollerAnimationDuration: TimeInterval { 0.1 }
}

// MARK: - TextField Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// TextField content padding configuration
    var textFieldContentPadding: EdgeInsets { EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12) }
    
    /// TextField border width configuration
    var textFieldBorderWidth: CGFloat { 1.0 }
    
    /// TextField corner radii configuration
    var textFieldCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// TextField minimum height configuration
    var textFieldMinHeight: CGFloat { 32 }
    
    /// TextField icon spacing configuration (spacing between icon and text field)
    var textFieldIconSpacing: CGFloat { 8 }
}

// MARK: - Notification Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Notification positioning & layout
    var notificationTopPadding: CGFloat { 16 }
    var notificationHorizontalPadding: CGFloat { 16 }
    var notificationCornerRadii: RectangleCornerRadii { cornerRadii }
    
    /// Notification styling
    var notificationMinHeight: CGFloat { 56 }
    var notificationIconSize: CGFloat { 20 }
    var notificationPadding: CGFloat { 16 }
    
    /// Animation timing
    var notificationShowAnimation: Animation { .spring(response: 0.4, dampingFraction: 0.8) }
    var notificationHideAnimation: Animation { .easeOut(duration: 0.25) }
    
    /// Advanced animation styles for enhanced presentation modes
    var notificationBounceAnimation: Animation { .spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.0) }
    var notificationScaleAnimation: Animation { .spring(response: 0.5, dampingFraction: 0.7) }
    
    /// Notification handle styling (drag indicator)
    var notificationHandleWidth: CGFloat { 32 }
    var notificationHandleHeight: CGFloat { 4 }
    var notificationHandleCornerRadius: CGFloat { 2 }
    var notificationHandleOpacityVisible: Double { 0.3 }
    var notificationHandleOpacityHidden: Double { 0.0 }
    var notificationHandleFadeAnimation: Animation { .easeInOut(duration: 0.2) }
}

// MARK: - Bezel Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// Bezel size configuration
    var bezelSize: CGSize { CGSize(width: 200, height: 200) }
    
    /// Bezel corner radius configuration
    var bezelCornerRadius: CGFloat { 19.0 }
    
    /// Bezel content padding (inset from edge)
    var bezelContentPadding: CGFloat { 20.0 }
    
    /// Bezel background blur material (NSVisualEffectView.Material)
    var bezelBlurMaterial: NSVisualEffectView.Material { .hudWindow }
    
    /// Bezel position offset from center (y-axis)
    var bezelPositionOffset: CGFloat { 140.0 }
    
    /// Bezel offset from top edge for top positions
    var bezelTopOffset: CGFloat { 60.0 }
    
    /// Bezel offset from bottom edge for bottom positions  
    var bezelBottomOffset: CGFloat { 60.0 }
    
    /// Bezel offset from leading/trailing edges for corner positions
    var bezelHorizontalOffset: CGFloat { 60.0 }
    
    /// Animation timing for show transition
    var bezelShowAnimationDuration: TimeInterval { 0.33 }
    
    /// Animation timing for hide transition
    var bezelHideAnimationDuration: TimeInterval { 0.66 }
}

// MARK: - Convenience Methods

public extension NimbusTheming {
    /// Gets the primary color for the current environment's color scheme
    func primaryColor(from environment: EnvironmentValues) -> Color {
        primaryColor(for: environment.colorScheme)
    }
    
    /// Gets the secondary color for the current environment's color scheme
    func secondaryColor(from environment: EnvironmentValues) -> Color {
        secondaryColor(for: environment.colorScheme)
    }
    
    /// Gets the error color for the current environment's color scheme
    func errorColor(from environment: EnvironmentValues) -> Color {
        errorColor(for: environment.colorScheme)
    }
    
    /// Gets the background color for the current environment's color scheme
    func backgroundColor(from environment: EnvironmentValues) -> Color {
        backgroundColor(for: environment.colorScheme)
    }
    
    /// Gets the notification handle color for the current color scheme
    func notificationHandleColor(for scheme: ColorScheme) -> Color {
        primaryTextColor(for: scheme)
    }
}
