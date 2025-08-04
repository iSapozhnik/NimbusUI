//
//  CloseButtonStyle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI
import NimbusCore

public struct CloseButtonStyle: ButtonStyle {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isHovering: Bool
    
    #if DEBUG
    @State private var debugIsPressed: Bool
    private let isDebugMode: Bool
    #endif
    
    public init() {
        self.isHovering = false
        #if DEBUG
        self.debugIsPressed = false
        self.isDebugMode = false
        #endif
    }

    #if DEBUG
        init(
            isHovering: Bool = false,
            isPressed: Bool = false
        ) {
            self.isHovering = isHovering
            self.debugIsPressed = isPressed
            self.isDebugMode = true
        }
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
        
        #if DEBUG
        let effectiveIsPressed = isDebugMode ? debugIsPressed : configuration.isPressed
        #else
        let effectiveIsPressed = configuration.isPressed
        #endif
        
        let animationFast = overrideAnimationFast ?? theme.animationFast
        let closeButtonSize = theme.closeButtonSize
        let closeButtonIconSize = theme.closeButtonIconSize
        let textColor = theme.primaryTextColor(for: colorScheme)
        let hoverBackgroundColor = theme.tertiaryBackgroundColor(for: colorScheme)
        let pressedBackgroundColor = theme.borderColor(for: colorScheme)
        
        configuration.label
            .font(.system(size: closeButtonIconSize, weight: .medium))
            .foregroundStyle(textColor)
            .frame(width: closeButtonSize, height: closeButtonSize)
            .background(
                Circle()
                    .fill(effectiveIsPressed ? pressedBackgroundColor : (isHovering ? hoverBackgroundColor : Color.clear))
                    .animation(animationFast, value: isHovering)
                    .animation(animationFast, value: effectiveIsPressed)
            )
            .scaleEffect(effectiveIsPressed ? 0.95 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
            .animation(animationFast, value: effectiveIsPressed)
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
}
