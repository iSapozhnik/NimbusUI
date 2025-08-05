# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NimbusUI is a modular SwiftUI component library for macOS 14.0+ applications, built with Swift Package Manager. It provides a comprehensive theming system, reusable UI components, and custom view modifiers through four main libraries that can be imported selectively or as a complete umbrella package.

## Development Commands

### Build and Test
```bash
# Build the package
swift build

# Run tests (Swift Testing framework)
swift test

# Run specific test targets
swift test --filter NimbusCoreTests
swift test --filter NimbusComponentsTests  
swift test --filter NimbusNotificationsTests
swift test --filter NimbusOnboardingTests

# Clean build artifacts
swift package clean

# Resolve dependencies
swift package resolve

# Update snapshots when needed
swift test -Xswiftc -DUPDATE_SNAPSHOTS
```

### Modular Library Structure
NimbusUI is organized into four distinct libraries for selective importing:

- **`NimbusCore`**: Core theming system, modifiers, utilities, and AppKit integrations
- **`NimbusComponents`**: Main UI components (buttons, checkboxes, lists, scrollers)
- **`NimbusNotifications`**: Complete notification system with semantic types and animations
- **`NimbusOnboarding`**: Onboarding flows with FluidGradient and SmoothGradient animations
- **`NimbusUI`**: Convenience umbrella library that includes all of the above

## Architecture

### Core Systems

**Theme System**: Enhanced protocol-based theming using `NimbusTheming` protocol with environment injection via `@Environment(\.nimbusTheme)`. The protocol is split into **required core tokens** (17 properties: colors + basic design) and **optional component tokens** (30+ properties with sensible defaults via protocol extensions). Developers only implement what they need - most themes need just the 17 core properties. Environment values serve as optional overrides using the pattern `override ?? theme.property`. Available themes: `NimbusTheme.default`, `MaritimeTheme()`, `CustomWarmTheme()`, `MinimalTheme.default`.

**Environment Configuration**: SwiftUI `@Entry` environment values used for two purposes:
- **Design Token Overrides**: Optional values (`nil` by default) that override theme defaults
- **Behavioral Configuration**: Component-specific settings (hover states, dividers, borders)

**Modifier System**: Custom view modifiers for consistent styling:
- `NimbusFilledModifier` - Fill backgrounds with interaction states
- `NimbusShadowModifier` - Elevation-based shadows  
- `NimbusInnerShadowModifier` - Inner shadow effects
- `NimbusGradientBorderModifier` - Gradient borders
- `NimbusHoverableModifier` - Hover interactions
- `LevitatingViewModifier` - Floating effects

**Button Hierarchy**: Comprehensive button system with controlSize support:
- `.primary` - Filled primary buttons with brand color background
- `.accent` - Prominent accent buttons for key actions
- `.secondary` - Subtle filled buttons with secondary appearance
- `.primaryOutline` - Outline buttons with primary color border
- `.secondaryOutline` - Outline buttons with subtle border styling

**ControlSize Support**: All button styles support SwiftUI's native controlSize (.large, .regular, .small, .mini) with automatic height, padding, and font size adjustments. Theme-aware sizing through ControlSizeUtility integration.

**Enhanced Button + Label API**: Auto-detection system that applies `NimbusDividerLabelStyle` when Label environment values are set:
- `nimbusButtonHasDivider: Bool?` - Controls divider visibility (nil = no styling, true/false = apply with/without divider)
- `nimbusButtonIconAlignment: HorizontalAlignment?` - Controls icon position (leading/trailing)
- `nimbusButtonContentPadding: CGFloat?` - Controls label content padding
- All button styles automatically apply label styling when environment values are present
- Maintains full backward compatibility with plain text buttons

### Key Components

**Button System** (`Sources/NimbusComponents/Components/ButtonStyles/`): Comprehensive button system with five main styles (primary, accent, secondary, primaryOutline, secondaryOutline) plus specialized styles (LinkButtonStyle, CloseButtonStyle). All styles feature Enhanced Button + Label API for automatic divider detection and full controlSize support (.large, .regular, .small, .mini). LinkButtonStyle provides text-only action buttons, CloseButtonStyle provides icon-only dismiss buttons.

