//
//  PrimaryButtonTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func secondaryButtons() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                SecondaryButtonVariants.create()
            }
            .environment(\.nimbusTheme, NimbusTheme())
        ),
        as: .image,
        record: recording
    )
}

