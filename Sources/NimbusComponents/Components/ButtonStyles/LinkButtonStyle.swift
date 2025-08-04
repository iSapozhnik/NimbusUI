//
//  LinkButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI
import NimbusCore

public struct LinkButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isHovering: Bool
    
    #if DEBUG
    @State private var debugIsPressed: Bool
    private let isDebugMode: Bool
    #endif
    
    /// Optional custom semantic color for the link button
    /// If nil, uses theme.primaryColor(for:)
    private let semanticColor: Color?
    
    public init() {
        self.isHovering = false
        self.semanticColor = nil
        #if DEBUG
        self.debugIsPressed = false
        self.isDebugMode = false
        #endif
    }
    
    public init(semanticColor: Color) {
        self.isHovering = false
        self.semanticColor = semanticColor
        #if DEBUG
        self.debugIsPressed = false
        self.isDebugMode = false
        #endif
    }

    #if DEBUG
        init(
            isHovering: Bool = false,
            isPressed: Bool = false,
            semanticColor: Color? = nil
        ) {
            self.isHovering = isHovering
            self.debugIsPressed = isPressed
            self.isDebugMode = true
            self.semanticColor = semanticColor
        }
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
        
        #if DEBUG
        let effectiveIsPressed = isDebugMode ? debugIsPressed : configuration.isPressed
        #else
        let effectiveIsPressed = configuration.isPressed
        #endif
        
        let animationFast = overrideAnimationFast ?? theme.animationFast
        let linkButtonFontWeight = theme.linkButtonFontWeight
        let textColor = semanticColor ?? theme.primaryColor(for: colorScheme)
        
        configuration.label
            .fontWeight(linkButtonFontWeight)
            .foregroundStyle(textColor)
            .opacity(isEnabled ? (effectiveIsPressed ? 0.6 : (isHovering ? 0.8 : 1.0)) : 0.5)
            .scaleEffect(effectiveIsPressed ? 0.98 : 1.0)
            .animation(animationFast, value: isHovering)
            .animation(animationFast, value: effectiveIsPressed)
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
}
