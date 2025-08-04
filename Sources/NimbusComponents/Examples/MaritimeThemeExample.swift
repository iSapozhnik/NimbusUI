//
//  MaritimeThemeExample.swift
//  NimbusUI
//
//  Created by Claude on 04.08.25.
//

import SwiftUI
import NimbusCore

/// Maritime theme usage example demonstrating professional nautical design.
/// This theme showcases selective component token overrides while maintaining
/// the power of the optional token system.
///
/// **Maritime Theme Features:**
/// - Professional nautical color palette (blues, whites, structured reds)
/// - 8pt corner radius for structured, business-like appearance
/// - Custom scroller styling for refined interface elements
/// - High contrast colors for excellent readability
/// - Trustworthy and reliable design personality
///
/// **What's Customized:**
/// - Brand colors with nautical inspiration
/// - Scroller width and styling (12pt width for refined appearance)
/// - All other component tokens use sensible defaults
///
/// **Usage Example:**
/// ```swift
/// ContentView()
///     .environment(\.nimbusTheme, MaritimeTheme())
/// ```
public struct MaritimeThemeUsageExample {
    
    /// Example of applying MaritimeTheme to your application
    public static func applyToApp() {
        // Apply to your root view:
        // WindowGroup {
        //     ContentView()
        //         .environment(\.nimbusTheme, MaritimeTheme())
        // }
    }
    
    /// Example of customizing specific components with MaritimeTheme
    public static func customizeComponents() {
        // MaritimeTheme automatically provides:
        // - Professional blue color palette
        // - 8pt corner radius (structured appearance)
        // - Custom scroller styling (12pt width)
        // - All other components use beautiful defaults
        
        // You can further customize with environment overrides:
        // Button("Action") {}
        //     .buttonStyle(.primary)
        //     .environment(\.nimbusTheme, MaritimeTheme())
        //     .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(6)) // Even more structured
    }
    
    /// Example showing theme customization philosophy
    public static func customizationPhilosophy() {
        // MaritimeTheme demonstrates selective customization:
        // 
        // ✅ Required: 17 core properties (colors, spacing, materials)
        // ✅ Customized: scrollerWidth (12pt for refined appearance)  
        // ✅ Defaults: All other component tokens (30+ properties)
        //
        // This selective approach means:
        // - Focus on your brand colors and key visual differences
        // - Beautiful defaults handle the rest
        // - Easy to maintain and extend
        // - Future-proof as new components are added
    }
}

#if DEBUG
/// Maritime theme showcase using the unified ThemeShowcase
/// This provides consistent presentation across all themes
@available(macOS 15.0, *)
#Preview("Maritime Theme Showcase") {
    ThemeShowcase()
        .environment(\.nimbusTheme, MaritimeTheme())
}

/// Simple usage example for testing and development
@available(macOS 15.0, *)
#Preview("Maritime Usage Example") {
    MaritimeUsageExample()
}

/// Minimal usage example showing MaritimeTheme in action
private struct MaritimeUsageExample: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Maritime Theme Example")
                .font(.title)
                .padding()
            
            HStack(spacing: 12) {
                Button("Primary") {}.buttonStyle(.primary)
                Button("Secondary") {}.buttonStyle(.secondary) 
                Button("Accent") {}.buttonStyle(.accent)
            }
            
            Text("Professional nautical design with structured 8pt corners and refined scroller styling.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
        }
        .environment(\.nimbusTheme, MaritimeTheme())
        .padding()
    }
}
#endif