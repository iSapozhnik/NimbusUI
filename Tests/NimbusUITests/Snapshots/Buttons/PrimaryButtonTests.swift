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