**Checkbox System** (`Sources/NimbusComponents/Components/Checkbox/`): `NimbusCheckbox` standalone component and `NimbusCheckboxItem` with title/subtitle support, flexible positioning (leading/trailing), and full theming integration.

**Badge System** (`Sources/NimbusComponents/Components/Badge/`): `BadgeView` component for status indicators, counters, and labels with theming integration.

**List Components** (`Sources/NimbusComponents/Components/List/`): `ListItem` with configurable hover states and theming.

**Scroll System** (`Sources/NimbusComponents/Components/ScrollView/` & `Sources/NimbusComponents/Components/Scroller/`): `NimbusScrollView` (NSScrollView wrapper) and `NimbusScroller` (standalone scroller) with custom theming and visibility controls.

**Notification System** (`Sources/NimbusNotifications/Components/Notification/`): Complete notification system with `NimbusNotificationView` component, view modifier presentation (`.nimbusNotification()`), 4 semantic types (info, success, warning, error), auto-dismiss timing, icon alignment options, and enhanced color hierarchy using theme semantic colors.

**Onboarding System** (`Sources/NimbusOnboarding/Components/Onboarding/`): Complete onboarding flow with FluidGradient animations, fixed dimensions (600x560), and page navigation.

### Modular Project Structure
```
Sources/
├── NimbusCore/              # Core foundation library
│   ├── NimbusCore.swift     # Library entry point
│   ├── Theming/             # Theme system and protocols
│   │   ├── NimbusTheming.swift
│   │   ├── NimbusTheme.swift
│   │   ├── MaritimeTheme.swift
│   │   └── CustomWarmTheme.swift
│   ├── Modifiers/           # Custom SwiftUI view modifiers
│   │   ├── NimbusFilledModifier.swift
│   │   ├── NimbusShadowModifier.swift
│   │   ├── NimbusAspectRatioModifier.swift
│   │   └── [8 more modifiers]
│   ├── Extensions/          # Swift and SwiftUI extensions
│   ├── Utilities/           # Helper utilities
│   │   ├── ControlSizeUtility.swift
│   │   └── ListRoundedCornerBehavior.swift
│   └── AppKit/             # AppKit integrations
│       └── Scoller/
├── NimbusComponents/        # Main UI components library
│   ├── NimbusComponents.swift # Library entry point
│   ├── Components/          # UI components with standardized structure
│   │   ├── ButtonStyles/    # Button style implementations
│   │   │   ├── [7 button styles].swift
│   │   │   └── Preview/     # Dedicated preview files
│   │   ├── Badge/           # Badge components
│   │   │   ├── BadgeView.swift
│   │   │   └── Preview/
│   │   │       └── BadgeView+Preview.swift
│   │   ├── Checkbox/        # Checkbox components
│   │   │   ├── NimbusCheckbox.swift
│   │   │   ├── NimbusCheckboxItem.swift
│   │   │   ├── NimbusCheckbox+Extensions.swift
│   │   │   └── Preview/
│   │   ├── List/            # List components
│   │   ├── ScrollView/      # Custom scroll view wrapper
│   │   └── Scroller/        # Standalone scroller component
│   ├── Examples/            # Theme examples and showcases
│   └── Extensions/          # Component convenience methods
├── NimbusNotifications/     # Notification system library
│   ├── NimbusNotifications.swift # Library entry point
│   ├── Components/
│   │   └── Notification/    # Complete notification system
│   │       ├── NimbusNotificationView.swift
│   │       ├── NimbusNotificationModifier.swift
│   │       ├── View+NimbusNotification.swift
│   │       ├── [6 more notification files]
│   │       └── Preview/
│   └── Extensions/          # Notification convenience methods
├── NimbusOnboarding/        # Onboarding system library
│   ├── NimbusOnboarding.swift # Library entry point
│   └── Components/
│       └── Onboarding/      # Onboarding flow components
│           ├── FeaturePageView.swift
│           ├── OnboardingView.swift
│           ├── PageControlView.swift
│           └── Preview/
└── NimbusUI/               # Umbrella library (convenience import)
```

