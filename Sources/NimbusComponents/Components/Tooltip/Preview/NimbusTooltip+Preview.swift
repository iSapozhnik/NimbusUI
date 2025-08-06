//
//  NimbusTooltip+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - NimbusTooltip Component Previews

#Preview("Tooltip - Basic Content") {
    VStack(spacing: 40) {
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
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Arrow Positioning Fixed") {
    VStack(spacing: 40) {
        Text("Arrow Positioning Fixes")
            .font(.title2)
            .fontWeight(.semibold)
        
        VStack(spacing: 48) {
            HStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Top")
                        .font(.caption)
                    NimbusTooltip("Arrow points down", position: .top)
                }
                
                VStack(spacing: 20) {
                    Text("Bottom")
                        .font(.caption)
                    NimbusTooltip("Arrow points up", position: .bottom)
                }
            }
            
            HStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Leading")
                        .font(.caption)
                    NimbusTooltip("Arrow points right", position: .leading)
                }
                
                VStack(spacing: 20) {
                    Text("Trailing")
                        .font(.caption)
                    NimbusTooltip("Arrow points left", position: .trailing)
                }
            }
        }
        
        VStack(spacing: 4) {
            Text("✅ Arrows FULLY visible outside tooltip background")
                .font(.caption)
                .foregroundColor(.green)
            Text("✅ No overlap - proper clearance maintained")
                .font(.caption)
                .foregroundColor(.green)
        }
        .multilineTextAlignment(.center)
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Dynamic Sizing & Improved Arrows") {
    VStack(spacing: 32) {
        Text("Dynamic Sizing & Wider Arrow Base")
            .font(.title2)
            .fontWeight(.semibold)
        
        VStack(spacing: 24) {
            // Short content - should have tight spacing
            NimbusTooltip("Short", position: .top)
            
            // Medium content - should size accordingly
            NimbusTooltip("Medium length tooltip text", position: .top)
            
            // Long content - should expand appropriately
            NimbusTooltip("This is a much longer tooltip that demonstrates dynamic sizing based on content", position: .top)
            
            // With icon - should account for icon space
            NimbusTooltip(
                title: "With Icon",
                subtitle: "Icon adds width",
                icon: Image(systemName: "star.fill"),
                position: .top
            )
        }
        
        VStack(spacing: 4) {
            Text("✅ Each tooltip sizes to its content")
                .font(.caption)
                .foregroundColor(.green)
            Text("✅ Arrows have wider base for better connection")
                .font(.caption)
                .foregroundColor(.green)
            Text("✅ Minimal spacing (10px total: 8px arrow + 2px buffer)")
                .font(.caption)
                .foregroundColor(.green)
        }
        .multilineTextAlignment(.center)
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Long Text") {
    VStack(spacing: 32) {
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
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Custom Styling") {
    VStack(spacing: 32) {
        NimbusTooltip("Custom Corner Radii", position: .top)
            .cornerRadii(RectangleCornerRadii(16))
        
        NimbusTooltip("High Elevation", position: .top)
            .elevation(.high)
        
        NimbusTooltip("Custom Padding", position: .top)
            .padding(20)
        
        NimbusTooltip("Large Arrow", position: .top)
            .arrowSize(16)
        
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
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Different Themes") {
    ScrollView {
        VStack(spacing: 48) {
            VStack(spacing: 8) {
                Text("Nimbus Theme")
                    .font(.headline)
                tooltipGrid
                    .environment(\.nimbusTheme, NimbusTheme.default)
            }
            
            VStack(spacing: 8) {
                Text("Maritime Theme")
                    .font(.headline)
                tooltipGrid
                    .environment(\.nimbusTheme, MaritimeTheme())
            }
            
            VStack(spacing: 8) {
                Text("Custom Warm Theme")
                    .font(.headline)
                tooltipGrid
                    .environment(\.nimbusTheme, CustomWarmTheme())
            }
        }
        .padding()
    }
}

private var tooltipGrid: some View {
    VStack(spacing: 24) {
        HStack(spacing: 32) {
            NimbusTooltip("Top", position: .top)
            NimbusTooltip("Bottom", position: .bottom)
        }
        
        HStack(spacing: 32) {
            NimbusTooltip("Leading", position: .leading)
            NimbusTooltip("Trailing", position: .trailing)
        }
        
        HStack(spacing: 32) {
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

#Preview("Tooltip - Color Scheme Variations") {
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
    .environment(\.nimbusTheme, NimbusTheme.default)
}