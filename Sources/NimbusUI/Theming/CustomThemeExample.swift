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
    
    // MARK: - Design Tokens
    
    public let animation = Animation.smooth(duration: 0.2)
    public let animationFast = Animation.easeInOut(duration: 0.1)
    public let minHeight: CGFloat = 30
    public let horizontalPadding: CGFloat = 8
    public let elevation = Elevation.low
    public let buttonCornerRadii = RectangleCornerRadii(12)
    public let compactButtonCornerRadii = RectangleCornerRadii(8)
    public let listItemCornerRadii = RectangleCornerRadii(2)
    public let listItemHeight: CGFloat = 44
    public let labelContentSpacing: CGFloat = 6
    
    // MARK: - Scroller Design Tokens
    
    // Core scroller dimensions
    public let scrollerWidth: CGFloat = 18
    public let scrollerKnobWidth: CGFloat = 8
    public let scrollerKnobPadding: CGFloat = 2.5
    public let scrollerSlotCornerRadius: CGFloat = 6
    public let scrollerShowSlot: Bool = true
    
    // Auto-calculated knob corner radius (based on knob width and padding)
    public var scrollerKnobCornerRadius: CGFloat {
        (scrollerKnobWidth - scrollerKnobPadding) / 2
    }
    
    // Legacy properties (keeping for backward compatibility)
    public let scrollerKnobInsetVertical: CGFloat = 4
    public let scrollerKnobInsetHorizontal: CGFloat = 2
    public let scrollerSlotInset: CGFloat = 2
    public let scrollerInitialOpacity: CGFloat = 0.4
    public let scrollerFadeOpacity: CGFloat = 0.4
    public let scrollerFadeDelay: TimeInterval = 0.8
    public let scrollerAnimationDuration: TimeInterval = 0.15
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
                styleType: .primaryDefault,
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
                styleType: .primaryProminent,
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
                styleType: .secondaryProminent,
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
                styleType: .secondaryBordered,
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
                        .buttonStyle(.primaryDefault)
                        .frame(height: 40)
                    
                    Button("Primary Prominent") {}
                        .buttonStyle(.primaryProminent)
                        .frame(height: 40)
                    
                    Button("Secondary Prominent") {}
                        .buttonStyle(.secondaryProminent)
                        .frame(height: 40)
                    
                    Button("Secondary Bordered") {}
                        .buttonStyle(.secondaryBordered)
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
                    BulletPoint("Use .primaryDefault for main theme-colored actions")
                    BulletPoint("Use .primaryProminent for primary CTAs with automatic destructive styling")
                    BulletPoint("Use .secondaryProminent for secondary important actions")
                    BulletPoint("Use .secondaryBordered for subtle, system-integrated actions")
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
        case primaryDefault, primaryProminent, secondaryProminent, secondaryBordered
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
                            case .primaryDefault:
                                example.button.buttonStyle(.primaryDefault)
                            case .primaryProminent:
                                example.button.buttonStyle(.primaryProminent)
                            case .secondaryProminent:
                                example.button.buttonStyle(.secondaryProminent)
                            case .secondaryBordered:
                                example.button.buttonStyle(.secondaryBordered)
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
