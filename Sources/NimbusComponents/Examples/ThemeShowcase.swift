//
//  ThemeShowcase.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 04.08.25.
//

import SwiftUI
import NimbusCore

/// Unified theme showcase that demonstrates any NimbusTheming implementation.
/// This environment-driven showcase focuses on theme-specific tokens and customizations,
/// providing consistent presentation for development, previews, and snapshot testing.
///
/// **Usage:**
/// ```swift
/// ThemeShowcase()
///     .environment(\.nimbusTheme, MaritimeTheme())
/// ```
public struct ThemeShowcase: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header Section
                HeaderSection()
                
                // Color Palette Section
                ColorPaletteSection()
                
                // Component Customizations Section
                ComponentCustomizationsSection()
                
                // Button Showcase Section
                ButtonShowcaseSection()
            }
            .padding(32)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
}

// MARK: - Header Section

private struct HeaderSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Theme Showcase")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            Text("Comprehensive showcase of theme-specific tokens, customizations, and component integration. This view adapts to any theme applied via Environment.")
                .font(.subheadline)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                .fixedSize(horizontal: false, vertical: true)
            
            // Theme metadata section
            VStack(alignment: .leading, spacing: 4) {
                Label("Theme: \(String(describing: type(of: theme)))", systemImage: "paintbrush.fill")
                    .font(.caption)
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                
                Label("Color Scheme: \(colorScheme == .dark ? "Dark" : "Light")", systemImage: "circle.lefthalf.filled")
                    .font(.caption)
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Color Palette Section

private struct ColorPaletteSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Color Palette", subtitle: "Brand colors, semantic colors, and theme-specific color tokens")
            
            // Brand Colors
            VStack(alignment: .leading, spacing: 8) {
                Text("Brand Colors")
                    .font(.headline)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ColorSwatch(name: "Primary", color: theme.primaryColor(for: colorScheme))
                    ColorSwatch(name: "Secondary", color: theme.secondaryColor(for: colorScheme))
                    ColorSwatch(name: "Tertiary", color: theme.tertiaryColor(for: colorScheme))
                    ColorSwatch(name: "Accent", color: theme.accentColor(for: colorScheme))
                }
            }
            
            // Semantic Colors
            VStack(alignment: .leading, spacing: 8) {
                Text("Semantic Colors")
                    .font(.headline)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                    ColorSwatch(name: "Success", color: theme.successColor(for: colorScheme))
                    ColorSwatch(name: "Warning", color: theme.warningColor(for: colorScheme))
                    ColorSwatch(name: "Error", color: theme.errorColor(for: colorScheme))
                    ColorSwatch(name: "Info", color: theme.infoColor(for: colorScheme))
                }
            }
            
            // Background & Text Colors
            VStack(alignment: .leading, spacing: 8) {
                Text("Background & Text Colors")
                    .font(.headline)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 12) {
                    ColorSwatch(name: "Background", color: theme.backgroundColor(for: colorScheme))
                    ColorSwatch(name: "Secondary BG", color: theme.secondaryBackgroundColor(for: colorScheme))
                    ColorSwatch(name: "Tertiary BG", color: theme.tertiaryBackgroundColor(for: colorScheme))
                    ColorSwatch(name: "Primary Text", color: theme.primaryTextColor(for: colorScheme))
                    ColorSwatch(name: "Secondary Text", color: theme.secondaryTextColor(for: colorScheme))
                    ColorSwatch(name: "Tertiary Text", color: theme.tertiaryTextColor(for: colorScheme))
                }
            }
        }
    }
}

// MARK: - Component Customizations Section

