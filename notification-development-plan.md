# NimbusNotificationView System Development Plan

## 🎯 Overview

Complete notification system for NimbusUI following the reference design with 4 semantic types (info, success, warning, error), proper theming integration, and a SwiftUI view modifier presentation system.

**Reference Image**: `/Users/isapozhnik/Library/Application Support/CleanShot/media/media_6WJW8BhzDW/CleanShot 2025-08-03 at 00.31.14.png`

## 📋 Development Phases

### Phase 1: Button Styles Foundation ✅
**Location**: `Sources/NimbusUI/Components/ButtonStyles/`

- [x] **LinkButtonStyle.swift** - Text-only action buttons
  - Text-only button with semantic color text
  - No background, hover opacity change (0.8)
  - Medium font weight, theme color integration
  - Used for notification actions ("Try again", "Check details", etc.)

- [x] **CloseButtonStyle.swift** - Icon-only X dismiss buttons
  - Icon-only X button with subtle gray styling
  - Small size (~24pt), minimal padding (~14pt icon)
  - Hover state with light background tint
  - Used for dismissing notifications, modals, etc.

- [x] **Preview/LinkButtonStyle+Preview.swift** - LinkButton previews
- [x] **Preview/CloseButtonStyle+Preview.swift** - CloseButton previews

### Phase 2: Core Notification Components ✅
**Location**: `Sources/NimbusUI/Components/Notification/`

- [x] **NotificationDismissBehavior.swift**
```swift
public enum NotificationDismissBehavior: Sendable {
    case sticky                    // Manual dismiss only
    case temporary(TimeInterval)   // Auto-dismiss after seconds
}
```

- [x] **NotificationType.swift** - Semantic types with icon/color mapping
```swift
public enum NotificationType: CaseIterable, Sendable {
    case info, success, warning, error
    
    var systemIcon: String {
        // info.circle, checkmark.circle, exclamationmark.triangle, xmark.circle
    }
    
    func backgroundColor(theme: NimbusTheming, scheme: ColorScheme) -> Color {
        // Returns semantic color with ~12% opacity
    }
}
```

- [x] **NimbusNotificationView.swift** - Core notification view component
  - Layout: [Icon] [Message] [Spacer] [Action LinkButton] [Close CloseButton]
  - Semi-transparent semantic background colors
  - Proper spacing and typography
  - Matches reference image exactly

### Phase 3: Presentation System ✅
**Location**: `Sources/NimbusUI/Components/Notification/`

- [x] **NimbusNotificationModifier.swift** - ViewModifier for presentation
  - Overlay positioning at top with safe area + padding
  - Show/hide animations (slide down/up from top)
  - Auto-dismiss timer management for temporary notifications
  - State binding management and reset

- [x] **View+NimbusNotification.swift** - SwiftUI View extension
```swift
public extension View {
    func nimbusNotification(
        isPresented: Binding<Bool>,
        type: NotificationType,
        message: String,
        actionText: String? = nil,
        dismissBehavior: NotificationDismissBehavior = .sticky,
        onAction: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View
}
```

### Phase 4: Theme Integration ✅
**Location**: `Sources/NimbusUI/Theming/NimbusTheming.swift`

- [x] **Add Notification Design Tokens** - Extend NimbusTheming protocol
```swift
// Notification positioning & layout
var notificationTopPadding: CGFloat { 16 }
var notificationHorizontalPadding: CGFloat { 16 }
var notificationCornerRadii: RectangleCornerRadii { cornerRadii }

// Notification styling
var notificationBackgroundOpacity: CGFloat { 0.12 }
var notificationMinHeight: CGFloat { 56 }
var notificationIconSize: CGFloat { 20 }
var notificationPadding: CGFloat { 16 }

// Button styling for new styles
var linkButtonFontWeight: Font.Weight { .medium }
var closeButtonSize: CGFloat { 24 }
var closeButtonIconSize: CGFloat { 14 }

// Animation timing
var notificationShowAnimation: Animation { .spring(response: 0.4, dampingFraction: 0.8) }
var notificationHideAnimation: Animation { .easeOut(duration: 0.25) }
```

### Phase 5: Preview & Testing ✅
**Location**: `Sources/NimbusUI/Components/Notification/Preview/`

- [x] **NimbusNotificationView+Preview.swift** - Comprehensive previews
  - All 4 notification types
  - Both sticky and temporary dismiss behaviors
  - Different message lengths and action texts
  - Light and dark mode variations

### Phase 6: Theme Showcase Integration ✅
**Location**: `Sources/NimbusUI/Theming/CustomThemeExample.swift`

- [x] **Add NotificationComponentsSection** - Add to CustomThemeContentView
  - Showcase all 4 notification types with warm theme
  - Demonstrate both LinkButton and CloseButton styles
  - Show sticky vs temporary behaviors
  - Interactive examples with state management

## 🎨 Design Specifications

### Visual Requirements (from reference image):
- **Background**: Semantic colors with ~12% opacity
- **Layout**: Icon (20pt) → Message → Spacer → Action Link → Close X (24pt)
- **Typography**: Single flowing message text, medium weight action links
- **Spacing**: 16pt padding, comfortable icon/text spacing
- **Border Radius**: Consistent with theme corner radii
- **Colors**: Full opacity icons/text on semi-transparent backgrounds

### Presentation Requirements:
- **Position**: Top of window with safe area + 16pt padding
- **Width**: Full width minus 32pt horizontal padding
- **Animation**: Slide down/up from top edge (~0.3s spring/easeOut)
- **Z-Index**: Above all app content using overlay
- **Auto-dismiss**: Smooth timer for temporary notifications

