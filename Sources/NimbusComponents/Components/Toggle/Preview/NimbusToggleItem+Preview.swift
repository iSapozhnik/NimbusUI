//
//  NimbusToggleItem+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Previews

#Preview("Basic Toggle Items") {
    @Previewable @State var notifications = true
    @Previewable @State var darkMode = false
    @Previewable @State var autoSave = true
    @Previewable @State var analytics = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Toggle Items")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Enable Notifications",
                    subtitle: "Receive app alerts and updates",
                    isOn: $notifications
                )
                
                NimbusToggleItem(
                    "Dark Mode",
                    subtitle: "Use dark theme throughout the app",
                    isOn: $darkMode
                )
                
                NimbusToggleItem(
                    "Auto Save",
                    subtitle: "Automatically save changes",
                    isOn: $autoSave
                )
                
                NimbusToggleItem(
                    "Analytics",
                    subtitle: "Help improve the app by sharing anonymous usage data",
                    isOn: $analytics
                )
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Toggle Positions") {
    @Previewable @State var leadingSetting = true
    @Previewable @State var trailingSetting = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Toggle Positions")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Leading Toggle",
                    subtitle: "Toggle positioned on the left side",
                    isOn: $leadingSetting,
                    togglePosition: .leading
                )
                
                NimbusToggleItem(
                    "Trailing Toggle",
                    subtitle: "Toggle positioned on the right side (default)",
                    isOn: $trailingSetting,
                    togglePosition: .trailing
                )
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Vertical Alignment") {
    @Previewable @State var centerAligned = true
    @Previewable @State var baselineAligned = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Vertical Alignment")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Center Aligned",
                    subtitle: "Toggle centered with entire text content (default)",
                    isOn: $centerAligned,
                    verticalAlignment: .center
                )
                
                NimbusToggleItem(
                    "Baseline Aligned",
                    subtitle: "Toggle aligned with title text baseline",
                    isOn: $baselineAligned,
                    verticalAlignment: .baseline
                )
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Without Subtitles") {
    @Previewable @State var simpleToggle1 = true
    @Previewable @State var simpleToggle2 = false
    @Previewable @State var simpleToggle3 = true
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Simple Toggle Items")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem("Wi-Fi", isOn: $simpleToggle1)
                NimbusToggleItem("Bluetooth", isOn: $simpleToggle2)
                NimbusToggleItem("Airplane Mode", isOn: $simpleToggle3)
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Disabled States") {
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Disabled Toggle Items")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Disabled On",
                    subtitle: "This toggle is disabled and on",
                    isOn: .constant(true)
                )
                .disabled(true)
                
                NimbusToggleItem(
                    "Disabled Off",
                    subtitle: "This toggle is disabled and off",
                    isOn: .constant(false)
                )
                .disabled(true)
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Custom Shapes") {
    @Previewable @State var circleToggle = true
    @Previewable @State var squareToggle = false
    @Previewable @State var pillToggle = true
    @Previewable @State var roundedToggle = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Custom Toggle Shapes")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Circle Toggle",
                    subtitle: "Traditional circular toggle",
                    isOn: $circleToggle
                )
                .circularToggle()
                
                NimbusToggleItem(
                    "Square Toggle",
                    subtitle: "Modern square toggle",
                    isOn: $squareToggle
                )
                .squareToggle()
                
                NimbusToggleItem(
                    "Pill Toggle",
                    subtitle: "Fully rounded toggle",
                    isOn: $pillToggle
                )
                .pillToggle()
                
                NimbusToggleItem(
                    "Rounded Toggle",
                    subtitle: "Custom corner radius",
                    isOn: $roundedToggle
                )
                .roundedToggle(cornerRadius: 6)
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Theme Variations") {
    @Previewable @State var setting1 = true
    @Previewable @State var setting2 = false
    
    VStack(spacing: 25) {
        VStack(spacing: 8) {
            Text("NimbusTheme.default")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Example Setting",
                    subtitle: "This is an example setting",
                    isOn: $setting1
                )
            }
        }
        
        VStack(spacing: 8) {
            Text("MaritimeTheme")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Example Setting",
                    subtitle: "This is an example setting",
                    isOn: $setting2
                )
            }
            .environment(\.nimbusTheme, MaritimeTheme())
        }
        
        VStack(spacing: 8) {
            Text("CustomWarmTheme")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Example Setting",
                    subtitle: "This is an example setting",
                    isOn: $setting1
                )
            }
            .environment(\.nimbusTheme, CustomWarmTheme())
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Custom Configurations") {
    @Previewable @State var customToggle1 = true
    @Previewable @State var customToggle2 = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Custom Item Configurations")
                .font(.headline)
            
            VStack(spacing: 4) {
                NimbusToggleItem(
                    "Spacious Item",
                    subtitle: "More padding and spacing",
                    isOn: $customToggle1
                )
                .toggleItemSpacing(20)
                .toggleTextSpacing(8)
                .toggleItemPadding(16)
                .toggleItemMinHeight(60)
                .controlSize(.large)
                
                NimbusToggleItem(
                    "Compact Item",
                    subtitle: "Tighter spacing",
                    isOn: $customToggle2,
                    togglePosition: .leading
                )
                .toggleItemSpacing(8)
                .toggleTextSpacing(2)
                .toggleItemPadding(4)
                .toggleItemMinHeight(32)
                .controlSize(.small)
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}
