//
//  CustomThemeExample.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 01.08.25.
//

import SwiftUI

/// Example custom theme implementation using warm, friendly colors.
/// This demonstrates how to implement the NimbusTheming protocol with your brand colors.
/// 
/// **Hex Color Implementation:**
/// This theme now uses the enhanced Color(hex:) initializer for maintainable color definitions.
/// The initializer supports various formats: "#F1D1A7", "F1D1A7", "#f1d1a7", "f1d1a7", "0xF1D1A7"
/// 
/// **Base Brand Colors:**
/// - Primary: #F1D1A7 (warm cream)
/// - Danger: #EE7671 (soft red) 
/// - Accent: #5584E4 (blue)
/// - Background: #FDF8F1 (warm white)
/// 
/// **Color Theory Applied:**
/// - Complementary colors derived using proper color theory principles
/// - Dark mode variants calculated for optimal contrast and accessibility
/// - Secondary and tertiary colors maintain warm color harmony
/// - Text colors ensure WCAG compliance for readability
public struct CustomWarmTheme: NimbusTheming, Sendable {
    public init() {}
    
    // MARK: - Brand Colors
    
    public func primaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F1D1A7"),
            dark: Color(hex: "#EAC393"),  // Slightly darker for dark mode
            scheme: scheme
        )
    }
    
    public func secondaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#D6B88E"), // Darker cream variant
            dark: Color(hex: "#C4A67C"),  // Dark mode variant
            scheme: scheme
        )
    }
    
    public func tertiaryColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#BB9D73"), // Even darker cream
            dark: Color(hex: "#A98B61"),  // Dark mode variant
            scheme: scheme
        )
    }
    
    public func accentColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#5584E4"),
            dark: Color(hex: "#769EF6"),  // Brighter for dark mode
            scheme: scheme
        )
    }
    
    // MARK: - Semantic Colors
    
    public func errorColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#EE7671"),
            dark: Color(hex: "#F38D88"),  // Slightly brighter for dark mode
            scheme: scheme
        )
    }
    
    public func successColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#4CAF50"), // Complementary green
            dark: Color(hex: "#66BB6A"),  // Brighter for dark mode
            scheme: scheme
        )
    }
    
    public func warningColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#FCAB34"), // Warm orange
            dark: Color(hex: "#FFC04D"),    // Brighter for dark mode
            scheme: scheme
        )
    }
    
    public func infoColor(for scheme: ColorScheme) -> Color {
        accentColor(for: scheme) // Reuse accent blue for info
    }
    
    // MARK: - Background Colors
    
    public func backgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#FDF8F1"),
            dark: Color(hex: "#1E1B17"),  // Dark warm background
            scheme: scheme
        )
    }
    
    public func secondaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F8EFE3"), // Slightly darker warm
            dark: Color(hex: "#282521"),  // Dark mode variant
            scheme: scheme
        )
    }
    
    public func tertiaryBackgroundColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#F1E3D1"), // Even darker warm
            dark: Color(hex: "#322F2B"),  // Dark mode variant
            scheme: scheme
        )
    }
    
    // MARK: - Text Colors
    
    public func primaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#2D231A"), // Warm dark brown
            dark: Color(hex: "#F1EBE3"),  // Warm light for dark mode
            scheme: scheme
        )
    }
    
    public func secondaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#695A4C"), // Medium warm brown
            dark: Color(hex: "#B7ADA2"),  // Medium warm for dark mode
            scheme: scheme
        )
    }
    
    public func tertiaryTextColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#968779"), // Light warm brown
            dark: Color(hex: "#82786D"),  // Darker warm for dark mode
            scheme: scheme
        )
    }
    
    // MARK: - Border Colors
    
    public func borderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#D6C7B7"), // Warm border
            dark: Color(hex: "#4C443C"),  // Dark warm border
            scheme: scheme
        )
    }
    
    public func secondaryBorderColor(for scheme: ColorScheme) -> Color {
        Color.adaptiveColor(
            light: Color(hex: "#E5DBCF"), // Subtle warm border
            dark: Color(hex: "#3C3630"),  // Subtle dark warm border
            scheme: scheme
        )
    }
    
    // MARK: - Material & Styling
    
    public let backgroundMaterial: Material? = Material.thinMaterial
    public let cornerRadii = RectangleCornerRadii(12) // Slightly more rounded for friendly feel
    
    // MARK: - Core Design Tokens (Required)
    
    public let animation = Animation.smooth(duration: 0.2)
    public let animationFast = Animation.easeInOut(duration: 0.1)
    public let minHeight: CGFloat = 30
    public let horizontalPadding: CGFloat = 8
    public let elevation = Elevation.low
    
    // MARK: - Component Token Overrides (Optional)
    // Warm theme emphasizes rounded, friendly design with larger touch targets
    
    // Button customization for friendly, rounded feel
    public var buttonCornerRadii: RectangleCornerRadii { RectangleCornerRadii(12) }
    public var compactButtonCornerRadii: RectangleCornerRadii { RectangleCornerRadii(8) }
    
    // Scroller customization for warm, accessible feel
    public var scrollerWidth: CGFloat { 18 }
    public var scrollerKnobWidth: CGFloat { 8 }
    public var scrollerKnobPadding: CGFloat { 2.5 }
    public var scrollerSlotCornerRadius: CGFloat { 6 }
    
    // Warm scroller timing - more responsive
    public var scrollerInitialOpacity: CGFloat { 0.4 }
    public var scrollerFadeOpacity: CGFloat { 0.4 }
    public var scrollerFadeDelay: TimeInterval { 0.8 }
    public var scrollerAnimationDuration: TimeInterval { 0.15 }
    
    // Legacy overrides for warm theme
    public var scrollerKnobInsetVertical: CGFloat { 4 }
    public var scrollerKnobInsetHorizontal: CGFloat { 2 }
    public var scrollerSlotInset: CGFloat { 2 }
    
    // Notification animation customization for warm, friendly feel
    public var notificationBounceAnimation: Animation { 
        .spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.0) 
    }
    public var notificationScaleAnimation: Animation { 
        .spring(response: 0.6, dampingFraction: 0.6).delay(0.1) 
    }
}

