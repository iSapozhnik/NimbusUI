//
//  NimbusAlert+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Alert Configuration Extensions

public extension NimbusAlert {
    /// Sets the alert corner radii
    func cornerRadii(_ radii: RectangleCornerRadii) -> some View {
        self.environment(\.nimbusAlertCornerRadii, radii)
    }
}

// MARK: - Theme Integration Extensions

public extension NimbusAlert {
    func themed(_ theme: NimbusTheming) -> some View {
        self.environment(\.nimbusTheme, theme)
    }
}