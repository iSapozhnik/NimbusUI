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

**Theme System**: Protocol-based theming using `NimbusTheming` protocol with environment injection via `@Environment(\.nimbusTheme)`. Default theme provided by `NimbusTheme.default`.

**Environment Configuration**: Extensive use of SwiftUI `@Entry` environment values for configurable parameters (animations, padding, corner radii, hover states).

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

Components require proper environment setup:
```swift
import NimbusUI

// Apply theme environment
.environment(\.nimbusTheme, NimbusTheme.default)

// Use button styles
Button("Action") { }.buttonStyle(.primaryDefault)
```

All styling should go through the theme system and environment values rather than hardcoded values.

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
- Use protocol-based design for theming and configuration
- Leverage SwiftUI's environment system (`@Environment`) for configuration
- Create reusable view modifiers for consistent styling
- Ensure type safety to prevent design inconsistencies
- Maintain comprehensive usage examples and guidelines

### Code Quality Requirements
- Follow Swift API Design Guidelines
- Use proper access control (public, internal, private)
- Implement comprehensive error handling
- Write self-documenting code with clear naming
- Include inline documentation for public APIs