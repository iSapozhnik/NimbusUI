//
//  LuminareAspectRatioModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//


import SwiftUI

struct NimbusAspectRatioModifier: ViewModifier {
    @Environment(\.nimbusMinHeight) private var minHeight
    @Environment(\.nimbusAspectRatio) private var aspectRatio
    @Environment(\.nimbusAspectRatioContentMode) private var contentMode
    @Environment(\.nimbusAspectRatioHasFixedHeight) private var hasFixedHeight

    @ViewBuilder
    func body(content: Content) -> some View {
        if let contentMode {
            Group {
                if isConstrained {
                    content
                        .frame(
                            minWidth: minWidth, maxWidth: .infinity,
                            minHeight: minHeight,
                            maxHeight: hasFixedHeight ? nil : .infinity
                        )
                        .aspectRatio(
                            aspectRatio,
                            contentMode: contentMode
                        )
                } else {
                    content
                        .frame(
                            maxWidth: .infinity, minHeight: minHeight,
                            maxHeight: .infinity
                        )
                }
            }
            .fixedSize(
                horizontal: contentMode == .fit,
                vertical: hasFixedHeight
            )
        } else {
            content
        }
    }

    private var isConstrained: Bool {
        guard let contentMode else { return false }
        return contentMode == .fit || hasFixedHeight
    }

    private var minWidth: CGFloat? {
        if hasFixedHeight, let aspectRatio {
            minHeight * aspectRatio
        } else {
            nil
        }
    }
}
