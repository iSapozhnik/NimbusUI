//
//  NimbusTextField+Preview.swift
//  NimbusUI
//
//  Created by AI Assistant on 07.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - NimbusTextField Previews

#Preview("TextField - Basic Examples") {
    Group {
        VStack(spacing: 16) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter your email"))
        
        NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
        
        NimbusTextField("Disabled", text: .constant("Cannot edit"))
            .disabled(true)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Control Sizes") {
    Group {
        VStack(spacing: 16) {
        NimbusTextField("Extra Large", text: .constant("Sample Text"))
            .controlSize(.extraLarge)
        
        NimbusTextField("Large", text: .constant("Sample Text"))
            .controlSize(.large)
        
        NimbusTextField("Regular", text: .constant("Sample Text"))
            .controlSize(.regular)
        
        NimbusTextField("Small", text: .constant("Sample Text"))
            .controlSize(.small)
        
        NimbusTextField("Mini", text: .constant("Sample Text"))
            .controlSize(.mini)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Styling Variations") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Default", text: .constant("With border and background"))
            
            NimbusTextField("No Border", text: .constant("Background only"))
                .bordered(false)
            
            NimbusTextField("No Background", text: .constant("Border only"))
                .hasBackground(false)
            
            NimbusTextField("Plain", text: .constant("No styling"))
                .bordered(false)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Custom Styling") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Custom Padding", text: .constant("Extra padding"))
                .contentPadding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            
            NimbusTextField("Custom Border", text: .constant("Thick border"))
                .borderWidth(2)
            
            NimbusTextField("Rounded", text: .constant("Custom corners"))
                .cornerRadii(RectangleCornerRadii(12))
            
            NimbusTextField("Tall Field", text: .constant("Custom height"))
                .minHeight(60)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Value Types") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Price", text: .constant("$29.99"))
            
            NimbusTextField("Quantity", text: .constant("5"))
            
            NimbusTextField("Percentage", text: .constant("85%"))
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Different Themes") {
    Group {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Nimbus Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, NimbusTheme.default)
                }
                
                VStack(spacing: 8) {
                    Text("Maritime Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, MaritimeTheme())
                }
                
                VStack(spacing: 8) {
                    Text("Custom Warm Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, CustomWarmTheme())
                }
            }
            .padding()
        }
    }
}

private var textFieldGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter email"))
        
        NimbusTextField("Custom", text: .constant("Rounded corners"))
            .cornerRadii(RectangleCornerRadii(8))
    }
}