// MARK: - Usage Example
//
// Creating custom themes with hex colors is now straightforward:
//
// ```swift
// struct MyBrandTheme: NimbusTheming {
//     func primaryColor(for scheme: ColorScheme) -> Color {
//         Color.adaptiveColor(
//             light: Color(hex: "#FF6B6B"),  // Your brand red
//             dark: Color(hex: "#FF8E8E"),   // Lighter for dark mode
//             scheme: scheme
//         )
//     }
//     
//     func backgroundColor(for scheme: ColorScheme) -> Color {
//         Color.adaptiveColor(
//             light: Color(hex: "FFFFFF"),   // Without hash prefix
//             dark: Color(hex: "0x121212"),  // With 0x prefix
//             scheme: scheme
//         )
//     }
// }
// ```

#if DEBUG
/// Comprehensive showcase of all CustomWarmTheme parameters
struct CustomThemeExampleView: View {
    var body: some View {
        CustomThemeContentView()
            .environment(\.nimbusTheme, CustomWarmTheme())
    }
}

/// Internal content view that uses the properly set theme environment
internal struct CustomThemeContentView: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("Custom Warm Theme Showcase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Brand Colors Section
                ColorSection(
                    title: "Brand Colors",
                    colors: [
                        ("Primary Color", theme.primaryColor(for: colorScheme)),
                        ("Secondary Color", theme.secondaryColor(for: colorScheme)),
                        ("Tertiary Color", theme.tertiaryColor(for: colorScheme)),
                        ("Accent Color", theme.accentColor(for: colorScheme))
                    ]
                )
                
                // Semantic Colors Section
                ColorSection(
                    title: "Semantic Colors",
                    colors: [
                        ("Error Color", theme.errorColor(for: colorScheme)),
                        ("Success Color", theme.successColor(for: colorScheme)),
                        ("Warning Color", theme.warningColor(for: colorScheme)),
                        ("Info Color", theme.infoColor(for: colorScheme))
                    ]
                )
                
                // Background Colors Section
                ColorSection(
                    title: "Background Colors",
                    colors: [
                        ("Background Color", theme.backgroundColor(for: colorScheme)),
                        ("Secondary Background", theme.secondaryBackgroundColor(for: colorScheme)),
                        ("Tertiary Background", theme.tertiaryBackgroundColor(for: colorScheme))
                    ]
                )
                
                // Text Colors Section
                ColorSection(
                    title: "Text Colors",
                    colors: [
                        ("Primary Text", theme.primaryTextColor(for: colorScheme)),
                        ("Secondary Text", theme.secondaryTextColor(for: colorScheme)),
                        ("Tertiary Text", theme.tertiaryTextColor(for: colorScheme))
                    ]
                )
                
                // Border Colors Section
                ColorSection(
                    title: "Border Colors",
                    colors: [
                        ("Border Color", theme.borderColor(for: colorScheme)),
                        ("Secondary Border", theme.secondaryBorderColor(for: colorScheme))
                    ]
                )
                
                // Material Demo Section
                MaterialDemoSection()
                
                // Corner Radius Demo Section
                CornerRadiusDemoSection()
                
                // Button Styles Showcase Section
                ButtonStylesSection()
                
                // Checkbox Components Section
                CheckboxComponentsSection()
                
                // Scroller Components Section
                ScrollerComponentsSection()
                
                // Notification Components Section
                NotificationComponentsSection()
            }
            .padding(40)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
}

