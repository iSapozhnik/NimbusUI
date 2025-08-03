//
//  LinkButtonStyle.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI

public struct LinkButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isHovering: Bool
    
    /// Optional custom semantic color for the link button
    /// If nil, uses theme.primaryColor(for:)
    private let semanticColor: Color?
    
    public init() {
        self.isHovering = false
        self.semanticColor = nil
    }
    
    public init(semanticColor: Color) {
        self.isHovering = false
        self.semanticColor = semanticColor
    }

    #if DEBUG
        init(
            isHovering: Bool = false,
            semanticColor: Color? = nil
        ) {
            self.isHovering = isHovering
            self.semanticColor = semanticColor
        }
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
        let animationFast = overrideAnimationFast ?? theme.animationFast
        let linkButtonFontWeight = theme.linkButtonFontWeight
        let textColor = semanticColor ?? theme.primaryColor(for: colorScheme)
        
        configuration.label
            .fontWeight(linkButtonFontWeight)
            .foregroundStyle(textColor)
            .opacity(isEnabled ? (configuration.isPressed ? 0.6 : (isHovering ? 0.8 : 1.0)) : 0.5)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(animationFast, value: isHovering)
            .animation(animationFast, value: configuration.isPressed)
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
}
