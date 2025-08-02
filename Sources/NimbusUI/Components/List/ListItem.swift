//
//  ListItem.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 31.07.25.
//

import SwiftUI

public enum ListRoundedCornerBehavior: String, Hashable, Equatable,
    Identifiable, CaseIterable, Codable, Sendable {
    case never
    case always
    case fixedHeight
    case variableHeight

    public var id: Self { self }

    public var negate: Self {
        switch self {
        case .never:
            .always
        case .always:
            .never
        case .fixedHeight:
            .variableHeight
        case .variableHeight:
            .fixedHeight
        }
    }

    func isRounded(hasFixedHeight: Bool) -> Bool {
        switch self {
        case .never:
            false
        case .always:
            true
        case .fixedHeight:
            hasFixedHeight
        case .variableHeight:
            !hasFixedHeight
        }
    }
}

public struct ListItem<Content, V>: View where Content: View, V: Hashable {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusListItemCornerRadii) private var overrideItemCornerRadii
    @Environment(\.nimbusCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusListItemHeight) private var overrideItemHeight
    @Environment(\.nimbusListItemHighlightOnHover) private var highlightOnHover
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    @Environment(\.nimbusHasDividers) private var hasDividers
    @Environment(\.colorScheme) private var colorScheme


    @Binding var items: [V]
    @Binding var selection: Set<V>
    
    @Binding var item: V
    @Binding var firstItem: V?
    @Binding var lastItem: V?
    
    var roundedTop: Bool
    var roundedBottom: Bool
    
    @State private var isHovering = false
    
    private let maxLineWidth: CGFloat = 1.5
    @State private var lineWidth: CGFloat = .zero
    
    private let maxTintOpacity: CGFloat = 0.15
    @State private var tintOpacity: CGFloat = .zero
    
    @ViewBuilder var content: (Binding<V>) -> Content
    
    private var itemHeight: CGFloat {
        overrideItemHeight ?? theme.listItemHeight
    }
    
    private var animationFast: Animation {
        overrideAnimationFast ?? theme.animationFast
    }
    
    private var itemCornerRadii: RectangleCornerRadii {
        overrideItemCornerRadii ?? theme.listItemCornerRadii
    }
    
    private var cornerRadii: RectangleCornerRadii {
        overrideCornerRadii ?? theme.cornerRadii
    }
    
    public var body: some View {
        Color.clear
            .frame(minHeight: itemHeight)
            .overlay {
                content($item)
                    .environment(\.nimbusItemBeingHovered, isHovering)
                    .foregroundStyle(isEnabled ? .primary : .secondary)
            }
            .tag(item)
            .onHover { isHovering in
                withAnimation(animationFast) {
                    self.isHovering = isHovering
                }
            }
            .background {
                if hasDividers, !isLast {
                    VStack {
                        Spacer()

                        Divider()
                    }
                    .padding(.trailing, -1)
                }

                if isEnabled {
                    ZStack {
                        itemBorder()
                        itemBackground()
                    }
                    .padding(.horizontal, 1)
                    .padding(.leading, 1) // it's nuanced
                }
            }
            .onChange(of: selection) { _ in
                guard isEnabled else { return }
                withAnimation(animationFast) {
                    updateSelection()
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(animationFast) {
                        // Initialize selection
                        updateSelection()

                        // Reset hovering state
                        isHovering = false
                    }
                }
            }
    }
    
    // MARK: - Functions
    
    private func updateSelection() {
        guard !selection.isEmpty else {
            tintOpacity = .zero
            lineWidth = .zero
            return
        }

        tintOpacity = selection.contains(item) ? maxTintOpacity : .zero
        lineWidth = selection.contains(item) ? maxLineWidth : .zero
    }
}

extension ListItem {
    fileprivate var isFirst: Bool {
        guard !items.isEmpty else { return false }
        return item == items.first
    }

    fileprivate var isLast: Bool {
        guard !items.isEmpty else { return false }
        return item == items.last
    }
    
