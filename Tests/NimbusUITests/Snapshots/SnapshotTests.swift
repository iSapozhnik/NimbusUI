//
//  SnapshotTests.swift
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

@MainActor
@Test func showcaseMaritimeTheme() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView()
                .environment(\.nimbusTheme, MaritimeTheme())
        ),
        as: .image,
        record: recording
    )
}

// MARK: SecondaryBorderedButtonStyle
@MainActor
@Test func showcaseSecondaryBorderedButtonStyle() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ThemedSecondaryBorderedButtonStylePreview()
                .environment(\.nimbusTheme, NimbusTheme())
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
                    .foregroundStyle(.primary)
                CustomThemeContentView()
                    .environment(\.colorScheme, .light)
            }
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                CustomThemeContentView()
                    .environment(\.colorScheme, .dark)
            }
        }
        .padding()
        .background(.black)
    }
}

struct ThemedSecondaryBorderedButtonStylePreview: View {
    var body: some View {
        HStack {
            VStack {
                Text("Light Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                SecondaryBorderedButtonStylePreview()
                    .environment(\.colorScheme, .light)
            }
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                SecondaryBorderedButtonStylePreview()
                    .environment(\.colorScheme, .dark)
            }
        }
        .padding()
        .background(.black)
    }
}

struct MaritimeShowcaseView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Light Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                MaritimeThemeContentView()
                    .environment(\.colorScheme, .light)
            }
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                MaritimeThemeContentView()
                    .environment(\.colorScheme, .dark)
            }
        }
        .padding()
        .background(.black)
    }
}

fileprivate enum SnapshotUtility<Content> where Content: View {

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
