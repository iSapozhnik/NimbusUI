//
//  MaritimeThemeExample.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 01.08.25.
//

import SwiftUI

#if DEBUG
/// Comprehensive showcase of all MaritimeTheme parameters
struct MaritimeThemeExampleView: View {
    var body: some View {
        MaritimeThemeContentView()
            .environment(\.nimbusTheme, MaritimeTheme())
    }
}

/// Internal content view that uses the properly set maritime theme environment
internal struct MaritimeThemeContentView: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("Maritime Theme Showcase")
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
                MaritimeMaterialDemoSection()
                
                // Corner Radius Demo Section
                MaritimeCornerRadiusDemoSection()
                
                // Button Styles Showcase Section
                MaritimeButtonStylesSection()
            }
            .padding(40)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
}

/// Material demonstration section for maritime theme
private struct MaritimeMaterialDemoSection: View {
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

/// Corner radius demonstration section for maritime theme
private struct MaritimeCornerRadiusDemoSection: View {
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
                    
                    Text("Structured maritime design (vs 12pt warm theme)")
                        .font(.caption2)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                }
            }
        }
    }
}

/// Comprehensive button styles showcase section for maritime theme
private struct MaritimeButtonStylesSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Section Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Button Styles")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("All NimbusUI button styles with maritime theme colors")
                    .font(.caption)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
            }
            
            // Primary Default Style
            MaritimeButtonStyleDemo(
                title: "Primary Default",
                description: "Uses theme.primaryColor (\(theme.primaryColor(for: colorScheme).hexString)) - Cerulean maritime blue",
                styleType: .primary,
                examples: [
                    .init(title: "Basic Text", button: AnyView(Button("Maritime Action") {})),
                    .init(title: "With Icon", button: AnyView(Button("Navigate", systemImage: "compass") {})),
                    .init(title: "Label Style", button: AnyView(
                        Button(action: {}) {
                            Label("Chart Course", systemImage: "map")
                        }
                    ))
                ]
            )
            
            // Primary Prominent Style
            MaritimeButtonStyleDemo(
                title: "Primary Prominent",
                description: "Uses theme.accentColor (\(theme.accentColor(for: colorScheme).hexString)) for normal, theme.errorColor for destructive",
                styleType: .accent,
                examples: [
                    .init(title: "Normal Action", button: AnyView(Button("Set Sail") {})),
                    .init(title: "Destructive Role", button: AnyView(Button("Abandon Ship", role: .destructive) {})),
                    .init(title: "Success Tint", button: AnyView(
                        Button("All Clear") {}
                            .tint(theme.successColor(for: colorScheme))
                    )),
                    .init(title: "Warning Tint", button: AnyView(
                        Button("Storm Warning", systemImage: "exclamationmark.triangle") {}
                            .tint(theme.warningColor(for: colorScheme))
                    ))
                ]
            )
            
            // Secondary Prominent Style
            MaritimeButtonStyleDemo(
                title: "Secondary Prominent",
                description: "Maritime-themed secondary prominent actions with structured styling",
                styleType: .secondary,
                examples: [
                    .init(title: "Apply Course", button: AnyView(Button("Apply") {})),
                    .init(title: "Drop Anchor", button: AnyView(Button("Anchor", systemImage: "anchor") {})),
                    .init(title: "Success Action", button: AnyView(
                        Button("Safe Harbor", systemImage: "checkmark.shield") {}
                            .tint(theme.successColor(for: colorScheme))
                    ))
                ]
            )
            
            // Secondary Bordered Style
            MaritimeButtonStyleDemo(
                title: "Secondary Bordered",
                description: "Subtle maritime controls for navigation and settings",
                styleType: .secondaryOutline,
                examples: [
                    .init(title: "Navigation", button: AnyView(Button("Options") {})),
                    .init(title: "Ship Settings", button: AnyView(Button("Settings", systemImage: "gearshape") {})),
                    .init(title: "Maritime Log", button: AnyView(
                        Button(action: {}) {
                            Label("Log", systemImage: "book")
                        }
                    ))
                ]
            )
            
            // Size Comparison
            VStack(alignment: .leading, spacing: 12) {
                Text("Maritime Theme Comparison")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                Text("Structured 8pt corners vs warm theme's 12pt - professional maritime feel")
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
        }
    }
}

/// Individual button style demonstration for maritime theme
private struct MaritimeButtonStyleDemo: View {
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

@available(macOS 15.0, *)
#Preview {
    MaritimeThemeExampleView()
}
#endif