//
//  TooltipSnapshotTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func tooltipPositions() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 40) {
                    Text("Fixed Arrow Positioning")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 48) {
                        HStack(spacing: 40) {
                            VStack(spacing: 8) {
                                Text("Top - Arrow Down")
                                    .font(.caption)
                                NimbusTooltip("Arrow outside tooltip", position: .top)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Bottom - Arrow Up")
                                    .font(.caption)
                                NimbusTooltip("No overlap with edge", position: .bottom)
                            }
                        }
                        
                        HStack(spacing: 40) {
                            VStack(spacing: 8) {
                                Text("Leading - Arrow Right")
                                    .font(.caption)
                                NimbusTooltip("Correct positioning", position: .leading)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Trailing - Arrow Left")
                                    .font(.caption)
                                NimbusTooltip("Proper clearance", position: .trailing)
                            }
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
@Test func tooltipContentVariants() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    Text("Tooltip Content Variants")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 24) {
                        // Title only
                        NimbusTooltip("Basic tooltip", position: .top)
                        
                        // Title with subtitle
                        NimbusTooltip(
                            title: "Main Title",
                            subtitle: "Optional subtitle text",
                            position: .top
                        )
                        
                        // Title with icon
                        NimbusTooltip(
                            title: "With Icon",
                            icon: Image(systemName: "info.circle.fill"),
                            position: .top
                        )
                        
                        // Full content - title, subtitle, and icon
                        NimbusTooltip(
                            title: "Complete Tooltip",
                            subtitle: "This shows all content types together",
                            icon: Image(systemName: "star.fill"),
                            position: .top
                        )
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
@Test func tooltipCustomStyling() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    Text("Tooltip Custom Styling")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 20) {
                        // Default styling
                        NimbusTooltip("Default styling", position: .top)
                        
                        // Custom corner radii
                        NimbusTooltip("Custom corner radii", position: .top)
                            .cornerRadii(RectangleCornerRadii(16))
                        
                        // High elevation
                        NimbusTooltip("High elevation", position: .top)
                            .elevation(.high)
                        
                        // Custom padding
                        NimbusTooltip("Custom padding", position: .top)
                            .padding(20)
                        
                        // Large arrow
                        NimbusTooltip("Large arrow", position: .top)
                            .arrowSize(16)
                        
                        // Custom typography
                        NimbusTooltip(
                            title: "Custom Typography",
                            subtitle: "Modified font sizes",
                            position: .top
                        )
                        .typography(
                            titleWeight: Font.Weight.bold,
                            subtitleWeight: Font.Weight.regular,
                            titleSize: 16,
                            subtitleSize: 11
                        )
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
@Test func tooltipLongText() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    Text("Tooltip Long Text")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 24) {
                        NimbusTooltip(
                            "This is a very long tooltip text that demonstrates how the tooltip handles text wrapping within the maximum width constraints",
                            position: .top
                        )
                        
                        NimbusTooltip(
                            title: "Long Title Example",
                            subtitle: "This subtitle demonstrates how longer text content is handled within the tooltip layout system, ensuring proper readability and formatting",
                            icon: Image(systemName: "text.alignleft"),
                            position: .bottom
                        )
                        
                        // Custom max width
                        NimbusTooltip(
                            title: "Custom Width",
                            subtitle: "This tooltip has a custom maximum width setting",
                            position: .top
                        )
                        .maxWidth(180)
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
@Test func tooltipThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                ScrollView {
                    VStack(spacing: 40) {
                        Text("Tooltip Theme Variations")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 32) {
                            VStack(spacing: 16) {
                                Text("Nimbus Theme")
                                    .font(.headline)
                                tooltipThemeGrid
                                    .environment(\.nimbusTheme, NimbusTheme.default)
                            }
                            
                            VStack(spacing: 16) {
                                Text("Maritime Theme")
                                    .font(.headline)
                                tooltipThemeGrid
                                    .environment(\.nimbusTheme, MaritimeTheme())
                            }
                            
                            VStack(spacing: 16) {
                                Text("Custom Warm Theme")
                                    .font(.headline)
                                tooltipThemeGrid
                                    .environment(\.nimbusTheme, CustomWarmTheme())
                            }
                        }
                    }
                    .padding()
                }
            }
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func tooltipColorSchemes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 40) {
                    Text("Tooltip Color Schemes")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 32) {
                        VStack(spacing: 16) {
                            Text("Light Mode")
                                .font(.headline)
                            
                            HStack(spacing: 24) {
                                NimbusTooltip("Light Mode", position: .top)
                                NimbusTooltip(
                                    title: "With Content",
                                    subtitle: "Light appearance",
                                    icon: Image(systemName: "sun.max.fill"),
                                    position: .bottom
                                )
                            }
                        }
                        .preferredColorScheme(.light)
                        .padding()
                        .background(.regularMaterial)
                        
                        VStack(spacing: 16) {
                            Text("Dark Mode")
                                .font(.headline)
                            
                            HStack(spacing: 24) {
                                NimbusTooltip("Dark Mode", position: .top)
                                NimbusTooltip(
                                    title: "With Content",
                                    subtitle: "Dark appearance",
                                    icon: Image(systemName: "moon.fill"),
                                    position: .bottom
                                )
                            }
                        }
                        .preferredColorScheme(.dark)
                        .padding()
                        .background(.regularMaterial)
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
@Test func tooltipSpacingAndSizing() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    Text("Tooltip Spacing & Sizing")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 20) {
                        // Different content spacing
                        NimbusTooltip(
                            title: "Tight Spacing",
                            subtitle: "Content spacing: 1",
                            icon: Image(systemName: "arrow.up.and.down.and.arrow.left.and.right"),
                            position: .top
                        )
                        .contentSpacing(1)
                        
                        // Different icon spacing
                        NimbusTooltip(
                            title: "Wide Icon Spacing",
                            subtitle: "Icon spacing: 16",
                            icon: Image(systemName: "arrow.left.and.right"),
                            position: .top
                        )
                        .iconSpacing(16)
                        
                        // Different icon size
                        NimbusTooltip(
                            title: "Large Icon",
                            subtitle: "Icon size: 24",
                            icon: Image(systemName: "star.fill"),
                            position: .top
                        )
                        .iconSize(24)
                        
                        // Combined customizations
                        NimbusTooltip(
                            title: "Combined Customization",
                            subtitle: "Custom spacing and sizing",
                            icon: Image(systemName: "gear"),
                            position: .top
                        )
                        .iconSize(20)
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

// MARK: - Helper Views

private var tooltipThemeGrid: some View {
    VStack(spacing: 16) {
        HStack(spacing: 24) {
            NimbusTooltip("Top", position: .top)
            NimbusTooltip("Bottom", position: .bottom)
        }
        
        HStack(spacing: 24) {
            NimbusTooltip("Leading", position: .leading)
            NimbusTooltip("Trailing", position: .trailing)
        }
        
        HStack(spacing: 24) {
            NimbusTooltip(
                title: "With Icon",
                icon: Image(systemName: "info.circle.fill"),
                position: .top
            )
            
            NimbusTooltip(
                title: "Full Content",
                subtitle: "With subtitle",
                icon: Image(systemName: "star.fill"),
                position: .bottom
            )
        }
    }
}

@MainActor
@Test func tooltipNoOverlapDemo() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
                    Text("No Overlap Verification")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 48) {
                        // Demonstrate tooltips appearing clearly above/below/beside elements
                        HStack(spacing: 32) {
                            Rectangle()
                                .fill(.blue)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    NimbusTooltip("Above - no overlap", position: .top)
                                }
                            
                            Rectangle()
                                .fill(.green)
                                .frame(width: 60, height: 30)
                                .overlay {
                                    NimbusTooltip("Below - clear space", position: .bottom)
                                }
                        }
                        
                        HStack(spacing: 80) {
                            Rectangle()
                                .fill(.orange)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    NimbusTooltip("Left side", position: .leading)
                                }
                            
                            Rectangle()
                                .fill(.purple)
                                .frame(width: 40, height: 40)
                                .overlay {
                                    NimbusTooltip("Right side", position: .trailing)
                                }
                        }
                    }
                    
                    Text("All tooltips should appear with proper clearance from their anchor views")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}