/// Reusable section for displaying a collection of colors
internal struct ColorSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let colors: [(name: String, color: Color)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: min(colors.count, 4)), spacing: 12) {
                ForEach(colors.indices, id: \.self) { index in
                    ColorSwatch(
                        name: colors[index].name,
                        color: colors[index].color
                    )
                }
            }
        }
    }
}

/// Individual color swatch component
internal struct ColorSwatch: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let name: String
    let color: Color
    
    private var textColor: Color {
        // Simple luminance-based contrast calculation
        let luminance = color.luminance
        return luminance > 0.5 ? Color.black : Color.white
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .fill(color)
                .frame(height: 80)
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                        .stroke(theme.borderColor(for: colorScheme), lineWidth: 1)
                )
            
            VStack(spacing: 2) {
                Text(name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    .multilineTextAlignment(.center)
                
                Text(color.hexString)
                    .font(.caption2)
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    .fontDesign(.monospaced)
            }
        }
    }
}

/// Material demonstration section
private struct MaterialDemoSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Background Material")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            ZStack {
                // Background pattern to show material effect
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                theme.primaryColor(for: colorScheme),
                                theme.secondaryColor(for: colorScheme),
                                theme.accentColor(for: colorScheme)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                
                // Material overlay
                if let material = theme.backgroundMaterial {
                    Rectangle()
                        .fill(material)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                        .overlay(
                            VStack {
                                Text("Background Material")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Text("\(String(describing: material))")
                                    .font(.caption)
                                    .fontDesign(.monospaced)
                            }
                            .foregroundColor(theme.primaryTextColor(for: colorScheme))
                        )
                } else {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                        .overlay(
                            Text("No Background Material")
                                .font(.headline)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                        )
                }
            }
        }
    }
}

/// Corner radius demonstration section
private struct CornerRadiusDemoSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Corner Radius")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            HStack(spacing: 16) {
                ForEach([60, 80, 100], id: \.self) { size in
                    VStack(spacing: 8) {
                        Rectangle()
                            .fill(theme.secondaryBackgroundColor(for: colorScheme))
                            .frame(width: CGFloat(size), height: CGFloat(size))
                            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                            .overlay(
                                RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                                    .stroke(theme.borderColor(for: colorScheme), lineWidth: 2)
                            )
                        
                        Text("\(size)×\(size)")
                            .font(.caption2)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Corner Radius: \(Int(theme.cornerRadii.topLeading))pt")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    Text("Applied consistently across all corners")
                        .font(.caption2)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                }
            }
        }
    }
}

