//
//  NimbusCheckboxItem.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

/// A checkbox item component that combines NimbusCheckbox with title and optional subtitle text.
/// Supports positioning the checkbox on the left or right side, with full theming integration.
public struct NimbusCheckboxItem: View {
    @Binding private var isOn: Bool
    private let title: String
    private let subtitle: String?
    private let checkboxPosition: CheckboxPosition
    private let verticalAlignment: CheckboxVerticalAlignment
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusCheckboxItemSpacing) private var overrideItemSpacing
    @Environment(\.nimbusCheckboxItemTextSpacing) private var overrideTextSpacing
    @Environment(\.nimbusCheckboxItemPadding) private var overridePadding
    @Environment(\.nimbusCheckboxItemMinHeight) private var overrideMinHeight
    
    @State private var isHovering: Bool = false
    
    /// Position options for the checkbox within the item
    public enum CheckboxPosition: String, CaseIterable, Sendable {
        case leading
        case trailing
    }
    
    /// Vertical alignment options for the checkbox relative to text content
    public enum CheckboxVerticalAlignment: String, CaseIterable, Sendable {
        case center    // Centers checkbox with entire text content
        case baseline  // Aligns checkbox with title text baseline
    }
    
    /// Creates a checkbox item with the specified configuration.
    /// - Parameters:
    ///   - title: The primary text label (required)
    ///   - subtitle: Optional secondary text label
    ///   - isOn: A binding to the checked state of the checkbox
    ///   - checkboxPosition: Position of the checkbox (.leading or .trailing)
    ///   - verticalAlignment: Vertical alignment of checkbox (.center or .baseline)
    public init(
        _ title: String,
        subtitle: String? = nil,
        isOn: Binding<Bool>,
        checkboxPosition: CheckboxPosition = .leading,
        verticalAlignment: CheckboxVerticalAlignment = .center
    ) {
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.checkboxPosition = checkboxPosition
        self.verticalAlignment = verticalAlignment
    }
    
    public var body: some View {
        let itemSpacing = overrideItemSpacing ?? theme.checkboxItemSpacing
        let textSpacing = overrideTextSpacing ?? theme.checkboxItemTextSpacing
        let padding = overridePadding ?? theme.checkboxItemPadding
        let minHeight = overrideMinHeight ?? theme.checkboxItemMinHeight
        
        Button(action: {
            if isEnabled {
                isOn.toggle()
            }
        }) {
            Group {
                if verticalAlignment == .center {
                    HStack(alignment: .center, spacing: itemSpacing) {
                        if checkboxPosition == .leading {
                            checkbox
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                        } else {
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                            checkbox
                        }
                    }
                } else {
                    HStack(alignment: .top, spacing: itemSpacing) {
                        if checkboxPosition == .leading {
                            checkbox
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                        } else {
                            textContent(textSpacing: textSpacing)
                            Spacer(minLength: 0)
                            checkbox
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
        .opacity(isEnabled ? 1.0 : 0.5)
        .onHover { hovering in
            if isEnabled {
                withAnimation(theme.animationFast) {
                    isHovering = hovering
                }
            }
        }
    }
    
    private var checkbox: some View {
        NimbusCheckbox(isOn: $isOn)
            .disabled(!isEnabled)
    }
    
    private func textContent(textSpacing: CGFloat) -> some View {
        VStack(alignment: checkboxPosition == .leading ? .leading : .trailing, spacing: textSpacing) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(titleTextColor)
                .multilineTextAlignment(checkboxPosition == .leading ? .leading : .trailing)
            
            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(subtitleTextColor)
                    .multilineTextAlignment(checkboxPosition == .leading ? .leading : .trailing)
            }
        }
    }
    
    private var titleTextColor: Color {
        isEnabled ? theme.primaryTextColor(for: colorScheme) : theme.tertiaryTextColor(for: colorScheme)
    }
    
    private var subtitleTextColor: Color {
        isEnabled ? theme.secondaryTextColor(for: colorScheme) : theme.tertiaryTextColor(for: colorScheme)
    }
}