### Component Folder Structure Standards

**IMPORTANT**: All components MUST follow this standardized folder structure:

1. **Component Folder**: Named after the component (e.g., `ButtonStyles/`, `Checkbox/`)
2. **Implementation Files**: Main component files in the root of the component folder
3. **Preview Folder**: Dedicated `Preview/` subfolder for ALL SwiftUI previews
4. **Preview Files**: Named with the pattern `ComponentName+Preview.swift`

**Rules for Component Organization**:
- ✅ **DO**: Keep implementation and preview code separate
- ✅ **DO**: Use the `Preview/` subfolder for all preview code
- ✅ **DO**: Name preview files with `+Preview.swift` suffix
- ✅ **DO**: Follow the established pattern when creating new components
- ❌ **DON'T**: Embed preview code in implementation files
- ❌ **DON'T**: Create subfolders within component folders (except `Preview/`)
- ❌ **DON'T**: Place component files loose in the `Components/` root

**Benefits of This Structure**:
- Clear separation between implementation and preview code
- Easy navigation and maintenance
- Better team development workflow
- Consistent organization across all components
- Preview changes don't clutter implementation files

## Technical Requirements

- **Swift**: 5.9+ minimum (Swift 6.1+ recommended)
- **Platform**: macOS 14.0+ only
- **Dependencies**: 
  - FluidGradient (v1.0.0+) for onboarding animations
  - SmoothGradient (v1.0.1+) for enhanced gradient effects
  - swift-snapshot-testing (v1.18.6+) for visual regression testing
- **Testing**: Swift Testing framework (not XCTest)
- **Architecture**: Modular library system supporting selective imports

## Usage Patterns

### Theme-First Architecture
Components use theme defaults with optional environment overrides:

```swift
// Import selectively or use umbrella library
import NimbusCore        // For theming system
import NimbusComponents  // For button styles
// Or: import NimbusUI   // For all features

// Basic theme application
Button("Action") { }
    .buttonStyle(.primary)
    .environment(\.nimbusTheme, NimbusTheme.default)

// Theme with property overrides and controlSize
Button("Custom") { }
    .buttonStyle(.primary) 
    .controlSize(.large)
    .environment(\.nimbusTheme, MaritimeTheme())
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
    .environment(\.nimbusMinHeight, 50)

// Modular imports for specific functionality
import NimbusNotifications
ContentView()
    .nimbusNotification(isPresented: $showAlert, type: .success, message: "Success!")
```

### Button Customization with Convenience Methods
NimbusUI provides SwiftUI-idiomatic convenience methods for button customization, following the same pattern as NimbusScroller:

```swift
// Basic button styles (no customization needed)
Button("Save") { }
    .buttonStyle(.accent)
    .controlSize(.regular)

// Button with custom corner radii and elevation
Button("Custom") { }
    .buttonStyle(.primary)
    .cornerRadii(RectangleCornerRadii(16))
    .elevation(.medium)
    .controlSize(.large)

// Label button with convenience methods
Button(action: {}) {
    Label("Delete", systemImage: "trash")
}
.buttonStyle(.accent)
.controlSize(.regular)
.hasDivider(true)
.iconAlignment(.leading)

// Label without divider and trailing icon
Button(action: {}) {
    Label("Next", systemImage: "arrow.right")
}
.buttonStyle(.accent)
.controlSize(.small)
.hasDivider(false)
.iconAlignment(.trailing)

// Advanced customization with multiple modifiers
Button(action: {}) {
    Label("Export", systemImage: "square.and.arrow.up")
}
.buttonStyle(.primary)
.controlSize(.regular)
.cornerRadii(RectangleCornerRadii(8))
.elevation(.high)
.labelConfiguration(hasDivider: true, iconAlignment: .leading, contentPadding: 8)

// Icon-only square button
Button(action: {}) {
    Image(systemName: "gear")
}
.buttonStyle(.secondary)
.controlSize(.regular)
.iconOnly()

// Wide banner button
Button("Get Started Now") { }
    .buttonStyle(.accent)
    .controlSize(.large)
    .banner(aspectRatio: 3.0)

// ControlSize variations across button styles
VStack {
    Button("Primary Large") { }
        .buttonStyle(.primary)
        .controlSize(.large)
    
    Button("Secondary Regular") { }
        .buttonStyle(.secondary)
        .controlSize(.regular)
    
    Button("Outline Small") { }
        .buttonStyle(.primaryOutline)
        .controlSize(.small)
    
    Button("Mini Secondary Outline") { }
        .buttonStyle(.secondaryOutline)
        .controlSize(.mini)
}
```