/// Comprehensive button styles showcase section
private struct ButtonStylesSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Section Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Button Styles Showcase")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Comprehensive demonstration of all 4 available button styles with various configurations and theme colors")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Primary Default Style
            ButtonStyleDemo(
                title: "Primary Default",
                description: "Uses theme.primaryColor (\(theme.primaryColor(for: colorScheme).hexString)) with built-in hover states",
                styleType: .primary,
                examples: [
                    .init(title: "Basic Text", button: AnyView(Button("Default Action") {})),
                    .init(title: "With Icon", button: AnyView(Button("Save", systemImage: "square.and.arrow.down") {})),
                    .init(title: "Label Style", button: AnyView(
                        Button(action: {}) {
                            Label("Export", systemImage: "square.and.arrow.up")
                        }
                    ))
                ]
            )
            
            // Primary Prominent Style
            ButtonStyleDemo(
                title: "Primary Prominent",
                description: "Uses theme.accentColor (\(theme.accentColor(for: colorScheme).hexString)) for normal, theme.errorColor (\(theme.errorColor(for: colorScheme).hexString)) for destructive",
                styleType: .accent,
                examples: [
                    .init(title: "Normal Action", button: AnyView(Button("Continue") {})),
                    .init(title: "Destructive Role", button: AnyView(Button("Delete", role: .destructive) {})),
                    .init(title: "Cancel Role", button: AnyView(Button("Cancel", role: .cancel) {})),
                    .init(title: "Success Tint", button: AnyView(
                        Button("Complete") {}
                            .tint(theme.successColor(for: colorScheme))
                    )),
                    .init(title: "Warning Tint", button: AnyView(
                        Button("Warning", systemImage: "exclamationmark.triangle") {}
                            .tint(theme.warningColor(for: colorScheme))
                    )),
                    .init(title: "Icon + Destructive", button: AnyView(
                        Button("Delete", systemImage: "trash", role: .destructive) {}
                    ))
                ]
            )
            
            // Secondary Prominent Style
            ButtonStyleDemo(
                title: "Secondary Prominent",
                description: "Similar to Primary Prominent with different visual treatment and sizing",
                styleType: .secondary,
                examples: [
                    .init(title: "Normal Action", button: AnyView(Button("Apply") {})),
                    .init(title: "Destructive Role", button: AnyView(Button("Remove", role: .destructive) {})),
                    .init(title: "Success Tint", button: AnyView(
                        Button("Approve", systemImage: "checkmark") {}
                            .tint(theme.successColor(for: colorScheme))
                    )),
                    .init(title: "With Complex Label", button: AnyView(
                        Button(action: {}) {
                            Label("Process", systemImage: "gear")
                        }
                    ))
                ]
            )
            
            // Secondary Bordered Style
            ButtonStyleDemo(
                title: "Secondary Bordered",
                description: "Subtle bordered style using system colors (.quinary, .quaternary) - adapts to system theme",
                styleType: .secondaryOutline,
                examples: [
                    .init(title: "Basic Action", button: AnyView(Button("Options") {})),
                    .init(title: "With Icon", button: AnyView(Button("Settings", systemImage: "gearshape") {})),
                    .init(title: "Cancel Action", button: AnyView(Button("Cancel") {})),
                    .init(title: "More Actions", button: AnyView(
                        Button(action: {}) {
                            Label("More", systemImage: "ellipsis")
                        }
                    ))
                ]
            )
            
            // Size Comparison Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Size Comparison")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("All button styles at standard height with varying content")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack(spacing: 12) {
                    Button("Primary Default") {}
                        .buttonStyle(.primary)
                        .frame(height: 40)
                    
                    Button("Primary Prominent") {}
                        .buttonStyle(.accent)
                        .frame(height: 40)
                    
                    Button("Secondary Prominent") {}
                        .buttonStyle(.secondary)
                        .frame(height: 40)
                    
                    Button("Secondary Bordered") {}
                        .buttonStyle(.secondaryOutline)
                        .frame(height: 40)
                }
            }
            
            // Usage Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Developer Usage Notes")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                VStack(alignment: .leading, spacing: 4) {
                    BulletPoint("Use .primary for main theme-colored actions")
                    BulletPoint("Use .accent for primary CTAs with automatic destructive styling")
                    BulletPoint("Use .secondaryProminent for secondary important actions")
                    BulletPoint("Use .secondaryOutline for subtle, system-integrated actions")
                    BulletPoint("Apply .tint() modifier to override colors for specific semantic meanings")
                    BulletPoint("Button roles (.destructive, .cancel) automatically apply appropriate colors")
                    BulletPoint("All styles support Label views with system images")
                }
            }
        }
    }
}

