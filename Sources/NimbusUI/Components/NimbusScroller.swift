//
//  NimbusScroller.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI
import Cocoa

/// A SwiftUI wrapper for the custom AppKit Scroller implementation with theming support
public struct NimbusScroller: NSViewRepresentable {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Core scroller environment overrides
    @Environment(\.nimbusScrollerWidth) private var overrideScrollerWidth
    @Environment(\.nimbusScrollerKnobWidth) private var overrideScrollerKnobWidth
    @Environment(\.nimbusScrollerKnobPadding) private var overrideScrollerKnobPadding
    @Environment(\.nimbusScrollerSlotCornerRadius) private var overrideSlotCornerRadius
    @Environment(\.nimbusScrollerShowScrollerSlot) private var overrideShowScrollerSlot
    
    // Legacy environment overrides (keeping for backward compatibility)
    @Environment(\.nimbusScrollerKnobCornerRadius) private var overrideKnobCornerRadius
    @Environment(\.nimbusScrollerKnobInsetVertical) private var overrideKnobInsetVertical
    @Environment(\.nimbusScrollerKnobInsetHorizontal) private var overrideKnobInsetHorizontal
    @Environment(\.nimbusScrollerSlotInset) private var overrideSlotInset
    @Environment(\.nimbusScrollerInitialOpacity) private var overrideInitialOpacity
    @Environment(\.nimbusScrollerFadeOpacity) private var overrideFadeOpacity
    @Environment(\.nimbusScrollerFadeDelay) private var overrideFadeDelay
    @Environment(\.nimbusScrollerAnimationDuration) private var overrideAnimationDuration
    
    private let type: ScrollerType
    @Binding private var value: Float
    @Binding private var knobProportion: Float
    
    /// Creates a NimbusScroller with the specified type and bindings
    /// - Parameters:
    ///   - type: The orientation of the scroller (horizontal or vertical)
    ///   - value: Binding to the current scroll position (0.0 to 1.0)
    ///   - knobProportion: Binding to the knob size relative to the track (0.0 to 1.0)
    public init(
        type: ScrollerType,
        value: Binding<Float>,
        knobProportion: Binding<Float>
    ) {
        self.type = type
        self._value = value
        self._knobProportion = knobProportion
    }
    
    /// Creates a vertical NimbusScroller with the specified bindings
    /// - Parameters:
    ///   - value: Binding to the current scroll position (0.0 to 1.0)
    ///   - knobProportion: Binding to the knob size relative to the track (0.0 to 1.0)
    public init(
        value: Binding<Float>,
        knobProportion: Binding<Float>
    ) {
        self.init(type: .vertical, value: value, knobProportion: knobProportion)
    }
    
    public func makeNSView(context: Context) -> Scroller {
        let scroller = Scroller(withType: type)
        
        // Configure theme and color scheme
        scroller.theme = theme
        scroller.colorScheme = colorScheme
        
        // Apply core scroller configuration with environment overrides
        scroller.scrollerWidth = overrideScrollerWidth ?? theme.scrollerWidth
        scroller.scrollerKnobWidth = overrideScrollerKnobWidth ?? theme.scrollerKnobWidth
        scroller.scrollerKnobPadding = overrideScrollerKnobPadding ?? theme.scrollerKnobPadding
        scroller.scrollerSlotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        
        // Apply legacy configuration for backward compatibility
        scroller.knobCornerRadius = overrideKnobCornerRadius ?? theme.scrollerKnobCornerRadius
        scroller.knobInsetVertical = overrideKnobInsetVertical ?? theme.scrollerKnobInsetVertical
        scroller.knobInsetHorizontal = overrideKnobInsetHorizontal ?? theme.scrollerKnobInsetHorizontal
        scroller.slotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        scroller.slotInset = overrideSlotInset ?? theme.scrollerSlotInset
        
        // Set initial values
        scroller.floatValue = value
        scroller.knobProportion = CGFloat(knobProportion)
        
        // Set initial opacity
        let initialOpacity = overrideInitialOpacity ?? theme.scrollerInitialOpacity
        scroller.layer?.opacity = Float(initialOpacity)
        
        // Set up target-action for value changes
        scroller.target = context.coordinator
        scroller.action = #selector(Coordinator.scrollerValueChanged(_:))
        
        // Configure autoresizing based on orientation
        if type == .horizontal {
            scroller.autoresizingMask = [.width]
        } else {
            scroller.autoresizingMask = [.height]
        }
        
        return scroller
    }
    
