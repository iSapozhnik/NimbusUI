# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NimbusUI is a modular SwiftUI component library for macOS 14.0+ applications, built with Swift Package Manager. It provides a comprehensive theming system, reusable UI components, and custom view modifiers through six main libraries that can be imported selectively or as a complete umbrella package.

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
swift test --filter NimbusAlertsTests

# Clean build artifacts
swift package clean

# Resolve dependencies
swift package resolve

# Update snapshots when needed
swift test -Xswiftc -DUPDATE_SNAPSHOTS
```

### Modular Library Structure
NimbusUI is organized into six distinct libraries for selective importing:

- **`NimbusCore`**: Core theming system, modifiers, utilities, and AppKit integrations
- **`NimbusComponents`**: Main UI components (buttons, checkboxes, toggles, lists, scrollers)
- **`NimbusNotifications`**: Complete notification system with semantic types and animations
- **`NimbusOnboarding`**: Onboarding flows with FluidGradient and SmoothGradient animations
- **`NimbusBezel`**: System-level bezel notifications with positioning and theming
- **`NimbusAlerts`**: Modal and global window alert system with semantic styles
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
├── NimbusAlerts/            # Alert system library
│   ├── NimbusAlerts.swift   # Library entry point
│   ├── Components/
│   │   └── Alert/           # Complete alert system
│   │       ├── NimbusAlert.swift               # Main alert component
│   │       ├── NimbusAlertStyle.swift          # Alert semantic styles and button helpers
│   │       ├── NimbusAlertWindow.swift         # Global window alert implementation
│   │       ├── NimbusAlertModalModifier.swift  # In-app modal alert modifier
│   │       ├── View+NimbusAlert.swift          # View extension APIs
│   │       ├── NimbusAlert+Extensions.swift    # Alert convenience methods
│   │       └── Preview/                        # Alert preview examples
│   │           └── NimbusAlert+Preview.swift
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

// Alert system for modal and global alerts
import NimbusAlerts
ContentView()
    .nimbusModalAlert(
        isPresented: $showError,
        style: .error,
        title: "Connection Failed",
        message: "Unable to connect to server",
        actions: [.ok(), .cancel()]
    )

// Bezel system for system-level notifications
import NimbusBezel
NimbusBezel.show(
    image: NSImage(named: NSImage.networkName), 
    text: "Connected",
    position: .bottomTrailing
).hide(after: .seconds(2))
```

### Button Customization with Convenience Methods
NimbusUI provides SwiftUI-idiomatic convenience methods for button customization:

```swift
// Basic usage
Button("Save") { }.buttonStyle(.accent).controlSize(.regular)

// Custom styling
Button("Custom") { }
    .buttonStyle(.primary)
    .cornerRadii(RectangleCornerRadii(16))
    .elevation(.medium)
    .controlSize(.large)

// Label with divider
Button(action: {}) { Label("Delete", systemImage: "trash") }
    .buttonStyle(.accent)
    .hasDivider(true)
    .iconAlignment(.leading)

// Toggle usage
NimbusToggle(isOn: $isEnabled)
    .circularToggle()
    .toggleKnobSize(22)
    .bouncyToggle()
```

### Available Convenience Methods

**Button Methods:**
- Core: `.cornerRadii()`, `.minHeight()`, `.elevation()`, `.horizontalPadding()`
- Labels: `.hasDivider()`, `.iconAlignment()`, `.contentPadding()`
- Layout: `.aspectRatio()`, `.iconOnly()`, `.banner()`

**Toggle Methods:**
- Shapes: `.circularToggle()`, `.squareToggle()`, `.roundedToggle()`
- Sizing: `.toggleKnobSize()`, `.toggleKnobPadding()`, `.trackWidth()`
- Animation: `.bouncyToggle()`, `.smoothToggle()`, `.quickToggle()`
- Layout: `.toggleItemSpacing()`, `.toggleItemPadding()`

### Notification System Usage
```swift
// Basic usage
ContentView()
    .nimbusNotification(
        isPresented: $showSuccess,
        type: .success,
        message: "Payment completed!",
        dismissBehavior: .temporary(3.0)
    )

// Advanced usage
ContentView()
    .nimbusNotification(
        isPresented: $showWarning,
        type: .warning,
        message: "Action needed!",
        actionText: "Fix",
        iconAlignment: .baseline,
        onAction: { handleAction() }
    )
```

### Onboarding System Usage
```swift
// Basic usage
let features: [AnyFeature] = [
    AnyFeature.imageFeature(
        title: "Welcome",
        description: "Get started with our platform",
        image: Image(systemName: "sparkles")
    ),
    AnyFeature.iconFeature(
        title: "Quick Actions",
        description: "Access powerful features",
        systemName: "bolt.fill"
    )
]

OnboardingView(features: features)

// Custom content with animations
AnyFeature(title: "Custom", description: "Beautiful designs") {
    MyCustomView().levitatingFeatureContent()
}

// Features: Auto navigation, page control, footer links, theme integration
```