/// Individual button style demonstration section
private struct ButtonStyleDemo: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    enum StyleType {
        case primary, accent, secondary, secondaryOutline
    }
    
    struct ButtonExample {
        let title: String
        let button: AnyView
    }
    
    let title: String
    let description: String
    let styleType: StyleType
    let examples: [ButtonExample]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Style Header
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Examples Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: min(examples.count, 3)), spacing: 12) {
                ForEach(examples.indices, id: \.self) { index in
                    let example = examples[index]
                    
                    VStack(spacing: 6) {
                        // Apply the button style based on type
                        Group {
                            switch styleType {
                            case .primary:
                                example.button.buttonStyle(.primary)
                            case .accent:
                                example.button.buttonStyle(.accent)
                            case .secondary:
                                example.button.buttonStyle(.secondary)
                            case .secondaryOutline:
                                example.button.buttonStyle(.secondaryOutline)
                            }
                        }
                        .frame(height: 36)
                        
                        Text(example.title)
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .padding(16)
        .background(theme.secondaryBackgroundColor(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                .stroke(theme.secondaryBorderColor(for: colorScheme), lineWidth: 1)
        )
    }
}

/// Checkbox components showcase section
private struct CheckboxComponentsSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var standaloneCheckbox1: Bool = false
    @State private var standaloneCheckbox2: Bool = true
    @State private var itemCheckbox1: Bool = false
    @State private var itemCheckbox2: Bool = true
    @State private var itemCheckbox3: Bool = false
    @State private var itemCheckbox4: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Section Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Checkbox Components")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("NimbusCheckbox and NimbusCheckboxItem components with warm theme customization")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Standalone Checkbox Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("NimbusCheckbox - Size Customization")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Default 16pt vs Custom 20pt checkbox sizes")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack(spacing: 24) {
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $standaloneCheckbox1)
                        Text("Default (16pt)")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $standaloneCheckbox2)
                            .environment(\.nimbusCheckboxSize, 20)
                        Text("Custom (20pt)")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                }
            }
            
            // Checkbox Item Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("NimbusCheckboxItem - Position Customization")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Leading vs trailing checkbox positions with title and subtitle support")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                VStack(spacing: 16) {
                    // Leading position examples
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Leading Position")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        VStack(alignment: .leading, spacing: 6) {
                            NimbusCheckboxItem(
                                "Enable warm theme features",
                                isOn: $itemCheckbox1,
                                checkboxPosition: .leading
                            )
                            
                            NimbusCheckboxItem(
                                "Advanced settings",
                                subtitle: "Configure additional warm theme options",
                                isOn: $itemCheckbox2,
                                checkboxPosition: .leading
                            )
                        }
                    }
                    
                    // Trailing position examples
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Trailing Position")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        VStack(alignment: .leading, spacing: 6) {
                            NimbusCheckboxItem(
                                "Friendly rounded corners",
                                isOn: $itemCheckbox3,
                                checkboxPosition: .trailing
                            )
                            
                            NimbusCheckboxItem(
                                "Enhanced accessibility",
                                subtitle: "Improved touch targets and contrast",
                                isOn: $itemCheckbox4,
                                checkboxPosition: .trailing
                            )
                        }
                    }
                }
            }
            
            // Usage Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Checkbox Theme Integration")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                VStack(alignment: .leading, spacing: 4) {
                    BulletPoint("Uses theme.primaryColor (\(theme.primaryColor(for: colorScheme).hexString)) for checked state")
                    BulletPoint("Inherits warm theme's 12pt corner radius for friendly appearance")
                    BulletPoint("Supports environment overrides for size and positioning")
                    BulletPoint("NimbusCheckboxItem provides flexible title/subtitle layouts")
                }
            }
        }
        .padding(16)
        .background(theme.secondaryBackgroundColor(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                .stroke(theme.secondaryBorderColor(for: colorScheme), lineWidth: 1)
        )
    }
}

