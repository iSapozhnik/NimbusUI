//
//  LinkButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

// MARK: - Previews

@available(macOS 15.0, *)
// Note: .sizeThatFitsLayout trait causes content clipping with 
// VStack containing multiple HStacks with Button+Label combinations  
#Preview {
    VStack(alignment: .leading, spacing: 16) {
        HStack {
            Text("Normal:")
            Button("Try again") {}
                .buttonStyle(LinkButtonStyle())
        }
        
        HStack {
            Text("Disabled:")
            Button("Try again") {}
                .buttonStyle(LinkButtonStyle())
                .disabled(true)
        }
        
        HStack {
            Text("Various texts:")
            VStack(alignment: .leading, spacing: 8) {
                Button("Check details") {}
                    .buttonStyle(LinkButtonStyle())
                Button("Edit Profile") {}
                    .buttonStyle(LinkButtonStyle())
                Button("View Details") {}
                    .buttonStyle(LinkButtonStyle())
            }
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}