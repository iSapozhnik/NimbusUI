//
//  NimbusLeftDividerCenteredLabelStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI

struct NimbusDividerLabelStyle: LabelStyle {
    @Environment(\.nimbusLabelIconContentSpacing) var contentSpacing
    
    private let hasDivider: Bool
    private let iconAlignment: HorizontalAlignment
    private let contentHorizontalPadding: CGFloat
    
    init(
        hasDivider: Bool = true,
        iconAlignment: HorizontalAlignment = .leading,
        contentHorizontalPadding: CGFloat = 0
    ) {
        self.hasDivider = hasDivider
        self.iconAlignment = iconAlignment
        self.contentHorizontalPadding = contentHorizontalPadding
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: contentSpacing) {
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
