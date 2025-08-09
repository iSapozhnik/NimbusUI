//
//  Feature+Extensions.swift
//  NimbusUI
//
//  Created by Claude Code
//

import SwiftUI
import NimbusCore

// MARK: - Feature Convenience Functions

/// Creates a feature with an image using standard styling
public func imageFeature(
    title: String,
    description: String,
    image: Image,
    imageSize: CGFloat = 120
) -> Feature<some View> {
    Feature(title: title, description: description) {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: imageSize, height: imageSize)
            .modifier(LevitatingViewModifier())
    }
}

/// Creates a feature with an SF Symbol icon
public func iconFeature(
    title: String,
    description: String,
    systemName: String,
    iconSize: CGFloat = 60
) -> Feature<some View> {
    Feature(title: title, description: description) {
        Image(systemName: systemName)
            .font(.system(size: iconSize))
            .modifier(LevitatingViewModifier())
    }
}

/// Creates a feature with custom content
public func customFeature<T: View>(
    title: String,
    description: String,
    @ViewBuilder content: @escaping () -> T
) -> Feature<T> {
    Feature(title: title, description: description, content: content)
}

// MARK: - AnyFeature Convenience Initializers

public extension AnyFeature {
    /// Creates an AnyFeature with an image using standard styling
    static func imageFeature(
        title: String,
        description: String,
        image: Image,
        imageSize: CGFloat = 120
    ) -> AnyFeature {
        AnyFeature(title: title, description: description) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize)
                .modifier(LevitatingViewModifier())
        }
    }
    
    /// Creates an AnyFeature with an SF Symbol icon
    static func iconFeature(
        title: String,
        description: String,
        systemName: String,
        iconSize: CGFloat = 60
    ) -> AnyFeature {
        AnyFeature(title: title, description: description) {
            Image(systemName: systemName)
                .font(.system(size: iconSize))
                .modifier(LevitatingViewModifier())
        }
    }
}

// MARK: - Content Styling Extensions

public extension View {
    /// Centers content within the available space
    func centeredFeatureContent() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    /// Applies fixed size to feature content
    func fixedFeatureContentSize(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self.frame(
            width: width,
            height: height
        )
    }
    
    /// Applies maximum size constraints to feature content
    func maxFeatureContentSize(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self.frame(
            maxWidth: width ?? .infinity,
            maxHeight: height ?? .infinity
        )
    }
    
    /// Applies levitating animation effect
    func levitatingFeatureContent() -> some View {
        self.modifier(LevitatingViewModifier())
    }
    
    /// Applies fade-in animation
    func fadeInFeatureContent(delay: Double = 0) -> some View {
        self
            .opacity(0)
            .onAppear {
                withAnimation(.easeIn(duration: 0.6).delay(delay)) {
                    // Animation handled by view modifier
                }
            }
            .opacity(1)
    }
    
    /// Applies scale animation effect
    func scaleFeatureContent(scale: CGFloat = 1.1, duration: Double = 2.0) -> some View {
        self
            .scaleEffect(1.0)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                ) {
                    // Animation state managed internally
                }
            }
    }
}