## 📁 Complete File Structure
```
Sources/NimbusUI/Components/
├── ButtonStyles/
│   ├── LinkButtonStyle.swift                    # NEW
│   ├── CloseButtonStyle.swift                   # NEW
│   └── Preview/
│       ├── LinkButtonStyle+Preview.swift        # NEW
│       └── CloseButtonStyle+Preview.swift       # NEW
└── Notification/                                # NEW FOLDER
    ├── NimbusNotificationView.swift             # Core component
    ├── NimbusNotificationModifier.swift         # Presentation logic
    ├── View+NimbusNotification.swift            # Extension API
    ├── NotificationDismissBehavior.swift        # Behavior enum
    ├── NotificationType.swift                   # Semantic types
    └── Preview/NimbusNotificationView+Preview.swift
```

## 💡 Usage Examples

### Basic Usage:
```swift
struct ContentView: View {
    @State private var showSuccess = false
    
    var body: some View {
        VStack {
            Button("Show Success") { showSuccess = true }
        }
        .nimbusNotification(
            isPresented: $showSuccess,
            type: .success,
            message: "Payment completed successfully!",
            actionText: "View Details",
            dismissBehavior: .temporary(3.0)
        )
    }
}
```

### Advanced with Actions:
```swift
.nimbusNotification(
    isPresented: $showWarning,
    type: .warning,
    message: "Update payment information in your profile.",
    actionText: "Edit Profile",
    dismissBehavior: .sticky,
    onAction: { navigateToProfile() },
    onDismiss: { handleDismiss() }
)
```

## ✅ Success Criteria

1. **Pixel-perfect match** with reference image layout and styling
2. **View Modifier API** that feels natural in SwiftUI
3. **Perfect positioning** at top with safe area + padding
4. **Smooth animations** for show/hide transitions
5. **Auto-dismiss timer** for temporary notifications
6. **Complete theme integration** with semantic colors and transparency
7. **Reusable button components** (LinkButton, CloseButton) for other use cases
8. **Comprehensive showcase** in theme examples
9. **Follows NimbusUI patterns** for consistency and maintainability

## 📝 Development Notes

- All components should follow existing NimbusUI folder structure patterns
- Use existing theme semantic colors with transparency overlay
- Ensure accessibility compliance for all button interactions
- Test with different message lengths and screen sizes
- Consider future enhancements like notification queuing/stacking

---

## 🔄 Phase 7: Refinements & Improvements

**Based on user feedback after initial implementation**

### Issues Identified:
1. **Background too transparent** - Content behind notification shows through, text unreadable
2. **Color system mismatch** - Should use semantic color as base, derive darker variants for icon/text  
3. **Text truncation** - Long text gets cut off instead of wrapping properly
4. **Missing icon alignment** - Need vertical alignment options like checkbox component

### Refinement Tasks:

- [x] **Update NotificationType.swift** - Color system improvements
  - Increase background opacity from 12% to 22% for readability
  - Add `iconColor()`, `textColor()`, and `actionColor()` methods using `darker(by:)` method
  - Light mode: Use semantic color + darker(by: 0.15 icon, 0.2 text, 0.1 action)
  - Dark mode: Use semantic color for proper visibility

- [x] **Create NotificationIconAlignment.swift** - Icon positioning system
```swift
public enum NotificationIconAlignment: String, CaseIterable, Sendable {
    case center    // Centers icon with entire text content (default)
    case baseline  // Aligns icon with first line text baseline  
    case top       // Aligns icon with top of text content
}
```

- [x] **Update NimbusNotificationView.swift** - Layout improvements
  - Add `iconAlignment` parameter with `.center` default
  - Fix text wrapping - use `fixedSize(horizontal: false, vertical: true)` for proper wrapping
  - Implement icon alignment logic with separate `iconView` and `messageView` computed properties
  - Enhanced LinkButtonStyle with custom semantic color support

- [x] **Update View+NimbusNotification.swift** - API enhancement
  - Add `iconAlignment` parameter to view modifier API
  - Maintain backward compatibility with default value
  - Updated NimbusNotificationModifier to pass through iconAlignment

- [x] **Update NimbusTheming.swift** - Theme token adjustments
  - Adjust `notificationBackgroundOpacity` from 0.12 to 0.22
  - Enhanced readability without compromising design

- [x] **Update CustomThemeExample.swift** - Enhanced showcase
  - Add comprehensive icon alignment examples section
  - Add enhanced text wrapping demonstration section
  - Update color system description (22% background opacity)
  - Show enhanced color contrast with darker variants
  - Include edge cases and alignment comparisons

- [x] **Update NimbusNotificationView+Preview.swift** - Comprehensive testing
  - Add "Icon Alignment Options" preview with all 3 alignment types
  - Add "Enhanced Color Contrast" preview showing improved color system
  - Update "Long Message with Text Wrapping" with extensive examples
  - Test improved color contrast and text wrapping functionality

### Enhanced API Example:
```swift
.nimbusNotification(
    isPresented: $showWarning,
    type: .warning,
    message: "This is a very long warning message that should wrap properly instead of being truncated and remain fully readable.",
    actionText: "Fix Now",
    iconAlignment: .baseline,  // NEW - follows checkbox pattern
    dismissBehavior: .sticky,
    onAction: { /* action */ }
)
```

### Color System Specification:
- **Background**: Semantic color with 22% opacity (increased from 12%)
- **Icon**: Semantic color.darker(by: 0.15) in light mode
- **Text**: Semantic color.darker(by: 0.2) in light mode
- **Action Link**: Semantic color.darker(by: 0.1) in light mode
- **Close Button**: Secondary text color (unchanged)

---

**Status**: Initial implementation complete, refinements in progress  
**Last Updated**: 2025-08-03  
**Reference**: CleanShot 2025-08-03 at 00.31.14.png