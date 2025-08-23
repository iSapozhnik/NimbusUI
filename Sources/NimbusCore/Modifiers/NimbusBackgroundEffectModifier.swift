//
//  NimbusBackgroundEffectModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI

public struct NimbusBackgroundEffectModifier: ViewModifier {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode

    public init(
        material: NSVisualEffectView.Material = .menu,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
    ) {
        self.material = material
        self.blendingMode = blendingMode
    }
    
    public func body(content: Content) -> some View {
        content
            .background {
                VisualEffectView(
                    material: material,
                    blendingMode: blendingMode
                )
                .edgesIgnoringSafeArea(.top)
                .allowsHitTesting(false)
            }
    }
}
