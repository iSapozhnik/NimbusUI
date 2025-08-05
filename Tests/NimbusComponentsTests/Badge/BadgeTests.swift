//
//  BadgeTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func badgeVariants() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                BadgeVariantsView()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func primaryBadgeSemanticTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        PrimaryBadge("Info", semanticType: .info)
                        PrimaryBadge("Success", semanticType: .success)
                        PrimaryBadge("Warning", semanticType: .warning)
                        PrimaryBadge("Error", semanticType: .error)
                    }
                    
                    HStack(spacing: 12) {
                        PrimaryBadge("New", systemImage: "star.fill", semanticType: .info)
                        PrimaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                        PrimaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                        PrimaryBadge("Failed", systemImage: "xmark.circle.fill", semanticType: .error)
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func secondaryBadgeSemanticTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        SecondaryBadge("Info", semanticType: .info)
                        SecondaryBadge("Success", semanticType: .success)
                        SecondaryBadge("Warning", semanticType: .warning)
                        SecondaryBadge("Error", semanticType: .error)
                    }
                    
                    HStack(spacing: 12) {
                        SecondaryBadge("New", systemImage: "star.fill", semanticType: .info)
                        SecondaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                        SecondaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                        SecondaryBadge("Failed", systemImage: "xmark.circle.fill", semanticType: .error)
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func badgeControlSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Primary badges
                    VStack(spacing: 8) {
                        Text("Primary Badges")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            PrimaryBadge("Large", semanticType: .info)
                                .controlSize(.large)
                            PrimaryBadge("Regular", semanticType: .success)
                                .controlSize(.regular)
                            PrimaryBadge("Small", semanticType: .warning)
                                .controlSize(.small)
                            PrimaryBadge("Mini", semanticType: .error)
                                .controlSize(.mini)
                        }
                    }
                    
                    // Secondary badges
                    VStack(spacing: 8) {
                        Text("Secondary Badges")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            SecondaryBadge("Large", semanticType: .info)
                                .controlSize(.large)
                            SecondaryBadge("Regular", semanticType: .success)
                                .controlSize(.regular)
                            SecondaryBadge("Small", semanticType: .warning)
                                .controlSize(.small)
                            SecondaryBadge("Mini", semanticType: .error)
                                .controlSize(.mini)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func badgeTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Primary badges
                    VStack(spacing: 8) {
                        Text("Primary Badge Types")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            PrimaryBadge("Capsule", semanticType: .info)
                                .capsule()
                            PrimaryBadge("Round 4", semanticType: .success)
                                .roundedRect(4)
                            PrimaryBadge("Round 8", semanticType: .warning)
                                .roundedRect(8)
                            PrimaryBadge("Round 12", semanticType: .error)
                                .roundedRect(12)
                        }
                    }
                    
                    // Secondary badges
                    VStack(spacing: 8) {
                        Text("Secondary Badge Types")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            SecondaryBadge("Capsule", semanticType: .info)
                                .capsule()
                            SecondaryBadge("Round 4", semanticType: .success)
                                .roundedRect(4)
                            SecondaryBadge("Round 8", semanticType: .warning)
                                .roundedRect(8)
                            SecondaryBadge("Round 12", semanticType: .error)
                                .roundedRect(12)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func badgeCustomizations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Border width variations (secondary only)
                    VStack(spacing: 8) {
                        Text("Border Width (Secondary)")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            SecondaryBadge("1px", semanticType: .info)
                                .borderWidth(1)
                            SecondaryBadge("2px", semanticType: .success)
                                .borderWidth(2)
                            SecondaryBadge("3px", semanticType: .warning)
                                .borderWidth(3)
                        }
                    }
                    
                    // Content padding variations
                    VStack(spacing: 8) {
                        Text("Content Padding")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            PrimaryBadge("Default", semanticType: .info)
                            PrimaryBadge("Tight", semanticType: .success)
                                .contentPadding(2)
                            PrimaryBadge("Spacious", semanticType: .warning)
                                .contentPadding(16)
                            PrimaryBadge("Custom", semanticType: .error)
                                .contentPadding(top: 8, leading: 20, bottom: 8, trailing: 20)
                        }
                    }
                    
                    // Long text
                    VStack(spacing: 8) {
                        Text("Long Text Adaptation")
                            .font(.headline)
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("This is a very long badge text", semanticType: .info)
                                .capsule()
                            SecondaryBadge("Another long text example", semanticType: .success)
                                .roundedRect(8)
                                .borderWidth(1.5)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}
