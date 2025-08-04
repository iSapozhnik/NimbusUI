//
//  MaritimeThemeExampleSimplified.swift
//  NimbusComponents
//
//  Created by Claude on 04.08.25.
//

import SwiftUI
import NimbusCore

#if DEBUG
/// Simplified maritime theme example that focuses on component showcase
struct MaritimeThemeExampleView: View {
    var body: some View {
        MaritimeThemeContentView()
            .environment(\.nimbusTheme, MaritimeTheme())
    }
}

/// Internal content view for simplified maritime theme showcase
internal struct MaritimeThemeContentView: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("Maritime Theme - Component Showcase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Button Styles Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Button Styles")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    // Primary and Secondary Buttons
                    HStack(spacing: 12) {
                        Button("Primary") {}
                            .buttonStyle(.primary)
                        
                        Button("Secondary") {}
                            .buttonStyle(.secondary)
                        
                        Button("Accent") {}
                            .buttonStyle(.accent)
                    }
                    
                    // Outline Buttons
                    HStack(spacing: 12) {
                        Button("Primary Outline") {}
                            .buttonStyle(.primaryOutline)
                        
                        Button("Secondary Outline") {}
                            .buttonStyle(.secondaryOutline)
                    }
                    
                    // Link and Close Buttons
                    HStack(spacing: 12) {
                        Button("Link Style") {}
                            .buttonStyle(.nimbusLink)
                        
                        Button {} label: {
                            Image(systemName: "xmark")
                        }
                        .buttonStyle(.close)
                    }
                }
                
                // Color Palette Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Maritime Colors")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                        ColorSwatchView(name: "Primary", color: theme.primaryColor(for: colorScheme))
                        ColorSwatchView(name: "Secondary", color: theme.secondaryColor(for: colorScheme))
                        ColorSwatchView(name: "Accent", color: theme.accentColor(for: colorScheme))
                        ColorSwatchView(name: "Error", color: theme.errorColor(for: colorScheme))
                        ColorSwatchView(name: "Success", color: theme.successColor(for: colorScheme))
                        ColorSwatchView(name: "Warning", color: theme.warningColor(for: colorScheme))
                    }
                }
            }
            .padding(24)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
}

/// Simple color swatch component for theme showcase
private struct ColorSwatchView: View {
    let name: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                )
            
            Text(name)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MaritimeThemeExampleView()
}
#endif