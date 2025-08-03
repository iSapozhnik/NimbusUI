//
//  SecondaryOutlineButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview("Secondary Outline Button Style") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
            Text("ControlSize Variations")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button("Large Secondary Outline") {}
                    .buttonStyle(SecondaryOutlineButtonStyle())
                    .controlSize(.large)
                
                Button("Regular Secondary Outline") {}
                    .buttonStyle(SecondaryOutlineButtonStyle())
                    .controlSize(.regular)
                
                Button("Small Secondary Outline") {}
                    .buttonStyle(SecondaryOutlineButtonStyle())
                    .controlSize(.small)
                
                Button("Mini Secondary Outline") {}
                    .buttonStyle(SecondaryOutlineButtonStyle())
                    .controlSize(.mini)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Enhanced Button API")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button(action: {}) {
                    Label("Settings", systemImage: "gear")
                }
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Export", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.small)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Navigation Buttons")
                .font(.headline)
            
            HStack(spacing: 12) {
                Button(action: {}) {
                    Label("Previous", systemImage: "arrow.left")
                }
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                .environment(\.nimbusButtonIconAlignment, .leading)
                
                Button(action: {}) {
                    Label("Next", systemImage: "arrow.right")
                }
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Enhanced API Demo") {
    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme
    @Previewable @Environment(\.colorScheme) var colorScheme
    
    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
    VStack(alignment: .leading, spacing: 16) {
        Text("Plain Text Buttons (no changes needed)")
            .font(.subheadline)
            .foregroundColor(.secondary)
        HStack {
            Button("Normal") {}
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
            Button("Save") {}
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(SecondaryOutlineButtonStyle())
                .controlSize(.regular)
        }
        
        Text("Label Buttons - Enhanced API")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top)
        
        HStack {
            Button(action: {}) {
                Label("Delete", systemImage: "trash")
            }
            .buttonStyle(SecondaryOutlineButtonStyle())
            .controlSize(.regular)
            .environment(\.nimbusButtonHasDivider, true)
            
            Button(action: {}) {
                Label("Export", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(SecondaryOutlineButtonStyle())
            .controlSize(.regular)
            .environment(\.nimbusButtonContentPadding, contentPadding)
        }
        
        HStack {
            Button(action: {}) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(SecondaryOutlineButtonStyle())
            .controlSize(.small)
            .environment(\.nimbusButtonIconAlignment, .trailing)
            
            Button(action: {}) {
                Label("Custom Padding", systemImage: "textformat")
            }
            .buttonStyle(SecondaryOutlineButtonStyle())
            .controlSize(.small)
            .environment(\.nimbusButtonContentPadding, 16)
        }
    }
    .padding()
    .background(theme.backgroundColor(for: colorScheme))
    .environment(\.nimbusTheme, NimbusTheme.default)
}