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

@MainActor
@Test func showcaseNimbusDefaultLightMode() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: CustomThemeContentView()
                .environment(\.nimbusTheme, NimbusTheme()),
            colorScheme: .light
        ),
        as: .image(perceptualPrecision: 0.9),
        record: false
    )
}

@MainActor
@Test func showcaseNimbusDefaultDarkMode() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: CustomThemeContentView()
                .environment(\.nimbusTheme, NimbusTheme()),
            colorScheme: .dark
        ),
        as: .image(perceptualPrecision: 0.9),
        record: false
    )
}

@MainActor
@Test func showcaseWarmThemeLightMode() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: CustomThemeContentView()
                .environment(\.nimbusTheme, CustomWarmTheme()),
            colorScheme: .light
        ),
        as: .image(perceptualPrecision: 0.9),
        record: false
    )
}

@MainActor
@Test func showcaseWarmThemeDarkMode() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: CustomThemeContentView()
                .environment(\.nimbusTheme, CustomWarmTheme()),
            colorScheme: .dark
        ),
        as: .image(perceptualPrecision: 0.9),
        record: false
    )
}

fileprivate enum SnapshotUtility<Content> where Content: View {

    @MainActor
    static func view(from content: Content, colorScheme: ColorScheme) -> NSView {
        let nsView = NSHostingView(
            rootView: content
                .environment(\.colorScheme, colorScheme)
                .frame(minWidth:480, minHeight: 300)
                .fixedSize()
        )
        nsView.layoutSubtreeIfNeeded()
        nsView.isFlipped = true
        let fittingSize = nsView.fittingSize
        nsView.frame = NSRect(origin: .zero, size: fittingSize)
        return nsView
    }
}
