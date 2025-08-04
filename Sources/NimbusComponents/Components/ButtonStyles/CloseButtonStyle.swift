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
    
    public init() {
        self.isHovering = false
    }

    #if DEBUG
        init(
            isHovering: Bool = false
        ) {
            self.isHovering = isHovering
        }
    #endif
    
    public func makeBody(configuration: Configuration) -> some View {
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
                    .fill(configuration.isPressed ? pressedBackgroundColor : (isHovering ? hoverBackgroundColor : Color.clear))
                    .animation(animationFast, value: isHovering)
                    .animation(animationFast, value: configuration.isPressed)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
            .animation(animationFast, value: configuration.isPressed)
            .onHover { isHovering in
                self.isHovering = isHovering
            }
    }
}