    public func updateNSView(_ nsView: Scroller, context: Context) {
        // Update theme and color scheme
        nsView.theme = theme
        nsView.colorScheme = colorScheme
        
        // Update core scroller configuration if values changed
        nsView.scrollerWidth = overrideScrollerWidth ?? theme.scrollerWidth
        nsView.scrollerKnobWidth = overrideScrollerKnobWidth ?? theme.scrollerKnobWidth
        nsView.scrollerKnobPadding = overrideScrollerKnobPadding ?? theme.scrollerKnobPadding
        nsView.scrollerSlotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        nsView.showScrollerSlot = overrideShowScrollerSlot ?? theme.scrollerShowSlot
        
        // Update legacy configuration
        nsView.knobCornerRadius = overrideKnobCornerRadius ?? theme.scrollerKnobCornerRadius
        nsView.knobInsetVertical = overrideKnobInsetVertical ?? theme.scrollerKnobInsetVertical
        nsView.knobInsetHorizontal = overrideKnobInsetHorizontal ?? theme.scrollerKnobInsetHorizontal
        nsView.slotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        nsView.slotInset = overrideSlotInset ?? theme.scrollerSlotInset
        
        // Update values if they changed externally
        if nsView.floatValue != value {
            nsView.floatValue = value
        }
        
        if nsView.knobProportion != CGFloat(knobProportion) {
            nsView.knobProportion = CGFloat(knobProportion)
        }
        
        // Update coordinator bindings
        context.coordinator.valueBinding = _value
        context.coordinator.knobProportionBinding = _knobProportion
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(valueBinding: _value, knobProportionBinding: _knobProportion)
    }
    
    public class Coordinator: NSObject {
        var valueBinding: Binding<Float>
        var knobProportionBinding: Binding<Float>
        
        init(valueBinding: Binding<Float>, knobProportionBinding: Binding<Float>) {
            self.valueBinding = valueBinding
            self.knobProportionBinding = knobProportionBinding
        }
        
        @objc func scrollerValueChanged(_ sender: Scroller) {
            valueBinding.wrappedValue = sender.floatValue
        }
    }
}

// MARK: - Convenience Modifiers

public extension NimbusScroller {
    /// Sets the scroller track width
    func scrollerWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusScrollerWidth, width)
    }
    
    /// Sets the knob width (thickness)
    func knobWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobWidth, width)
    }
    
    /// Sets the knob padding within the slot
    func knobPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobPadding, padding)
    }
    
    /// Sets the slot corner radius
    func slotCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusScrollerSlotCornerRadius, radius)
    }
    
    // Legacy modifiers (keeping for backward compatibility)
    
    /// Sets the knob corner radius for the scroller (legacy)
    func knobCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobCornerRadius, radius)
    }
    
    /// Sets the knob insets for the scroller (legacy)
    func knobInsets(vertical: CGFloat, horizontal: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobInsetVertical, vertical)
            .environment(\.nimbusScrollerKnobInsetHorizontal, horizontal)
    }
    
    /// Sets the slot inset for the scroller (legacy)
    func slotInset(_ inset: CGFloat) -> some View {
        environment(\.nimbusScrollerSlotInset, inset)
    }
    
    /// Sets the initial opacity for the scroller (legacy)
    func initialOpacity(_ opacity: CGFloat) -> some View {
        environment(\.nimbusScrollerInitialOpacity, opacity)
    }
    
    /// Sets the fade properties for the scroller (legacy)
    func fadeProperties(opacity: CGFloat, delay: TimeInterval, duration: TimeInterval) -> some View {
        environment(\.nimbusScrollerFadeOpacity, opacity)
            .environment(\.nimbusScrollerFadeDelay, delay)
            .environment(\.nimbusScrollerAnimationDuration, duration)
    }

    /// Sets the scroller slot visibility
    func showScrollerSlot(_ show: Bool) -> some View {
        environment(\.nimbusScrollerShowScrollerSlot, show)
    }
}

// MARK: - Preview

