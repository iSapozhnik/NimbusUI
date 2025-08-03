//
//  SecondaryButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 03.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview("Secondary Button Style") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
            Text("ControlSize Variations")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button("Large Secondary") {}
                    .buttonStyle(.secondary)
                    .controlSize(.large)
                
                Button("Regular Secondary") {}
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                
                Button("Small Secondary") {}
                    .buttonStyle(.secondary)
                    .controlSize(.small)
                
                Button("Mini Secondary") {}
                    .buttonStyle(.secondary)
                    .controlSize(.mini)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Enhanced Button API")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button(action: {}) {
                    Label("Edit", systemImage: "pencil")
                }
                .buttonStyle(.secondary)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Options", systemImage: "ellipsis")
                }
                .buttonStyle(.secondary)
                .controlSize(.small)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Button Roles")
                .font(.headline)
            
            HStack(spacing: 12) {
                Button("Save") {}
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                
                Button("Cancel", role: .cancel) {}
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                
                Button("Remove", role: .destructive) {}
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("All Button Styles Comparison") {
    VStack(spacing: 20) {
        Text("Button Style Comparison")
            .font(.headline)
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Primary Styles")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button("Primary") {}
                    .buttonStyle(.primary)
                    .controlSize(.regular)
                
                Button("Primary Outline") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.regular)
            }
            
            Text("Secondary Styles")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button("Secondary") {}
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                
                Button("Secondary Outline") {}
                    .buttonStyle(.secondaryOutline)
                    .controlSize(.regular)
            }
            
            Text("Accent Style")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button("Accent") {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
                
                Button("Accent Destructive", role: .destructive) {}
                    .buttonStyle(.accent)
                    .controlSize(.regular)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}