    fileprivate var isFirstInSelection: Bool {
        guard !items.isEmpty else { return false }
        return if
            let firstIndex = items.firstIndex(of: item),
            firstIndex > 0 {
            !selection.contains(items[firstIndex - 1])
        } else {
            item == firstItem
        }
    }
    
    private var isInSelection: Bool {
        guard !items.isEmpty else { return false }
        return selection.contains(item)
    }

    fileprivate var isLastInSelection: Bool {
        guard !items.isEmpty else { return false }
        return if
            let firstIndex = items.firstIndex(of: item),
            firstIndex < items.count - 1 {
            !selection.contains(items[firstIndex + 1])
        } else {
            item == lastItem
        }
    }
    
    @ViewBuilder
    fileprivate func itemBorder() -> some View {
        if isFirstInSelection, isLastInSelection {
            singleSelectionPart()
        } else if isFirstInSelection {
            firstItemPart()
        } else if isLastInSelection {
            lastItemPart()
        } else if isInSelection {
            doubleLinePart()
        }
    }
    
    @ViewBuilder
    fileprivate func itemBackground() -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(theme.accentColor(for: colorScheme))
                .opacity(tintOpacity)

            if highlightOnHover, isHovering {
                Rectangle()
                    .foregroundStyle(theme.hoverBackgroundColor(for: colorScheme))
                    .opacity((maxTintOpacity - tintOpacity) * (1 / maxTintOpacity))
            }
        }
        .clipShape(itemBackgroundShape)
    }
    
    @ViewBuilder
    fileprivate func singleSelectionPart() -> some View {
        UnevenRoundedRectangle(
            topLeadingRadius: isFirst && roundedTop
                ? cornerRadii.topLeading - 1 : itemCornerRadii.topLeading,
            bottomLeadingRadius: isLast && roundedBottom
                ? cornerRadii.bottomLeading - 1 : itemCornerRadii.bottomLeading,
            bottomTrailingRadius: isLast && roundedBottom
                ? cornerRadii.bottomTrailing - 1 : itemCornerRadii.bottomTrailing,
            topTrailingRadius: isFirst && roundedTop
                ? cornerRadii.topTrailing - 1 : itemCornerRadii.topTrailing
        )
        .strokeBorder(theme.accentColor(for: colorScheme), lineWidth: lineWidth)
    }
    
    @ViewBuilder
    fileprivate func firstItemPart() -> some View {
        VStack(spacing: 0) {
            // Top half
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: isFirst && roundedTop
                        ? cornerRadii.topLeading - 1
                        : itemCornerRadii.topLeading,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: isFirst && roundedTop
                        ? cornerRadii.topTrailing - 1
                        : itemCornerRadii.topTrailing
                )
                .strokeBorder(theme.accentColor(for: colorScheme), lineWidth: lineWidth)

                VStack {
                    Color.clear
                    HStack {
                        Spacer()
                            .frame(width: lineWidth)

                        Rectangle()
                            .foregroundStyle(.white)
                            .blendMode(.destinationOut)

                        Spacer()
                            .frame(width: lineWidth)
                    }
                }
            }
            .compositingGroup()

            // Bottom half
            HStack {
                Rectangle()
                    .frame(width: lineWidth)

                Spacer()

                Rectangle()
                    .frame(width: lineWidth)
            }
            .foregroundStyle(theme.accentColor(for: colorScheme))
        }
    }
    
    @ViewBuilder
    fileprivate func lastItemPart() -> some View {
        VStack(spacing: 0) {
            // Top half
            HStack {
                Rectangle()
                    .frame(width: lineWidth)

                Spacer()

                Rectangle()
                    .frame(width: lineWidth)
            }
            .foregroundStyle(theme.accentColor(for: colorScheme))

            // Bottom half
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: isLast && roundedBottom
                        ? cornerRadii.bottomLeading - 1
                        : itemCornerRadii.bottomLeading,
                    bottomTrailingRadius: isLast && roundedBottom
                        ? cornerRadii.bottomTrailing - 1
                        : itemCornerRadii.bottomTrailing,
                    topTrailingRadius: 0
                )
                .strokeBorder(theme.accentColor(for: colorScheme), lineWidth: lineWidth)

                VStack {
                    HStack {
                        Spacer()
                            .frame(width: lineWidth)

                        Rectangle()
                            .foregroundStyle(.white)
                            .blendMode(.destinationOut)

                        Spacer()
                            .frame(width: lineWidth)
                    }
                    Color.clear
                }
            }
            .compositingGroup()
        }
    }
    
    @ViewBuilder
    fileprivate func doubleLinePart() -> some View {
        HStack {
            Rectangle()
                .frame(width: lineWidth)

            Spacer()

            Rectangle()
                .frame(width: lineWidth)
        }
        .foregroundStyle(theme.accentColor(for: colorScheme))
    }
    
    private var itemBackgroundShape: UnevenRoundedRectangle {
        let topCornerRadii =
            if isInSelection {
                isFirstInSelection ? itemCornerRadii : .zero
            } else { itemCornerRadii }
        let bottomCornerRadii =
            if isInSelection {
                isLastInSelection ? itemCornerRadii : .zero
            } else { itemCornerRadii }

        return .init(
            topLeadingRadius: isFirst && roundedTop
                ? cornerRadii.topLeading : topCornerRadii.topLeading,
            bottomLeadingRadius: isLast && roundedBottom
                ? cornerRadii.bottomLeading : bottomCornerRadii.bottomLeading,
            bottomTrailingRadius: isLast && roundedBottom
                ? cornerRadii.bottomTrailing : bottomCornerRadii.bottomTrailing,
            topTrailingRadius: isFirst && roundedTop
                ? cornerRadii.topTrailing : topCornerRadii.topTrailing
        )
    }
}

