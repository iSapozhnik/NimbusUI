# NimbusUI Component Development Template

This template provides a comprehensive guide for implementing new components in the NimbusUI design system, based on the established patterns and lessons learned from the Badge component implementation.

## 📋 Table of Contents

- [Component Overview](#-component-overview)
- [Architecture Planning](#-architecture-planning)
- [File Structure & Organization](#-file-structure--organization)
- [Theme System Integration](#-theme-system-integration)
- [Component Implementation](#-component-implementation)
- [Convenience Methods API](#-convenience-methods-api)
- [Testing Strategy](#-testing-strategy)
- [Documentation Requirements](#-documentation-requirements)
- [Quality Checklist](#-quality-checklist)
- [Code Templates](#-code-templates)

---

## 🎯 Component Overview

### Step 1: Define Component Purpose

**Requirements Gathering:**
- [ ] What is the component's primary purpose?
- [ ] What are the key use cases and user scenarios?
- [ ] How does this component fit into the broader design system?
- [ ] What are similar components in other design systems?

**Design Principles:**
- [ ] **Behavioral vs Visual**: Is this primarily interactive or decorative?
- [ ] **Sizing Strategy**: Fixed dimensions, content-adaptive, or hybrid?
- [ ] **Semantic Types**: Does it need status/type variations (info, success, warning, error)?
- [ ] **Variants**: How many distinct variations are needed (e.g., Primary/Secondary)?

**Example (Badge):**
```
Purpose: Status indicators, labels, and counters for UI elements
Use Cases: Notification counts, status labels, category tags, progress indicators
Sizing: Content-adaptive (text + padding determines size)
Semantic Types: Yes (info, success, warning, error)
Variants: PrimaryBadge (solid), SecondaryBadge (outlined)
```

### Step 2: User Experience Requirements

**Interaction Requirements:**
- [ ] Does the component need hover states?
- [ ] Should it support click/tap interactions?
- [ ] Are there keyboard accessibility needs?
- [ ] What animation/transition requirements exist?

**Content Requirements:**
- [ ] What types of content will it display? (text, icons, images)
- [ ] Should it support SF Symbols integration?
- [ ] Does it need multiple content configurations?
- [ ] Are there localization considerations?

---

## 🏗️ Architecture Planning

### Step 1: Component Variants Design

**Variant Analysis:**
- [ ] How many distinct component types are needed?
- [ ] What differentiates each variant? (visual style, behavior, use case)
- [ ] Should variants share common protocols or base classes?
- [ ] Are there specialized variants for specific use cases?

**Example Structure:**
```swift
// Primary variant - main use case
struct PrimaryComponentName<Content: View>: View { }

// Secondary variant - alternative styling
struct SecondaryComponentName<Content: View>: View { }

// Specialized variants (if needed)
struct CompactComponentName<Content: View>: View { }
```

### Step 2: API Design Philosophy

**SwiftUI Integration:**
- [ ] Should it integrate with existing SwiftUI APIs? (ControlSize, ColorScheme, etc.)
- [ ] What SwiftUI patterns should it follow? (Label, Button, Toggle, etc.)
- [ ] Does it need custom initializers for different content types?
- [ ] Should it support ViewBuilder content?

**Customization Strategy:**
- [ ] What properties need theme-based defaults?
- [ ] What properties need environment-based overrides?
- [ ] Which customizations are most common and need convenience methods?
- [ ] How should complex configurations be handled?

### Step 3: Integration Points

**Theme System:**
- [ ] What theme tokens are required vs optional?
- [ ] Which semantic colors should it use?
- [ ] Does it need component-specific design tokens?
- [ ] How should it handle light/dark mode?

**Environment System:**
- [ ] What environment values are needed?
- [ ] Should existing environment values be reused?
- [ ] Are new @Entry environment values required?
- [ ] How should environment precedence work?

---

## 📁 File Structure & Organization

### Mandatory Folder Structure

```
Sources/NimbusComponents/Components/ComponentName/
├── PrimaryComponentName.swift           # Main component implementation
├── SecondaryComponentName.swift         # Secondary variant (if applicable)
├── ComponentNameSemanticType.swift      # Semantic types enum (if applicable)
├── ComponentName+Extensions.swift       # Convenience methods (MANDATORY)
└── Preview/                            # Dedicated preview folder (MANDATORY)
    ├── PrimaryComponentName+Preview.swift
    ├── SecondaryComponentName+Preview.swift
    └── ComponentNameVariantsView.swift  # For testing multiple variants
```

### Implementation Checklist

**Core Files:**
- [ ] Main component Swift files in component root folder
- [ ] Semantic type enum (if component has status/type variations)
- [ ] Convenience methods extension file (MANDATORY)
- [ ] All preview files in dedicated `Preview/` subfolder

**Naming Conventions:**
- [ ] Component names follow `NimbusComponentName` or `ComponentName` pattern
- [ ] Semantic type enum named `ComponentNameSemanticType`
- [ ] Extension file named `ComponentName+Extensions.swift`
- [ ] Preview files follow `ComponentName+Preview.swift` pattern

**Organization Rules:**
- [ ] ✅ **DO**: Keep implementation and preview code separate
- [ ] ✅ **DO**: Use the `Preview/` subfolder for all preview code
- [ ] ✅ **DO**: Follow the established pattern for all new components
- [ ] ❌ **DON'T**: Embed preview code in implementation files
- [ ] ❌ **DON'T**: Create subfolders within component folders (except `Preview/`)

---

## 🎨 Theme System Integration

### Step 1: Theme Token Design

**Required Core Tokens (Always Used):**
```swift
// These 17 properties are required for ALL components
extension ComponentImplementation {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Use semantic colors from theme
    private var effectiveBackgroundColor: Color {
        semanticType.backgroundColor(theme: theme, scheme: colorScheme)
    }
}
```

**Optional Component Tokens (Add to NimbusTheming.swift):**
```swift
public extension NimbusTheming {
    /// Component content padding configuration
    var componentNameContentPadding: EdgeInsets { 
        EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8) 
    }
    
    /// Component border width configuration
    var componentNameBorderWidth: CGFloat { 1.0 }
    
    /// Component corner radius configuration (if fixed radius needed)
    var componentNameCornerRadius: CGFloat { 6 }
    
    /// Component minimum size configuration (if size constraints needed)
    var componentNameMinSize: CGFloat { 24 }
}
```

### Step 2: Environment Values Design

**Environment Values (Add to EnvironmentValues+Extensions.swift):**
```swift
// MARK: ComponentName
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusComponentNameSize: CGFloat? = nil
    @Entry var nimbusComponentNameCornerRadii: RectangleCornerRadii? = nil
    @Entry var nimbusComponentNameBorderWidth: CGFloat? = nil
    @Entry var nimbusComponentNameContentPadding: EdgeInsets? = nil
    // Add other component-specific environment values as needed
}
```

### Step 3: Integration Pattern

**Theme Access Pattern:**
```swift
struct ComponentName: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize
    
    // Component-specific environment values
    @Environment(\.nimbusComponentNameSize) private var size
    @Environment(\.nimbusComponentNameCornerRadii) private var cornerRadii
    
    private var effectiveSize: CGFloat {
        size ?? theme.componentNameMinSize // Theme default with environment override
    }
}
```

---

## 🧱 Component Implementation

### Step 1: Core Component Structure

**Basic Component Template:**
```swift
/// A [description] component with [key features]
public struct ComponentName<Content: View>: View {
    private let semanticType: ComponentNameSemanticType // If applicable
    private let content: Content
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize
    
    // Component-specific environment values
    @Environment(\.nimbusComponentNameSize) private var size
    // ... other environment values
    
    public init(
        _ semanticType: ComponentNameSemanticType, // If applicable
        @ViewBuilder content: () -> Content
    ) {
        self.semanticType = semanticType
        self.content = content()
    }
    
    public var body: some View {
        content
            .font(fontForControlSize)
            .foregroundColor(effectiveTextColor)
            .padding(effectiveContentPadding)
            // Apply other styling based on theme and environment
            .background(
                backgroundShape
                    .fill(effectiveBackgroundColor)
            )
    }
    
    // MARK: - Private Computed Properties
    
    private var effectiveSize: CGFloat {
        size ?? theme.componentNameMinSize
    }
    
    // ... other computed properties
}
```

### Step 2: ControlSize Integration

**ControlSize Support Pattern:**
```swift
private var controlSizeMultiplier: CGFloat {
    switch controlSize {
    case .extraLarge:
        return 1.6
    case .large:
        return 1.4
    case .regular:
        return 1.0
    case .small:
        return 0.8
    case .mini:
        return 0.6
    @unknown default:
        return 1.0
    }
}

private var fontForControlSize: Font {
    switch controlSize {
    case .extraLarge:
        return .system(size: 18, weight: .medium)
    case .large:
        return .system(size: 16, weight: .medium)
    case .regular:
        return .system(size: 14, weight: .medium)
    case .small:
        return .system(size: 12, weight: .medium)
    case .mini:
        return .system(size: 10, weight: .medium)
    @unknown default:
        return .system(size: 14, weight: .medium)
    }
}
```

### Step 3: Semantic Types (If Applicable)

**Semantic Type Enum Template:**
```swift
/// Defines the semantic type for component styling and color selection
public enum ComponentNameSemanticType: String, CaseIterable, Hashable, Sendable {
    case info
    case success
    case warning
    case error
    
    // Primary style colors (for solid backgrounds)
    public func primaryBackgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        switch self {
        case .info:
            return theme.infoColor(for: scheme)
        case .success:
            return theme.successColor(for: scheme)
        case .warning:
            return theme.warningColor(for: scheme)
        case .error:
            return theme.errorColor(for: scheme)
        }
    }
    
    // Secondary style colors (for outlined variants)
    public func secondaryBackgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        // Usually transparent or very subtle tint
        return primaryBackgroundColor(theme: theme, scheme: scheme).opacity(0.1)
    }
    
    // Border colors (for outlined variants)
    public func borderColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        return primaryBackgroundColor(theme: theme, scheme: scheme).opacity(0.8)
    }
    
    // Text colors
    public func primaryTextColor(scheme: ColorScheme) -> Color {
        // Usually white for solid backgrounds
        return Color.adaptiveColor(light: .white, dark: .white, scheme: scheme)
    }
    
    public func textColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        // Usually matches the semantic color for outlined variants
        return primaryBackgroundColor(theme: theme, scheme: scheme)
    }
}
```

### Step 4: Convenience Initializers

**Common Initializer Patterns:**
```swift
// MARK: - Convenience Initializers

public extension ComponentName where Content == Text {
    /// Creates a component with text content
    init(_ text: String, semanticType: ComponentNameSemanticType) {
        self.init(semanticType) {
            Text(text)
        }
    }
}

public extension ComponentName where Content == Label<Text, Image> {
    /// Creates a component with label content (text + icon)
    init(_ title: String, systemImage: String, semanticType: ComponentNameSemanticType) {
        self.init(semanticType) {
            Label(title, systemImage: systemImage)
        }
    }
}
```

---

## 🔧 Convenience Methods API

### MANDATORY: Convenience Methods Implementation

**File: `ComponentName+Extensions.swift`**
```swift
//
//  ComponentName+Extensions.swift
//  NimbusUI
//
//  Created by [Author] on [Date].
//

import SwiftUI
import NimbusCore

// MARK: - ComponentName Convenience Modifiers

public extension ComponentName {
    /// Sets the component size
    func size(_ size: CGFloat) -> some View {
        environment(\.nimbusComponentNameSize, size)
    }
    
    /// Sets the component corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        environment(\.nimbusComponentNameCornerRadii, radii)
    }
    
    /// Sets the component border width
    func borderWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusComponentNameBorderWidth, width)
    }
    
    /// Sets the component content padding with EdgeInsets for maximum flexibility
    func contentPadding(_ padding: EdgeInsets) -> some View {
        environment(\.nimbusComponentNameContentPadding, padding)
    }
    
    /// Sets the component content padding with individual values
    func contentPadding(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> some View {
        environment(\.nimbusComponentNameContentPadding, EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    
    /// Sets uniform component content padding
    func contentPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusComponentNameContentPadding, EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding))
    }
}

// MARK: - Generic View Extensions (if needed for broader usage)

public extension View {
    /// Sets the component-specific property for any view
    func componentNameSize(_ size: CGFloat) -> some View {
        environment(\.nimbusComponentNameSize, size)
    }
}
```

### API Design Requirements

**Method Categories:**
- [ ] **Core Customization**: Size, colors, corner radii, borders, padding
- [ ] **Behavioral Configuration**: States, interactions, animations
- [ ] **Convenience Combinations**: Common multi-property configurations

**Naming Conventions:**
- [ ] Use descriptive method names that match the property they configure
- [ ] Follow SwiftUI naming patterns (camelCase, descriptive)
- [ ] Avoid abbreviations unless they're well-established (e.g., `cornerRadii` not `corners`)

**Documentation Requirements:**
- [ ] Every convenience method must have clear documentation
- [ ] Include parameter descriptions and usage examples
- [ ] Document any special behaviors or interactions

---

## 🧪 Testing Strategy

### Step 1: Test File Structure

```
Tests/NimbusComponentsTests/ComponentName/
├── ComponentNameTests.swift             # Main snapshot tests
├── ComponentNameVariantsView.swift      # Visual test view (if complex)
└── __Snapshots__/                      # Auto-generated snapshot images
    └── ComponentNameTests/
        ├── componentNameBasic.1.png
        ├── componentNameSemanticTypes.1.png
        ├── componentNameControlSizes.1.png
        └── componentNameCustomizations.1.png
```

### Step 2: Snapshot Test Template

**File: `ComponentNameTests.swift`**
```swift
//
//  ComponentNameTests.swift
//  NimbusUI
//
//  Created by [Author] on [Date].
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func componentNameBasic() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    ComponentName(.info) { Text("Basic Example") }
                    ComponentName(.success) { Text("Success Example") }
                    ComponentName(.warning) { Text("Warning Example") }
                    ComponentName(.error) { Text("Error Example") }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func componentNameSemanticTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        ComponentName("Info", semanticType: .info)
                        ComponentName("Success", semanticType: .success)
                        ComponentName("Warning", semanticType: .warning)
                        ComponentName("Error", semanticType: .error)
                    }
                    
                    HStack(spacing: 12) {
                        ComponentName("Icon", systemImage: "star.fill", semanticType: .info)
                        ComponentName("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                        ComponentName("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                        ComponentName("Failed", systemImage: "xmark.circle.fill", semanticType: .error)
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func componentNameControlSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("ControlSize Variations")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            ComponentName("Large", semanticType: .info)
                                .controlSize(.large)
                            ComponentName("Regular", semanticType: .success)
                                .controlSize(.regular)
                            ComponentName("Small", semanticType: .warning)
                                .controlSize(.small)
                            ComponentName("Mini", semanticType: .error)
                                .controlSize(.mini)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func componentNameCustomizations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Test convenience methods
                    VStack(spacing: 8) {
                        Text("Customization Examples")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            ComponentName("Default", semanticType: .info)
                            
                            ComponentName("Custom Size", semanticType: .success)
                                .size(32)
                            
                            ComponentName("Custom Padding", semanticType: .warning)
                                .contentPadding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

// Theme testing
@MainActor
@Test func componentNameThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ComponentNameVariantsView() // If you created a variants view
            }
            .environment(\.nimbusTheme, MaritimeTheme())
        ),
        as: .image,
        record: recording
    )
}
```

### Step 3: Testing Checklist

**Required Tests:**
- [ ] Basic component variations
- [ ] Semantic types (if applicable)
- [ ] ControlSize variations (.extraLarge, .large, .regular, .small, .mini)
- [ ] Convenience method customizations
- [ ] Theme variations (default, maritime, custom warm)
- [ ] Long text/content adaptation
- [ ] Edge cases (empty content, very long content)

**Quality Requirements:**
- [ ] All tests use `SnapshotUtility.view()` wrapper
- [ ] Tests cover all semantic types and component variants
- [ ] ControlSize testing includes all supported sizes
- [ ] Convenience methods are thoroughly tested
- [ ] Multiple themes are tested for consistency

---

## 📚 Documentation Requirements

### Step 1: README Updates

**Add to Table of Contents:**
```markdown
- [ComponentName Components](#componentname-components)
```

**Add to Features Section:**
```markdown
### 🧱 **Rich Component Library**
<!-- existing bullets -->
- [Description] components with [key features]
```

**Add Component Section (after appropriate existing section):**
```markdown
### ComponentName Components

[Brief description of the component and its purpose]

<details>
<summary><strong>Basic Usage</strong></summary>

[Basic usage examples with semantic types]

```swift
import NimbusComponents

// Primary examples
ComponentName("Example", semanticType: .info)
ComponentName("Success", semanticType: .success)
ComponentName("Warning", semanticType: .warning)
ComponentName("Error", semanticType: .error)
```

</details>

<details>
<summary><strong>Advanced Customization</strong></summary>

[Advanced examples with convenience methods]

```swift
// Custom styling
ComponentName("Custom", semanticType: .info)
    .size(32)
    .contentPadding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    .controlSize(.large)
```

</details>

<details>
<summary><strong>Features</strong></summary>

- 🎨 **Feature 1**: Description
- 🔄 **Feature 2**: Description
- 📐 **Feature 3**: Description
- ✨ **Convenience Methods**: SwiftUI-idiomatic customization API

</details>
```

**Update Library Structure:**
```markdown
├── NimbusComponents/        # UI components
│   ├── Components/
│   │   ├── ComponentName/   # Component with [key feature]
```

**Update Theme Tokens:**
```markdown
| Component | Tokens |
|-----------|---------|
| **ComponentName** | `componentNameProperty1`, `componentNameProperty2` |
```

### Step 2: CLAUDE.md Updates

**Add to Key Components section:**
```markdown
**ComponentName System** (`Sources/NimbusComponents/Components/ComponentName/`): [Brief description with key features, semantic types, controlSize support, etc.]
```

**Update project structure:**
```markdown
│   │   ├── ComponentName/   # [Component description]
│   │   │   ├── [List of files]
│   │   │   └── Preview/
```

### Step 3: Documentation Checklist

**README Requirements:**
- [ ] Added to table of contents
- [ ] Updated features section
- [ ] Comprehensive component section with examples
- [ ] Updated library structure
- [ ] Updated theme tokens table

**CLAUDE.md Requirements:**
- [ ] Added to key components description
- [ ] Updated project structure
- [ ] Follows established documentation patterns

**Code Documentation:**
- [ ] All public APIs have comprehensive documentation
- [ ] Convenience methods include usage examples
- [ ] Complex logic has inline comments
- [ ] Semantic types are well-documented

---

## ✅ Quality Checklist

### Architecture Compliance

**File Organization:**
- [ ] ✅ Component folder follows standardized structure
- [ ] ✅ All previews are in dedicated `Preview/` subfolder
- [ ] ✅ Convenience methods in separate `+Extensions.swift` file
- [ ] ✅ No mixed content (implementation + preview in same file)

**Theme System Integration:**
- [ ] ✅ Uses `@Environment(\.nimbusTheme)` for theme access
- [ ] ✅ Uses theme semantic colors appropriately
- [ ] ✅ Implements environment override pattern: `override ?? theme.property`
- [ ] ✅ Theme tokens have sensible defaults
- [ ] ✅ Only necessary theme tokens are added (avoid unused properties)

**SwiftUI Integration:**
- [ ] ✅ Supports ControlSize environment (.extraLarge through .mini)
- [ ] ✅ Respects ColorScheme for light/dark mode
- [ ] ✅ Follows SwiftUI API patterns and conventions
- [ ] ✅ Generic content support with ViewBuilder where appropriate

**Convenience Methods:**
- [ ] ✅ All customization through convenience methods (never direct environment)
- [ ] ✅ Methods follow SwiftUI naming conventions
- [ ] ✅ Comprehensive documentation for all methods
- [ ] ✅ Logical method grouping with MARK comments
- [ ] ✅ Support for both individual and combined configurations

### Code Quality

**Implementation Standards:**
- [ ] ✅ No hardcoded values (use theme tokens)
- [ ] ✅ Proper accessibility support
- [ ] ✅ Performance optimized (avoid unnecessary computations)
- [ ] ✅ Type safety (strong typing, no stringly-typed APIs)
- [ ] ✅ Error handling where appropriate

**Testing Coverage:**
- [ ] ✅ Snapshot tests for all major variations
- [ ] ✅ ControlSize testing across all supported sizes
- [ ] ✅ Semantic type testing (if applicable)
- [ ] ✅ Theme variation testing
- [ ] ✅ Convenience method testing
- [ ] ✅ Edge case testing (long text, empty content)

**Documentation Quality:**
- [ ] ✅ README updated with comprehensive examples
- [ ] ✅ CLAUDE.md updated with component description
- [ ] ✅ All public APIs documented
- [ ] ✅ Usage examples provided
- [ ] ✅ Clear feature descriptions

### Final Validation

**Build & Test:**
- [ ] ✅ `swift build` passes without warnings
- [ ] ✅ `swift test --filter ComponentNameTests` passes
- [ ] ✅ Snapshot tests generate expected images
- [ ] ✅ No compiler warnings or errors

**API Consistency:**
- [ ] ✅ Follows established NimbusUI patterns
- [ ] ✅ Consistent with other components
- [ ] ✅ Backward compatibility maintained
- [ ] ✅ No breaking changes to existing APIs

**User Experience:**
- [ ] ✅ Component feels native to SwiftUI
- [ ] ✅ Intuitive API that follows expectations
- [ ] ✅ Good performance in real-world usage
- [ ] ✅ Accessible to screen readers and keyboard navigation

---

## 📝 Code Templates

### Environment Values Template

```swift
// Add to EnvironmentValues+Extensions.swift

// MARK: ComponentName
// Internal APIs for convenience methods - not for direct consumer use

public extension EnvironmentValues {
    @Entry var nimbusComponentNameSize: CGFloat? = nil
    @Entry var nimbusComponentNameCornerRadii: RectangleCornerRadii? = nil
    @Entry var nimbusComponentNameBorderWidth: CGFloat? = nil
    @Entry var nimbusComponentNameContentPadding: EdgeInsets? = nil
}
```

### Theme Tokens Template

```swift
// Add to NimbusTheming.swift

// MARK: - ComponentName Component Tokens (Optional with Defaults)

public extension NimbusTheming {
    /// ComponentName content padding configuration
    var componentNameContentPadding: EdgeInsets { 
        EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8) 
    }
    
    /// ComponentName border width configuration
    var componentNameBorderWidth: CGFloat { 1.0 }
    
    /// ComponentName size configuration
    var componentNameSize: CGFloat { 24 }
}
```

### Preview Template

```swift
//
//  ComponentName+Preview.swift
//  NimbusUI
//
//  Created by [Author] on [Date].
//

import SwiftUI
import NimbusCore
@testable import NimbusComponents

struct ComponentName_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseView {
            VStack(spacing: 20) {
                // Basic examples
                VStack(spacing: 8) {
                    Text("Basic ComponentName")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ComponentName("Info", semanticType: .info)
                        ComponentName("Success", semanticType: .success)
                        ComponentName("Warning", semanticType: .warning)
                        ComponentName("Error", semanticType: .error)
                    }
                }
                
                // ControlSize examples
                VStack(spacing: 8) {
                    Text("ControlSize Variations")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ComponentName("Large", semanticType: .info)
                            .controlSize(.large)
                        ComponentName("Regular", semanticType: .success)
                            .controlSize(.regular)
                        ComponentName("Small", semanticType: .warning)
                            .controlSize(.small)
                        ComponentName("Mini", semanticType: .error)
                            .controlSize(.mini)
                    }
                }
                
                // Customization examples
                VStack(spacing: 8) {
                    Text("Customization Examples")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ComponentName("Custom", semanticType: .info)
                            .size(32)
                            .contentPadding(12)
                    }
                }
            }
            .padding()
        }
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}
```

---

## 🚀 Getting Started

### Quick Implementation Steps

1. **Plan**: Define component purpose, variants, and API design
2. **Structure**: Create folder structure following the mandatory pattern
3. **Implement**: Build core component with theme integration
4. **Extend**: Add convenience methods for customization
5. **Test**: Create comprehensive snapshot tests
6. **Document**: Update README and CLAUDE.md
7. **Validate**: Run quality checklist and final validation

### Success Criteria

Your component implementation is complete when:
- ✅ All quality checklist items pass
- ✅ Snapshot tests generate expected images
- ✅ Documentation is comprehensive and clear
- ✅ API feels native and intuitive to SwiftUI developers
- ✅ Component integrates seamlessly with existing NimbusUI patterns

---

**This template ensures every new component meets the high standards established by the NimbusUI design system and provides a consistent, high-quality developer experience.**