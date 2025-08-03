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
                    .buttonStyle(PrimaryButtonStyle())
                    .controlSize(.large)
                
                Button("Regular Primary") {}
                    .buttonStyle(PrimaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Small Primary") {}
                    .buttonStyle(PrimaryButtonStyle())
                    .controlSize(.small)
                
                Button("Mini Primary") {}
                    .buttonStyle(PrimaryButtonStyle())
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
                .buttonStyle(PrimaryButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Export PDF", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(PrimaryButtonStyle())
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
                    .buttonStyle(PrimaryButtonStyle())
                    .controlSize(.regular)
                
                Button("Delete", role: .destructive) {}
                    .buttonStyle(PrimaryButtonStyle())
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
            .buttonStyle(PrimaryButtonStyle())
            .controlSize(.large)
        
        Button("Regular Maritime") {}
            .buttonStyle(PrimaryButtonStyle())
            .controlSize(.regular)
        
        Button(action: {}) {
            Label("Action", systemImage: "play.fill")
        }
        .buttonStyle(PrimaryButtonStyle())
        .controlSize(.small)
        .environment(\.nimbusButtonHasDivider, true)
    }
    .padding()
    .environment(\.nimbusTheme, MaritimeTheme())
}