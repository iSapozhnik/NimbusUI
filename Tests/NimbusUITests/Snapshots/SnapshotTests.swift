//
//  File.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 01.08.25.
//

import Testing
import SwiftUI
@testable import NimbusUI
import SnapshotTesting
import XCTest
import Foundation
import AppKit

private let recording = false

@MainActor
@Test func showcaseNimbusTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView()
                .environment(\.nimbusTheme, NimbusTheme())
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func showcaseWarmTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView()
                .environment(\.nimbusTheme, CustomWarmTheme())
        ),
        as: .image,
        record: recording
    )
}

struct ShowcaseView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Light Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                CustomThemeContentView()
                    .environment(\.colorScheme, .light)
            }
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                CustomThemeContentView()
                    .environment(\.colorScheme, .dark)
            }
        }
    }
}

fileprivate enum SnapshotUtility<Content> where Content: View {

    @MainActor
    static func view(from content: Content, colorScheme: ColorScheme) -> NSView {
        let nsView = NSHostingView(
            rootView: content
                .environment(\.colorScheme, colorScheme)
                .fixedSize()
        )
        nsView.layoutSubtreeIfNeeded()
        nsView.isFlipped = true
        let fittingSize = nsView.fittingSize
        nsView.frame = NSRect(origin: .zero, size: fittingSize)
        return nsView
    }
    
    @MainActor
    static func view(from content: Content) -> NSView {
        let nsView = NSHostingView(
            rootView: content
                .fixedSize()
        )
        nsView.layoutSubtreeIfNeeded()
        nsView.isFlipped = true
        let fittingSize = nsView.fittingSize
        nsView.frame = NSRect(origin: .zero, size: fittingSize)
        return nsView
    }
}