/// Scroller components showcase section
private struct ScrollerComponentsSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var scrollerValue1: Float = 0.3
    @State private var scrollerKnobProportion1: Float = 0.2
    @State private var scrollerValue2: Float = 0.6
    @State private var scrollerKnobProportion2: Float = 0.3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Section Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Scroller Components")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("NimbusScroller and NimbusScrollView with warm theme scroller customization")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Standalone Scroller Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("NimbusScroller - Width Customization")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Default 18pt vs Custom 24pt scroller width (warm theme uses wider 18pt vs default 16pt)")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack(spacing: 40) {
                    VStack(spacing: 8) {
                        NimbusScroller(
                            type: .vertical,
                            value: $scrollerValue1,
                            knobProportion: $scrollerKnobProportion1
                        )
                        .frame(height: 120)
                        
                        Text("Default (18pt)")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                    
                    VStack(spacing: 8) {
                        NimbusScroller(
                            type: .vertical,
                            value: $scrollerValue2,
                            knobProportion: $scrollerKnobProportion2
                        )
                        .environment(\.nimbusScrollerWidth, 24)
                        .environment(\.nimbusScrollerKnobWidth, 10)
                        .frame(height: 120)
                        
                        Text("Custom (24pt)")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                }
            }
            
            // ScrollView Integration Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("NimbusScrollView Integration")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Custom scrollers integrated with scrollable content")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                NimbusScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(0..<8, id: \.self) { index in
                            HStack {
                                Circle()
                                    .fill(theme.primaryColor(for: colorScheme))
                                    .frame(width: 12, height: 12)
                                
                                Text("Scrollable content item \(index + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(theme.tertiaryBackgroundColor(for: colorScheme))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                    .padding(16)
                }
                .frame(height: 150)
                .background(theme.backgroundColor(for: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                        .stroke(theme.borderColor(for: colorScheme), lineWidth: 1)
                )
            }
            
            // Usage Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Scroller Theme Integration")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                VStack(alignment: .leading, spacing: 4) {
                    BulletPoint("Warm theme uses 18pt scroller width (vs 16pt default) for better accessibility")
                    BulletPoint("Custom knob width of 8pt provides comfortable drag targets")
                    BulletPoint("Enhanced opacity settings (0.4 vs 0.3) for better visibility")
                    BulletPoint("Responsive animation duration (0.15s) matches warm theme feel")
                }
            }
        }
        .padding(16)
        .background(theme.secondaryBackgroundColor(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                .stroke(theme.secondaryBorderColor(for: colorScheme), lineWidth: 1)
        )
    }
}

