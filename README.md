# NimbusUI

[![Swift 5.9](https://img.shields.io/badge/Swift-5.9-brightgreen.svg)](https://swift.org)
[![macOS 14.0+](https://img.shields.io/badge/macOS-14.0+-blue.svg)](https://developer.apple.com/macos/)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange.svg)](https://swift.org/package-manager/)

A modern SwiftUI component library for macOS applications with a comprehensive theming system and beautiful, interactive components.

## 📚 Table of Contents

- [✨ Features](#-features)
- [📦 Installation](#-installation)
- [🚀 Quick Start](#-quick-start)
- [🧱 Components](#-components)
  - [Button Styles](#button-styles)
  - [List Components](#list-components)
  - [Onboarding System](#onboarding-system)
  - [NimbusScrollView](#nimbusscrollview)
  - [NimbusScroller](#nimbusscroller)
- [🎨 Theme System](#-theme-system)
  - [Available Themes](#available-themes)
  - [Design Tokens](#design-tokens)
  - [Property Overrides](#property-overrides)
  - [Creating Custom Themes](#creating-custom-themes)
- [🏗️ Architecture](#️-architecture)
- [🎭 Theme Gallery](#-theme-gallery)
- [🛠️ Development](#️-development)
- [📄 License](#-license)
- [🙏 Dependencies](#-dependencies)

## ✨ Features

- 🎨 **Advanced Theme System** - Protocol-based theming with design tokens and per-component overrides
- 🧱 **Rich Component Library** - Buttons, lists, onboarding flows, and custom modifiers
- 🌊 **Stunning Animations** - FluidGradient backgrounds and smooth transitions
- 🔧 **Highly Customizable** - Override any design property while maintaining consistency
- ⚡ **Performance Optimized** - Built for real-world macOS applications

## 📦 Installation

Add NimbusUI to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/NimbusUI.git", from: "1.0.0")
]
```

**Requirements:**
- macOS 14.0+
- Swift 6.1+
- Xcode 15.0+

## 🚀 Quick Start

```swift
import SwiftUI
import NimbusUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Button("Primary Action") { }
                .buttonStyle(.primaryDefault)
            
            Button("Secondary Action") { }
                .buttonStyle(.secondaryProminent)
        }
        .environment(\.nimbusTheme, NimbusTheme.default)
        .padding()
    }
}
```

## 🧱 Components

### Button Styles

NimbusUI provides a comprehensive button hierarchy with built-in theming and state management:

#### Primary Buttons

For main actions and call-to-action buttons:

```swift
// Default primary button
Button("Save") { }
    .buttonStyle(.primaryDefault)

// Prominent primary button with enhanced styling
Button("Continue") { }
    .buttonStyle(.primaryProminent)
```

#### Secondary Buttons

For secondary actions and alternative options:

```swift
// Prominent secondary button
Button("Cancel") { }
    .buttonStyle(.secondaryProminent)

// Bordered secondary button
Button("More Options") { }
    .buttonStyle(.secondaryBordered)
```

#### Enhanced Button + Label API

NimbusUI automatically detects Label usage and applies appropriate styling:

```swift
// Plain text button (no changes needed)
Button("Delete") { }
    .buttonStyle(.primaryProminent)

// Label with divider (auto-applied)
Button(action: {}) {
    Label("Export", systemImage: "square.and.arrow.up")
}
.buttonStyle(.primaryProminent)
.environment(\.nimbusButtonHasDivider, true)

// Label with trailing icon
Button(action: {}) {
    Label("Next", systemImage: "arrow.right")
}
.buttonStyle(.primaryProminent)
.environment(\.nimbusButtonIconAlignment, .trailing)
```

#### Button Customization

Override specific properties while maintaining theme consistency:

```swift
Button("Custom Button") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
    .environment(\.nimbusMinHeight, 50)
    .environment(\.nimbusButtonMaterial, .thin)
```

### List Components

Interactive list items with selection states, hover effects, and flexible content:

#### Basic List Item

```swift
@State private var items = ["Item 1", "Item 2", "Item 3"]
@State private var selection = Set<String>()

ListItem(items: $items, selection: $selection, item: .constant("Item 1")) { binding in
    HStack {
        Image(systemName: "doc.text")
        Text(binding.wrappedValue)
        Spacer()
        Text("Details")
            .foregroundColor(.secondary)
    }
    .padding()
}
```

#### Interactive Features

Enable hover effects and customize appearance:

```swift
ListItem(items: $items, selection: $selection, item: $item) { binding in
    Text(binding.wrappedValue)
        .padding()
}
.environment(\.nimbusListItemHighlightOnHover, true)
.environment(\.nimbusListItemHeight, 60)
.environment(\.nimbusListItemCornerRadii, RectangleCornerRadii(12))
```

#### Fixed Height Lists

Control list behavior with fixed heights:

```swift
VStack(spacing: 0) {
    ForEach(items.indices, id: \.self) { index in
        ListItem(items: $items, selection: $selection, item: $items[index]) { binding in
            // Item content
        }
    }
}
.environment(\.nimbusListFixedHeightUntil, 300)
```

### Onboarding System

Beautiful onboarding flows with FluidGradient animations, fixed dimensions (600x560), and smooth page navigation:

#### Basic Setup

```swift
OnboardingView(features: [
    OnboardingView.Feature(
        title: "Welcome",
        description: "Get started with our amazing app",
        icon: "star.fill"
    ),
    OnboardingView.Feature(
        title: "Powerful Features",
        description: "Discover all the capabilities of our platform",
        icon: "bolt.fill"
    ),
    OnboardingView.Feature(
        title: "Get Started",
        description: "You're ready to begin your journey",
        icon: "checkmark.circle.fill"
    )
])
```

#### Features

- **FluidGradient Backgrounds**: Smooth, animated gradient backgrounds
- **Fixed Dimensions**: Consistent 600x560 window size
- **Page Navigation**: Built-in page controls and smooth transitions
- **Icon Support**: SF Symbols integration for feature icons
- **Theme Integration**: Automatically adapts to your chosen theme

#### Customization

The onboarding system automatically inherits your theme colors and styling:

```swift
OnboardingView(features: features)
    .environment(\.nimbusTheme, MaritimeTheme())
```

### NimbusScrollView

A SwiftUI wrapper around NSScrollView with custom themed scrollers, providing smooth scrolling with beautiful, themed scroll indicators.

#### Basic Usage

```swift
NimbusScrollView {
    VStack(spacing: 16) {
        ForEach(1...50, id: \.self) { index in
            Text("Item \(index)")
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
    .padding()
}
```

#### Scroller Visibility Control

Control which scrollers are visible using chainable modifiers:

```swift
// Hide both scrollers
NimbusScrollView {
    // Long content
}
.hideScrollers()

// Show only horizontal scroller
NimbusScrollView {
    // Wide content
}
.showsScrollers(vertical: false, horizontal: true)

// Individual control
NimbusScrollView {
    // Content
}
.showsVerticalScroller(false)
.showsHorizontalScroller(true)
```

#### Custom Scroller Styling

Apply custom styling to the scroll indicators:

```swift
NimbusScrollView {
    // Content
}
.scrollerWidth(20)           // Thicker scroll track
.knobWidth(8)               // Wider scroll knob
.knobPadding(3)             // More padding around knob
.slotCornerRadius(8)        // Rounded scroll track
```

#### Content Insets

Add padding around the scrollable content:

```swift
NimbusScrollView(contentInsets: NSEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)) {
    // Content will have 16pt padding on all sides
    Text("Padded content")
}
```

#### Theme Integration

NimbusScrollView automatically adapts to your theme:

```swift
NimbusScrollView {
    // Content
}
.environment(\.nimbusTheme, MaritimeTheme())
.scrollerWidth(24)  // Override theme default
```

### NimbusScroller

A standalone SwiftUI wrapper for custom AppKit scrollers, useful when you need precise control over scroll position and behavior.

#### Basic Usage

```swift
@State private var scrollPosition: Float = 0.3
@State private var knobProportion: Float = 0.2

NimbusScroller(
    type: .vertical,
    value: $scrollPosition,
    knobProportion: $knobProportion
)
.frame(width: 50, height: 200)
```

#### Horizontal Scroller

```swift
@State private var horizontalPosition: Float = 0.5
@State private var horizontalKnob: Float = 0.3

NimbusScroller(
    type: .horizontal,
    value: $horizontalPosition,
    knobProportion: $horizontalKnob
)
.frame(width: 300, height: 50)
```

#### Custom Styling

```swift
NimbusScroller(value: $position, knobProportion: $proportion)
    .scrollerWidth(18)
    .knobWidth(6)
    .knobPadding(2)
    .slotCornerRadius(6)
```

## 🎨 Theme System

NimbusUI features a sophisticated theme system that provides both consistency and flexibility.

### Available Themes

```swift
// Default theme
.environment(\.nimbusTheme, NimbusTheme.default)

// Professional maritime theme
.environment(\.nimbusTheme, MaritimeTheme())

// Warm, friendly theme
.environment(\.nimbusTheme, CustomWarmTheme())
```

### Design Tokens

Themes provide consistent defaults for all design properties:

- **Layout**: `minHeight`, `horizontalPadding`, `listItemHeight`
- **Animations**: `animation`, `animationFast`
- **Corner Radii**: `cornerRadii`, `buttonCornerRadii`, `compactButtonCornerRadii`, `listItemCornerRadii`
- **Elevation**: `elevation`
- **Spacing**: `labelContentSpacing`

### Property Overrides

Override specific properties while keeping theme consistency:

```swift
Button("Custom Button") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusTheme, MaritimeTheme())
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
    .environment(\.nimbusMinHeight, 50)
```

### Creating Custom Themes

Implement the `NimbusTheming` protocol for complete customization:

```swift
struct MyCustomTheme: NimbusTheming {
    // Implement required color methods
    func primaryColor(for scheme: ColorScheme) -> Color { ... }
    func backgroundColor(for scheme: ColorScheme) -> Color { ... }
    // ... other color methods
    
    // Design token properties
    let cornerRadii = RectangleCornerRadii(8)
    let minHeight: CGFloat = 32
    let horizontalPadding: CGFloat = 12
    // ... other design tokens
}
```

## 🏗️ Architecture

NimbusUI is built around several core systems:

- **Theme System**: Protocol-based theming with environment injection
- **Component Library**: Reusable, themeable UI components
- **Modifier System**: Custom view modifiers for consistent styling
- **Environment Configuration**: SwiftUI environment values for customization

### Design Principles

1. **Consistency First** - Every component feels part of a cohesive system
2. **Flexibility** - Override any property when needed
3. **Performance** - Optimized for real-world usage
4. **Accessibility** - Built-in macOS accessibility support
5. **Developer Experience** - Intuitive APIs and clear documentation

## 🎭 Theme Gallery

| Nimbus Theme (Default) | Maritime Theme | Warm Theme |
|------------------------|----------------|------------|
| ![](Tests/NimbusUITests/Snapshots/__Snapshots__/SnapshotTests/showcaseNimbusTheme.1.png) | ![](Tests/NimbusUITests/Snapshots/__Snapshots__/SnapshotTests/showcaseMaritimeTheme.1.png) | ![](Tests/NimbusUITests/Snapshots/__Snapshots__/SnapshotTests/showcaseWarmTheme.1.png) |

## 🛠️ Development

### Building

```bash
# Build the package
swift build

# Run tests
swift test

# Clean build artifacts
swift package clean
```

### Testing

NimbusUI uses Swift Testing framework with snapshot testing for visual regression testing.

```bash
# Run all tests
swift test

# Update snapshots (if needed)
swift test -Xswiftc -DUPDATE_SNAPSHOTS
```

## 📄 License

NimbusUI is available under the MIT license. See the LICENSE file for more info.

## 🙏 Dependencies

- [FluidGradient](https://github.com/Cindori/FluidGradient) - Beautiful gradient animations
- [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) - Visual regression testing

---

Made with ❤️ for the macOS developer community.