### Available Button Convenience Methods

**Core Customization:**
- `.cornerRadii(RectangleCornerRadii)` - Sets button corner radii
- `.minHeight(CGFloat)` - Sets minimum button height
- `.horizontalPadding(CGFloat)` - Sets horizontal padding
- `.elevation(Elevation)` - Sets shadow depth

**Label Configuration:**
- `.hasDivider(Bool)` - Controls divider between icon and text
- `.iconAlignment(HorizontalAlignment)` - Sets icon position (leading/trailing)
- `.contentPadding(CGFloat)` - Sets spacing between icon and text

**Aspect Ratio & Layout:**
- `.aspectRatio(CGFloat, contentMode: ContentMode)` - Sets button aspect ratio
- `.fixedHeight(Bool)` - Controls height behavior with aspect ratio

**Convenience Combinations:**
- `.labelConfiguration(hasDivider:iconAlignment:contentPadding:)` - Configure label settings in one call
- `.iconOnly(size:)` - Configure for square icon-only usage
- `.banner(aspectRatio:)` - Configure for wide banner buttons

**Migration from Legacy API:**
```swift
// Old complex initializer approach
Button("Save") { }
    .buttonStyle(.primary(
        cornerRadii: RectangleCornerRadii(12),
        elevation: .medium,
        hasDivider: true,
        iconAlignment: .trailing
    ))

// New convenience method approach
Button("Save") { }
    .buttonStyle(.primary)
    .cornerRadii(RectangleCornerRadii(12))
    .elevation(.medium)
    .hasDivider(true)
    .iconAlignment(.trailing)
```

### Notification System Usage
The notification system provides semantic notifications with flexible presentation:

```swift
import NimbusUI

// Basic notification with auto-dismiss
ContentView()
    .nimbusNotification(
        isPresented: $showSuccess,
        type: .success,
        message: "Payment completed successfully!",
        actionText: "View Details",
        dismissBehavior: .temporary(3.0)
    )

// Advanced notification with icon alignment and action handling
ContentView()
    .nimbusNotification(
        isPresented: $showWarning,
        type: .warning,
        message: "Action needed! Update payment information in your profile.",
        actionText: "Edit Profile",
        iconAlignment: .baseline,
        dismissBehavior: .sticky,
        onAction: { navigateToProfile() },
        onDismiss: { handleDismiss() }
    )

// Long message with proper text wrapping
ContentView()
    .nimbusNotification(
        isPresented: $showInfo,
        type: .info,
        message: "This is a very long informational message that demonstrates proper text wrapping without truncation while maintaining excellent readability.",
        iconAlignment: .top,
        dismissBehavior: .temporary(5.0)
    )
```

### Theme System Architecture

**Core Design Tokens (Required - 17 properties):**
- **Brand Colors** (4): `primaryColor`, `secondaryColor`, `tertiaryColor`, `accentColor`
- **Semantic Colors** (4): `errorColor`, `successColor`, `warningColor`, `infoColor`
- **Background Colors** (3): `backgroundColor`, `secondaryBackgroundColor`, `tertiaryBackgroundColor`
- **Text Colors** (3): `primaryTextColor`, `secondaryTextColor`, `tertiaryTextColor`
- **Border Colors** (2): `borderColor`, `secondaryBorderColor`
- **Core Design** (1): `backgroundMaterial`, `cornerRadii`, `animation`, `animationFast`, `minHeight`, `horizontalPadding`, `elevation`

