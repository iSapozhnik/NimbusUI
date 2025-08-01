# NimbusUI

A SwiftUI component library for macOS 14.0+ with a comprehensive theming system.

## Theme System

NimbusUI uses a protocol-based theming system that allows both global themes and per-component customization.

### Basic Usage

```swift
import NimbusUI

// Apply default theme
Button("Action") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusTheme, NimbusTheme.default)
```

### Custom Themes

```swift
// Use a custom theme  
Button("Maritime Style") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusTheme, MaritimeTheme())
```

### Property Overrides

Override specific design tokens while keeping theme defaults:

```swift
// Override corner radius and height
Button("Custom Styling") { }
    .buttonStyle(.primaryDefault)
    .environment(\.nimbusTheme, NimbusTheme.default)
    .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
    .environment(\.nimbusMinHeight, 50)
```

### Multiple Overrides

```swift
// Combine theme with multiple property overrides
ListItem(items: $items, selection: $selection, item: $item) { binding in
    Text(binding.wrappedValue.name)
}
.environment(\.nimbusTheme, MaritimeTheme())
.environment(\.nimbusListItemHeight, 60)
.environment(\.nimbusListItemCornerRadii, RectangleCornerRadii(8))
```

**Key Benefit:** Themes provide consistent defaults, environment values allow granular customization when needed.