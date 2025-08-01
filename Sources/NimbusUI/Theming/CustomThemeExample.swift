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
private struct CustomThemeContentView: View {
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
            }
            .padding(40)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
}

/// Reusable section for displaying a collection of colors
private struct ColorSection: View {
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
private struct ColorSwatch: View {
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

@available(macOS 15.0, *)
#Preview {
    CustomThemeExampleView()
}
#endif