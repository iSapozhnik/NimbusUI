//
//  AccentButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview("Accent Button Style") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
            Text("ControlSize Variations")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button("Large Accent") {}
                    .buttonStyle(.accent)
                    .controlSize(.large)
                
                Button("Regular Accent") {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
                
                Button("Small Accent") {}
                    .buttonStyle(.accent)
                    .controlSize(.small)
                
                Button("Mini Accent") {}
                    .buttonStyle(.accent)
                    .controlSize(.mini)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Enhanced Button API")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button(action: {}) {
                    Label("Download", systemImage: "arrow.down.circle")
                }
                .buttonStyle(.accent)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Upload", systemImage: "arrow.up.circle")
                }
                .buttonStyle(.accent)
                .controlSize(.small)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Button Roles")
                .font(.headline)
            
            HStack(spacing: 12) {
                Button("Confirm", role: .none) {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
                
                Button("Delete", role: .destructive) {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Enhanced Button API Demo") {
    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme

    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
    VStack(spacing: 16) {
        Text("Enhanced Button API - Flexible Usage")
            .font(.headline)
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Plain Text Buttons (no changes needed)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Button("Ok") {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
                Button("Cancel", role: .destructive) {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
            }
        }
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Label Buttons - Enhanced API")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Button(role: .destructive, action: {}) {
                    Label("Delete", systemImage: "trash")
                }
                .buttonStyle(.accent)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(role: .none, action: {}) {
                    Label("Next", systemImage: "arrow.right")
                }
                .buttonStyle(.accent)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}
