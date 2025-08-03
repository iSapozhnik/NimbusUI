//
//  CloseButtonStyle+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
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
            Button {
                // dismiss action
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.close)
        }
        
        HStack {
            Text("Disabled:")
            Button {
                // dismiss action
            } label: {
                Image(systemName: "xmark")
            }
            .buttonStyle(.close)
            .disabled(true)
        }
        
        HStack {
            Text("In context:")
            HStack(spacing: 12) {
                Text("Notification message")
                Button {
                    // dismiss action
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.close)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}
