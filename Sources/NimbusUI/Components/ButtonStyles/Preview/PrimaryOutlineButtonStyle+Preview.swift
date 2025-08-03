//
//  PrimaryOutlineButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude on 03.08.25.
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
                    .buttonStyle(PrimaryOutlineButtonStyle())
                    .controlSize(.large)
                
                Button("Regular Primary Outline") {}
                    .buttonStyle(PrimaryOutlineButtonStyle())
                    .controlSize(.regular)
                
                Button("Small Primary Outline") {}
                    .buttonStyle(PrimaryOutlineButtonStyle())
                    .controlSize(.small)
                
                Button("Mini Primary Outline") {}
                    .buttonStyle(PrimaryOutlineButtonStyle())
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
                .buttonStyle(PrimaryOutlineButtonStyle())
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
                
                Button(action: {}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(PrimaryOutlineButtonStyle())
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
                    .buttonStyle(PrimaryOutlineButtonStyle())
                    .controlSize(.regular)
                
                Button("Delete", role: .destructive) {}
                    .buttonStyle(PrimaryOutlineButtonStyle())
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
            .buttonStyle(PrimaryOutlineButtonStyle())
            .controlSize(.large)
        
        Button("Regular Maritime Outline") {}
            .buttonStyle(PrimaryOutlineButtonStyle())
            .controlSize(.regular)
        
        Button(action: {}) {
            Label("Action", systemImage: "play.fill")
        }
        .buttonStyle(PrimaryOutlineButtonStyle())
        .controlSize(.small)
        .environment(\.nimbusButtonHasDivider, true)
        
        HStack {
            Button("Normal") {}
                .buttonStyle(PrimaryOutlineButtonStyle())
                .controlSize(.mini)
            
            Button("Destructive", role: .destructive) {}
                .buttonStyle(PrimaryOutlineButtonStyle())
                .controlSize(.mini)
        }
    }
    .padding()
    .environment(\.nimbusTheme, MaritimeTheme())
}