/// Notification components showcase section
internal struct NotificationComponentsSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var showInfo = false
    @State private var showSuccess = false
    @State private var showWarning = false
    @State private var showError = false
    @State private var showTemporary = false
    
    // Animation style demos
    @State private var showSlideFromTop = false
    @State private var showFadeIn = false
    @State private var showSlideFromBottom = false
    @State private var showSlideFromLeading = false
    @State private var showSlideFromTrailing = false
    @State private var showBounce = false
    @State private var showScale = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Notification System")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Enhanced NimbusNotificationView system with icon alignment, improved text wrapping, and enhanced color contrast")
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
            }
            
            // Button Styles Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("New Button Styles")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Link Button Style")
                            .font(.caption)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        HStack(spacing: 12) {
                            Button("Try again", action: {})
                                .buttonStyle(LinkButtonStyle())
                            Button("Check details", action: {})
                                .buttonStyle(LinkButtonStyle())
                            Button("Edit Profile", action: {})
                                .buttonStyle(LinkButtonStyle())
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Close Button Style")
                            .font(.caption)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        HStack(spacing: 12) {
                            Button(action: {}) {
                                Image(systemName: "xmark")
                            }
                            .buttonStyle(CloseButtonStyle())
                            
                            Button(action: {}) {
                                Image(systemName: "xmark")
                            }
                            .buttonStyle(CloseButtonStyle())
                            .disabled(true)
                        }
                    }
                }
                .padding(16)
                .background(theme.tertiaryBackgroundColor(for: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
            }
            
            // Icon Alignment Examples
            VStack(alignment: .leading, spacing: 12) {
                Text("Icon Alignment Options")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Demonstrates the new icon alignment system for better layout control:")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                VStack(spacing: 12) {
                    // Center alignment (default)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Center Alignment (Default)")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        NimbusNotificationView(
                            type: .info,
                            message: "Center alignment where the icon is centered relative to the entire text content. This is the default behavior that works well for most use cases.",
                            actionText: "Learn More",
                            iconAlignment: .center
                        )
                    }
                    
                    // Baseline alignment
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Baseline Alignment")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        NimbusNotificationView(
                            type: .success,
                            message: "Baseline alignment positions the icon to align with the first line of text, creating a more structured appearance.",
                            actionText: "Confirm",
                            iconAlignment: .baseline
                        )
                    }
                    
                    // Top alignment
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Top Alignment")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                        
                        NimbusNotificationView(
                            type: .warning,
                            message: "Top alignment positions the icon at the very top of the text content. This is particularly useful for notifications with very long messages that wrap to multiple lines.",
                            actionText: "Fix",
                            iconAlignment: .top
                        )
                    }
                }
            }
            
            // Enhanced Text Wrapping Examples
            VStack(alignment: .leading, spacing: 12) {
                Text("Enhanced Text Wrapping")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Improved text wrapping without truncation for long messages:")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                VStack(spacing: 12) {
                    NimbusNotificationView(
                        type: .warning,
                        message: "This is a very long notification message that demonstrates the improved text wrapping functionality. The message should properly wrap to multiple lines without any truncation, allowing users to read the complete content while maintaining proper layout with action buttons and icons.",
                        actionText: "Fix Now"
                    )
                    
                    NimbusNotificationView(
                        type: .error,
                        message: "Extremely long error message to test edge cases where users might provide exceptionally detailed notification content that spans multiple lines. The enhanced implementation ensures proper vertical expansion and readability regardless of message length.",
                        actionText: "Retry"
                    )
                }
            }
            
            // Static Notification Examples
            VStack(alignment: .leading, spacing: 12) {
                Text("Enhanced Color System (22% Background Opacity)")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                VStack(spacing: 12) {
                    NimbusNotificationView(
                        type: .info,
                        message: "New feature coming soon! Prepare yourself for the release next month.",
                        actionText: "Try again"
                    )
                    
                    NimbusNotificationView(
                        type: .success,
                        message: "Congratulations! Your payment is completed successfully.",
                        actionText: "Check details"
                    )
                    
                    NimbusNotificationView(
                        type: .warning,
                        message: "Action needed! Update payment information in your profile.",
                        actionText: "Edit Profile"
                    )
                    
                    NimbusNotificationView(
                        type: .error,
                        message: "Something went wrong! We failed to complete your payment.",
                        actionText: "Try again"
                    )
                }
            }
            
            // Interactive Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("Interactive Demo")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Click buttons to test the notification presentation system:")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack(spacing: 12) {
                    Button("Info") { showInfo = true }
                        .buttonStyle(.secondary)
                    
                    Button("Success") { showSuccess = true }
                        .buttonStyle(.secondary)
                    
                    Button("Warning") { showWarning = true }
                        .buttonStyle(.secondary)
                    
                    Button("Error") { showError = true }
                        .buttonStyle(.secondary)
                    
                    Button("Auto-dismiss (3s)") { showTemporary = true }
                        .buttonStyle(.secondaryOutline)
                }
                .padding(16)
                .background(theme.tertiaryBackgroundColor(for: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
            }
            
            // Animation Styles Demo
            VStack(alignment: .leading, spacing: 12) {
                Text("Animation Styles Demo")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Test all 7 presentation styles with different animations and positioning:")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                    Button("Slide from Top") { showSlideFromTop = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Fade In") { showFadeIn = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Slide from Bottom") { showSlideFromBottom = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Slide from Leading") { showSlideFromLeading = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Slide from Trailing") { showSlideFromTrailing = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Bounce (Enhanced)") { showBounce = true }
                        .buttonStyle(.secondaryOutline)
                    
                    Button("Scale (Custom)") { showScale = true }
                        .buttonStyle(.secondaryOutline)
                }
                .padding(16)
                .background(theme.tertiaryBackgroundColor(for: colorScheme))
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
            }
            
            // Usage Notes
            VStack(alignment: .leading, spacing: 8) {
                Text("Notification Theme Integration")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                VStack(alignment: .leading, spacing: 4) {
                    BulletPoint("Enhanced color system with 22% background opacity for better readability")
                    BulletPoint("Semantic colors with darker variants (0.15x icon, 0.2x text, 0.1x action) for improved contrast")
                    BulletPoint("Icon alignment options: center (default), baseline, and top positioning")
                    BulletPoint("Improved text wrapping with fixedSize for proper multi-line support")
                    BulletPoint("LinkButton and CloseButton styles with custom semantic color support")
                    BulletPoint("7 presentation styles: slideFromTop (default), fadeIn, slideFromBottom, slideFromLeading, slideFromTrailing, bounce, scale")
                    BulletPoint("Dynamic positioning: notifications appear from top/bottom/sides/center based on presentation style")
                    BulletPoint("Custom animation tokens: notificationBounceAnimation and notificationScaleAnimation for enhanced styles")
                    BulletPoint("Auto-dismiss timers available for temporary notifications")
                    BulletPoint("Full backward compatibility: existing calls work unchanged with slideFromTop default")
                }
            }
        }
        .padding(16)
        .background(theme.secondaryBackgroundColor(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
        .overlay(
            RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                .stroke(theme.secondaryBorderColor(for: colorScheme), lineWidth: 1)
        )
        .nimbusNotification(
            isPresented: $showInfo,
            type: .info,
            message: "New feature coming soon! Prepare yourself for the release next month.",
            actionText: "Try again",
            dismissBehavior: .sticky,
            onAction: { print("Info action tapped") }
        )
        .nimbusNotification(
            isPresented: $showSuccess,
            type: .success,
            message: "Congratulations! Your payment is completed successfully.",
            actionText: "Check details",
            dismissBehavior: .sticky,
            onAction: { print("Success action tapped") }
        )
        .nimbusNotification(
            isPresented: $showWarning,
            type: .warning,
            message: "Action needed! Update payment information in your profile.",
            actionText: "Edit Profile",
            dismissBehavior: .sticky,
            onAction: { print("Warning action tapped") }
        )
        .nimbusNotification(
            isPresented: $showError,
            type: .error,
            message: "Something went wrong! We failed to complete your payment.",
            actionText: "Try again",
            dismissBehavior: .sticky,
            onAction: { print("Error action tapped") }
        )
        .nimbusNotification(
            isPresented: $showTemporary,
            type: .success,
            message: "This notification will auto-dismiss in 3 seconds!",
            dismissBehavior: .temporary(3.0)
        )
        // Animation Styles Demos
        .nimbusNotification(
            isPresented: $showSlideFromTop,
            type: .info,
            message: "Slide from Top - The default animation style with smooth slide from top edge.",
            actionText: "OK",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .slideFromTop
        )
        .nimbusNotification(
            isPresented: $showFadeIn,
            type: .success,
            message: "Fade In - Pure opacity transition appearing in center of screen.",
            actionText: "Great",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .fadeIn
        )
        .nimbusNotification(
            isPresented: $showSlideFromBottom,
            type: .warning,
            message: "Slide from Bottom - Notification slides up from the bottom edge.",
            actionText: "Got it",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .slideFromBottom
        )
        .nimbusNotification(
            isPresented: $showSlideFromLeading,
            type: .error,
            message: "Slide from Leading - Slides in from the left side of the screen.",
            actionText: "Understood",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .slideFromLeading
        )
        .nimbusNotification(
            isPresented: $showSlideFromTrailing,
            type: .info,
            message: "Slide from Trailing - Slides in from the right side of the screen.",
            actionText: "Nice",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .slideFromTrailing
        )
        .nimbusNotification(
            isPresented: $showBounce,
            type: .success,
            message: "Bounce Animation - Enhanced spring animation with custom warm theme bounce settings (response: 0.8, damping: 0.5).",
            actionText: "Bouncy!",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .bounce
        )
        .nimbusNotification(
            isPresented: $showScale,
            type: .warning,
            message: "Scale Animation - Scales up from center with custom warm theme scale settings (response: 0.6, damping: 0.6, delay: 0.1s).",
            actionText: "Cool",
            dismissBehavior: .temporary(4.0),
            presentationStyle: .scale
        )
    }
}

/// Simple bullet point component for usage notes
private struct BulletPoint: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text("•")
                .foregroundColor(theme.accentColor(for: colorScheme))
                .fontWeight(.medium)
            
            Text(text)
                .font(.caption)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

@available(macOS 15.0, *)
#Preview {
    CustomThemeExampleView()
}
#endif
