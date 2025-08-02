//
//  PrimaryDefaultButtonStyle+Preview.swift
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
    VStack {
        HStack {
            Button("Normal") {}
                .buttonStyle(.primaryDefault)
        }
        .frame(height: 40)
            .padding()
    }
}