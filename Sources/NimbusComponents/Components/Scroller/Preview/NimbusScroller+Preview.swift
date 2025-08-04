//
//  NimbusScroller+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

// MARK: - Previews

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
                                .buttonStyle(.secondaryOutline)
                            Button("Mid") { verticalValue = 0.5 }
                                .buttonStyle(.secondaryOutline)
                            Button("Bottom") { verticalValue = 1.0 }
                                .buttonStyle(.secondaryOutline)
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
                                    .buttonStyle(.secondaryOutline)
                                Button("C") { horizontalValue = 0.5 }
                                    .buttonStyle(.secondaryOutline)
                                Button("R") { horizontalValue = 1.0 }
                                    .buttonStyle(.secondaryOutline)
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
                                .buttonStyle(.secondaryOutline)
                            Button("Mid") { customValue = 0.5 }
                                .buttonStyle(.secondaryOutline)
                            Button("Bottom") { customValue = 1.0 }
                                .buttonStyle(.secondaryOutline)
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
