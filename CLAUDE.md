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
swift test --filter NimbusBezelsTests

# Clean build artifacts
swift package clean

# Resolve dependencies
swift package resolve

# Update snapshots when needed
swift test -Xswiftc -DUPDATE_SNAPSHOTS
```

### Modular Library Structure
NimbusUI is organized into five distinct libraries for selective importing:

- **`NimbusCore`**: Core theming system, modifiers, utilities, and AppKit integrations
- **`NimbusComponents`**: Main UI components (buttons, checkboxes, toggles, lists, scrollers)
- **`NimbusNotifications`**: Complete notification system with semantic types and animations
- **`NimbusOnboarding`**: Onboarding flows with FluidGradient and SmoothGradient animations
- **`NimbusBezel`**: System-level bezel notifications with positioning and theming
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

## Modifier-First Architecture Guidelines

**IMPORTANT**: NimbusUI follows a modifier-first architecture approach. Always prefer reusable modifiers over per-component custom implementations.

### Core Principles

1. **Reuse First**: Always check existing modifiers (`NimbusFilledModifier`, `NimbusBorderedModifier`, `NimbusHoverableModifier`, etc.) before implementing custom styling
2. **Create Modifiers**: When existing modifiers don't meet requirements, create new reusable modifiers instead of per-component solutions
3. **Avoid Duplication**: Never implement custom background/border/interaction logic within individual components
4. **Consistency**: Modifiers ensure consistent behavior and styling across all components

### Benefits

- **Consistency**: All components behave identically for similar interactions
- **Maintainability**: Changes to modifier behavior automatically apply to all components
- **Code Reduction**: Eliminates duplicate styling logic across components
- **Testing**: Modifiers can be tested independently and thoroughly

### Implementation Example

TextField component evolution shows this principle in action:
- **Before**: Custom background/border implementation with potential visual inconsistencies
- **After**: Uses `NimbusFilledModifier` and `NimbusBorderedModifier` for consistent styling with Button components

### Modifier Evaluation Checklist

When developing new components, evaluate styling needs with these questions:
- [ ] Can existing modifiers handle this styling need?
- [ ] If not, would a new modifier benefit multiple components?
- [ ] Does this create consistent behavior across the design system?
- [ ] Is the styling logic reusable and testable independently?

### Available Core Modifiers

- **`NimbusFilledModifier`**: Fill backgrounds with interaction states (hover, pressed)
- **`NimbusBorderedModifier`**: Bordered appearance with hover states
- **`NimbusHoverableModifier`**: Hover interactions with customizable effects
- **`NimbusShadowModifier`**: Elevation-based shadows
- **`NimbusInnerShadowModifier`**: Inner shadow effects
- **`NimbusGradientBorderModifier`**: Gradient borders
- **`LevitatingViewModifier`**: Floating effects
- **`NimbusAspectRatioModifier`**: Aspect ratio constraints with controlSize integration

### Key Components

**Button System** (`Sources/NimbusComponents/Components/ButtonStyles/`): Comprehensive button system with five main styles (primary, accent, secondary, primaryOutline, secondaryOutline) plus specialized styles (LinkButtonStyle, CloseButtonStyle). All styles feature Enhanced Button + Label API for automatic divider detection and full controlSize support (.large, .regular, .small, .mini). LinkButtonStyle provides text-only action buttons, CloseButtonStyle provides icon-only dismiss buttons.

**Checkbox System** (`Sources/NimbusComponents/Components/Checkbox/`): `NimbusCheckbox` standalone component and `NimbusCheckboxItem` with title/subtitle support, flexible positioning (leading/trailing), and full theming integration.

**Toggle System** (`Sources/NimbusComponents/Components/Toggle/`): `NimbusToggle` interactive toggle switch with drag gestures, customizable shapes (circle, square, rounded rectangle), and `NimbusToggleItem` with title/subtitle support. Features real-time drag interaction, threshold-based switching, controlSize integration, and comprehensive animation presets (bouncy, smooth, quick). All components follow the convenience method pattern with methods like `.circularToggle()`, `.squareToggle()`, `.roundedToggle()`, `.toggleKnobSize()`, `.trackWidth()`, etc.

**Badge System** (`Sources/NimbusComponents/Components/Badge/`): `BadgeView` component for status indicators, counters, and labels with theming integration.

**TextField System** (`Sources/NimbusComponents/Components/TextField/`): `NimbusTextField` component for styled text input with modifier-based architecture using `NimbusFilledModifier` and `NimbusBorderedModifier`, theme integration, enhanced visual stability, focus/hover states, string-based input with prompt text support, and full controlSize support (.extraLarge through .mini). Demonstrates the modifier-first architecture principle by reusing existing modifier components for consistent styling and behavior.

**List Components** (`Sources/NimbusComponents/Components/List/`): `ListItem` with configurable hover states and theming.

**Scroll System** (`Sources/NimbusComponents/Components/ScrollView/` & `Sources/NimbusComponents/Components/Scroller/`): `NimbusScrollView` (NSScrollView wrapper) and `NimbusScroller` (standalone scroller) with custom theming and visibility controls.

**Notification System** (`Sources/NimbusNotifications/Components/Notification/`): Complete notification system with `NimbusNotificationView` component, view modifier presentation (`.nimbusNotification()`), 4 semantic types (info, success, warning, error), auto-dismiss timing, icon alignment options, and enhanced color hierarchy using theme semantic colors.

**Onboarding System** (`Sources/NimbusOnboarding/Components/Onboarding/`): Complete onboarding flow with FluidGradient + SmoothGradient animations, generic content system supporting `Feature<Content>` and `AnyFeature`, navigation controls with back/forward buttons, footer links with semantic styling, hover effects with conditional masking, and fixed dimensions (600x560). Features convenience static methods (`AnyFeature.imageFeature()`, `AnyFeature.iconFeature()`), content styling extensions (`.levitatingFeatureContent()`, `.scaleFeatureContent()`, etc.), and full theme integration.

**Bezel System** (`Sources/NimbusBezel/NimbusBezel.swift`): System-level notification bezels for menubar apps and macOS system-style notifications. Features 7 positioning options (center, top, bottom, topLeading, topTrailing, bottomLeading, bottomTrailing), theme integration with customizable offsets, programmatic API with static convenience methods and direct instantiation, auto-hide timing with queue management, NSVisualEffectView blur materials, automatic light/dark mode detection, and smooth show/hide animations. Perfect for volume controls, status indicators, and system-level notifications that float above all applications.

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
│   │   ├── TextField/       # TextField components
│   │   │   ├── NimbusTextField.swift
│   │   │   ├── NimbusTextField+Extensions.swift
│   │   │   └── Preview/
│   │   │       └── NimbusTextField+Preview.swift
│   │   ├── Checkbox/        # Checkbox components
│   │   │   ├── NimbusCheckbox.swift
│   │   │   ├── NimbusCheckboxItem.swift
│   │   │   ├── NimbusCheckbox+Extensions.swift
│   │   │   └── Preview/
│   │   ├── Toggle/          # Toggle components
│   │   │   ├── NimbusToggle.swift
│   │   │   ├── NimbusToggleItem.swift
│   │   │   ├── NimbusToggle+Extensions.swift
│   │   │   ├── NimbusToggleShape.swift
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
│   ├── Components/
│   │   └── Onboarding/      # Onboarding flow components
│   │       ├── FeaturePageView.swift      # Generic Feature<Content> and AnyFeature page views
│   │       ├── OnboardingView.swift       # Main onboarding view with navigation controls
│   │       ├── PageControlView.swift      # Page control dots indicator
│   │       └── Preview/                   # Comprehensive preview examples
│   └── Extensions/          # Onboarding convenience methods
│       └── Feature+Extensions.swift       # AnyFeature static methods and content styling
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

// Bezel system for system-level notifications
import NimbusBezel
NimbusBezel.show(
    image: NSImage(named: NSImage.networkName), 
    text: "Connected",
    position: .bottomTrailing
).hide(after: .seconds(2))
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

// Toggle examples with shapes and customization
@State private var isEnabled = false
@State private var darkMode = true

// Basic toggle with drag interaction
NimbusToggle(isOn: $isEnabled)
    .circularToggle()
    .controlSize(.regular)

// Toggle item with subtitle and custom positioning
NimbusToggleItem(
    "Dark Mode", 
    subtitle: "Use dark theme throughout the app",
    isOn: $darkMode,
    togglePosition: .leading
)
.controlSize(.large)

// Customized toggle with animation
NimbusToggle(isOn: $isEnabled)
    .squareToggle()
    .toggleKnobSize(22)
    .toggleKnobPadding(6)
    .bouncyToggle()
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

### Available Toggle Convenience Methods

**Shape Configuration:**
- `.circularToggle()` - Traditional iOS-style circular knob with capsule track
- `.squareToggle()` - Modern square knob with rectangular track  
- `.roundedToggle(cornerRadius:)` - Custom rounded rectangle knob and track

**Size & Dimensions:**
- `.toggleKnobSize(CGFloat)` - Sets knob diameter
- `.toggleKnobPadding(CGFloat)` - Sets padding around knob inside track
- `.trackWidth(CGFloat)` - Override auto-calculated track width
- `.trackHeight(CGFloat)` - Override auto-calculated track height

**Animation Styles:**
- `.bouncyToggle()` - Bouncy spring animation with enhanced bounce
- `.smoothToggle()` - Smooth spring animation (default feel)
- `.quickToggle()` - Quick easeInOut animation for snappy interactions
- `.toggleAnimation(Animation)` - Custom animation spring

**Toggle Item Configuration:**
- `.toggleItemSpacing(CGFloat)` - Space between toggle and text
- `.toggleTextSpacing(CGFloat)` - Space between title and subtitle
- `.toggleItemPadding(CGFloat)` - Padding around toggle items
- `.toggleItemMinHeight(CGFloat)` - Minimum height for toggle items

**Toggle Integration Notes:**
Toggle components automatically respond to SwiftUI's native controlSize environment just like buttons and other controls. The convenience method pattern ensures consistent developer experience across all NimbusUI components.

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

### Onboarding System Usage
The onboarding system provides a flexible, generic content system for creating beautiful onboarding flows:

```swift
import NimbusOnboarding

