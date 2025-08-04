# NimbusUI Modularization Plan

## Overview

This document outlines the plan to modularize NimbusUI into multiple Swift Package Manager targets using the convenience method pattern for clean API design.

## Architecture Strategy

**Key Insight**: Use the existing ScrollView convenience method pattern to hide environment variables behind clean public APIs, enabling perfect modularization.

### Current Pattern (ScrollView)
```swift
// ✅ Clean public API (what developers use)
someView
    .scrollerWidth(12)          // Public convenience method
    .knobPadding(4)             // Public convenience method
    .slotCornerRadius(8)        // Public convenience method

// ❌ Internal implementation (hidden from developers)
    .environment(\.nimbusScrollerWidth, 12)         
    .environment(\.nimbusScrollerKnobPadding, 4)    
    .environment(\.nimbusScrollerSlotCornerRadius, 8) 
```

## Target Structure

### 1. `NimbusCore` (Internal Foundation)
**Contents**: 
- Theme protocols & implementations (internal)
- **All environment values** (internal) 
- Base modifiers & utilities (internal)
- AppKit wrappers (internal)

**Dependencies**: None
**Access Level**: Mostly internal, consumed by other targets

### 2. `NimbusComponents` (Primary Components + API)
**Contents**:
- Button styles (public)
- Checkbox, List, ScrollView, Scroller components (public)
- **Button convenience methods** (public):
  ```swift
  .buttonCornerRadius(_ radius: CGFloat)
  .buttonPadding(_ padding: CGFloat)  
  .buttonHeight(_ height: CGFloat)
  .buttonMaterial(_ material: Material)
  ```
- **General convenience methods** (public):
  ```swift
  .nimbusTheme(_ theme: NimbusTheming)
  .aspectRatio(_ ratio: CGFloat, contentMode: ContentMode)
  ```

**Dependencies**: NimbusCore
**Usage**: Most developers import this for full functionality

### 3. `NimbusNotifications` (Optional Feature)
**Contents**:
- Notification components (public)
- **Notification convenience methods** (public):
  ```swift
  .notificationCornerRadius(_ radius: CGFloat)
  .notificationPadding(_ padding: CGFloat)
  ```

**Dependencies**: NimbusCore

### 4. `NimbusOnboarding` (Optional + External Dependencies)
**Contents**:
- Onboarding components (public)
- **Onboarding convenience methods** (public)

**Dependencies**: NimbusCore, FluidGradient, SmoothGradient

## Benefits

✅ **Clean API**: No environment value exposure  
✅ **Perfect Modularization**: Internal environment values  
✅ **Discoverable**: Auto-complete shows relevant methods  
✅ **Extends Existing Pattern**: Builds on ScrollView approach  
✅ **Future Proof**: Easy to add new convenience methods  
✅ **Dependency Isolation**: Apps not using onboarding avoid FluidGradient/SmoothGradient  
✅ **Smaller App Size**: Include only needed components  
✅ **Faster Builds**: Smaller, focused targets  

## Developer Experience

### Option 1: Minimal (Buttons Only)
```swift
dependencies: [.product(name: "NimbusComponents")]

// Usage:
Button("Save") { }
    .buttonStyle(.primary)
    .buttonCornerRadius(12)        // Clean API
    .buttonPadding(20)             // Clean API
    .nimbusTheme(MyTheme())        // Clean API
```

### Option 2: Full Featured App  
```swift
dependencies: [
    .product(name: "NimbusComponents"), 
    .product(name: "NimbusNotifications"), 
    .product(name: "NimbusOnboarding")
]
```

### Option 3: Umbrella Library (Backward Compatible)
```swift
dependencies: [.product(name: "NimbusUI")]  // Includes everything
```

## Implementation Tasks

### ✅ Completed Tasks

1. **Restructure Package.swift** - Created targets: NimbusCore, NimbusComponents, NimbusNotifications, NimbusOnboarding
2. **Create target directory structure** - Started moving files to appropriate targets

### 🚧 In Progress Tasks

