//
//  ListItem+Preview.swift
//  NimbusUI
//
//  Created by Claude on 02.08.25.
//

import SwiftUI

// MARK: - Previews

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
        return 0
    }
    
    var body: some View {
        let roundedTop = topCorner.isRounded(
            hasFixedHeight: hasFixedHeight)
        let roundedBottom = bottomCorner.isRounded(
            hasFixedHeight: hasFixedHeight)
        
        EmptyView()
    }
}

#Preview {
    ListItemPreview(items: [1, 2, 3], selection: [2])
        .padding()
}