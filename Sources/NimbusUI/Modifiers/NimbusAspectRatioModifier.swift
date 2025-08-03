//
//  NimbusAspectRatioModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//


import SwiftUI

struct NimbusAspectRatioModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusMinHeight) private var overrideMinHeight
    @Environment(\.controlSize) private var controlSize
    @Environment(\.nimbusAspectRatio) private var aspectRatio
    @Environment(\.nimbusAspectRatioContentMode) private var contentMode
    @Environment(\.nimbusAspectRatioHasFixedHeight) private var hasFixedHeight

    private var minHeight: CGFloat {
        // Use controlSize-aware height calculation if controlSize is available
        ControlSizeUtility.height(for: controlSize, theme: theme, override: overrideMinHeight)
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        if let contentMode {
            // Aspect ratio configuration is provided - apply constraints
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
            // No aspect ratio configuration - use standard button frame behavior
            content
                .frame(
                    maxWidth: .infinity, 
                    minHeight: minHeight, 
                    maxHeight: .infinity
                )
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