2. **Create target directory structure and move files appropriately**
   - ✅ Created target directories: Sources/NimbusCore, Sources/NimbusComponents, etc.
   - ✅ Moved to NimbusCore: Theming/, Extensions/, Modifiers/, Utilities/, AppKit/
   - ⏳ Moving to NimbusComponents: ButtonStyles/, Checkbox/, List/, ScrollView/, Scroller/
   - ⏳ Move to NimbusNotifications: Notification/
   - ⏳ Move to NimbusOnboarding: Onboarding/

### 📋 Pending Tasks

3. **Make environment values internal and update access levels**
   - Change `public extension EnvironmentValues` to `internal extension EnvironmentValues`
   - Update access levels throughout codebase
   - Ensure proper import/export between targets

4. **Create convenience methods for Button components following ScrollView pattern**
   - Add to NimbusComponents/Extensions/View+ButtonConvenience.swift:
     ```swift
     public extension View {
         func buttonCornerRadius(_ radius: CGFloat) -> some View {
             environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(radius))
         }
         
         func buttonPadding(_ padding: CGFloat) -> some View {
             environment(\.nimbusHorizontalPadding, padding)
         }
         
         func buttonHeight(_ height: CGFloat) -> some View {
             environment(\.nimbusMinHeight, height)
         }
         
         func nimbusTheme(_ theme: NimbusTheming) -> some View {
             environment(\.nimbusTheme, theme)
         }
         
         func aspectRatio(_ ratio: CGFloat, contentMode: ContentMode = .fit) -> some View {
             environment(\.nimbusAspectRatio, ratio)
                 .environment(\.nimbusAspectRatioContentMode, contentMode)
         }
     }
     ```

5. **Create convenience methods for Checkbox, List, and other core components**
   - Add checkbox convenience methods
   - Add list convenience methods
   - Add general component convenience methods

6. **Create convenience methods for Notification components**
   - Add notification-specific convenience methods to NimbusNotifications

7. **Update imports and dependencies between targets**
   - Add proper import statements
   - Ensure target dependencies work correctly
   - Re-export necessary types from NimbusCore to NimbusComponents

8. **Test modularization works and builds correctly**
   - Test each target builds independently
   - Test target dependencies work
   - Test convenience methods work as expected
   - Update and run existing tests

9. **Update documentation to reflect new modular architecture**
   - Update README.md with new import options
   - Update CLAUDE.md with new architecture
   - Add migration guide for existing users

## File Organization

### Current Structure (Before)
```
Sources/NimbusUI/
├── Components/
├── Extensions/
├── Modifiers/
├── Theming/
├── Utilities/
└── AppKit/
```

### New Structure (After)
```
Sources/
├── NimbusCore/
│   ├── Theming/
│   ├── Extensions/
│   ├── Modifiers/
│   ├── Utilities/
│   └── AppKit/
├── NimbusComponents/
│   ├── Components/
│   │   ├── ButtonStyles/
│   │   ├── Checkbox/
│   │   ├── List/
│   │   ├── ScrollView/
│   │   └── Scroller/
│   └── Extensions/
│       └── View+ComponentConvenience.swift
├── NimbusNotifications/
│   ├── Components/
│   │   └── Notification/
│   └── Extensions/
│       └── View+NotificationConvenience.swift
└── NimbusOnboarding/
    ├── Components/
    │   └── Onboarding/
    └── Extensions/
        └── View+OnboardingConvenience.swift
```

## Migration Path

### For Existing Users
- **No Breaking Changes**: Umbrella `NimbusUI` library maintains backward compatibility
- **Gradual Migration**: Users can gradually adopt modular imports
- **Convenience Methods**: New clean API alongside existing environment method support

### For New Users
- **Recommended**: Start with `NimbusComponents` for most use cases
- **Add Optional**: Include `NimbusNotifications` and `NimbusOnboarding` as needed
- **Clean API**: Use convenience methods instead of environment values

## Next Steps

1. **Complete file moves** to appropriate target directories
2. **Make environment values internal** and create convenience method APIs
3. **Test build system** works with new target structure
4. **Update documentation** and migration guides
5. **Release** as new major version with modular architecture

---

*This plan implements a clean, modular architecture that maintains backward compatibility while providing better dependency management and developer experience.*