// Basic usage with pre-styled content
let features: [AnyFeature] = [
    // Image feature with automatic styling
    AnyFeature.imageFeature(
        title: "Welcome to Your App",
        description: "Get started with our powerful platform",
        image: Image(systemName: "sparkles"),
        imageSize: 120
    ),
    
    // Icon feature with SF Symbols
    AnyFeature.iconFeature(
        title: "Quick Actions",
        description: "Access powerful features instantly",
        systemName: "bolt.fill",
        iconSize: 80
    )
]

OnboardingView(features: features)
    .environment(\.nimbusTheme, NimbusTheme.default)

// Advanced usage with custom content
let customFeatures: [AnyFeature] = [
    // Custom ViewBuilder content
    AnyFeature(
        title: "Custom Interface",
        description: "Experience beautiful custom designs"
    ) {
        RoundedRectangle(cornerRadius: 20)
            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 120, height: 120)
            .levitatingFeatureContent()  // Built-in animation effect
    },
    
    // Interactive NimbusUI components
    AnyFeature(
        title: "Configure Settings",
        description: "Set up your preferences"
    ) {
        VStack(spacing: 16) {
            NimbusToggleItem(
                "Enable notifications",
                subtitle: "Stay updated with important alerts", 
                isOn: .constant(true),
                togglePosition: .leading
            )
            .controlSize(.small)
            .toggleShape(.roundedRect(3))
        }
        .padding(20)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
]

