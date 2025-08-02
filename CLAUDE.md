# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NimbusUI is a SwiftUI component library for macOS 14.0+ applications, built with Swift Package Manager. It provides a comprehensive theming system, reusable UI components, and custom view modifiers.

## Development Commands

### Build and Test
```bash
# Build the package
swift build

# Run tests
swift test

# Clean build artifacts
swift package clean

# Resolve dependencies
swift package resolve
```

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

**Button Hierarchy**: Structured button styles with appearance definitions:
- `.primaryDefault` / `.primaryProminent` - Primary buttons
- `.secondaryProminent` / `.secondaryBordered` - Secondary buttons

**Enhanced Button + Label API**: Auto-detection system that applies `NimbusDividerLabelStyle` when Label environment values are set:
- `nimbusButtonHasDivider: Bool?` - Controls divider visibility (nil = no styling, true/false = apply with/without divider)
- `nimbusButtonIconAlignment: HorizontalAlignment?` - Controls icon position (leading/trailing)
- `nimbusButtonContentPadding: CGFloat?` - Controls label content padding
- All button styles automatically apply label styling when environment values are present
- Maintains full backward compatibility with plain text buttons

### Key Components

**Button System** (`Sources/NimbusUI/Components/ButtonStyles/`): Six button styles (primaryDefault, primaryProminent, secondaryProminent, secondaryBordered, LinkButtonStyle, CloseButtonStyle) with Enhanced Button + Label API for automatic divider detection. LinkButtonStyle provides text-only action buttons, CloseButtonStyle provides icon-only dismiss buttons.

**Checkbox System** (`Sources/NimbusUI/Components/Checkbox/`): `NimbusCheckbox` standalone component and `NimbusCheckboxItem` with title/subtitle support, flexible positioning (leading/trailing), and full theming integration.

**List Components** (`Sources/NimbusUI/Components/List/`): `ListItem` with configurable hover states and theming.

**Onboarding System** (`Sources/NimbusUI/Components/Onboarding/`): Complete onboarding flow with FluidGradient animations, fixed dimensions (600x560), and page navigation.

**Scroll System** (`Sources/NimbusUI/Components/ScrollView/` & `Sources/NimbusUI/Components/Scroller/`): `NimbusScrollView` (NSScrollView wrapper) and `NimbusScroller` (standalone scroller) with custom theming and visibility controls.

**Notification System** (`Sources/NimbusUI/Components/Notification/`): Complete notification system with `NimbusNotificationView` component, view modifier presentation (`.nimbusNotification()`), 4 semantic types (info, success, warning, error), auto-dismiss timing, icon alignment options, and enhanced color hierarchy using theme semantic colors.

### Project Structure
```
Sources/NimbusUI/
├── NimbusUI.swift          # Library entry point
├── Components/             # UI components following standardized structure
│   ├── ButtonStyles/       # Button style implementations
│   │   ├── Appearance.swift
│   │   ├── PrimaryDefaultButtonStyle.swift
│   │   ├── PrimaryProminentButtonStyle.swift
│   │   ├── SecondaryBorderedButtonStyle.swift
│   │   ├── SecondaryProminentButtonStyle.swift
│   │   ├── LinkButtonStyle.swift
│   │   ├── CloseButtonStyle.swift
│   │   └── Preview/        # Dedicated preview files
│   │       ├── PrimaryDefaultButtonStyle+Preview.swift
│   │       ├── PrimaryProminentButtonStyle+Preview.swift
│   │       ├── SecondaryBorderedButtonStyle+Preview.swift
│   │       ├── SecondaryProminentButtonStyle+Preview.swift
│   │       ├── LinkButtonStyle+Preview.swift
│   │       └── CloseButtonStyle+Preview.swift
│   ├── Checkbox/           # Checkbox components
│   │   ├── NimbusCheckbox.swift
│   │   ├── NimbusCheckboxItem.swift
│   │   └── Preview/
│   │       ├── NimbusCheckbox+Preview.swift
│   │       └── NimbusCheckboxItem+Preview.swift
│   ├── List/               # List components
│   │   ├── ListItem.swift
│   │   └── Preview/
│   │       └── ListItem+Preview.swift
│   ├── Notification/       # Notification system
│   │   ├── NimbusNotificationView.swift
│   │   ├── NimbusNotificationModifier.swift
│   │   ├── View+NimbusNotification.swift
│   │   ├── NotificationDismissBehavior.swift
│   │   ├── NotificationType.swift
│   │   ├── NotificationIconAlignment.swift
│   │   └── Preview/
│   │       └── NimbusNotificationView+Preview.swift
│   ├── Onboarding/         # Onboarding system
│   │   ├── FeaturePageView.swift
│   │   ├── OnboardingView.swift
│   │   ├── PageControlView.swift
│   │   └── Preview/
│   │       └── OnboardingView+Preview.swift
│   ├── ScrollView/         # Custom scroll view
│   │   ├── NimbusScrollView.swift
│   │   └── Preview/
│   │       └── NimbusScrollView+Preview.swift
│   └── Scroller/           # Custom scroller component
│       ├── NimbusScroller.swift
│       └── Preview/
│           └── NimbusScroller+Preview.swift
├── Extensions/             # Swift extensions
├── Modifiers/              # Custom SwiftUI modifiers
└── Theming/               # Theme system and protocols
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

- **Swift**: 6.1+ minimum
- **Platform**: macOS 14.0+ only
- **Dependencies**: FluidGradient (v1.0.0+) for onboarding animations
- **Testing**: Swift Testing framework (not XCTest)

## Usage Patterns

### Theme-First Architecture
Components use theme defaults with optional environment overrides:

```swift
import NimbusUI

// Basic theme application
Button("Action") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusTheme, NimbusTheme.default)

// Theme with property overrides
Button("Custom") { }
    .buttonStyle(.primaryDefault) 
    .environment(\.nimbusTheme, MaritimeTheme())
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
    .environment(\.nimbusMinHeight, 50)
```

### Enhanced Button + Label API Usage
The enhanced API provides flexible button configurations:

```swift
// Plain text button (no changes needed)
Button("Save") { }
    .buttonStyle(.primaryProminent)

// Label with default divider (auto-applied)
Button(action: {}) {
    Label("Delete", systemImage: "trash")
}
.buttonStyle(.primaryProminent)
.environment(\.nimbusButtonHasDivider, true)

// Label without divider
Button(action: {}) {
    Label("Export", systemImage: "square.and.arrow.up")
}
.buttonStyle(.primaryProminent)
.environment(\.nimbusButtonHasDivider, false)

// Label with trailing icon
Button(action: {}) {
    Label("Next", systemImage: "arrow.right")
}
.buttonStyle(.primaryProminent)
.environment(\.nimbusButtonIconAlignment, .trailing)
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
- **Notification Tokens**: `notificationTopPadding`, `notificationHorizontalPadding`, `notificationCornerRadii`, `notificationBackgroundOpacity`, `notificationMinHeight`, `notificationIconSize`, `notificationPadding`, etc.
- **Scroller Tokens**: `scrollerWidth`, `scrollerKnobWidth`, `scrollerKnobPadding`, `scrollerSlotCornerRadius`, etc.

**Benefits of Optional Token System:**
- ✅ **Minimal Implementation**: Only 17 required properties vs 45+ previously
- ✅ **Selective Customization**: Override only what you need
- ✅ **Future-Proof**: New components add defaults, existing themes unaffected
- ✅ **Sensible Defaults**: Protocol extensions provide beautiful defaults
- ✅ **Better Developer Experience**: Focus on brand colors, not implementation details

All styling should go through the theme system with environment overrides when needed.

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