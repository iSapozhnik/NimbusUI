//
//  ListView.swift
//  NimbusUI
//
//  Created by Claude Code on 01.08.25.
//

import SwiftUI

/// A stylized list container that manages item collections and selection states.
public struct ListView<ContentA, ContentB, V, ID>: View
    where ContentA: View, ContentB: View, V: Hashable, ID: Hashable {
    
    // MARK: - Environment Values
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusListContentMarginsTop) private var overrideContentMarginsTop
    @Environment(\.nimbusListContentMarginsLeading) private var overrideContentMarginsLeading
    @Environment(\.nimbusListContentMarginsBottom) private var overrideContentMarginsBottom
    @Environment(\.nimbusListContentMarginsTrailing) private var overrideContentMarginsTrailing
    @Environment(\.nimbusListItemHeight) private var overrideItemHeight
    @Environment(\.nimbusListFixedHeightUntil) private var fixedHeight
    @Environment(\.nimbusListRoundedTopCornerBehavior) private var topCorner
    @Environment(\.nimbusListRoundedBottomCornerBehavior) private var bottomCorner
    @Environment(\.nimbusListScrollDisabled) private var scrollDisabled
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    
    // MARK: - Properties
    
    @Binding private var items: [V]
    @Binding private var selection: Set<V>
    private let keyPath: KeyPath<V, ID>

    @ViewBuilder private var content: (Binding<V>) -> ContentA
    @ViewBuilder private var emptyView: () -> ContentB

    @State private var firstItem: V?
    @State private var lastItem: V?
    
    private let id = UUID()
    
    // MARK: - Computed Properties
    
    private var contentMarginsTop: CGFloat {
        overrideContentMarginsTop ?? 0
    }
    
    private var contentMarginsLeading: CGFloat {
        overrideContentMarginsLeading ?? 0
    }
    
    private var contentMarginsBottom: CGFloat {
        overrideContentMarginsBottom ?? 0
    }
    
    private var contentMarginsTrailing: CGFloat {
        overrideContentMarginsTrailing ?? 0
    }
    
    private var itemHeight: CGFloat {
        overrideItemHeight ?? theme.listItemHeight
    }
    
    private var animationFast: Animation {
        overrideAnimationFast ?? theme.animationFast
    }

    private var totalHeight: CGFloat {
        let margins = contentMarginsTop + contentMarginsBottom
        return CGFloat(max(1, items.count)) * itemHeight + margins
    }

    private var hasFixedHeight: Bool {
        guard let fixedHeight else { return false }
        return totalHeight <= fixedHeight
    }
    
    // MARK: - Initializers

    /// Initializes a ``ListView``.
    ///
    /// - Parameters:
    ///   - items: the binding of the listed items.
    ///   - selection: the binding of the set of selected items.
    ///   - id: the key path for the identifiers of each element.
    ///   - content: the content generator that accepts a value binding.
    ///   - emptyView: the view to display when nothing is inside the list.
    public init(
        items: Binding<[V]>,
        selection: Binding<Set<V>>, 
        id keyPath: KeyPath<V, ID>,
        @ViewBuilder content: @escaping (Binding<V>) -> ContentA,
        @ViewBuilder emptyView: @escaping () -> ContentB
    ) {
        self._items = items
        self._selection = selection
        self.keyPath = keyPath
        self.content = content
        self.emptyView = emptyView
    }

    /// Initializes a ``ListView`` that displays literally nothing when nothing is inside the list.
    ///
    /// - Parameters:
    ///   - items: the binding of the listed items.
    ///   - selection: the binding of the set of selected items.
    ///   - id: the key path for the identifiers of each element.
    ///   - content: the content generator that accepts a value binding.
    public init(
        items: Binding<[V]>,
        selection: Binding<Set<V>>, 
        id keyPath: KeyPath<V, ID>,
        @ViewBuilder content: @escaping (Binding<V>) -> ContentA
    ) where ContentB == EmptyView {
        self.init(
            items: items,
            selection: selection, 
            id: keyPath,
            content: content
        ) {
            EmptyView()
        }
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if items.isEmpty {
                emptyView()
                    .foregroundStyle(theme.secondaryTextColor(for: colorScheme))
            } else {
                List(selection: $selection) {
                    if contentMarginsTop > 0 {
                        Spacer()
                            .frame(height: contentMarginsTop)
                    }

                    ForEach($items, id: keyPath) { item in
                        let roundedTop = topCorner.isRounded(hasFixedHeight: hasFixedHeight)
                        let roundedBottom = bottomCorner.isRounded(hasFixedHeight: hasFixedHeight)

                        ListItem(
                            items: $items,
                            selection: $selection,
                            item: item,
                            firstItem: $firstItem,
                            lastItem: $lastItem,
                            roundedTop: roundedTop,
                            roundedBottom: roundedBottom,
                            content: content
                        )
                    }
                    .onMove { indices, newOffset in
                        withAnimation(animationFast) {
                            items.move(
                                fromOffsets: indices,
                                toOffset: newOffset
                            )
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                    .padding(.horizontal, -10)
                    .padding(.leading, contentMarginsLeading)
                    .padding(.trailing, contentMarginsTrailing)

                    if contentMarginsBottom > 0 {
                        Spacer()
                            .frame(height: contentMarginsBottom)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDisabled(scrollDisabled || hasFixedHeight)
                .background(theme.backgroundColor(for: colorScheme))
            }
        }
        .frame(height: hasFixedHeight ? totalHeight : nil)
        .frame(maxHeight: hasFixedHeight ? nil : fixedHeight)
        .animation(animationFast, value: items)
        .animation(animationFast, value: selection)
        .onChange(of: items) { _ in
            guard !items.isEmpty else {
                selection = []
                return
            }

            selection = selection.intersection(items)
            processSelection()
        }
        .onChange(of: selection) { _ in
            processSelection()

            if selection.isEmpty {
                removeEventMonitor()
            } else {
                addEventMonitor()
            }
        }
        .onAppear {
            if !selection.isEmpty {
                addEventMonitor()
            }
        }
        .onDisappear {
            removeEventMonitor()
        }
    }

    // MARK: - Functions

    private func processSelection() {
        if items.isEmpty || selection.isEmpty {
            firstItem = nil
            lastItem = nil
        } else {
            firstItem = items.first { selection.contains($0) }
            lastItem = items.last { selection.contains($0) }
        }
    }

    private func addEventMonitor() {
        // Note: This would require implementing EventMonitorManager
        // For now, we'll use a simpler approach focusing on the core list functionality
    }

    private func removeEventMonitor() {
        // Note: This would require implementing EventMonitorManager
        // For now, we'll use a simpler approach focusing on the core list functionality
    }
}

// MARK: - Preview

private struct ListViewPreview: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var items = [
        "Dashboard Overview",
        "User Management", 
        "Analytics & Reports",
        "Settings & Configuration",
        "Billing & Subscriptions",
        "API Documentation",
        "Security & Permissions",
        "Notifications"
    ]
    @State private var selection: Set<String> = ["User Management", "Analytics & Reports"]
    
    @State private var emptyItems: [String] = []
    @State private var emptySelection: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Header
                Text("ListView Component Showcase")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Standard ListView
                VStack(alignment: .leading, spacing: 12) {
                    Text("Standard ListView")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    Text("Basic list with selection states and hover interactions")
                        .font(.caption)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    
                    ListView(
                        items: $items,
                        selection: $selection,
                        id: \.self
                    ) { itemBinding in
                        HStack {
                            Image(systemName: iconForItem(itemBinding.wrappedValue))
                                .foregroundColor(theme.accentColor(for: colorScheme))
                                .frame(width: 20)
                            
                            Text(itemBinding.wrappedValue)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            
                            Spacer()
                            
                            if selection.contains(itemBinding.wrappedValue) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(theme.successColor(for: colorScheme))
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 300)
                    .environment(\.nimbusListItemHighlightOnHover, true)
                    .environment(\.nimbusListRoundedTopCornerBehavior, .always)
                    .environment(\.nimbusListRoundedBottomCornerBehavior, .always)
                    
                    Text("Selected: \(selection.sorted().joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                }
                
                // Fixed Height ListView
                VStack(alignment: .leading, spacing: 12) {
                    Text("Fixed Height ListView")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    Text("List with fixed height, scrolling disabled when content fits")
                        .font(.caption)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    
                    ListView(
                        items: .constant(Array(items.prefix(4))),
                        selection: .constant(Set(["Dashboard Overview"])),
                        id: \.self
                    ) { itemBinding in
                        HStack {
                            Circle()
                                .fill(theme.accentColor(for: colorScheme))
                                .frame(width: 8, height: 8)
                            
                            Text(itemBinding.wrappedValue)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                    .environment(\.nimbusListFixedHeightUntil, 200)
                    .environment(\.nimbusListRoundedTopCornerBehavior, .fixedHeight)
                    .environment(\.nimbusListRoundedBottomCornerBehavior, .fixedHeight)
                    .background(theme.secondaryBackgroundColor(for: colorScheme))
                    .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                }
                
                // Empty State ListView
                VStack(alignment: .leading, spacing: 12) {
                    Text("Empty State ListView")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    Text("Demonstrates custom empty view when no items are present")
                        .font(.caption)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    
                    ListView(
                        items: $emptyItems,
                        selection: $emptySelection,
                        id: \.self,
                        content: { itemBinding in
                            Text(itemBinding.wrappedValue)
                                .padding(.horizontal, 16)
                        },
                        emptyView: {
                            VStack(spacing: 16) {
                                Image(systemName: "tray")
                                    .font(.system(size: 32))
                                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                                VStack(spacing: 4) {
                                    Text("No items available")
                                        .font(.headline)
                                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                                    Text("Add some items to see them here")
                                        .font(.caption)
                                        .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                                }
                                
                            }
                            .padding(40)
                        }
                    )
                    .frame(height: 200)
                    .background(theme.secondaryBackgroundColor(for: colorScheme))
                    .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadii.topLeading))
                }
                
                // Corner Behavior Showcase
                VStack(alignment: .leading, spacing: 12) {
                    Text("Corner Behavior Showcase")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    Text("Different corner rounding behaviors based on height constraints")
                        .font(.caption)
                        .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                    
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Text("Always Rounded")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            
                            ListView(
                                items: .constant(["Item 1", "Item 2"]),
                                selection: .constant(Set<String>()),
                                id: \.self
                            ) { itemBinding in
                                Text(itemBinding.wrappedValue)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                            }
                            .frame(height: 100)
                            .environment(\.nimbusListRoundedTopCornerBehavior, .always)
                            .environment(\.nimbusListRoundedBottomCornerBehavior, .always)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Never Rounded")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            
                            ListView(
                                items: .constant(["Item 1", "Item 2"]),
                                selection: .constant(Set<String>()),
                                id: \.self
                            ) { itemBinding in
                                Text(itemBinding.wrappedValue)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                            }
                            .frame(height: 100)
                            .environment(\.nimbusListRoundedTopCornerBehavior, .never)
                            .environment(\.nimbusListRoundedBottomCornerBehavior, .never)
                            .background(theme.secondaryBackgroundColor(for: colorScheme))
                        }
                        
                        VStack(spacing: 8) {
                            Text("Fixed Height Only")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            
                            ListView(
                                items: .constant(["Item 1", "Item 2"]),
                                selection: .constant(Set<String>()),
                                id: \.self
                            ) { itemBinding in
                                Text(itemBinding.wrappedValue)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                            }
                            .environment(\.nimbusListFixedHeightUntil, 150)
                            .environment(\.nimbusListRoundedTopCornerBehavior, .fixedHeight)
                            .environment(\.nimbusListRoundedBottomCornerBehavior, .fixedHeight)
                        }
                    }
                }
                
                // Feature Summary
                VStack(alignment: .leading, spacing: 8) {
                    Text("ListView Features")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        FeatureBullet("Multi-selection support with visual feedback")
                        FeatureBullet("Hover interactions with theme-aware colors")
                        FeatureBullet("Flexible corner radius behavior based on height")
                        FeatureBullet("Custom empty state views")
                        FeatureBullet("Fixed and variable height modes")
                        FeatureBullet("Drag-to-reorder support (when enabled)")
                        FeatureBullet("Full theme integration with environment overrides")
                        FeatureBullet("Content margins and scroll control")
                    }
                }
            }
            .padding(32)
        }
        .background(theme.backgroundColor(for: colorScheme))
    }
    
    private func iconForItem(_ item: String) -> String {
        switch item {
        case "Dashboard Overview": return "chart.bar.doc.horizontal"
        case "User Management": return "person.2"
        case "Analytics & Reports": return "chart.line.uptrend.xyaxis"
        case "Settings & Configuration": return "gearshape"
        case "Billing & Subscriptions": return "creditcard"
        case "API Documentation": return "doc.text"
        case "Security & Permissions": return "lock.shield"
        case "Notifications": return "bell"
        default: return "circle"
        }
    }
}

private struct FeatureBullet: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Text("•")
                .foregroundColor(theme.accentColor(for: colorScheme))
                .fontWeight(.medium)
            
            Text(text)
                .font(.caption)
                .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview("NimbusTheme") {
    ListViewPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("MaritimeTheme") {
    ListViewPreview()
        .fixedSize()
        .environment(\.nimbusTheme, MaritimeTheme())
}

#Preview("CustomWarmTheme") {
    ListViewPreview()
        .environment(\.nimbusTheme, CustomWarmTheme())
}