**Component Design Tokens (Optional - 35+ properties):**
- **Button Tokens**: `buttonCornerRadii`, `compactButtonCornerRadii`, `labelContentSpacing`
- **List Tokens**: `listItemCornerRadii`, `listItemHeight`
- **Checkbox Tokens**: `checkboxSize`, `checkboxCornerRadii`, `checkboxBorderWidth`, `checkboxItemSpacing`, etc.
- **Notification Tokens**: `notificationTopPadding`, `notificationHorizontalPadding`, `notificationCornerRadii`, `notificationMinHeight`, `notificationIconSize`, `notificationPadding`, etc.
- **Scroller Tokens**: `scrollerWidth`, `scrollerKnobWidth`, `scrollerKnobPadding`, `scrollerSlotCornerRadius`, etc.

**Benefits of Optional Token System:**
- ✅ **Minimal Implementation**: Only 17 required properties vs 45+ previously
- ✅ **Selective Customization**: Override only what you need
- ✅ **Future-Proof**: New components add defaults, existing themes unaffected
- ✅ **Sensible Defaults**: Protocol extensions provide beautiful defaults
- ✅ **Better Developer Experience**: Focus on brand colors, not implementation details

All styling should go through the theme system with environment overrides when needed.

## ControlSize System

### Overview
NimbusUI features comprehensive controlSize support across all button styles, automatically adapting heights, padding, and font sizes based on SwiftUI's native ControlSize environment values.

### Supported Sizes
- `.large`: 52px height, 24px padding, 17pt font
- `.regular`: 44px height, 20px padding, 15pt font (default)
- `.small`: 36px height, 16px padding, 13pt font
- `.mini`: 28px height, 12px padding, 11pt font

### ControlSizeUtility
The `ControlSizeUtility` provides centralized controlSize management:

```swift
// Get metrics for any control size
let metrics = ControlSizeUtility.metrics(for: .large)
let height = ControlSizeUtility.height(for: .small)

// Theme-aware sizing with override support
let themeHeight = ControlSizeUtility.height(
    for: controlSize, 
    theme: theme, 
    override: overrideMinHeight
)
```

### Theme Integration
ControlSize values can be customized per theme through optional theme tokens:

```swift
extension CustomTheme {
    var buttonHeightLarge: CGFloat? { 60 }     // Custom large size
    var buttonPaddingSmall: CGFloat? { 14 }    // Custom small padding
    var buttonFontSizeRegular: CGFloat? { 16 } // Custom regular font
}
```

### Usage Patterns
```swift
// Standard controlSize usage
Button("Action") { }
    .buttonStyle(.primary)
    .controlSize(.large)

// Mixed sizes in layouts
HStack {
    Button("Cancel") { }
        .buttonStyle(.secondaryOutline)
        .controlSize(.small)
    
    Button("Confirm") { }
        .buttonStyle(.accent)
        .controlSize(.regular)
}

// All button styles support all controlSize values
VStack {
    Button("Large Primary") { }.buttonStyle(.primary).controlSize(.large)
    Button("Regular Accent") { }.buttonStyle(.accent).controlSize(.regular)
    Button("Small Secondary") { }.buttonStyle(.secondary).controlSize(.small)
    Button("Mini Outline") { }.buttonStyle(.primaryOutline).controlSize(.mini)
}
```

## Aspect Ratio System

### Overview
NimbusUI includes sophisticated aspect ratio support for buttons through the enhanced `NimbusAspectRatioModifier`, providing precise control over button geometry while maintaining full controlSize integration.

### Core Functionality
The `NimbusAspectRatioModifier` provides:
- **ControlSize Integration**: Automatically respects controlSize when calculating dimensions
- **Optional Enhancement**: Only applies aspect ratio constraints when environment values are configured
- **Backward Compatibility**: Existing buttons work unchanged without aspect ratio configuration
- **Theme Awareness**: Uses theme-based heights with controlSize and override support

### Environment Values
```swift
// Aspect ratio configuration (all optional)
@Entry var nimbusAspectRatio: CGFloat? = nil              // Target ratio (width/height)
@Entry var nimbusAspectRatioContentMode: ContentMode? = .fit // How content fits
@Entry var nimbusAspectRatioHasFixedHeight: Bool = true   // Whether height is fixed
```

