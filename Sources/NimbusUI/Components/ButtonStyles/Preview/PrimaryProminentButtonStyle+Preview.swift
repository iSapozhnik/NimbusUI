//
//  PrimaryProminentButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview {

    @Previewable @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Previewable @Environment(\.nimbusTheme) var theme

    let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
    
    VStack {
        Text("Enhanced Button API - Flexible Usage")
            .font(.headline)
            .padding(.bottom)
        
        Text("Plain Text Buttons (no changes needed)")
            .font(.subheadline)
            .foregroundColor(.secondary)
        HStack {
            Button("Ok") {}
                .buttonStyle(.primaryProminent)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
        
        Text("Label Buttons - Enhanced API")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.top)
        
        HStack {
            Button("Delete", systemImage: "trash", role: .destructive) {}
                .buttonStyle(.primaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.primaryProminent)
        }
        .frame(height: 40)
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonHasDivider, true) // Enhanced API - auto-applies divider
            
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonContentPadding, contentPadding) // Enhanced API - auto-applies with custom padding
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
            
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
            .environment(\.nimbusButtonContentPadding, contentPadding)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonHasDivider, true) // Enhanced API - with divider
            .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon
            
            Button(role: .none, action: {}) {
                Label("Next", systemImage: "arrow.right")
            }
            .buttonStyle(.primaryProminent)
            .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
            .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon
        }
        .frame(height: 40)
    }
    .fixedSize()
    .padding()
}