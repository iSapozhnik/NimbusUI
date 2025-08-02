//
//  NimbusCheckbox.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

/// A checkbox component that mimics SwiftUI's Toggle API but renders as a checkbox.
/// Supports theming, disabled states, and smooth animations with a custom-drawn checkmark.
public struct NimbusCheckbox: View {
    @Binding private var isOn: Bool
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusCheckboxSize) private var overrideSize
    @Environment(\.nimbusCheckboxCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusCheckboxBorderWidth) private var overrideBorderWidth
    
    @State private var isHovering: Bool = false
    
    /// Creates a checkbox with the specified binding.
    /// - Parameter isOn: A binding to the checked state of the checkbox
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        let size = overrideSize ?? theme.checkboxSize
        let cornerRadii = overrideCornerRadii ?? theme.checkboxCornerRadii
        let borderWidth = overrideBorderWidth ?? theme.checkboxBorderWidth
        
        Button(action: {
            if isEnabled {
                isOn.toggle()
            }
        }) {
            ZStack {
                // Background and border
                RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                    .fill(isOn ? theme.primaryColor(for: colorScheme) : .clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                            .stroke(
                                isOn ? theme.primaryColor(for: colorScheme) : theme.borderColor(for: colorScheme),
                                lineWidth: borderWidth
                            )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                            .fill(isHovering && !isOn ? theme.secondaryBackgroundColor(for: colorScheme) : .clear)
                    )
                
                // Checkmark
                CheckmarkView(isAnimating: isOn)
                    .foregroundStyle(.white)
                    .opacity(isOn ? 1.0 : 0.0)
            }
        }
        .buttonStyle(.plain)
        .frame(width: size, height: size)
        .opacity(isEnabled ? 1.0 : 0.5)
        .onHover { hovering in
            if isEnabled {
                withAnimation(theme.animationFast) {
                    isHovering = hovering
                }
            }
        }
    }
}

/// Native SF Symbol checkmark view with bouncy animation
private struct CheckmarkView: View {
    let isAnimating: Bool
    @State private var scale: CGFloat = 0.0
    
    var body: some View {
        Image(systemName: "checkmark")
            .resizable()
            .frame(width: 10, height: 10)
            .scaleEffect(scale)
            .onChange(of: isAnimating) { _, newValue in
                if newValue {
                    // Bouncy animation: 0 -> 1.2 -> 1.0
                    withAnimation(.spring(.bouncy(duration: 0.25, extraBounce: 0.3))) {
                        scale = 1.0
                    }
                } else {
                    // Quick scale down
                    withAnimation(.easeInOut(duration: 0.1)) {
                        scale = 0.0
                    }
                }
            }
            .onAppear {
                scale = isAnimating ? 1.0 : 0.0
            }
    }
}

// MARK: - Previews

#Preview("Basic Checkbox States") {
    @Previewable @State var isChecked = false
    
    VStack(spacing: 20) {
        HStack {
            NimbusCheckbox(isOn: $isChecked)
            Text("Interactive Checkbox")
        }
        
        HStack {
            NimbusCheckbox(isOn: .constant(false))
            Text("Unchecked")
        }
        
        HStack {
            NimbusCheckbox(isOn: .constant(true))
            Text("Checked")
        }
        
        HStack {
            NimbusCheckbox(isOn: .constant(false))
                .disabled(true)
            Text("Disabled Unchecked")
        }
        
        HStack {
            NimbusCheckbox(isOn: .constant(true))
                .disabled(true)
            Text("Disabled Checked")
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Theme Variations") {
    @Previewable @State var isChecked = true
    
    VStack(spacing: 25) {
        VStack(spacing: 15) {
            Text("Default Theme")
                .font(.headline)
            HStack(spacing: 20) {
                NimbusCheckbox(isOn: .constant(false))
                NimbusCheckbox(isOn: .constant(true))
            }
        }
        .environment(\.nimbusTheme, NimbusTheme.default)
        
        VStack(spacing: 15) {
            Text("Maritime Theme")
                .font(.headline)
            HStack(spacing: 20) {
                NimbusCheckbox(isOn: .constant(false))
                NimbusCheckbox(isOn: .constant(true))
            }
        }
        .environment(\.nimbusTheme, MaritimeTheme())
        
        VStack(spacing: 15) {
            Text("Custom Warm Theme")
                .font(.headline)
            HStack(spacing: 20) {
                NimbusCheckbox(isOn: .constant(false))
                NimbusCheckbox(isOn: .constant(true))
            }
        }
        .environment(\.nimbusTheme, CustomWarmTheme())
    }
    .padding()
}

#Preview("Environment Overrides") {
    @Previewable @State var isChecked = true
    
    VStack(spacing: 20) {
        HStack {
            NimbusCheckbox(isOn: $isChecked)
            Text("Default (24x24)")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxSize, 32)
            Text("Large Size (32x32)")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxSize, 16)
            Text("Small Size (16x16)")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxCornerRadii, RectangleCornerRadii(8))
            Text("Rounded Corners")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxCornerRadii, RectangleCornerRadii(0))
            Text("Square Corners")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxBorderWidth, 3)
            Text("Thick Border")
        }
        
        HStack {
            NimbusCheckbox(isOn: $isChecked)
                .environment(\.nimbusCheckboxSize, 28)
                .environment(\.nimbusCheckboxCornerRadii, RectangleCornerRadii(6))
                .environment(\.nimbusCheckboxBorderWidth, 2)
            Text("Custom Combined")
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Animation Showcase") {
    @Previewable @State var isChecked = false
    
    VStack(spacing: 30) {
        Text("Tap to see bouncy animation")
            .font(.headline)
        
        VStack(spacing: 20) {
            NimbusCheckbox(isOn: $isChecked)
            
            Button("Toggle Checkbox") {
                isChecked.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}