OnboardingView(features: customFeatures)

// Content styling extensions
MyCustomView()
    .levitatingFeatureContent()           // Adds floating animation effect
    .scaleFeatureContent(scale: 1.2)      // Adds scaling animation  
    .centeredFeatureContent()             // Centers within available space
    .fadeInFeatureContent(delay: 0.5)     // Adds fade-in effect with delay

// Navigation and footer features:
// - Automatic "Continue" → "Finish" button progression
// - Back button appears conditionally with smooth transitions  
// - Page control dots showing current progress
// - Footer with Privacy Policy and Terms & Conditions using .nimbusLink style
// - All animations respect theme.animationFast with environment override support
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

## Bezel System

### Overview
The NimbusBezel system provides system-level notification bezels that float above all applications, perfect for menubar applications and macOS system-style notifications. The system features comprehensive positioning control, theme integration, and a programmatic API designed for standalone usage.

### Core Features
- **System-Level Display**: NSWindow-based implementation that floats above all applications but never becomes key
- **7 Position Options**: Complete screen positioning with theme-aware offset controls
- **Theme Integration**: Full theming support with customizable appearance and positioning offsets
- **Queue Management**: Automatic sequential display of multiple bezels with timing control
- **Programmatic API**: Both static convenience methods and direct instantiation patterns

