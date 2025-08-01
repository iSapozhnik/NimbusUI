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

### Key Components

**Onboarding System** (`Sources/NimbusUI/Components/Onboarding/`): Complete onboarding flow with FluidGradient animations, fixed dimensions (600x560), and page navigation.

**List Components** (`Sources/NimbusUI/Components/List/`): `ListItem` with configurable hover states and theming.

### Project Structure
```
Sources/NimbusUI/
├── NimbusUI.swift          # Library entry point
├── Components/             # UI components (ButtonStyles/, List/, Onboarding/)
├── Extensions/             # Swift extensions
├── Modifiers/              # Custom SwiftUI modifiers
└── Theming/               # Theme system and protocols
```

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

### Design Tokens (Available from Theme)
- **Layout**: `minHeight`, `horizontalPadding`, `listItemHeight`
- **Animations**: `animation`, `animationFast`
- **Corner Radii**: `cornerRadii`, `buttonCornerRadii`, `compactButtonCornerRadii`, `listItemCornerRadii`  
- **Elevation**: `elevation`
- **Spacing**: `labelContentSpacing`

All styling should go through the theme system with environment overrides when needed.

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
- **Theme Integration**: Access theme via `@Environment(\.nimbusTheme)` for design token defaults
- **Override Pattern**: Use `@Environment(\.nimbusProperty) private var overrideProperty` and apply as `overrideProperty ?? theme.property`
- **Design Token Usage**: Prefer theme-provided values over hardcoded constants
- **Behavioral vs Design**: Keep behavioral flags as environment-only, put visual properties in theme
- **Type Safety**: Use strong typing to prevent design inconsistencies
- **Documentation**: Include examples showing both theme defaults and override usage

### Code Quality Requirements
- Follow Swift API Design Guidelines
- Use proper access control (public, internal, private)
- Implement comprehensive error handling
- Write self-documenting code with clear naming
- Include inline documentation for public APIs