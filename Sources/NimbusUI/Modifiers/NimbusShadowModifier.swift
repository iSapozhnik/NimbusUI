//
//  NimbusShadowModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 22.07.25.
//

import SwiftUI

public struct NimbusShadowModifier: ViewModifier {
    @Environment(\.nimbusElevation) private var envElevation
    private let elevation: Elevation?

    public init(elevation: Elevation? = nil) {
        self.elevation = elevation
    }

    public func body(content: Content) -> some View {
        let effectiveElevation = elevation ?? envElevation
        switch effectiveElevation {
        case .none:
            content
        case .low:
            content.shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 1)
        case .medium:
            content.shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
        case .high:
            content.shadow(color: Color.black.opacity(0.16), radius: 8, x: 0, y: 4)
        case .extreme:
            content.shadow(color: Color.black.opacity(0.20), radius: 16, x: 0, y: 8)
        }
    }
}

// Usage: .modifier(NimbusShadowModifier(elevation: .medium)) or set via environment