### Alert System Usage
```swift
// Modal alerts (in-app overlays)
ContentView()
    .nimbusModalAlert(
        isPresented: $showSuccess,
        style: .success,
        title: "Upload Complete",
        message: "Your file has been uploaded successfully.",
        actions: [.ok()]
    )

// Global window alerts (system dialogs)
ContentView()
    .nimbusAlert(
        "Confirm Delete",
        message: "This action cannot be undone.",
        isPresented: $showConfirmation,
        actions: [
            .destructive("Delete") { performDelete() },
            .cancel()
        ]
    )

// Alert styles and customization
let actions: [NimbusAlertButton] = [
    .ok(),
    .cancel(),
    .custom("Retry", role: nil) { retryAction() },
    .destructive("Delete All") { deleteAll() }
]
```

### Theme System Architecture

**Required Core Tokens (17):** Brand colors (4), semantic colors (4), background colors (3), text colors (3), border colors (2), core design (1)

**Optional Component Tokens (35+):** Button, checkbox, toggle, notification, scroller, list, bezel, alert tokens with sensible defaults

**Benefits:** Minimal implementation (17 vs 45+ properties), selective customization, future-proof, better developer experience

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
ControlSize values can be customized per theme:

```swift
extension CustomTheme {
    var buttonHeightLarge: CGFloat? { 60 }
    var buttonPaddingSmall: CGFloat? { 14 }
}
```

### Usage Patterns
```swift
// Standard usage
Button("Action") { }.buttonStyle(.primary).controlSize(.large)

// Mixed sizes
HStack {
    Button("Cancel") { }.buttonStyle(.secondaryOutline).controlSize(.small)
    Button("Confirm") { }.buttonStyle(.accent).controlSize(.regular)
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
```swift
// Default - no constraints
Button("Save") { }.buttonStyle(.primary).controlSize(.regular)

// Square icons
Button { Image(systemName: "gear") }
    .buttonStyle(.primary)
    .environment(\.nimbusAspectRatio, 1.0)

// Wide banners
Button("Get Started") { }
    .buttonStyle(.accent)
    .environment(\.nimbusAspectRatio, 3.0)
```

### Implementation Details
The modifier uses `ControlSizeUtility.height(for:theme:override:)` ensuring theme consistency, environment overrides, and proper size adaptation across controlSizes.

### Benefits
Opt-in enhancement with zero impact on existing code, controlSize aware, theme compatible, performance optimized.

## Bezel System

### Overview
System-level notification bezels for menubar apps. Features 7 positioning options, theme integration, queue management, and programmatic API.

### Basic Usage
```swift
// Simple bezel
NimbusBezel.show(
    image: NSImage(named: NSImage.networkName),
    text: "Connected",
    position: .bottomTrailing
).hide(after: .seconds(2))

// Custom theme
NimbusBezel.show(
    image: volumeIcon,
    text: "Volume: 75%",
    theme: MenubarTheme(),
    position: .top
)
```

### Positions
7 options: center, top, bottom, topLeading, topTrailing, bottomLeading, bottomTrailing. Theme-aware offsets for positioning.

### Features
- NSWindow-based floating above all apps
- Automatic queue management
- Theme integration for appearance/positioning
- Multi-screen aware
- Accessibility compatible

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

**Implementation Pattern:**
```swift
public extension ComponentName {
    func size(_ size: CGFloat) -> some View {
        environment(\.nimbusComponentSize, size)
    }
    
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusComponentCornerRadii, radii)
    }
}
```

**Benefits:** SwiftUI idiomatic, chainable, consistent, type-safe, future-proof

#### Environment Variable Usage Rule (CRITICAL)
**NEVER use environment variables directly - ALWAYS use convenience methods:**

❌ **WRONG:**
```swift
NimbusCheckbox(isOn: $isChecked)
    .environment(\.nimbusCheckboxStrokeWidth, 2.5)
    .environment(\.nimbusCheckboxSize, 28)
```

✅ **CORRECT:**
```swift
NimbusCheckbox(isOn: $isChecked)
    .strokeWidth(2.5)
    .size(28)
```

**Why:** Developer experience, type safety, documentation, consistency, future-proof, chainable API. Applies to ALL components and properties.

#### Theme Development
**Examples by Complexity:**
- `MinimalTheme`: 17 core properties (starting point)
- `MaritimeTheme`: Core + scroller overrides
- `CustomWarmTheme`: Core + button/scroller tokens
- `NimbusTheme`: Full backward compatibility

**Usage Pattern:**
```swift
struct MyBrandTheme: NimbusTheming {
    func primaryColor(for scheme: ColorScheme) -> Color { Color(hex: "#007AFF") }
    // ... 16 more core properties
}

// Add overrides as needed
extension MyBrandTheme {
    var checkboxSize: CGFloat { 20 }
    var scrollerWidth: CGFloat { 12 }
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
