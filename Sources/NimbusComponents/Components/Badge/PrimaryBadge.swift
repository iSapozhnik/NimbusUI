//
//  PrimaryBadge.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
import NimbusCore

/// A primary badge component with solid background and semantic colors
public struct PrimaryBadge<Content: View>: View {
    private let semanticType: BadgeSemanticType
    private let content: Content
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize
    
    // Badge-specific environment values
    @Environment(\.nimbusBadgeType) private var badgeType
    @Environment(\.nimbusBadgeBorderWidth) private var borderWidth
    @Environment(\.nimbusBadgeContentPadding) private var contentPadding
    
    public init(
        _ semanticType: BadgeSemanticType,
        @ViewBuilder content: () -> Content
    ) {
        self.semanticType = semanticType
        self.content = content()
    }
    
    public var body: some View {
        content
            .font(fontForControlSize)
            .foregroundColor(semanticType.primaryTextColor(scheme: colorScheme))
            .padding(effectiveContentPadding)
            .background(
                backgroundShape
                    .fill(semanticType.primaryBackgroundColor(theme: theme, scheme: colorScheme))
            )
    }
    
    // MARK: - Private Computed Properties
    
    private var effectiveContentPadding: EdgeInsets {
        contentPadding ?? adjustedPaddingForControlSize
    }
    
    private var adjustedPaddingForControlSize: EdgeInsets {
        let basePadding = theme.badgeContentPadding
        let multiplier = controlSizeMultiplier
        
        return EdgeInsets(
            top: basePadding.top * multiplier,
            leading: basePadding.leading * multiplier,
            bottom: basePadding.bottom * multiplier,
            trailing: basePadding.trailing * multiplier
        )
    }
    
    private var controlSizeMultiplier: CGFloat {
        switch controlSize {
        case .extraLarge:
            return 1.6
        case .large:
            return 1.4
        case .regular:
            return 1.0
        case .small:
            return 0.8
        case .mini:
            return 0.6
        @unknown default:
            return 1.0
        }
    }
    
    private var fontForControlSize: Font {
        switch controlSize {
        case .extraLarge:
            return .system(size: 18, weight: .medium)
        case .large:
            return .system(size: 16, weight: .medium)
        case .regular:
            return .system(size: 14, weight: .medium)
        case .small:
            return .system(size: 12, weight: .medium)
        case .mini:
            return .system(size: 10, weight: .medium)
        @unknown default:
            return .system(size: 14, weight: .medium)
        }
    }
    
    private var effectiveBadgeType: BadgeType {
        badgeType ?? .capsule
    }
    
    private var backgroundShape: AnyShape {
        effectiveBadgeType.shape()
    }
}

// MARK: - Convenience Initializers

public extension PrimaryBadge where Content == Text {
    /// Creates a primary badge with text content
    init(_ text: String, semanticType: BadgeSemanticType) {
        self.init(semanticType) {
            Text(text)
        }
    }
}

public extension PrimaryBadge where Content == Label<Text, Image> {
    /// Creates a primary badge with label content (text + icon)
    init(_ title: String, systemImage: String, semanticType: BadgeSemanticType) {
        self.init(semanticType) {
            Label(title, systemImage: systemImage)
        }
    }
}
