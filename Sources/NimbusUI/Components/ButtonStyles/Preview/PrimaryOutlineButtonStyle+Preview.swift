//
//  PrimaryOutlineButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations
#Preview("Primary Outline Button Style") {
    VStack(spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
            Text("ControlSize Variations")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button("Large Primary Outline") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.large)
                
                Button("Regular Primary Outline") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.regular)
                
                Button("Small Primary Outline") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.small)
                
                Button("Mini Primary Outline") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.mini)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Enhanced Button API")
                .font(.headline)
            
            VStack(spacing: 8) {
                Button(action: {}) {
                    Label("Open File", systemImage: "folder")
                }
                .buttonStyle(.primaryOutline)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(.primaryOutline)
                .controlSize(.small)
                .environment(\.nimbusButtonHasDivider, false)
                .environment(\.nimbusButtonIconAlignment, .trailing)
            }
        }
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Button Roles")
                .font(.headline)
            
            HStack(spacing: 12) {
                Button("Confirm") {}
                    .buttonStyle(.primaryOutline)
                    .controlSize(.regular)
                
                Button("Delete", role: .destructive) {}
                    .buttonStyle(.primaryOutline)
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
        Button("Large Maritime Outline") {}
            .buttonStyle(.primaryOutline)
            .controlSize(.large)
        
        Button("Regular Maritime Outline") {}
            .buttonStyle(.primaryOutline)
            .controlSize(.regular)
        
        Button(action: {}) {
            Label("Action", systemImage: "play.fill")
        }
        .buttonStyle(.primaryOutline)
        .controlSize(.small)
        .environment(\.nimbusButtonHasDivider, true)
        
        HStack {
            Button("Normal") {}
                .buttonStyle(.primaryOutline)
                .controlSize(.mini)
            
            Button("Destructive", role: .destructive) {}
                .buttonStyle(.primaryOutline)
                .controlSize(.mini)
        }
    }
    .padding()
    .environment(\.nimbusTheme, MaritimeTheme())
}
