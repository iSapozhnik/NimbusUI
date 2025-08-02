//
//  SecondaryProminentButtonStyle+Preview.swift
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
    
    VStack(alignment: .leading) {
        HStack {
            Button("Ok") {}
                .buttonStyle(.secondaryProminent)
            Button("Cancel", role: .destructive) {}
                .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button("Delete", systemImage: "trash", role: .destructive) {}
                .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(NimbusDividerLabelStyle(contentHorizontalPadding: contentPadding))
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(NimbusDividerLabelStyle(contentHorizontalPadding: contentPadding))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false))
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Sign In", systemImage: "arrow.up")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
        
        HStack {
            Button(role: .destructive, action: {}) {
                Label("Delete", systemImage: "trash")
                    .labelStyle(
                        NimbusDividerLabelStyle(
                            hasDivider: true,
                            iconAlignment: .trailing,
                            contentHorizontalPadding: contentPadding
                        )
                    )
            }
            .buttonStyle(.secondaryProminent)
            Button(role: .none, action: {}) {
                Label("Next", systemImage: "arrow.right")
                    .labelStyle(NimbusDividerLabelStyle(hasDivider: false, iconAlignment: .trailing))

            }
            .buttonStyle(.secondaryProminent)
        }
        .frame(height: 40)
    }
    .environment(\.nimbusTheme, NimbusTheme())
    .padding()
}