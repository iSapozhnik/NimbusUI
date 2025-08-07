//
//  TextFieldTests.swift
//  NimbusUI
//
//  Created by AI Assistant on 07.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func textFieldBasic() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    NimbusTextField("Name", text: .constant("John Doe"))
                    
                    NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter your email"))
                    
                    NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
                    
                    NimbusTextField("Disabled", text: .constant("Cannot edit"))
                        .disabled(true)
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
@Test func textFieldControlSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("ControlSize Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Extra Large", text: .constant("Sample Text"))
                                .controlSize(.extraLarge)
                            
                            NimbusTextField("Large", text: .constant("Sample Text"))
                                .controlSize(.large)
                            
                            NimbusTextField("Regular", text: .constant("Sample Text"))
                                .controlSize(.regular)
                            
                            NimbusTextField("Small", text: .constant("Sample Text"))
                                .controlSize(.small)
                            
                            NimbusTextField("Mini", text: .constant("Sample Text"))
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
@Test func textFieldStylingVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Styling Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Default", text: .constant("With border and background"))
                            
                            NimbusTextField("No Border", text: .constant("Background only"))
                                .bordered(false)
                            
                            NimbusTextField("No Background", text: .constant("Border only"))
                                .hasBackground(false)
                            
                            NimbusTextField("Plain", text: .constant("No styling"))
                                .bordered(false)
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
@Test func textFieldCustomizations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Padding variations
                    VStack(spacing: 8) {
                        Text("Content Padding")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Default", text: .constant("Default padding"))
                            
                            NimbusTextField("Compact", text: .constant("Tight padding"))
                                .contentPadding(4)
                            
                            NimbusTextField("Spacious", text: .constant("Extra padding"))
                                .contentPadding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        }
                    }
                    
                    // Border and corner variations
                    VStack(spacing: 8) {
                        Text("Border & Corner Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Thick Border", text: .constant("2px border"))
                                .borderWidth(2)
                            
                            NimbusTextField("Rounded", text: .constant("Custom corners"))
                                .cornerRadii(RectangleCornerRadii(12))
                            
                            NimbusTextField("Tall Field", text: .constant("Custom height"))
                                .minHeight(60)
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
@Test func textFieldValueTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Value Types")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Price", text: .constant("$29.99"))
                            
                            NimbusTextField("Quantity", text: .constant("5"))
                            
                            NimbusTextField("Percentage", text: .constant("85%"))
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
@Test func textFieldThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        Text("Maritime Theme")
                            .font(.headline)
                        textFieldGrid
                            .environment(\.nimbusTheme, MaritimeTheme())
                    }
                    
                    VStack(spacing: 8) {
                        Text("Custom Warm Theme")
                            .font(.headline)
                        textFieldGrid
                            .environment(\.nimbusTheme, CustomWarmTheme())
                    }
                }
                .padding()
            }
        ),
        as: .image,
        record: recording
    )
}

private var textFieldGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter email"))
        
        NimbusTextField("Custom", text: .constant("Rounded corners"))
            .cornerRadii(RectangleCornerRadii(8))
    }
}