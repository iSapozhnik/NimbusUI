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
