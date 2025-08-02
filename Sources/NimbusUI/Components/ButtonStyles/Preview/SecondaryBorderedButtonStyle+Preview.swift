//
//  SecondaryBorderedButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

struct SecondaryBorderedButtonStylePreview: View {
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) var overrideContentPadding
    @Environment(\.nimbusTheme) var theme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Plain Text Buttons (no changes needed)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Button("Normal") {}
                    .buttonStyle(.secondaryBordered)
                Button("Save") {}
                    .buttonStyle(.secondaryBordered)
                Button("Cancel", role: .destructive) {}
                    .buttonStyle(.secondaryBordered)
            }
            
            Text("Label Buttons - Enhanced API")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            HStack {
                Button(action: {}) {
                    Label("Delete", systemImage: "trash")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonHasDivider, true) // Enhanced API - auto-applies divider
                
                Button(action: {}) {
                    Label("Export", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonContentPadding, contentPadding) // Enhanced API - auto-applies with custom padding
            }
            
            HStack {
                Button(action: {}) {
                    Label("Download", systemImage: "arrow.down.circle")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
                
                Button(action: {}) {
                    Label("Settings", systemImage: "gear")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonHasDivider, false) // Enhanced API - no divider
                .environment(\.nimbusButtonContentPadding, contentPadding)
            }
            
            HStack {
                Button(action: {}) {
                    Label("Previous", systemImage: "arrow.left")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonHasDivider, true) // Enhanced API - with divider
                .environment(\.nimbusButtonIconAlignment, .leading) // Enhanced API - leading icon (default)
                
                Button(action: {}) {
                    Label("Next", systemImage: "arrow.right")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonHasDivider, true) // Enhanced API - with divider
                .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon
            }
            
            HStack {
                Button(action: {}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonIconAlignment, .trailing) // Enhanced API - trailing icon, no divider
                
                Button(action: {}) {
                    Label("Custom Padding", systemImage: "textformat")
                }
                .buttonStyle(.secondaryBordered)
                .environment(\.nimbusButtonContentPadding, 16) // Enhanced API - custom padding
            }
        }
        .padding()
        .background(theme.backgroundColor(for: colorScheme))
    }
}

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview {
    SecondaryBorderedButtonStylePreview()
}