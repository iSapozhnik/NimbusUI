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
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.large)
                
                Button("Regular Secondary") {}
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Small Secondary") {}
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.small)
                
                Button("Mini Secondary") {}
                    .buttonStyle(SecondaryButtonStyle())
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
                .buttonStyle(SecondaryButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Options", systemImage: "ellipsis")
                }
                .buttonStyle(SecondaryButtonStyle())
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
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Cancel", role: .cancel) {}
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Remove", role: .destructive) {}
                    .buttonStyle(SecondaryButtonStyle())
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
                    .buttonStyle(PrimaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Primary Outline") {}
                    .buttonStyle(PrimaryOutlineButtonStyle())
                    .controlSize(.regular)
            }
            
            Text("Secondary Styles")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button("Secondary") {}
                    .buttonStyle(SecondaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Secondary Outline") {}
                    .buttonStyle(SecondaryOutlineButtonStyle())
                    .controlSize(.regular)
            }
            
            Text("Accent Style")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                Button("Accent") {}
                    .buttonStyle(AccentButtonStyle())
                    .controlSize(.regular)
                
                Button("Accent Destructive", role: .destructive) {}
                    .buttonStyle(AccentButtonStyle())
                    .controlSize(.regular)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}