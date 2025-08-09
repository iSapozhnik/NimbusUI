//
//  SwiftUIView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI
import FluidGradient
import SmoothGradient

/// A model representing a single onboarding feature page with generic content.
public struct Feature<Content: View>: Identifiable where Content: View {
    public let id = UUID()
    public let title: String
    public let description: String
    public let content: Content
    
    public init(
        title: String,
        description: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.description = description
        self.content = content()
    }
}

/// Type-erased wrapper for Feature to support mixed content types in arrays.
public struct AnyFeature: Identifiable {
    public let id: UUID
    public let title: String
    public let description: String
    public let content: AnyView
    
    public init<Content: View>(_ feature: Feature<Content>) {
        self.id = feature.id
        self.title = feature.title
        self.description = feature.description
        self.content = AnyView(feature.content)
    }
    
    public init(
        title: String,
        description: String,
        @ViewBuilder content: () -> some View
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.content = AnyView(content())
    }
}

/// A reusable onboarding view for macOS, displaying a sequence of features with page control and navigation.
public struct OnboardingView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) private var overrideContentPadding
    @Environment(\.nimbusAnimationFast) private var overrideFastAnimation
    
    public let features: [AnyFeature]
    @State private var currentIndex: Int = 0
    
    public init(features: [AnyFeature]) {
        self.features = features
    }
    
    public init<Content: View>(features: [Feature<Content>]) {
        self.features = features.map { AnyFeature($0) }
    }
    
    public var body: some View {
        let contentPadding = overrideContentPadding ?? theme.labelContentSpacing
        let fastAnimation = overrideFastAnimation ?? theme.animationFast
        
        FluidGradient(blobs: [.red, .blue],
                      highlights: [.yellow, .orange, .purple],
                      speed: 0.1,
                      blur: 0.75)
        .overlay(
            LinearGradient(
                gradient: .smooth(
                    from: theme.backgroundColor(for: colorScheme).opacity(0),
                    to: theme.backgroundColor(for: colorScheme),
                    curve: .easeInOut
                ),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 24) {
                AnyFeaturePageView(feature: features[currentIndex])
                
                Spacer()
                PageControlView(currentIndex: currentIndex, total: features.count)
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        withAnimation(fastAnimation) {
                            if currentIndex < features.count - 1 {
                                currentIndex += 1
                            }
                        }
                    }) {
                        let isLast = currentIndex == features.count - 1
                        Label(isLast ? "Finish" : "Continue", systemImage: isLast ? "checkmark" : "arrow.right")
                            .labelStyle(
                                NimbusDividerLabelStyle(
                                    hasDivider: true,
                                    iconAlignment: .trailing,
                                    contentHorizontalPadding: contentPadding
                                )
                            )
                    }
                    .buttonStyle(.accent)
                    Spacer()
                }
                .overlay(alignment: .leading) {
                    if currentIndex > 0 {
                        Button {
                            withAnimation(fastAnimation) {
                                currentIndex -= 1
                            }
                        } label: {
                            Image(systemName: "arrow.backward")
                        }
                        .buttonStyle(.primaryOutline)
                        .transition(.opacity.combined(with: .scale(scale: 0.8)))
                    }
                }
            }
            .padding(80)
            .overlay(alignment: .bottom) {
                HStack {
                    Button("Privacy Policy") {}
                        .buttonStyle(.nimbusLink)
                    Divider()
                        .frame(height: 20)
                    Button("Terms and Conditions") {}
                        .buttonStyle(.nimbusLink)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 16)
            }
        }
        .frame(width: 600, height: 560)
    }
}

