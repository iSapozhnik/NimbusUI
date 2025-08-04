//
//  File.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

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

