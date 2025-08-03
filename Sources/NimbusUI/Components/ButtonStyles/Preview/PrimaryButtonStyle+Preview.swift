//
//  PrimaryButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations  
#Preview("Primary Button Style") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
            Text("ControlSize Variations")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button("Large Primary") {}
                    .buttonStyle(.primary)
                    .controlSize(.large)
                
                Button("Regular Primary") {}
                    .buttonStyle(.primary)
                    .controlSize(.regular)
                
                Button("Small Primary") {}
                    .buttonStyle(.primary)
                    .controlSize(.small)
                
                Button("Mini Primary") {}
                    .buttonStyle(.primary)
                    .controlSize(.mini)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("With Labels & Dividers")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button(action: {}) {
                    Label("Save Document", systemImage: "doc.badge.plus")
                }
                .buttonStyle(.primary)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Export PDF", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.primary)
                .controlSize(.small)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Button Roles")
                .font(.headline)
            
            HStack(spacing: 12) {
                Button("Cancel", role: .cancel) {}
                    .buttonStyle(.primary)
                    .controlSize(.regular)
                
                Button("Delete", role: .destructive) {}
                    .buttonStyle(.primary)
                    .controlSize(.regular)
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

@available(macOS 15.0, *)
#Preview("Maritime Theme") {
    VStack(spacing: 16) {
        Button("Large Maritime") {}
            .buttonStyle(.primary)
            .controlSize(.large)
        
        Button("Regular Maritime") {}
            .buttonStyle(.primary)
            .controlSize(.regular)
        
        Button(action: {}) {
            Label("Action", systemImage: "play.fill")
        }
        .buttonStyle(.primary)
        .controlSize(.small)
        .environment(\.nimbusButtonHasDivider, true)
    }
    .padding()
    .environment(\.nimbusTheme, MaritimeTheme())
}
