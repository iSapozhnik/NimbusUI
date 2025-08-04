//
//  NimbusLeftDividerCenteredLabelStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

/// Internal API - not intended for direct consumer use
public struct NimbusDividerLabelStyle: LabelStyle {
    @Environment(\.nimbusTheme) var theme
    
    private let hasDivider: Bool
    private let iconAlignment: HorizontalAlignment
    private let contentHorizontalPadding: CGFloat
    
    public init(
        hasDivider: Bool = true,
        iconAlignment: HorizontalAlignment = .leading,
        contentHorizontalPadding: CGFloat = 0
    ) {
        self.hasDivider = hasDivider
        self.iconAlignment = iconAlignment
        self.contentHorizontalPadding = contentHorizontalPadding
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: theme.labelContentSpacing) {
            if iconAlignment == .leading {
                configuration.icon
                    .padding(.horizontal, contentHorizontalPadding)
                if hasDivider {
                    Divider()
                        .shadow(color: Color.primary.opacity(0.7), radius: 0, x: 1, y: 0)
                        .frame(height: 20)
                }
                configuration.title
                    .padding(.horizontal, contentHorizontalPadding)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            } else {
                configuration.title
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, contentHorizontalPadding)
                    .multilineTextAlignment(.center)
                if hasDivider {
                    Divider()
                        .shadow(color: Color.primary.opacity(0.7), radius: 0, x: 1, y: 0)
                        .frame(height: 20)
                }
                configuration.icon
                    .padding(.horizontal, contentHorizontalPadding)
            }
            
        }
    }
}
