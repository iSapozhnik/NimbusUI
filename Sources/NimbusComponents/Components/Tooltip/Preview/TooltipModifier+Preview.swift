//
//  TooltipModifier+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Tooltip Modifier Usage Previews

#Preview("Tooltip - Hover Examples") {
    VStack(spacing: 32) {
        Text("Hover Examples")
            .font(.title2)
            .fontWeight(.semibold)
        
        VStack(spacing: 24) {
            // Simple text tooltip
            Button("Hover for simple tooltip") {
                print("Button tapped")
            }
            .buttonStyle(.primary)
            .nimbusTooltip("This is a simple tooltip")
            
            // Tooltip with subtitle
            Button("Hover for detailed tooltip") {
                print("Button tapped")
            }
            .buttonStyle(.secondary)
            .nimbusTooltip(
                "Main Information",
                subtitle: "Additional details about this action"
            )
            
            // Tooltip with icon
            Button("Hover for icon tooltip") {
                print("Button tapped")
            }
            .buttonStyle(.accent)
            .nimbusTooltip(
                "Save Document",
                icon: Image(systemName: "doc.badge.plus"),
                position: .bottom
            )
            
            // Full tooltip with all content
            Button("Hover for complete tooltip") {
                print("Button tapped")
            }
            .buttonStyle(.primaryOutline)
            .nimbusTooltip(
                "Complete Action",
                subtitle: "This will complete all pending tasks in the background",
                icon: Image(systemName: "checkmark.circle.fill"),
                position: .top
            )
        }
        
        Spacer()
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Manual Control") {
    struct TooltipControlDemo: View {
        @State private var showTooltip = false
        @State private var showInfoTooltip = false
        
        var body: some View {
            VStack(spacing: 32) {
                Text("Manual Control Examples")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack(spacing: 24) {
                    // Manually controlled tooltip
                    Button("Toggle Tooltip") {
                        showTooltip.toggle()
                    }
                    .buttonStyle(.primary)
                    .nimbusTooltip(
                        isPresented: $showTooltip,
                        title: "Manually Controlled",
                        subtitle: "This tooltip is controlled by binding"
                    )
                    
                    // Another manual tooltip
                    Button("Show Info Tooltip") {
                        showInfoTooltip = true
                    }
                    .buttonStyle(.secondary)
                    .nimbusTooltip(
                        isPresented: $showInfoTooltip,
                        title: "Information",
                        subtitle: "This tooltip appears when button is pressed",
                        icon: Image(systemName: "info.circle"),
                        position: .bottom,
                        onDismiss: {
                            showInfoTooltip = false
                        }
                    )
                    
                    Text("Tooltip is \(showTooltip ? "visible" : "hidden")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    return TooltipControlDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Adaptive Positioning Demo") {
    struct AdaptivePositioningDemo: View {
        @State private var showTooltip1 = false
        @State private var showTooltip2 = false
        @State private var showTooltip3 = false
        @State private var showTooltip4 = false
        
        var body: some View {
            VStack(spacing: 32) {
                Text("Adaptive Positioning & Content Width Fixes")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text("These tooltips automatically choose the best position to avoid content overlap and size to their content width")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 40) {
                    // Example from the original issue - should now appear above
                    VStack(spacing: 8) {
                        Button("Toggle Manual Tooltip") {
                            showTooltip1.toggle()
                        }
                        .buttonStyle(.primary)
                        .nimbusTooltip(
                            isPresented: $showTooltip1,
                            title: "Manually Controlled",
                            subtitle: "This tooltip is controlled by binding and should appear above to avoid hiding content below",
                            position: .bottom  // Requests bottom, but should adapt to top
                        )
                        
                        Text("Important content below that should NOT be hidden")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding()
                            .background(.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    // Wide content tooltip - should size to content width
                    VStack(spacing: 8) {
                        Button("Wide Content Test") {
                            showTooltip2.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 120) // Narrow button
                        .nimbusTooltip(
                            isPresented: $showTooltip2,
                            title: "Very Long Title That Should Not Be Constrained",
                            subtitle: "This subtitle text is much longer than the button width and should size to its content, not the button width",
                            position: .top
                        )
                        
                        Text("Button width: 120px, tooltip should be wider")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    
                    // Edge case - tooltip near screen edges
                    HStack {
                        // Left edge
                        Button("Left Edge") {
                            showTooltip3.toggle()
                        }
                        .buttonStyle(.accent)
                        .nimbusTooltip(
                            isPresented: $showTooltip3,
                            title: "Edge Positioning",
                            subtitle: "Should automatically choose trailing position",
                            position: .leading  // Requests leading, should adapt if no space
                        )
                        
                        Spacer()
                        
                        // Right edge  
                        Button("Right Edge") {
                            showTooltip4.toggle()
                        }
                        .buttonStyle(.primaryOutline)
                        .nimbusTooltip(
                            isPresented: $showTooltip4,
                            title: "Right Edge Test",
                            subtitle: "Should automatically choose leading position",
                            position: .trailing  // Requests trailing, should adapt if no space
                        )
                    }
                    .padding(.horizontal, 16)
                    
                    // Legend
                    VStack(alignment: .leading, spacing: 4) {
                        Text("✅ Adaptive positioning prevents content overlap")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text("✅ Content-based width sizing (not constrained to button)")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text("✅ Automatic position selection based on available space")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text("✅ Arrows point correctly for adapted positions")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    return AdaptivePositioningDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
        .adaptivePositioning(true) // Explicitly enable for this demo
}

#Preview("Tooltip - Comparison: Adaptive vs Fixed") {
    struct ComparisonDemo: View {
        @State private var showAdaptive = false
        @State private var showFixed = false
        
        var body: some View {
            VStack(spacing: 40) {
                Text("Adaptive vs Fixed Positioning Comparison")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 60) {
                    VStack(spacing: 16) {
                        Text("Fixed Position")
                            .font(.headline)
                            .foregroundColor(.red)
                        
                        Button("Test Bottom Position") {
                            showFixed.toggle()
                        }
                        .buttonStyle(.primary)
                        .adaptivePositioning(false) // Disable adaptive positioning
                        .nimbusTooltip(
                            isPresented: $showFixed,
                            title: "Fixed Position",
                            subtitle: "This tooltip stays at bottom position even if it overlaps content",
                            position: .bottom
                        )
                        
                        Text("Content below will be hidden ❌")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding()
                            .background(.red.opacity(0.1))
                            .cornerRadius(4)
                    }
                    
                    VStack(spacing: 16) {
                        Text("Adaptive Position")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Button("Test Bottom Position") {
                            showAdaptive.toggle()
                        }
                        .buttonStyle(.primary)
                        .adaptivePositioning(true) // Enable adaptive positioning
                        .nimbusTooltip(
                            isPresented: $showAdaptive,
                            title: "Adaptive Position", 
                            subtitle: "This tooltip automatically moves to top to avoid hiding content",
                            position: .bottom // Requests bottom, adapts to top
                        )
                        
                        Text("Content below stays visible ✅")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding()
                            .background(.green.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
                
                Text("Both tooltips request bottom position, but only the adaptive one chooses top to avoid overlap")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return ComparisonDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Different Positions on UI Elements") {
    VStack(spacing: 32) {
        Text("Tooltip Positions - No Overlap Demo")
            .font(.title2)
            .fontWeight(.semibold)
        
        VStack(spacing: 80) {
            // Top row - top tooltips (should appear above elements with clearance)
            HStack(spacing: 32) {
                Button("Top Button") { }
                    .buttonStyle(.primary)
                    .nimbusTooltip("Should appear ABOVE button", position: .top)
                
                Button("Test") { }
                    .buttonStyle(.secondary)
                    .nimbusTooltip("Arrow points down, fully visible", position: .top)
                
                Button("Demo") { }
                    .buttonStyle(.accent)
                    .nimbusTooltip("No overlap at all", position: .top)
            }
            
            // Middle row - side tooltips (should appear beside elements)
            HStack(spacing: 120) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .nimbusTooltip("Left of element", position: .leading)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.pink)
                    .frame(width: 50, height: 50)
                    .nimbusTooltip("Right of element", position: .trailing)
            }
            
            // Bottom row - bottom tooltips (should appear below elements)
            HStack(spacing: 32) {
                Button("Bottom") { }
                    .buttonStyle(.primaryOutline)
                    .nimbusTooltip("Should appear BELOW button", position: .bottom)
                
                Button("Test") { }
                    .buttonStyle(.secondaryOutline)
                    .nimbusTooltip("Arrow points up, fully visible", position: .bottom)
                
                Button("Demo") { }
                    .buttonStyle(.primary)
                    .controlSize(.small)
                    .nimbusTooltip("Clear spacing below", position: .bottom)
            }
        }
        
        Spacer()
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Custom Delays and Animations") {
    VStack(spacing: 32) {
        Text("Custom Delays & Animations")
            .font(.title2)
            .fontWeight(.semibold)
        
        VStack(spacing: 24) {
            // Fast tooltip
            Button("Fast Tooltip (0.1s)") {
                print("Fast tooltip")
            }
            .buttonStyle(.primary)
            .nimbusTooltip("Fast appearance", hoverDelay: 0.1)
            
            // Normal tooltip
            Button("Normal Tooltip (0.5s)") {
                print("Normal tooltip")
            }
            .buttonStyle(.secondary)
            .nimbusTooltip("Normal appearance", hoverDelay: 0.5)
            
            // Slow tooltip
            Button("Slow Tooltip (1.5s)") {
                print("Slow tooltip")
            }
            .buttonStyle(.accent)
            .nimbusTooltip("Slow appearance", hoverDelay: 1.5)
            
            // Custom styled tooltip with animation
            Button("Custom Animation") {
                print("Custom animation")
            }
            .buttonStyle(.primaryOutline)
            .tooltipConfiguration(
                cornerRadii: RectangleCornerRadii(12),
                elevation: .high,
                maxWidth: 200,
                hoverDelay: 0.3
            )
            .nimbusTooltip(
                "Custom Animation",
                subtitle: "With spring animation and custom styling"
            )
        }
        
        Spacer()
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Offset & Width Verification") {
    struct OffsetWidthDemo: View {
        @State private var showTooltip1 = false
        @State private var showTooltip2 = false
        @State private var showTooltip3 = false
        
        var body: some View {
            VStack(spacing: 60) {
                Text("Tooltip Offset & Width Verification")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                VStack(spacing: 40) {
                    // Test 1: Small button with long tooltip content
                    VStack(spacing: 8) {
                        Button("Small Button") {
                            showTooltip1.toggle()
                        }
                        .buttonStyle(.primary)
                        .frame(width: 120, height: 40)
                        .border(.red, width: 1) // Show button bounds
                        .nimbusTooltip(
                            isPresented: $showTooltip1,
                            title: "This is a very long tooltip title that should be much wider than the button",
                            subtitle: "The subtitle should also be much wider than the button and not constrained by button width",
                            position: .top
                        )
                        
                        Text("Button: 120px wide, Tooltip should be much wider")
                            .font(.caption)
                            .foregroundColor(.red)
                        
                        Text("Expected: Tooltip appears ABOVE button with full height clearance")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    
                    // Test 2: Tall button with bottom tooltip 
                    VStack(spacing: 8) {
                        Button("Tall Button\n(80px high)") {
                            showTooltip2.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 140, height: 80)
                        .border(.blue, width: 1) // Show button bounds
                        .nimbusTooltip(
                            isPresented: $showTooltip2,
                            title: "Bottom Tooltip",
                            subtitle: "Should appear below with full 80px + arrow + spacing clearance",
                            position: .bottom
                        )
                        
                        Text("Button: 140x80px, Tooltip should appear below with full height clearance")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Test 3: Different width button
                    VStack(spacing: 8) {
                        Button("Wide Button (200px)") {
                            showTooltip3.toggle()
                        }
                        .buttonStyle(.accent)
                        .frame(width: 200, height: 44)
                        .border(.purple, width: 1)
                        .nimbusTooltip(
                            isPresented: $showTooltip3,
                            title: "Short",
                            subtitle: "This tooltip has short content and should size to this content, not the 200px button width",
                            position: .top
                        )
                        
                        Text("Button: 200px wide, Tooltip should be narrower (content-based)")
                            .font(.caption)
                            .foregroundColor(.purple)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("✅ Tooltip offset = button height/2 + arrow size + spacing")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Tooltip width = content width (not button width)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ No overlap between tooltip and button")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Proper clearance based on actual button dimensions")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return OffsetWidthDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - NSPanel Implementation Test") {
    struct NSPanelTooltipDemo: View {
        @State private var showTooltip1 = false
        @State private var showTooltip2 = false
        @State private var showTooltip3 = false
        
        var body: some View {
            VStack(spacing: 60) {
                Text("NSPanel Tooltip Implementation")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("These tooltips use NSPanel for proper layering and positioning")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 40) {
                    // Test the original issue scenario
                    VStack(spacing: 12) {
                        Button("Toggle Manual Tooltip") {
                            showTooltip1.toggle()
                        }
                        .buttonStyle(.primary)
                        .nimbusTooltip(
                            isPresented: $showTooltip1,
                            title: "Manually Controlled",
                            subtitle: "This tooltip is controlled by binding and should appear above to avoid hiding content below",
                            position: .bottom  // Will be adaptive
                        )
                        
                        Text("Content below will be hidden ❌")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding()
                            .background(.red.opacity(0.1))
                            .cornerRadius(8)
                        
                        Text("↑ This content should NOT be hidden by tooltip anymore! ↑")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    
                    // Wide content test
                    VStack(spacing: 8) {
                        Button("Wide Content") {
                            showTooltip2.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 120)
                        .nimbusTooltip(
                            isPresented: $showTooltip2,
                            title: "This is a very long tooltip that should be wider than the button",
                            subtitle: "Content width should not be constrained to button width",
                            position: .top
                        )
                        
                        Text("Button: 120px, Tooltip: content-based width")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // Z-index test
                    VStack(spacing: 8) {
                        Button("Z-Index Test") {
                            showTooltip3.toggle()
                        }
                        .buttonStyle(.accent)
                        .nimbusTooltip(
                            isPresented: $showTooltip3,
                            title: "Z-Index Test",
                            subtitle: "This tooltip should appear ABOVE all other content",
                            position: .top
                        )
                        
                        Text("This text should appear BELOW tooltip")
                            .font(.caption)
                            .foregroundColor(.purple)
                            .padding()
                            .background(.purple.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ NSPanel ensures tooltip appears above ALL content")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ No Z-index issues - proper window layering")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Content-based width sizing (not button-constrained)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Proper offset based on button dimensions")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return NSPanelTooltipDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Visual Debug Interface") {
    struct VisualDebugDemo: View {
        @State private var showTooltip = false
        @State private var debugInfo: [String] = []
        @State private var stepsPassed: [Bool] = [false, false, false, false, false]
        
        var body: some View {
            HStack(spacing: 20) {
                // Left side - Controls and basic info
                VStack(spacing: 30) {
                    Text("🐛 Visual Debug")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button("Toggle Tooltip") {
                        debugInfo.append("🚀 Button pressed at \(Date().formatted(.dateTime.hour().minute().second()))")
                        showTooltip.toggle()
                        debugInfo.append("📱 showTooltip = \(showTooltip)")
                        
                        // Simulate debug steps
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            updateDebugSteps()
                        }
                    }
                    .buttonStyle(.primary)
                    .nimbusTooltip(
                        isPresented: $showTooltip,
                        title: "Debug Tooltip",
                        subtitle: "Testing NSPanel visibility"
                    )
                    
                    // Binding state indicator
                    HStack {
                        Circle()
                            .fill(showTooltip ? .green : .red)
                            .frame(width: 12, height: 12)
                        Text("Binding: \(showTooltip ? "TRUE" : "FALSE")")
                            .fontWeight(.semibold)
                    }
                    
                    // Step verification
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Debug Steps:")
                            .font(.headline)
                        
                        DebugStep(
                            step: "1. Modifier Called",
                            passed: stepsPassed[0],
                            detail: "showTooltip() triggered"
                        )
                        
                        DebugStep(
                            step: "2. NSPanel Created",
                            passed: stepsPassed[1],
                            detail: "TooltipPanel instantiated"
                        )
                        
                        DebugStep(
                            step: "3. Content Added",
                            passed: stepsPassed[2],
                            detail: "SwiftUI view hosted"
                        )
                        
                        DebugStep(
                            step: "4. Panel Positioned",
                            passed: stepsPassed[3],
                            detail: "Frame calculated & set"
                        )
                        
                        DebugStep(
                            step: "5. Panel Visible",
                            passed: stepsPassed[4],
                            detail: "orderFront() called"
                        )
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                // Right side - Debug log
                VStack(alignment: .leading, spacing: 10) {
                    Text("Debug Log:")
                        .font(.headline)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(Array(debugInfo.enumerated()), id: \.offset) { index, info in
                                Text("\(index + 1): \(info)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            if debugInfo.isEmpty {
                                Text("No debug info yet...")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 200)
                    .border(.gray.opacity(0.3))
                    
                    Button("Clear Log") {
                        debugInfo.removeAll()
                        stepsPassed = [false, false, false, false, false]
                    }
                    .buttonStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        
        private func updateDebugSteps() {
            // Simulate the debug process
            stepsPassed[0] = showTooltip // Step 1: Modifier called
            debugInfo.append("✅ Step 1: Modifier showTooltip() called")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                stepsPassed[1] = true // Assume panel creation
                debugInfo.append("✅ Step 2: NSPanel creation attempted")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    stepsPassed[2] = true // Content hosting
                    debugInfo.append("✅ Step 3: SwiftUI content hosted")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        stepsPassed[3] = true // Positioning
                        debugInfo.append("✅ Step 4: Panel positioned at screen center")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            stepsPassed[4] = true // Visibility
                            debugInfo.append("❓ Step 5: Panel orderFront() - IS IT VISIBLE?")
                            debugInfo.append("🔍 Look for tooltip at center of screen...")
                        }
                    }
                }
            }
        }
    }
    
    return VisualDebugDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Pure SwiftUI Implementation Test") {
    struct PureSwiftUITooltipDemo: View {
        @State private var showTooltip1 = false
        @State private var showTooltip2 = false
        @State private var showTooltip3 = false
        @State private var showTooltip4 = false
        
        var body: some View {
            VStack(spacing: 60) {
                Text("✨ Pure SwiftUI Tooltip Implementation")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("New overlay-based approach with proper positioning and z-index handling")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 40) {
                    // Test the original issue scenario
                    VStack(spacing: 12) {
                        Button("Toggle Manual Tooltip") {
                            showTooltip1.toggle()
                        }
                        .buttonStyle(.primary)
                        .nimbusTooltip(
                            isPresented: $showTooltip1,
                            title: "Pure SwiftUI Implementation",
                            subtitle: "This tooltip uses SwiftUI overlays instead of NSPanel for reliable positioning",
                            position: .bottom  // Will be adaptive if needed
                        )
                        
                        Text("Content below should NOT be hidden ✅")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding()
                            .background(.green.opacity(0.1))
                            .cornerRadius(8)
                        
                        Text("↑ This content should remain visible when tooltip appears ↑")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                    
                    // Wide content test
                    VStack(spacing: 8) {
                        Button("Wide Content Test") {
                            showTooltip2.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 120)
                        .nimbusTooltip(
                            isPresented: $showTooltip2,
                            title: "This is a very long tooltip that should be wider than the button",
                            subtitle: "Content width is now properly calculated and not constrained to button width",
                            position: .top
                        )
                        
                        Text("Button: 120px, Tooltip: content-based width")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // Position test with proper clearance
                    HStack(spacing: 60) {
                        Button("Top Position") {
                            showTooltip3.toggle()
                        }
                        .buttonStyle(.accent)
                        .nimbusTooltip(
                            isPresented: $showTooltip3,
                            title: "Top Position",
                            subtitle: "Appears above with proper clearance",
                            position: .top
                        )
                        
                        Button("Bottom Position") {
                            showTooltip4.toggle()
                        }
                        .buttonStyle(.primaryOutline)
                        .nimbusTooltip(
                            isPresented: $showTooltip4,
                            title: "Bottom Position", 
                            subtitle: "Appears below with proper spacing",
                            position: .bottom
                        )
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ Pure SwiftUI overlay implementation")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Proper z-index handling via .zIndex(1000)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Content-based width sizing (not button-constrained)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Native SwiftUI animations and transitions")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Reliable positioning with proper clearance")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return PureSwiftUITooltipDemo()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Reference Implementation Edge Positioning Test") {
    struct ReferencePositioningTest: View {
        @State private var topTooltip = false
        @State private var bottomTooltip = false
        @State private var leadingTooltip = false
        @State private var trailingTooltip = false
        
        var body: some View {
            VStack(spacing: 80) {
                Text("🎯 Reference Implementation Edge Positioning")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Tooltips should have arrows touching button edges with NO content overlap")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 100) {
                    // Top position test  
                    VStack(spacing: 30) {
                        Text("TOP: Arrow should touch BOTTOM edge of button")
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Button("Show Top Tooltip") {
                            topTooltip.toggle()
                        }
                        .buttonStyle(.primary)
                        .frame(width: 160, height: 40)
                        .border(.blue, width: 1) // Visual border to see exact edges
                        .nimbusTooltip(
                            isPresented: $topTooltip,
                            title: "Top Positioned Tooltip",
                            subtitle: "Arrow should touch bottom edge of blue border",
                            position: .top
                        )
                        
                        Text("Formula: offsetY = -(tooltipHeight + spacing + arrowSize)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    // Bottom position test
                    VStack(spacing: 30) {
                        Text("BOTTOM: Arrow should touch TOP edge of button")
                            .font(.caption)
                            .foregroundColor(.green)
                        
                        Button("Show Bottom Tooltip") {
                            bottomTooltip.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 160, height: 40)
                        .border(.green, width: 1) // Visual border to see exact edges
                        .nimbusTooltip(
                            isPresented: $bottomTooltip,
                            title: "Bottom Positioned Tooltip",
                            subtitle: "Arrow should touch top edge of green border",
                            position: .bottom
                        )
                        
                        Text("Formula: offsetY = anchorHeight + spacing + arrowSize")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    // Horizontal positions test
                    HStack(spacing: 120) {
                        VStack(spacing: 20) {
                            Text("LEADING")
                                .font(.caption)
                                .foregroundColor(.purple)
                            
                            Button("Leading") {
                                leadingTooltip.toggle()
                            }
                            .buttonStyle(.accent)
                            .frame(width: 80, height: 40)
                            .border(.purple, width: 1)
                            .nimbusTooltip(
                                isPresented: $leadingTooltip,
                                title: "Leading Tooltip",
                                subtitle: "Arrow touches right edge",
                                position: .leading
                            )
                            
                            Text("offsetX = -(tooltipWidth + spacing + arrow)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(spacing: 20) {
                            Text("TRAILING")
                                .font(.caption)
                                .foregroundColor(.orange)
                            
                            Button("Trailing") {
                                trailingTooltip.toggle()
                            }
                            .buttonStyle(.primaryOutline)
                            .frame(width: 80, height: 40)
                            .border(.orange, width: 1)
                            .nimbusTooltip(
                                isPresented: $trailingTooltip,
                                title: "Trailing Tooltip", 
                                subtitle: "Arrow touches left edge",
                                position: .trailing
                            )
                            
                            Text("offsetX = anchorWidth + spacing + arrow")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                // Expected behavior checklist
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ Arrow tips touch colored borders (button edges) exactly")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ NO tooltip content overlaps with button content")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Clear visual separation between tooltip and button")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ True popover behavior with edge-based positioning")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return ReferencePositioningTest()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Comprehensive Positioning Test") {
    struct ComprehensivePositioningTest: View {
        @State private var topTooltip = false
        @State private var bottomTooltip = false
        @State private var leadingTooltip = false
        @State private var trailingTooltip = false
        @State private var adaptiveTooltip = false
        
        var body: some View {
            VStack(spacing: 60) {
                Text("📐 Comprehensive Positioning Test")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Testing all tooltip positions with proper clearance and sizing")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                // Grid of positioning tests
                VStack(spacing: 80) {
                    // Top position test
                    VStack(spacing: 20) {
                        Text("Top Position Test")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Button("Show Top Tooltip") {
                            topTooltip.toggle()
                        }
                        .buttonStyle(.primary)
                        .frame(height: 50) // Specific height for clearance testing
                        .nimbusTooltip(
                            isPresented: $topTooltip,
                            title: "Top Position",
                            subtitle: "Should appear above with (height/2 + arrow + spacing) clearance",
                            icon: Image(systemName: "arrow.up"),
                            position: .top
                        )
                        
                        Text("Expected clearance: 25px (height/2) + 8px (arrow) + 4px (spacing) = 37px")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Bottom position test
                    VStack(spacing: 20) {
                        Text("Bottom Position Test")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Button("Show Bottom Tooltip") {
                            bottomTooltip.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(height: 60) // Different height for testing
                        .nimbusTooltip(
                            isPresented: $bottomTooltip,
                            title: "Bottom Position",
                            subtitle: "Should appear below with proper clearance based on 60px height",
                            icon: Image(systemName: "arrow.down"),
                            position: .bottom
                        )
                        
                        Text("Expected clearance: 30px (height/2) + 8px (arrow) + 4px (spacing) = 42px")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    // Horizontal positions test
                    HStack(spacing: 100) {
                        VStack(spacing: 8) {
                            Text("Leading")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Button("Leading") {
                                leadingTooltip.toggle()
                            }
                            .buttonStyle(.accent)
                            .frame(width: 80)
                            .nimbusTooltip(
                                isPresented: $leadingTooltip,
                                title: "Leading Position",
                                subtitle: "Appears to the left",
                                position: .leading
                            )
                        }
                        
                        VStack(spacing: 8) {
                            Text("Trailing")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Button("Trailing") {
                                trailingTooltip.toggle()
                            }
                            .buttonStyle(.primaryOutline)
                            .frame(width: 80)
                            .nimbusTooltip(
                                isPresented: $trailingTooltip,
                                title: "Trailing Position",
                                subtitle: "Appears to the right",
                                position: .trailing
                            )
                        }
                    }
                    
                    // Adaptive positioning test
                    VStack(spacing: 20) {
                        Text("Adaptive Positioning Test")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Button("Test Adaptive") {
                            adaptiveTooltip.toggle()
                        }
                        .buttonStyle(.accent)
                        .adaptivePositioning(true) // Enable adaptive positioning
                        .nimbusTooltip(
                            isPresented: $adaptiveTooltip,
                            title: "Adaptive Positioning",
                            subtitle: "This tooltip should automatically choose the best position to avoid going off-screen",
                            icon: Image(systemName: "location.fill"),
                            position: .bottom  // Request bottom, but will adapt if needed
                        )
                        
                        Text("Requests bottom position but will adapt based on available space")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Test results summary
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ All positions use (anchorSize/2 + arrowSize + spacing) clearance formula")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Content-based width sizing (not constrained to button width)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Proper z-index ordering with .zIndex(1000)")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Native SwiftUI animations and transitions")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("✅ Adaptive positioning when enabled")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return ComprehensivePositioningTest()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Universal Formula Test (Different Button Sizes)") {
    struct UniversalFormulaTest: View {
        @State private var smallTooltip = false
        @State private var mediumTooltip = false
        @State private var largeTooltip = false
        @State private var tallTooltip = false
        
        var body: some View {
            VStack(spacing: 80) {
                Text("📏 Universal Formula Test - Different Button Sizes")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Reference formulas should work with any button size")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 60) {
                    // Small button test
                    VStack(spacing: 15) {
                        Text("Small Button (60x30)")
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Button("Small") {
                            smallTooltip.toggle()
                        }
                        .buttonStyle(.primary)
                        .frame(width: 60, height: 30)
                        .border(.blue, width: 1)
                        .nimbusTooltip(
                            isPresented: $smallTooltip,
                            title: "Small Button Tooltip",
                            subtitle: "Arrow should touch edge exactly",
                            position: .bottom
                        )
                    }
                    
                    // Medium button test  
                    VStack(spacing: 15) {
                        Text("Medium Button (120x44)")
                            .font(.caption)
                            .foregroundColor(.green)
                        
                        Button("Medium Button") {
                            mediumTooltip.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 120, height: 44)
                        .border(.green, width: 1)
                        .nimbusTooltip(
                            isPresented: $mediumTooltip,
                            title: "Medium Button Tooltip",
                            subtitle: "Arrow should touch edge with same precision as small button",
                            position: .top
                        )
                    }
                    
                    // Large button test
                    VStack(spacing: 15) {
                        Text("Large Button (200x60)")
                            .font(.caption)
                            .foregroundColor(.purple)
                        
                        Button("Large Button Text") {
                            largeTooltip.toggle()
                        }
                        .buttonStyle(.accent)
                        .frame(width: 200, height: 60)
                        .border(.purple, width: 1)
                        .nimbusTooltip(
                            isPresented: $largeTooltip,
                            title: "Large Button Tooltip",
                            subtitle: "Formula should scale correctly for larger buttons too",
                            position: .leading
                        )
                    }
                    
                    // Tall narrow button test
                    VStack(spacing: 15) {
                        Text("Tall Narrow Button (80x80)")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Button("Tall") {
                            tallTooltip.toggle()
                        }
                        .buttonStyle(.primaryOutline)
                        .frame(width: 80, height: 80)
                        .border(.orange, width: 1)
                        .nimbusTooltip(
                            isPresented: $tallTooltip,
                            title: "Square Button",
                            subtitle: "Works with square dimensions",
                            position: .trailing
                        )
                    }
                }
                
                // Formula verification
                VStack(alignment: .leading, spacing: 6) {
                    Text("Reference Formulas Applied:")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("• TOP: offsetY = -(tooltipHeight + spacing + arrowSize)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• BOTTOM: offsetY = buttonHeight + spacing + arrowSize")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• LEADING: offsetX = -(tooltipWidth + spacing + arrowSize)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• TRAILING: offsetX = buttonWidth + spacing + arrowSize")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return UniversalFormulaTest()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Screenshot Scenario Test") {
    struct ScreenshotScenarioTest: View {
        @State private var showTooltip = false
        
        var body: some View {
            VStack(spacing: 100) {
                Text("📸 Screenshot Scenario Recreation")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This should match the user's screenshot with tooltip close to button")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 20) {
                    // Blue small button (like in screenshot)
                    VStack(spacing: 10) {
                        Button("Small") {
                            // Nothing - just for visual reference
                        }
                        .buttonStyle(.primary)
                        .frame(width: 80, height: 40)
                        .disabled(true)
                        
                        Text("Reference button (matches screenshot)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // Medium button test (the problematic one from screenshot)
                    VStack(spacing: 30) {
                        Button("Medium Button") {
                            showTooltip.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 120, height: 44)
                        .border(.green, width: 1)
                        .nimbusTooltip(
                            isPresented: $showTooltip,
                            title: "Medium But...",
                            subtitle: "Arrow should touch top edge directly",
                            position: .top
                        )
                        
                        Text("Expected: Tooltip should appear CLOSE to green border, not way up")
                            .font(.caption)
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ Reference Implementation Applied:")
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text("• No alignment in .overlay() - matches reference")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• GeometryReader with .offset() - single positioning system")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• offsetY = -(tooltipHeight + spacing + arrowSize)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• Should eliminate the huge gap from screenshot")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return ScreenshotScenarioTest()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Tooltip - Final Reference Implementation Validation") {
    struct FinalValidationTest: View {
        @State private var topTooltip = false
        @State private var bottomTooltip = false
        @State private var leadingTooltip = false
        @State private var trailingTooltip = false
        
        var body: some View {
            VStack(spacing: 80) {
                Text("🎯 Final Validation: All Positions")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Testing all four positions with reference implementation structure")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 100) {
                    // Top position - should be close to button
                    VStack(spacing: 20) {
                        Text("TOP Position")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Button("Top Tooltip Test") {
                            topTooltip.toggle()
                        }
                        .buttonStyle(.primary)
                        .frame(width: 140, height: 44)
                        .border(.blue, width: 2)
                        .nimbusTooltip(
                            isPresented: $topTooltip,
                            title: "Top Tooltip",
                            subtitle: "Should be close to blue border",
                            position: .top
                        )
                        
                        Text("Expected: Close to blue border, NOT way up")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // Horizontal positions
                    HStack(spacing: 100) {
                        VStack(spacing: 20) {
                            Text("LEADING")
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            Button("Leading") {
                                leadingTooltip.toggle()
                            }
                            .buttonStyle(.accent)
                            .frame(width: 100, height: 44)
                            .border(.purple, width: 2)
                            .nimbusTooltip(
                                isPresented: $leadingTooltip,
                                title: "Leading Tooltip",
                                subtitle: "Close to left edge",
                                position: .leading
                            )
                            
                            Text("Should be close to purple border")
                                .font(.caption)
                                .foregroundColor(.purple)
                                .multilineTextAlignment(.center)
                        }
                        
                        VStack(spacing: 20) {
                            Text("TRAILING")
                                .font(.headline)
                                .foregroundColor(.orange)
                            
                            Button("Trailing") {
                                trailingTooltip.toggle()
                            }
                            .buttonStyle(.primaryOutline)
                            .frame(width: 100, height: 44)
                            .border(.orange, width: 2)
                            .nimbusTooltip(
                                isPresented: $trailingTooltip,
                                title: "Trailing Tooltip",
                                subtitle: "Close to right edge", 
                                position: .trailing
                            )
                            
                            Text("Should be close to orange border")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    // Bottom position
                    VStack(spacing: 20) {
                        Text("BOTTOM Position")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Button("Bottom Tooltip Test") {
                            bottomTooltip.toggle()
                        }
                        .buttonStyle(.secondary)
                        .frame(width: 140, height: 44)
                        .border(.green, width: 2)
                        .nimbusTooltip(
                            isPresented: $bottomTooltip,
                            title: "Bottom Tooltip",
                            subtitle: "Should be close to green border",
                            position: .bottom
                        )
                        
                        Text("Expected: Close to green border, NOT way down")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("✅ Reference Implementation Complete:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    Text("• Single positioning system (no double offset)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• GeometryReader provides anchor dimensions")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• Tooltips positioned close to button edges")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("• Matches proven SwiftUI-Tooltip repository approach")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
        }
    }
    
    return FinalValidationTest()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

struct DebugStep: View {
    let step: String
    let passed: Bool
    let detail: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(passed ? .green : .gray)
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(step)
                    .font(.caption)
                    .fontWeight(.medium)
                
                Text(detail)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Helper Shape

private struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let centerX = rect.midX
            let centerY = rect.midY
            let halfWidth = rect.width / 2
            let halfHeight = rect.height / 2
            
            path.move(to: CGPoint(x: centerX, y: centerY - halfHeight))
            path.addLine(to: CGPoint(x: centerX + halfWidth, y: centerY))
            path.addLine(to: CGPoint(x: centerX, y: centerY + halfHeight))
            path.addLine(to: CGPoint(x: centerX - halfWidth, y: centerY))
            path.closeSubpath()
        }
    }
}