// MARK: - Preview

private struct ListItemPreview: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusListRoundedTopCornerBehavior) private var topCorner
    @Environment(\.nimbusListRoundedBottomCornerBehavior) private var bottomCorner
    @Environment(\.nimbusListFixedHeightUntil) private var fixedHeight
    
    @State private var items = ["First Item", "Second Item", "Third Item", "Fourth Item"]
    @State private var selection: Set<String> = ["Second Item"]
    @State private var firstItem: String? = "Second Item"
    @State private var lastItem: String? = "Second Item"

    private var hasFixedHeight: Bool {
        guard let fixedHeight else { return false }
        return totalHeight <= fixedHeight
    }
    
    private var totalHeight: CGFloat {
        return CGFloat(items.count) * theme.listItemHeight
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("ListItem Showcase")
                .font(.headline)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            VStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element) { index, item in
                    let roundedTop = topCorner.isRounded(hasFixedHeight: hasFixedHeight)
                    let roundedBottom = bottomCorner.isRounded(hasFixedHeight: hasFixedHeight)
                    
                    ListItem(
                        items: $items,
                        selection: $selection,
                        item: .constant(item),
                        firstItem: $firstItem,
                        lastItem: $lastItem,
                        roundedTop: roundedTop,
                        roundedBottom: roundedBottom
                    ) { itemBinding in
                        HStack {
                            Text(itemBinding.wrappedValue)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            Spacer()
                            if selection.contains(itemBinding.wrappedValue) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(theme.accentColor(for: colorScheme))
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                }
            }
            .background(theme.backgroundColor(for: colorScheme))
            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
            
            Text("Selection: \(selection.joined(separator: ", "))")
                .font(.caption)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
        }
        .padding()
        .background(theme.secondaryBackgroundColor(for: colorScheme))
    }
}

#Preview {
    ListItemPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
        .environment(\.nimbusListItemHighlightOnHover, true)
        .environment(\.nimbusListRoundedTopCornerBehavior, .always)
        .environment(\.nimbusListRoundedBottomCornerBehavior, .always)
}
