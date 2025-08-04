//
//  SnapshotTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 01.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting
import XCTest
import Foundation
import AppKit

private let recording = false

// MARK: - Theme Showcase Tests
// These tests use the unified ThemeShowcase to ensure consistent presentation across all themes

@MainActor
@Test func showcaseNimbusTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ThemeShowcase()
            }
            .environment(\.nimbusTheme, NimbusTheme())
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func showcaseCustomWarmTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ThemeShowcase()
            }
            .environment(\.nimbusTheme, CustomWarmTheme())
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func showcaseMaritimeTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ThemeShowcase()
            }
            .environment(\.nimbusTheme, MaritimeTheme())
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func showcaseMinimalTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ThemeShowcase()
            }
            .environment(\.nimbusTheme, MinimalTheme())
        ),
        as: .image,
        record: recording
    )
}

// MARK: - Component-Specific Tests
// These tests focus on specific component functionality rather than theme showcases
//@MainActor
//@Test func showcaseSecondaryOutlineButtonStyle() async throws {
//    assertSnapshot(
//        of: SnapshotUtility.view(
//            from: ThemedSecondaryOutlineButtonStylePreview()
//                .environment(\.nimbusTheme, NimbusTheme())
//        ),
//        as: .image,
//        record: recording
//    )
//}


struct SecondaryOutlineButtonStylePreview: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("ControlSize Variations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    Button("Large Secondary Outline") {}
                        .buttonStyle(.secondaryOutline)
                        .controlSize(.large)
                    
                    Button("Regular Secondary Outline") {}
                        .buttonStyle(.secondaryOutline)
                        .controlSize(.regular)
                    
                    Button("Small Secondary Outline") {}
                        .buttonStyle(.secondaryOutline)
                        .controlSize(.small)
                    
                    Button("Mini Secondary Outline") {}
                        .buttonStyle(.secondaryOutline)
                        .controlSize(.mini)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Enhanced Button API")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    Button(action: {}) {
                        Label("Settings", systemImage: "gear")
                    }
                    .buttonStyle(.secondaryOutline)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    
                    Button(action: {}) {
                        Label("Export", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.secondaryOutline)
                    .controlSize(.small)
                    .environment(\.nimbusButtonHasDivider, false)
                    .environment(\.nimbusButtonIconAlignment, .trailing)
                }
            }
        }
        .padding()
    }
}

struct ThemedSecondaryOutlineButtonStylePreview: View {
    var body: some View {
        HStack {
            VStack {
                Text("Light Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                SecondaryOutlineButtonStylePreview()
                    .environment(\.colorScheme, .light)
            }
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                SecondaryOutlineButtonStylePreview()
                    .environment(\.colorScheme, .dark)
            }
        }
        .padding()
        .background(.black)
    }
}

// Note: MaritimeShowcaseView removed - now using unified ThemeShowcase for all theme testing