### Position System
```swift
public enum BezelPosition: CaseIterable {
    case center         // Perfect mathematical center of screen (no theme offsets)
    case top           // Center horizontally, positioned from top using bezelTopOffset
    case bottom        // Center horizontally, positioned from bottom using bezelBottomOffset (default)
    case topLeading    // Top-left corner using bezelTopOffset + bezelHorizontalOffset
    case topTrailing   // Top-right corner using bezelTopOffset + bezelHorizontalOffset
    case bottomLeading // Bottom-left corner using bezelBottomOffset + bezelHorizontalOffset
    case bottomTrailing// Bottom-right corner using bezelBottomOffset + bezelHorizontalOffset
}
```

### API Patterns

#### Static Convenience API (Recommended)
```swift
// Basic usage with positioning
NimbusBezel.show(
    image: NSImage(named: NSImage.networkName),
    position: .bottomTrailing
).hide(after: .seconds(2))

// With text and custom theme
NimbusBezel.show(
    image: NSImage(named: NSImage.statusAvailableName),
    text: "Connected",
    theme: MaritimeTheme(),
    position: .top
).hide(after: .seconds(3))

// Multiple bezels queue automatically
NimbusBezel.show(image: image1, text: "First").hide(after: .seconds(2))
NimbusBezel.show(image: image2, text: "Second").hide(after: .seconds(2))
NimbusBezel.show(image: image3, text: "Third").hide(after: .seconds(2))
```

#### Direct Instantiation API
```swift
// Advanced control over configuration
let bezel = NimbusBezel(
    image: NSImage(named: NSImage.cautionName),
    text: "Network disconnected",
    theme: CustomWarmTheme(),
    colorScheme: .dark,
    position: .center
)

bezel.appearance(NSAppearance(named: .darkAqua))
bezel.show().hide(after: .seconds(4))

// Manual dismiss control
let persistentBezel = NimbusBezel.show(image: image, text: "Manual dismiss")
// Later: persistentBezel.hide()
```

### Theme Integration
Bezel positioning and appearance can be customized through theme tokens:

```swift
extension CustomTheme {
    // Positioning offset control
    var bezelTopOffset: CGFloat { 80.0 }        // Distance from top edge
    var bezelBottomOffset: CGFloat { 40.0 }     // Distance from bottom edge
    var bezelHorizontalOffset: CGFloat { 100.0 } // Distance from side edges
    
    // Visual appearance
    var bezelSize: CGSize { CGSize(width: 220, height: 220) }
    var bezelCornerRadius: CGFloat { 24.0 }
    var bezelContentPadding: CGFloat { 24.0 }
    var bezelBlurMaterial: NSVisualEffectView.Material { .hudWindow }
    
    // Animation timing
    var bezelShowAnimationDuration: TimeInterval { 0.4 }
    var bezelHideAnimationDuration: TimeInterval { 0.6 }
}
```

### Implementation Details

#### Positioning Logic
The `positionBezel()` method uses screen coordinates and theme offsets:

```swift
switch position {
case .center:
    // Perfect mathematical center (no theme offset)
    newFrame.origin.x = (screenFrame.width - bezelSize.width) / 2
    newFrame.origin.y = (screenFrame.height - bezelSize.height) / 2
    
case .top:
    // Center horizontally, offset from top using theme
    newFrame.origin.x = (screenFrame.width - bezelSize.width) / 2
    newFrame.origin.y = screenFrame.height - bezelSize.height - theme.bezelTopOffset
    
case .bottomTrailing:
    // Corner position using both horizontal and bottom offsets
    newFrame.origin.x = screenFrame.width - bezelSize.width - theme.bezelHorizontalOffset
    newFrame.origin.y = theme.bezelBottomOffset
    
// ... other positions with theme-aware calculations
}
```