### Usage Patterns

#### Default Behavior (No Changes)
```swift
// Standard button - no aspect ratio constraints applied
Button("Save") { }
    .buttonStyle(.primary)
    .controlSize(.regular)
// Behaves exactly as before - maxWidth: .infinity, controlSize-based minHeight
```

#### Square Icon Buttons
```swift
// Perfect for toolbar icons and action buttons
Button { } label: { Image(systemName: "gear") }
    .buttonStyle(.primary)
    .controlSize(.regular)
    .environment(\.nimbusAspectRatio, 1.0)              // 1:1 square
    .environment(\.nimbusAspectRatioContentMode, .fit)
```

#### Wide Banner Buttons
```swift
// Great for call-to-action buttons and banners
Button("Get Started Now") { }
    .buttonStyle(.accent)
    .controlSize(.large)
    .environment(\.nimbusAspectRatio, 3.0)              // 3:1 wide
    .environment(\.nimbusAspectRatioHasFixedHeight, true)
```

#### Responsive Proportional Buttons
```swift
// Maintains proportions while allowing flexibility
Button("Continue") { }
    .buttonStyle(.primary)
    .controlSize(.regular)
    .environment(\.nimbusAspectRatio, 2.5)              // 2.5:1 ratio
    .environment(\.nimbusAspectRatioContentMode, .fit)
    .environment(\.nimbusAspectRatioHasFixedHeight, false) // Allows vertical flexibility
```

### Implementation Details

#### NimbusAspectRatioModifier Logic
```swift
// When no aspect ratio is configured (default)
content.frame(maxWidth: .infinity, minHeight: controlSizeHeight, maxHeight: .infinity)

// When aspect ratio is configured
content
    .frame(minWidth: calculatedMinWidth, maxWidth: .infinity, minHeight: controlSizeHeight, maxHeight: maxHeight)
    .aspectRatio(aspectRatio, contentMode: contentMode)
    .fixedSize(horizontal: contentMode == .fit, vertical: hasFixedHeight)
```

#### ControlSize Integration
The modifier automatically uses `ControlSizeUtility.height(for:theme:override:)` for height calculations, ensuring:
- ✅ **Theme Consistency**: Respects theme-specific controlSize overrides
- ✅ **Environment Overrides**: Honors `nimbusMinHeight` environment values
- ✅ **Size Adaptation**: Aspect ratios scale appropriately with different controlSizes

### Architecture Benefits
- **Opt-In Enhancement**: Zero impact on existing code, only applies when configured
- **ControlSize Aware**: Seamlessly integrates with the controlSize system
- **Theme Compatible**: Works with all themes and theme overrides
- **Performance Optimized**: Only adds constraints when aspect ratio is specified

## Known Issues & Workarounds

### SwiftUI Preview Layout Bug
**Issue**: `.sizeThatFitsLayout` preview trait causes content clipping when used with VStacks containing multiple HStacks with Button+Label combinations.

**Symptoms**: Preview content gets cut off vertically, especially with complex button layouts using Labels and dividers.

**Workaround**: Remove `traits: .sizeThatFitsLayout` from previews and use standard `#Preview` instead.

**Affected Files**: All button style preview files now include documentation comments about this limitation.

**Root Cause**: SwiftUI framework bug in layout calculation system - not related to custom code.

## Design System Specialist Guidance

### For Complex Design System Tasks
Use the Task tool with specialized design system knowledge for:
- Component architecture and API design decisions
- Design token system implementation and organization
- Theming system enhancements and protocol design
- Cross-component consistency patterns
- Performance optimization of component libraries
- Accessibility integration in design systems

### Design System Principles
1. **Consistency First**: Every component should feel part of a cohesive system
2. **Developer Experience**: APIs should be intuitive and well-documented  
3. **Performance Aware**: Components should be optimized for real-world usage
4. **Accessibility**: All components must meet macOS accessibility standards
5. **Composability**: Components should work well together and be easily combinable

### Component Development Standards

