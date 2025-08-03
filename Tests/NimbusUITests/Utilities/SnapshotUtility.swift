//
//  SnapshotUtility.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

enum SnapshotUtility<Content> where Content: View {

    static func view(from content: Content, colorScheme: ColorScheme) -> NSView {
        let nsView = NSHostingView(
            rootView: content
                .environment(\.colorScheme, colorScheme)
                .fixedSize()
        )
        nsView.layoutSubtreeIfNeeded()
        nsView.frame = NSRect(origin: .zero, size: nsView.fittingSize)
        return nsView
    }
    
    static func view(from content: Content) -> NSView {
        let nsView = NSHostingView(
            rootView: content
                .fixedSize()
        )
        nsView.layoutSubtreeIfNeeded()
        nsView.frame = NSRect(origin: .zero, size: nsView.fittingSize)
        return nsView
    }
}
