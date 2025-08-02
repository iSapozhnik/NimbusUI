# ListView with Custom Scrollers

This example demonstrates how to use ListView with custom themed scrollers.

## Basic Usage

### Standard ListView (Default)
```swift
ListView(
    items: $items,
    selection: $selection,
    id: \.self
) { itemBinding in
    Text(itemBinding.wrappedValue)
        .padding(.horizontal, 16)
}
// Uses SwiftUI's native List with standard scrollers
```

### ListView with Custom Scrollers
```swift
ListView(
    items: $items,
    selection: $selection,
    id: \.self
) { itemBinding in
    Text(itemBinding.wrappedValue)
        .padding(.horizontal, 16)
}
.useCustomScrollers() // Enable custom themed scrollers
.scrollerWidth(18)    // Customize scroller appearance
.knobWidth(8)
.knobPadding(3)
.slotCornerRadius(6)
```

### Environment-based Configuration
```swift
ListView(
    items: $items,
    selection: $selection,
    id: \.self
) { itemBinding in
    Text(itemBinding.wrappedValue)
        .padding(.horizontal, 16)
}
.environment(\.nimbusListUseCustomScrollers, true)
.environment(\.nimbusScrollerWidth, 20)
.environment(\.nimbusScrollerKnobWidth, 10)
```

## Features

### Custom Scroller Mode
- ✅ Custom themed scrollers with full theme integration
- ✅ Manual selection handling with tap gestures
- ✅ Maintains visual consistency with native List mode
- ✅ All ListView environment overrides work normally
- ❌ Drag-to-reorder is disabled (limitation of LazyVStack)

### Native List Mode (Default)
- ✅ Full SwiftUI List functionality
- ✅ Drag-to-reorder support
- ✅ Native selection behavior
- ✅ All ListView features work as expected

## Implementation Details

When custom scrollers are enabled:
- ListView uses `NimbusScrollView` with `LazyVStack` instead of SwiftUI's `List`
- Selection is handled manually through tap gestures
- Scroll behavior is controlled by the custom scroller components
- Theme integration remains consistent across both modes

## Theme Integration

Custom scrollers automatically integrate with your theme:

```swift
ListView(items: $items, selection: $selection, id: \.self) { item in
    Text(item.wrappedValue)
        .padding(.horizontal, 16)
}
.useCustomScrollers()
.environment(\.nimbusTheme, MaritimeTheme()) // Scrollers match theme
```

The scrollers will use:
- `theme.accentColor` for the knob color
- `theme.tertiaryBackgroundColor` for the slot background
- Theme-defined dimensions as defaults (overridable)