//
//  View+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

extension View {
    // Applies a materialized background over a view
    @ViewBuilder func background(with material: Material?, @ViewBuilder content: () -> some View) -> some View {
        background(material.map(AnyShapeStyle.init(_:)) ?? AnyShapeStyle(.clear))
            .background {
                content()
            }
    }
}
