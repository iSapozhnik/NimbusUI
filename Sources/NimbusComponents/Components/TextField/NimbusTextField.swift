//
//  NimbusTextField.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 07.08.25.
//

import SwiftUI
import Foundation
import NimbusCore

/// A stylized text field that follows NimbusUI design patterns
public struct NimbusTextField<Label>: View where Label: View {
    @Binding private var text: String
    private let prompt: Text?
    @ViewBuilder private var label: () -> Label
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusHasBackground) private var hasBackground
    @Environment(\.nimbusIsBordered) private var isBordered
    
    // TextField-specific environment values
    @Environment(\.nimbusTextFieldContentPadding) private var contentPadding
    @Environment(\.nimbusTextFieldBorderWidth) private var borderWidth
    @Environment(\.nimbusTextFieldCornerRadii) private var cornerRadii
    @Environment(\.nimbusTextFieldMinHeight) private var minHeight
    
    // TextField icon environment values
    @Environment(\.nimbusTextFieldIcon) private var icon
    @Environment(\.nimbusTextFieldIconAlignment) private var iconAlignment
    @Environment(\.nimbusTextFieldIconSpacing) private var iconSpacing
    
    @FocusState private var isFocused: Bool
    @State private var isHovering: Bool = false
    
    private let id = UUID()
    
    // MARK: - Initializers
    
    public init(
        text: Binding<String>,
        prompt: Text? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._text = text
        self.prompt = prompt
        self.label = label
    }
    
    @_disfavoredOverload
    public init(
        _ title: some StringProtocol,
        text: Binding<String>,
        prompt: Text? = nil
    ) where Label == Text {
        self.init(text: text, prompt: prompt) {
            Text(title)
        }
    }
    
    public init(
        _ titleKey: LocalizedStringKey,
        text: Binding<String>,
        prompt: Text? = nil
    ) where Label == Text {
        self.init(text: text, prompt: prompt) {
            Text(titleKey)
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            label()
                .font(.system(size: labelFontSize, weight: .medium))
                .foregroundColor(labelColor)
            
            textFieldWithIconLayout
                .modifier(NimbusFilledModifier(isHovering: isHovering, isPressed: isFocused))
                .modifier(NimbusBorderedModifier(isHovering: isHovering, borderColor: .quaternary, cornerRadii: effectiveCornerRadii))
                .clipShape(RoundedRectangle(cornerRadius: effectiveCornerRadii.topLeading, style: .continuous))
                .focused($isFocused)
                .onHover { hovering in
                    isHovering = hovering
                }
        }
    }
    
    // MARK: - Private Computed Properties
    
    private var textFieldWithIconLayout: some View {
        Group {
            if let icon = icon {
                HStack(spacing: effectiveIconSpacing) {
                    if effectiveIconAlignment == .leading {
                        iconView(icon)
                        textField
                    } else {
                        textField
                        iconView(icon)
                    }
                }
                .padding(effectiveContentPadding)
                .frame(minHeight: effectiveMinHeight)
            } else {
                textField
                    .padding(effectiveContentPadding)
                    .frame(minHeight: effectiveMinHeight)
            }
        }
    }
    
    private var textField: some View {
        TextField(text: $text, prompt: prompt) {}
            .textFieldStyle(.plain)
//            .font(.system(size: inputFontSize)) // once hoeverd causing text jump
            .foregroundColor(inputTextColor)
    }
    
    private func iconView(_ iconContent: AnyView) -> some View {
        iconContent
            .foregroundColor(iconColor)
    }
    
    private var effectiveContentPadding: EdgeInsets {
        contentPadding ?? adjustedPaddingForControlSize
    }
    
    private var effectiveBorderWidth: CGFloat {
        borderWidth ?? theme.textFieldBorderWidth
    }
    
    private var effectiveCornerRadii: RectangleCornerRadii {
        cornerRadii ?? theme.textFieldCornerRadii
    }
    
    private var effectiveMinHeight: CGFloat {
        minHeight ?? adjustedMinHeightForControlSize
    }
    
    private var effectiveIconSpacing: CGFloat {
        iconSpacing ?? theme.textFieldIconSpacing
    }
    
    private var effectiveIconAlignment: HorizontalAlignment {
        iconAlignment ?? .leading
    }
    
    private var adjustedPaddingForControlSize: EdgeInsets {
        let basePadding = theme.textFieldContentPadding
        let multiplier = controlSizeMultiplier
        
        return EdgeInsets(
            top: basePadding.top * multiplier,
            leading: basePadding.leading * multiplier,
            bottom: basePadding.bottom * multiplier,
            trailing: basePadding.trailing * multiplier
        )
    }
    
    private var adjustedMinHeightForControlSize: CGFloat {
        theme.textFieldMinHeight * controlSizeMultiplier
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
    
    private var labelFontSize: CGFloat {
        switch controlSize {
        case .extraLarge:
            return 16
        case .large:
            return 15
        case .regular:
            return 14
        case .small:
            return 13
        case .mini:
            return 12
        @unknown default:
            return 14
        }
    }
    
    private var inputFontSize: CGFloat {
        switch controlSize {
        case .extraLarge:
            return 18
        case .large:
            return 16
        case .regular:
            return 15
        case .small:
            return 13
        case .mini:
            return 11
        @unknown default:
            return 15
        }
    }
    
    private var labelColor: Color {
        if isEnabled {
            return theme.secondaryTextColor(for: colorScheme)
        } else {
            return theme.tertiaryTextColor(for: colorScheme)
        }
    }
    
    private var inputTextColor: Color {
        if isEnabled {
            return theme.primaryTextColor(for: colorScheme)
        } else {
            return theme.tertiaryTextColor(for: colorScheme)
        }
    }
    
    private var iconColor: Color {
        if isEnabled {
            if isFocused {
                return theme.accentColor(for: colorScheme)
            } else {
                return theme.secondaryTextColor(for: colorScheme)
            }
        } else {
            return theme.tertiaryTextColor(for: colorScheme)
        }
    }
    
    private var backgroundFill: Color {
        if isEnabled {
            if isFocused {
                return theme.secondaryBackgroundColor(for: colorScheme)
            } else if isHovering {
                return theme.tertiaryBackgroundColor(for: colorScheme)
            } else {
                return theme.tertiaryBackgroundColor(for: colorScheme)
            }
        } else {
            return theme.tertiaryBackgroundColor(for: colorScheme).opacity(0.5)
        }
    }
    
    private var borderColor: Color {
        if isEnabled {
            if isFocused {
                return theme.primaryColor(for: colorScheme)
            } else if isHovering {
                return theme.secondaryBorderColor(for: colorScheme)
            } else {
                return theme.borderColor(for: colorScheme)
            }
        } else {
            return theme.borderColor(for: colorScheme).opacity(0.5)
        }
    }
}

