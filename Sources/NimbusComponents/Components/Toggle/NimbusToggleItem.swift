//
//  NimbusToggleItem.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

/// A toggle item component that combines NimbusToggle with title and optional subtitle text.
/// Supports positioning the toggle on the left or right side, with full theming integration.
public struct NimbusToggleItem: View {
    @Binding private var isOn: Bool
    private let title: String
    private let subtitle: String?
    private let togglePosition: TogglePosition
    private let verticalAlignment: ToggleVerticalAlignment
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusToggleItemSpacing) private var overrideItemSpacing
    @Environment(\.nimbusToggleItemTextSpacing) private var overrideTextSpacing
    @Environment(\.nimbusToggleItemPadding) private var overridePadding
    @Environment(\.nimbusToggleItemMinHeight) private var overrideMinHeight
    
    @State private var isHovering: Bool = false
    
    /// Position options for the toggle within the item
    public enum TogglePosition: String, CaseIterable, Sendable {
        case leading
        case trailing
    }
    
    /// Vertical alignment options for the toggle relative to text content
    public enum ToggleVerticalAlignment: String, CaseIterable, Sendable {
        case center    // Centers toggle with entire text content
        case baseline  // Aligns toggle with title text baseline
    }
    
    /// Creates a toggle item with the specified configuration.
    /// - Parameters:
    ///   - title: The primary text label (required)
    ///   - subtitle: Optional secondary text label
    ///   - isOn: A binding to the toggle state of the switch
    ///   - togglePosition: Position of the toggle (.leading or .trailing)
    ///   - verticalAlignment: Vertical alignment of toggle (.center or .baseline)
    public init(
        _ title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>,
        togglePosition: TogglePosition = .trailing,
        verticalAlignment: ToggleVerticalAlignment = .center
    ) {
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.togglePosition = togglePosition
        self.verticalAlignment = verticalAlignment
    }
    
    public var body: some View {
        let itemSpacing = overrideItemSpacing ?? theme.toggleItemSpacing
        let textSpacing = overrideTextSpacing ?? theme.toggleItemTextSpacing
        let padding = overridePadding ?? theme.toggleItemPadding
        let minHeight = overrideMinHeight ?? theme.toggleItemMinHeight
        
        Button(action: {
            if isEnabled {
                isOn.toggle()
            }
        }) {
            Group {
                if verticalAlignment == .center {
                    HStack(alignment: .center, spacing: itemSpacing) {
                        if togglePosition == .leading {
                            toggle
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                        } else {
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                            toggle
                        }
                    }
                } else {
                    HStack(alignment: .top, spacing: itemSpacing) {
                        if togglePosition == .leading {
                            toggle
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                        } else {
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                            toggle
                        }
                    }
                }
            }
            .padding(.horizontal, padding)
            .padding(.vertical, padding / 2)
            .frame(minHeight: minHeight)
            .background(
                RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading)
                    .fill(isHovering ? theme.secondaryBackgroundColor(for: colorScheme).opacity(0.5) : .clear)
            )
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            if isEnabled {
                withAnimation(theme.animationFast) {
                    isHovering = hovering
                }
            }
        }
    }
    
    private var toggle: some View {
        NimbusToggle(isOn: $isOn)
            .disabled(!isEnabled)
    }
    
    private func textContent(textSpacing: CGFloat) -> some View {
        VStack(alignment: togglePosition == .leading ? .leading : .trailing, spacing: textSpacing) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(titleTextColor)
                .multilineTextAlignment(togglePosition == .leading ? .leading : .trailing)
            
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(subtitleTextColor)
                    .multilineTextAlignment(togglePosition == .leading ? .leading : .trailing)
            }
        }
    }
    
    private var titleTextColor: Color {
        theme.primaryTextColor(for: colorScheme)
    }
    
    private var subtitleTextColor: Color {
        theme.secondaryTextColor(for: colorScheme)
    }
}