private struct ComponentCustomizationsSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Component Customizations", subtitle: "Theme-specific component token overrides and customizations")
            
            VStack(alignment: .leading, spacing: 12) {
                // Core Design Tokens
                CustomizationGroup(title: "Core Design Tokens") {
                    TokenDisplay(name: "Corner Radii", value: theme.cornerRadii.topLeading.description)
                    TokenDisplay(name: "Min Height", value: "\(theme.minHeight)pt")
                    TokenDisplay(name: "Horizontal Padding", value: "\(theme.horizontalPadding)pt")
                    TokenDisplay(name: "Background Material", value: theme.backgroundMaterial != nil ? "Set" : "None")
                }
                
                // Button Customizations
                if hasButtonCustomizations() {
                    CustomizationGroup(title: "Button Customizations") {
                        if theme.buttonCornerRadii.topLeading != theme.cornerRadii.topLeading {
                            TokenDisplay(name: "Button Corner Radii", value: "\(theme.buttonCornerRadii.topLeading)pt")
                        }
                        if theme.compactButtonCornerRadii.topLeading != theme.cornerRadii.topLeading {
                            TokenDisplay(name: "Compact Corner Radii", value: "\(theme.compactButtonCornerRadii.topLeading)pt")
                        }
                        if theme.labelContentSpacing != 6 {
                            TokenDisplay(name: "Label Content Spacing", value: "\(theme.labelContentSpacing)pt")
                        }
                    }
                }
                
                // Other Component Customizations
                if hasOtherCustomizations() {
                    CustomizationGroup(title: "Other Component Tokens") {
                        if theme.scrollerWidth != 16 {
                            TokenDisplay(name: "Scroller Width", value: "\(theme.scrollerWidth)pt")
                        }
                        if theme.checkboxSize != 16 {
                            TokenDisplay(name: "Checkbox Size", value: "\(theme.checkboxSize)pt")
                        }
                        if theme.listItemHeight != 44 {
                            TokenDisplay(name: "List Item Height", value: "\(theme.listItemHeight)pt")
                        }
                    }
                }
                
                // Default Message
                if !hasButtonCustomizations() && !hasOtherCustomizations() {
                    Text("This theme uses default values for all component tokens, demonstrating the power of the optional token system!")
                        .font(.subheadline)
                        .foregroundColor(theme.successColor(for: colorScheme))
                        .italic()
                        .padding(16)
                        .background(theme.successColor(for: colorScheme).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                }
            }
        }
    }
    
    private func hasButtonCustomizations() -> Bool {
        theme.buttonCornerRadii.topLeading != theme.cornerRadii.topLeading || 
        theme.compactButtonCornerRadii.topLeading != theme.cornerRadii.topLeading || 
        theme.labelContentSpacing != 6
    }
    
    private func hasOtherCustomizations() -> Bool {
        theme.scrollerWidth != 16 || 
        theme.checkboxSize != 16 || 
        theme.listItemHeight != 44
    }
}

// MARK: - Button Showcase Section

private struct ButtonShowcaseSection: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Button Styles", subtitle: "All button styles with theme-specific styling applied")
            
            // Main Button Styles Grid (Columns = Styles, Rows = ControlSizes)
            HStack(alignment: .top, spacing: 16) {
                // Column 1: Primary Style
                VStack(spacing: 8) {
                    Text("Primary")
                        .font(.headline)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    buttons(style: .primary, controlSize: .large, text: "Large")
                    buttons(style: .primary, controlSize: .regular, text: "Regular")
                    buttons(style: .primary, controlSize: .small, text: "Small")
                    buttons(style: .primary, controlSize: .mini, text: "Mini")
                }
                
                // Column 2: Secondary Style
                VStack(spacing: 8) {
                    Text("Secondary")
                        .font(.headline)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    buttons(style: .secondary, controlSize: .large, text: "Large")
                    buttons(style: .secondary, controlSize: .regular, text: "Regular")
                    buttons(style: .secondary, controlSize: .small, text: "Small")
                    buttons(style: .secondary, controlSize: .mini, text: "Mini")
                }
                
                // Column 3: Accent Style
                VStack(spacing: 8) {
                    Text("Accent")
                        .font(.headline)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    buttons(style: .accent, controlSize: .large, text: "Large")
                    buttons(style: .accent, controlSize: .regular, text: "Regular")
                    buttons(style: .accent, controlSize: .small, text: "Small")
                    buttons(style: .accent, controlSize: .mini, text: "Mini")
                }
                
                // Column 4: Primary Outline Style
                VStack(spacing: 8) {
                    Text("Primary Outline")
                        .font(.headline)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    buttons(style: .primaryOutline, controlSize: .large, text: "Large")
                    buttons(style: .primaryOutline, controlSize: .regular, text: "Regular")
                    buttons(style: .primaryOutline, controlSize: .small, text: "Small")
                    buttons(style: .primaryOutline, controlSize: .mini, text: "Mini")
                }
                
                // Column 5: Secondary Outline Style
                VStack(spacing: 8) {
                    Text("Secondary Outline")
                        .font(.headline)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    buttons(style: .secondaryOutline, controlSize: .large, text: "Large")
                    buttons(style: .secondaryOutline, controlSize: .regular, text: "Regular")
                    buttons(style: .secondaryOutline, controlSize: .small, text: "Small")
                    buttons(style: .secondaryOutline, controlSize: .mini, text: "Mini")
                }
            }
            
            // Special Styles Section (Separate from main grid)
            VStack(alignment: .leading, spacing: 8) {
                Text("Special Styles")
                    .font(.headline)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                
                HStack(spacing: 12) {
                    buttons(style: .nimbusLink, controlSize: .regular, text: "Link Style")
                    
                    Button {} label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.close)
                    .controlSize(.regular)
                    
                    Button("Destructive", role: .destructive) {}
                        .buttonStyle(.accent)
                        .controlSize(.regular)
                }
            }
        }
    }
    
    @ViewBuilder
    func buttons<S: ButtonStyle>(style: S, controlSize: ControlSize = .regular, text: String) -> some View {
        Button(text) {}
            .buttonStyle(style)
            .controlSize(controlSize)
    }
}

