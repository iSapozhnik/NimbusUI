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
//        if isFirstInSelection, isLastInSelection {
//            singleSelectionPart()
//        } else if isFirstInSelection {
//            firstItemPart()
//        } else if isLastInSelection {
//            lastItemPart()
//        } else if isInSelection {
//            doubleLinePart()
//        }
        EmptyView()
    }
    
    @ViewBuilder
    fileprivate func itemBackground() -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.tint)
                .opacity(tintOpacity)

            if highlightOnHover, isHovering {
                Rectangle()
                    .foregroundStyle(.quaternary.opacity(0.7))
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
        .strokeBorder(.tint, lineWidth: lineWidth)
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

private struct ListItemPreview<V>: View where V: Hashable & Comparable {
    @Environment(\.nimbusListRoundedTopCornerBehavior) private var topCorner
    @Environment(\.nimbusListRoundedBottomCornerBehavior) private var bottomCorner
    @Environment(\.nimbusListFixedHeightUntil) private var fixedHeight
    
    @State var items: [V]
    @State var selection: Set<V>

    private var hasFixedHeight: Bool {
        guard let fixedHeight else { return false }
        return totalHeight <= fixedHeight
    }
    
    private var totalHeight: CGFloat {
//        let margins = contentMarginsTop + contentMarginsBottom
//        return CGFloat(max(1, items.count)) * itemHeight + margins
        return 0
    }
    
    var body: some View {
        let roundedTop = topCorner.isRounded(
            hasFixedHeight: hasFixedHeight)
        let roundedBottom = bottomCorner.isRounded(
            hasFixedHeight: hasFixedHeight)
        
//        ListItem(
//            items: $items,
//            selection: $selection,
//            item: $items.last!,
//            firstItem: $items.first,
//            lastItem: $items.last,
//            roundedTop: roundedTop,
//            roundedBottom: roundedBottom
//        ) { value in
//                Text("\(value.wrappedValue)")
//            }
//        )
        EmptyView()
    }
}

#Preview {
    ListItemPreview(items: [1, 2, 3], selection: [2])
        .padding()
}
