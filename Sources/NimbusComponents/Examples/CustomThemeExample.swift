//
//  CustomThemeExample.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 04.08.25.
//

import SwiftUI
import NimbusCore

/// Custom warm theme usage example demonstrating extensive component customization.
/// This theme showcases the full power of the optional component token system
/// by customizing multiple component tokens while maintaining consistency.
///
/// **CustomWarmTheme Features:**
/// - Warm, friendly color palette (creams, beiges, soft blues)
/// - 12pt corner radius for softer, approachable appearance  
/// - Custom button styling (14pt corner radius for extra friendliness)
/// - Custom scroller styling (10pt width, refined knob design)
/// - Warm and inviting design personality perfect for consumer applications
///
/// **What's Customized:**
/// - Brand colors with warm, friendly tones
/// - Button corner radii (14pt for softer appearance)
/// - Scroller width and styling (10pt width, custom knob design)
/// - Label content spacing for better visual balance
/// - All other component tokens use sensible defaults
///
/// **Usage Example:**
/// ```swift
/// ContentView()
///     .environment(\.nimbusTheme, CustomWarmTheme())
/// ```
public struct CustomWarmThemeUsageExample {
    
    /// Example of applying CustomWarmTheme to your application
    public static func applyToApp() {
        // Apply to your root view:
        // WindowGroup {
        //     ContentView()
        //         .environment(\.nimbusTheme, CustomWarmTheme())
        // }
    }
    
    /// Example of customizing specific components with CustomWarmTheme
    public static func customizeComponents() {
        // CustomWarmTheme automatically provides:
        // - Warm, friendly color palette
        // - 12pt corner radius (approachable appearance)
        // - Custom button corner radii (14pt for extra friendliness)
        // - Custom scroller styling (10pt width, refined design)
        // - All other components use beautiful defaults
        
        // You can further customize with environment overrides:
        // Button("Action") {}
        //     .buttonStyle(.primary)
        //     .environment(\.nimbusTheme, CustomWarmTheme())
        //     .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16)) // Even more rounded
    }
    
    /// Example showing advanced customization approach
    public static func advancedCustomization() {
        // CustomWarmTheme demonstrates extensive customization:
        // 
        // ✅ Required: 17 core properties (colors, spacing, materials)
        // ✅ Customized: buttonCornerRadii (14pt for friendliness)
        // ✅ Customized: scrollerWidth + scrollerKnobWidth (refined scrolling)
        // ✅ Customized: labelContentSpacing (better visual balance)
        // ✅ Defaults: All other component tokens (25+ properties)
        //
        // This approach demonstrates:
        // - How to create a distinctive brand experience
        // - Selective customization for maximum impact
        // - Maintaining consistency through defaults
        // - Future-proof design as new components are added
    }
    
    /// Example of theme personality expression
    public static func themePersonality() {
        // CustomWarmTheme expresses "warm and friendly" through:
        //
        // 🎨 Color Psychology:
        // - Warm beiges and creams (approachable, comfortable)
        // - Soft blue accent (trustworthy yet friendly)
        // - Neutral backgrounds (non-intimidating)
        //
        // 🔄 Shape Language:
        // - 12pt corner radius (approachable, not harsh)
        // - 14pt button corners (extra friendly touch)
        // - Consistent rounding creates harmony
        //
        // 🎯 Component Focus:
        // - Button customization (primary interaction points)
        // - Scroller refinement (polished details)
        // - Balanced spacing (comfortable, not cramped)
    }
}

#if DEBUG
/// Custom warm theme showcase using the unified ThemeShowcase
/// This provides consistent presentation across all themes
@available(macOS 15.0, *)
#Preview("CustomWarmTheme Showcase") {
    ThemeShowcase()
        .environment(\.nimbusTheme, CustomWarmTheme())
}

/// Simple usage example for testing and development
@available(macOS 15.0, *)
#Preview("CustomWarm Usage Example") {
    CustomWarmUsageExample()
}

/// Minimal usage example showing CustomWarmTheme in action
private struct CustomWarmUsageExample: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Custom Warm Theme Example")
                .font(.title)
                .padding()
            
            VStack(spacing: 8) {
                Button("Large Friendly") {}.buttonStyle(.primary).controlSize(.large)
                Button("Regular Friendly") {}.buttonStyle(.primary).controlSize(.regular)
                Button("Small Friendly") {}.buttonStyle(.primary).controlSize(.small)
            }
            
            Text("Warm, friendly design with 14pt button corners and refined 10pt scroller styling.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
        }
        .environment(\.nimbusTheme, CustomWarmTheme())
        .padding()
    }
}
#endif