// MARK: - Supporting Views

private struct SectionHeader: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
        }
    }
}

private struct ColorSwatch: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let name: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                .fill(color)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                        .stroke(theme.borderColor(for: colorScheme), lineWidth: 1)
                )
            
            Text(name)
                .font(.caption2)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                .lineLimit(1)
        }
    }
}

private struct CustomizationGroup<Content: View>: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            VStack(alignment: .leading, spacing: 4) {
                content
            }
            .padding(12)
            .background(theme.secondaryBackgroundColor(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
            .overlay(
                RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                    .stroke(theme.borderColor(for: colorScheme), lineWidth: 1)
            )
        }
    }
}

private struct TokenDisplay: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.caption)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
            
            Spacer()
            
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
        }
    }
}

private struct SpacingDemo: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let size: CGFloat
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Rectangle()
                .fill(theme.primaryColor(for: colorScheme))
                .frame(width: size, height: size)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
        }
    }
}

// MARK: - Preview Support

#if DEBUG
/// Theme showcase with preview support for all available themes
@available(macOS 15.0, *)
#Preview("NimbusTheme") {
    ThemeShowcase()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("MaritimeTheme") {
    ThemeShowcase()
        .environment(\.nimbusTheme, MaritimeTheme())
}

@available(macOS 15.0, *)
#Preview("CustomWarmTheme") {
    ThemeShowcase()
        .environment(\.nimbusTheme, CustomWarmTheme())
}

@available(macOS 15.0, *)
#Preview("MinimalTheme") {
    ThemeShowcase()
        .environment(\.nimbusTheme, MinimalTheme.default)
}

/// Interactive theme picker for development and testing
@available(macOS 15.0, *)
#Preview("Theme Picker") {
    ThemePickerShowcase()
}

private struct ThemePickerShowcase: View {
    @State private var selectedTheme: ThemeOption = .nimbus
    
    enum ThemeOption: String, CaseIterable {
        case nimbus = "NimbusTheme"
        case maritime = "MaritimeTheme"
        case customWarm = "CustomWarmTheme"
        case minimal = "MinimalTheme"
        
        var theme: any NimbusTheming {
            switch self {
            case .nimbus: return NimbusTheme.default
            case .maritime: return MaritimeTheme()
            case .customWarm: return CustomWarmTheme()
            case .minimal: return MinimalTheme.default
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Theme picker header
            HStack {
                Text("Theme:")
                    .font(.headline)
                
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(ThemeOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            // Theme showcase
            ThemeShowcase()
                .environment(\.nimbusTheme, selectedTheme.theme)
        }
    }
}
#endif