#### File Organization (MANDATORY)
- **Folder Structure**: ALWAYS follow the standardized component folder pattern
- **Component Folder**: Create a dedicated folder for each component (e.g., `NewComponent/`)
- **Implementation Files**: Place main component files in the component folder root
- **Preview Separation**: ALWAYS create a `Preview/` subfolder for all SwiftUI previews
- **Preview Naming**: Use `ComponentName+Preview.swift` naming pattern
- **No Mixed Content**: NEVER embed preview code in implementation files

#### Theme Development Standards (IMPORTANT)
- **Minimal Implementation**: ALWAYS implement only the 17 required core properties first
- **Selective Overrides**: ONLY override component tokens when specifically needed for your design
- **Protocol Extensions**: Understand that 30+ component properties have sensible defaults
- **Testing**: Verify your theme works with ALL components even without overrides
- **Documentation**: Document which component tokens you override and why

#### Theme and API Integration
- **Theme Integration**: Access theme via `@Environment(\.nimbusTheme)` for design token defaults
- **Override Pattern**: Use `@Environment(\.nimbusProperty) private var overrideProperty` and apply as `overrideProperty ?? theme.property`
- **Design Token Usage**: Prefer theme-provided values over hardcoded constants
- **Behavioral vs Design**: Keep behavioral flags as environment-only, put visual properties in theme
- **Type Safety**: Use strong typing to prevent design inconsistencies
- **Documentation**: Include examples showing both theme defaults and override usage
- **Button API Pattern**: Use `AutoLabelDetectionModifier` to conditionally apply `NimbusDividerLabelStyle` only when environment values are set
- **Backward Compatibility**: Ensure new APIs don't break existing plain text button usage

#### Convenience Methods Pattern (MANDATORY)
**All components MUST provide SwiftUI-idiomatic convenience methods for customization following the Button pattern:**

- **Environment Override Pattern**: Use `public extension ComponentType` with convenience methods that set environment values
- **Method Categories**: 
  - **Core Customization**: Size, colors, corner radii, borders
  - **Behavioral Configuration**: States, interactions, animations  
  - **Convenience Combinations**: Common multi-property configurations
- **Implementation Structure**: Follow `Button+Extensions.swift` pattern with clear method grouping and comprehensive documentation
- **Naming Convention**: Use descriptive method names that match the property they configure (e.g., `.strokeWidth()`, `.cornerRadii()`)

**Example Implementation Pattern:**
```swift
// ComponentName+Extensions.swift
public extension ComponentName {
    // MARK: - Core Customization
    
    /// Sets the component size
    func size(_ size: CGFloat) -> some View {
        environment(\.nimbusComponentSize, size)
    }
    
    /// Sets the component corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusComponentCornerRadii, radii)
    }
    
    // MARK: - Behavioral Configuration
    
    /// Controls component interaction behavior
    func interactionEnabled(_ enabled: Bool) -> some View {
        environment(\.nimbusComponentInteractionEnabled, enabled)
    }
    
    // MARK: - Convenience Combinations
    
    /// Configures component with common settings
    func customConfiguration(
        size: CGFloat = 24,
        cornerRadii: RectangleCornerRadii = RectangleCornerRadii(4)
    ) -> some View {
        self
            .environment(\.nimbusComponentSize, size)
            .environment(\.nimbusComponentCornerRadii, cornerRadii)
    }
}
```

**Benefits of This Pattern:**
- ✅ **SwiftUI Idiomatic**: Matches native SwiftUI modifier patterns
- ✅ **Developer Experience**: Chainable, discoverable, well-documented
- ✅ **Consistency**: All components use the same customization approach
- ✅ **Type Safety**: Compile-time validation of configuration values
- ✅ **Future-Proof**: Easy to add new customization options

#### Environment Variable Usage Rule (CRITICAL)
**NEVER use environment variables directly in code - ALWAYS use convenience methods for ALL NimbusUI components:**

