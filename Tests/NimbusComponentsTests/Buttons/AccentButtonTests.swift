//
//  AccentButtonTests.swift
//  NimbusUI
//
//  Created by Claude on 04.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func accentButtons() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                AccentButtonVariants.create()
            }
            .environment(\.nimbusTheme, NimbusTheme())
        ),
        as: .image,
        record: recording
    )
}