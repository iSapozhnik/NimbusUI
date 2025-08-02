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

**Theme System**: Enhanced protocol-based theming using `NimbusTheming` protocol with environment injection via `@Environment(\.nimbusTheme)`. Themes provide default values for 11 design tokens (layout, animations, corner radii, elevation, spacing). Environment values serve as optional overrides using the pattern `override ?? theme.property`. Available themes: `NimbusTheme.default`, `MaritimeTheme()`, `CustomWarmTheme()`.

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

**Onboarding System** (`Sources/NimbusUI/Components/Onboarding/`): Complete onboarding flow with FluidGradient animations, fixed dimensions (600x560), and page navigation.

**List Components** (`Sources/NimbusUI/Components/List/`): `ListItem` with configurable hover states and theming.

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
│   │   └── Preview/        # Dedicated preview files
│   │       ├── PrimaryDefaultButtonStyle+Preview.swift
│   │       ├── PrimaryProminentButtonStyle+Preview.swift
│   │       ├── SecondaryBorderedButtonStyle+Preview.swift
│   │       └── SecondaryProminentButtonStyle+Preview.swift
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

### Design Tokens (Available from Theme)
- **Layout**: `minHeight`, `horizontalPadding`, `listItemHeight`
- **Animations**: `animation`, `animationFast`
- **Corner Radii**: `cornerRadii`, `buttonCornerRadii`, `compactButtonCornerRadii`, `listItemCornerRadii`  
- **Elevation**: `elevation`
- **Spacing**: `labelContentSpacing`

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

#### Theme and API Integration
- **Theme Integration**: Access theme via `@Environment(\.nimbusTheme)` for design token defaults
- **Override Pattern**: Use `@Environment(\.nimbusProperty) private var overrideProperty` and apply as `overrideProperty ?? theme.property`
- **Design Token Usage**: Prefer theme-provided values over hardcoded constants
- **Behavioral vs Design**: Keep behavioral flags as environment-only, put visual properties in theme
- **Type Safety**: Use strong typing to prevent design inconsistencies
- **Documentation**: Include examples showing both theme defaults and override usage
- **Button API Pattern**: Use `AutoLabelDetectionModifier` to conditionally apply `NimbusDividerLabelStyle` only when environment values are set
- **Backward Compatibility**: Ensure new APIs don't break existing plain text button usage

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