❌ **WRONG - Direct Environment Usage (Multiple Components):**
```swift
// Checkbox - WRONG
NimbusCheckbox(isOn: $isChecked)
    .environment(\.nimbusCheckboxStrokeWidth, 2.5)
    .environment(\.nimbusCheckboxLineCap, .round)
    .environment(\.nimbusCheckboxSize, 28)

// Button - WRONG  
Button("Save") { }
    .buttonStyle(.primary)
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(12))
    .environment(\.nimbusElevation, .medium)

// Scroller - WRONG
NimbusScroller(...)
    .environment(\.nimbusScrollerWidth, 16)
    .environment(\.nimbusScrollerKnobWidth, 12)
```

✅ **CORRECT - Convenience Methods (Multiple Components):**
```swift
// Checkbox - CORRECT
NimbusCheckbox(isOn: $isChecked)
    .strokeWidth(2.5)
    .lineCap(.round)
    .size(28)

// Button - CORRECT
Button("Save") { }
    .buttonStyle(.primary)
    .cornerRadii(RectangleCornerRadii(12))
    .elevation(.medium)

// Scroller - CORRECT  
NimbusScroller(...)
    .scrollerWidth(16)
    .knobWidth(12)
```

**Why This Universal Rule Exists:**
- **Developer Experience**: Convenience methods are discoverable via Xcode autocomplete across ALL components
- **Type Safety**: Methods provide compile-time validation of parameters for every component
- **Documentation**: Methods include comprehensive inline documentation for every customization option
- **Universal Consistency**: ALL components follow the same customization pattern (Checkbox, Button, Scroller, etc.)
- **Future-Proof**: Internal environment keys can change without breaking user code across the entire design system
- **Chainable API**: Methods create clean, readable SwiftUI modifier chains for every component
- **Design System Cohesion**: Ensures a unified developer experience across the entire NimbusUI library

**Universal Application:**
- ✅ **ALL Current Components**: Buttons, Checkboxes, Scrollers, Notifications, etc.
- ✅ **ALL Future Components**: This rule applies to every new component added to NimbusUI
- ✅ **ALL Customization Properties**: Size, colors, corner radii, spacing, interactions, etc.

**Exception:** Only use environment variables directly in component extensions when implementing the convenience methods themselves.

#### Theme Examples by Complexity
- **Minimal Theme**: Only 17 core properties - `MinimalTheme` (perfect starting point)
- **Selective Override**: Core + few component tokens - `MaritimeTheme` (scroller customization)
- **Full Customization**: Core + many component tokens - `CustomWarmTheme` (buttons + scroller)
- **Legacy Approach**: All properties explicitly defined - `NimbusTheme` (backward compatibility)

#### Theme File Locations & Examples
- **`MinimalThemeExample.swift`**: Complete minimal theme (17 properties) with comprehensive showcase demonstrating all components work with defaults
- **`MaritimeTheme.swift`**: Professional theme with selective scroller overrides
- **`CustomThemeExample.swift`**: Extensive warm theme with button and scroller customization + full component showcase
- **`NimbusTheme.swift`**: Clean default theme using protocol extension defaults

#### Usage Patterns for Theme Development
```swift
// Start with minimal approach
struct MyBrandTheme: NimbusTheming {
    // Implement 17 required properties only
    func primaryColor(for scheme: ColorScheme) -> Color { Color(hex: "#007AFF") }
    // ... 16 more core properties
    // All 30+ component tokens automatically use beautiful defaults!
}

// Add selective overrides as needed
extension MyBrandTheme {
    var checkboxSize: CGFloat { 20 } // Only if you need custom checkboxes
    var scrollerWidth: CGFloat { 12 } // Only if you need custom scrollers
}
```

#### Preview Standards
- **Separation**: ALL previews MUST be in dedicated `Preview/` folder
- **Layout Issues**: Avoid `traits: .sizeThatFitsLayout` for complex layouts; document SwiftUI limitations
- **Preview Content**: Include comprehensive examples covering all component states and configurations
- **Theme Variations**: Show component behavior across different themes when applicable

### Code Quality Requirements
- Follow Swift API Design Guidelines
- Use proper access control (public, internal, private)
- Implement comprehensive error handling
- Write self-documenting code with clear naming
- Include inline documentation for public APIs
