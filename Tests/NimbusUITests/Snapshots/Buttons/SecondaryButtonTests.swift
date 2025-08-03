//
//  PrimaryButtonTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import Testing
import SwiftUI
@testable import NimbusUI
import SnapshotTesting

private let recording = false

@MainActor
@Test func secondaryButtons() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                SecondaryButtonVariants()
            }
            .environment(\.nimbusTheme, NimbusTheme())
        ),
        as: .image,
        record: recording
    )
}

fileprivate struct SecondaryButtonVariants: View {
    var body: some View {
        VStack(spacing: 24) {
            // MARK: - ControlSize Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("ControlSize Variations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    Button("Large Primary") {}
                        .buttonStyle(.secondary)
                        .controlSize(.large)
                    
                    Button("Regular Primary") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                    
                    Button("Small Primary") {}
                        .buttonStyle(.secondary)
                        .controlSize(.small)
                    
                    Button("Mini Primary") {}
                        .buttonStyle(.secondary)
                        .controlSize(.mini)
                }
            }
            
            // MARK: - Enhanced Button + Label API
            VStack(alignment: .leading, spacing: 12) {
                Text("Enhanced Button + Label API")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    // Plain text button (baseline)
                    Button("Plain Text Button") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                    
                    // Label with divider
                    Button(action: {}) {
                        Label("Save Document", systemImage: "doc.badge.plus")
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    
                    // Label without divider
                    Button(action: {}) {
                        Label("Export PDF", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, false)
                    
                    // Icon alignment: trailing
                    Button(action: {}) {
                        Label("Next Step", systemImage: "arrow.right")
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    .environment(\.nimbusButtonIconAlignment, .trailing)
                    
                    // Custom content padding
                    Button(action: {}) {
                        Label("Custom Padding", systemImage: "square.grid.2x2")
                    }
                    .buttonStyle(.secondary)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    .environment(\.nimbusButtonContentPadding, 16)
                }
            }
            
            // MARK: - Aspect Ratio System
            VStack(alignment: .leading, spacing: 12) {
                Text("Aspect Ratio System")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Square button (ideal for icons)
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusAspectRatio, 1.0)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                        
                        Button(action: {}) {
                            Image(systemName: "play.fill")
                        }
                        .buttonStyle(.secondary)
                        .controlSize(.small)
                        .environment(\.nimbusAspectRatio, 1.0)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                    }
                    
                    // Wide banner button
                    Button("Get Started - Call to Action") {}
                        .buttonStyle(.secondary)
                        .controlSize(.large)
                        .environment(\.nimbusAspectRatio, 3.0)
                        .environment(\.nimbusAspectRatioHasFixedHeight, true)
                    
                    // Custom ratio with flexible height
                    Button("Flexible Height") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusAspectRatio, 2.5)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                        .environment(\.nimbusAspectRatioHasFixedHeight, false)
                }
            }
            
            // MARK: - Environment Overrides
            VStack(alignment: .leading, spacing: 12) {
                Text("Environment Overrides")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    // Custom corner radii
                    Button("Custom Corner Radii") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
                    
                    // Custom height
                    Button("Custom Height") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusMinHeight, 60)
                    
                    // Custom horizontal padding
                    Button("Custom Padding") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusHorizontalPadding, 32)
                    
                    // Custom elevation
                    Button("High Elevation") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusElevation, .high)
                    
                    // Combined overrides
                    Button("Combined Overrides") {}
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(24))
                        .environment(\.nimbusMinHeight, 56)
                        .environment(\.nimbusHorizontalPadding, 28)
                        .environment(\.nimbusElevation, .medium)
                }
            }
            
            // MARK: - Interactive States
            VStack(alignment: .leading, spacing: 12) {
                Text("Interactive States")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Normal state
                        Button("Normal") {}
                            .buttonStyle(.secondary)
                            .controlSize(.regular)
                        
                        // Hover state
                        Button("Hover") {}
                            .buttonStyle(SecondaryButtonStyle(isHovering: true))
                            .controlSize(.regular)
                        
                        // Pressed state
                        Button("Pressed") {}
                            .buttonStyle(SecondaryButtonStyle(isPressed: true))
                            .controlSize(.regular)
                    }
                    
                    // Interactive states with labels
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Label("Normal", systemImage: "star.fill")
                        }
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                        
                        Button(action: {}) {
                            Label("Hover", systemImage: "star.fill")
                        }
                        .buttonStyle(SecondaryButtonStyle(isHovering: true))
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                        
                        Button(action: {}) {
                            Label("Pressed", systemImage: "star.fill")
                        }
                        .buttonStyle(SecondaryButtonStyle(isPressed: true))
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                    }
                }
            }
            
            // MARK: - Button States & Roles
            VStack(alignment: .leading, spacing: 12) {
                Text("Button States & Roles")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Enabled button
                        Button("Enabled") {}
                            .buttonStyle(.secondary)
                            .controlSize(.regular)
                        
                        // Disabled button
                        Button("Disabled") {}
                            .buttonStyle(.secondary)
                            .controlSize(.regular)
                            .disabled(true)
                    }
                    
                    HStack(spacing: 12) {
                        // Cancel role
                        Button("Cancel", role: .cancel) {}
                            .buttonStyle(.secondary)
                            .controlSize(.regular)
                        
                        // Destructive role
                        Button("Delete", role: .destructive) {}
                            .buttonStyle(.secondary)
                            .controlSize(.regular)
                    }
                    
                    // Combined: Label with role
                    HStack(spacing: 12) {
                        Button(role: .cancel) {
                            // Action
                        } label: {
                            Label("Cancel Upload", systemImage: "xmark.circle")
                        }
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                        
                        Button(role: .destructive) {
                            // Action
                        } label: {
                            Label("Delete File", systemImage: "trash")
                        }
                        .buttonStyle(.secondary)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                    }
                }
            }
        }
        .padding()
    }
}