private struct NimbusScrollerPreview: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var verticalValue: Float = 0.3
    @State private var verticalKnobProportion: Float = 0.2
    
    @State private var horizontalValue: Float = 0.5
    @State private var horizontalKnobProportion: Float = 0.3
    
    @State private var customValue: Float = 0.7
    @State private var customKnobProportion: Float = 0.15
    
    var body: some View {
        VStack(spacing: 24) {
            Text("NimbusScroller Showcase")
                .font(.headline)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            // Vertical Scroller with Default Theme
            VStack(alignment: .leading, spacing: 8) {
                Text("Vertical Scroller (Default Theme)")
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack {
                    NimbusScroller(
                        type: .vertical,
                        value: $verticalValue,
                        knobProportion: $verticalKnobProportion
                    )
                    .frame(width: 50, height: 200)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Value: \(String(format: "%.2f", verticalValue))")
                            .font(.caption)
                        Text("Knob: \(String(format: "%.2f", verticalKnobProportion))")
                            .font(.caption)
                        
                        Slider(value: $verticalKnobProportion, in: 0.1...1.0) {
                            Text("Knob Size")
                        }
                        .frame(width: 150)
                        
                        HStack(spacing: 8) {
                            Button("Top") { verticalValue = 0.0 }
                                .buttonStyle(.secondaryBordered)
                            Button("Mid") { verticalValue = 0.5 }
                                .buttonStyle(.secondaryBordered)
                            Button("Bottom") { verticalValue = 1.0 }
                                .buttonStyle(.secondaryBordered)
                        }
                        .font(.caption2)
                    }
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    
                    Spacer()
                }
            }
            
            // Horizontal Scroller with Default Theme
            VStack(alignment: .leading, spacing: 8) {
                Text("Horizontal Scroller (Default Theme)")
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                VStack {
                    NimbusScroller(
                        type: .horizontal,
                        value: $horizontalValue,
                        knobProportion: $horizontalKnobProportion
                    )
                    .frame(width: 300, height: 50)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Value: \(String(format: "%.2f", horizontalValue))")
                                .font(.caption)
                            Text("Knob: \(String(format: "%.2f", horizontalKnobProportion))")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Knob Size")
                                .font(.caption)
                            Slider(value: $horizontalKnobProportion, in: 0.1...1.0)
                                .frame(width: 120)
                            
                            HStack(spacing: 6) {
                                Button("L") { horizontalValue = 0.0 }
                                    .buttonStyle(.secondaryBordered)
                                Button("C") { horizontalValue = 0.5 }
                                    .buttonStyle(.secondaryBordered)
                                Button("R") { horizontalValue = 1.0 }
                                    .buttonStyle(.secondaryBordered)
                            }
                            .font(.caption2)
                        }
                    }
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                }
            }
            
            // Custom Styled Scroller
            VStack(alignment: .leading, spacing: 8) {
                Text("Custom Styled Vertical Scroller")
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack {
                    NimbusScroller(
                        type: .vertical,
                        value: $customValue,
                        knobProportion: $customKnobProportion
                    )
                    .scrollerWidth(24)
                    .environment(\.nimbusScrollerKnobWidth, 10)
                    .environment(\.nimbusScrollerKnobPadding, 3)
                    .environment(\.nimbusScrollerSlotCornerRadius, 8)
                    .frame(width: 50, height: 200)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Custom styling applied:")
                            .font(.caption)
                            .fontWeight(.medium)
                        Text("• Scroller width: 24")
                            .font(.caption2)
                        Text("• Knob width: 10")
                            .font(.caption2)
                        Text("• Knob padding: 3")
                            .font(.caption2)
                        Text("• Slot corner radius: 8")
                            .font(.caption2)
                        Text("• Knob corner radius: 3.5 (auto-calculated)")
                            .font(.caption2)
                        
                        Spacer().frame(height: 8)
                        
                        Text("Value: \(String(format: "%.2f", customValue))")
                            .font(.caption)
                        Text("Knob: \(String(format: "%.2f", customKnobProportion))")
                            .font(.caption)
                        
                        Slider(value: $customKnobProportion, in: 0.05...0.8) {
                            Text("Knob Size")
                        }
                        .frame(width: 150)
                        
                        HStack(spacing: 8) {
                            Button("Top") { customValue = 0.0 }
                                .buttonStyle(.secondaryBordered)
                            Button("Mid") { customValue = 0.5 }
                                .buttonStyle(.secondaryBordered)
                            Button("Bottom") { customValue = 1.0 }
                                .buttonStyle(.secondaryBordered)
                        }
                        .font(.caption2)
                    }
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(24)
        .background(theme.backgroundColor(for: colorScheme))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview("Default Theme") {
    NimbusScrollerPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Maritime Theme") {
    NimbusScrollerPreview()
        .environment(\.nimbusTheme, MaritimeTheme())
}

#Preview("Custom Theme") {
    NimbusScrollerPreview()
        .environment(\.nimbusTheme, CustomWarmTheme())
}

#Preview("Dark Mode") {
    NimbusScrollerPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
        .preferredColorScheme(.dark)
}