#### System Integration
- Uses `NSWindow.Level.cursorWindow` for proper layering above all applications
- Uses `NSScreen.current` for accurate screen detection and positioning
- Automatic system appearance detection and theme application
- NSVisualEffectView integration for proper blur materials and vibrancy
- CAMediaTimingFunction support for smooth show/hide animations

### Development Patterns

#### Menubar Application Usage
Perfect for system-level status indicators and notifications:

```swift
// Volume control bezel
func showVolumeBezel(level: Float) {
    let volumeIcon = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
    NimbusBezel.show(
        image: volumeIcon,
        text: "Volume: \(Int(level * 100))%",
        position: .bottomTrailing
    ).hide(after: .seconds(1.5))
}

// Network status notification
func showNetworkStatus(connected: Bool) {
    let icon = NSImage(named: connected ? NSImage.networkName : NSImage.cautionName)
    let message = connected ? "Network connected" : "Network disconnected"
    
    NimbusBezel.show(
        image: icon,
        text: message,
        position: .top
    ).hide(after: .seconds(2))
}
```

#### Theme-Aware Development
```swift
// Bezels use explicit positioning with theme-aware offsets
let bezel = NimbusBezel(image: image, theme: myTheme, position: .bottomTrailing)
let centered = NimbusBezel(image: image, theme: myTheme, position: .center) // Mathematical center

// Theme positioning offsets can be customized per-theme
struct MenubarTheme: NimbusTheming {
    // ... 17 required core properties
    
    // Custom offsets for menubar app positioning
    var bezelBottomOffset: CGFloat { 20 }       // Closer to screen bottom
    var bezelHorizontalOffset: CGFloat { 20 }   // Closer to screen edge
    var bezelTopOffset: CGFloat { 40 }          // Less space from top
}

// Usage with custom theme
NimbusBezel.show(
    image: volumeIcon,
    text: "Volume: 75%",
    theme: MenubarTheme(),
    position: .bottomTrailing  // Uses custom offsets from theme
).hide(after: .seconds(1.5))
```

### Architecture Benefits
- **System-Level Integration**: Proper NSWindow configuration for floating above all applications
- **Theme Consistency**: All positioning and appearance controlled through theme system
- **Queue Management**: Automatic handling of multiple bezels with sequential display
- **Memory Efficient**: Bezels are properly cleaned up after hide animations complete
- **Accessibility**: Bezels don't interfere with VoiceOver or keyboard navigation
- **Multi-Screen Aware**: Automatically positions relative to current screen

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
6. **Modifier-First Architecture**: Always prefer reusable modifiers over per-component custom implementations

### Component Development Standards

#### Modifier-First Development (MANDATORY)
- **Reuse Existing Modifiers**: ALWAYS check available modifiers (`NimbusFilledModifier`, `NimbusBorderedModifier`, `NimbusHoverableModifier`) before implementing custom styling
- **Create Reusable Modifiers**: When existing modifiers don't meet needs, create new modifiers that can benefit multiple components
- **Avoid Custom Implementations**: NEVER implement custom background/border/interaction logic within individual components
- **Consistency Check**: Ensure new components use the same modifier patterns as existing components (see TextField's use of `NimbusFilledModifier` and `NimbusBorderedModifier`)
- **Modifier Documentation**: Document which modifiers are used and why they were chosen over custom implementations

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

// Toggle - WRONG
NimbusToggle(isOn: $isToggled)
    .environment(\.nimbusToggleKnobSize, 24)
    .environment(\.nimbusToggleKnobPadding, 6)
    .environment(\.nimbusToggleShape, .circle)

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

// Toggle - CORRECT
NimbusToggle(isOn: $isToggled)
    .toggleKnobSize(24)
    .toggleKnobPadding(6)
    .circularToggle()

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
- ✅ **ALL Current Components**: Buttons, Checkboxes, Toggles, Scrollers, Notifications, etc.
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
