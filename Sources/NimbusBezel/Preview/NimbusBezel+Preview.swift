//
//  NimbusBezel+Preview.swift
//  NimbusBezel
//
//  Created by Ivan Sapozhnik on 08.08.25.
//

import SwiftUI
import AppKit

#if DEBUG

// MARK: - Programmatic API Examples

struct BezelProgrammaticExamplesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("NimbusBezel - Programmatic API")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            Text("Direct method calls - no SwiftUI modifiers needed")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            // MARK: - Basic Usage
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Basic Usage")
                    .font(.headline)
                
                Button("Volume Bezel (2s)") {
                    // Perfect for system-style notifications
                    let image = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
                    NimbusBezel.show(image: image)
                        .hide(after: .seconds(2))
                }
                
                Button("Success Message (3s)") {
                    // Task completion notification
                    let image = NSImage(named: NSImage.statusAvailableName)
                    NimbusBezel.show(
                        image: image,
                        text: "Task completed successfully!"
                    ).hide(after: .seconds(3))
                }
            }
            
            Divider()
            
            // MARK: - Custom Themes
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Custom Themes")
                    .font(.headline)
                
                Button("Maritime Theme (4s)") {
                    // Branded bezel with custom theme
                    let image = NSImage(named: NSImage.networkName)
                    NimbusBezel.show(
                        image: image,
                        text: "Maritime theme applied",
                        theme: MaritimeTheme()
                    ).hide(after: .seconds(4))
                }
                
                Button("Default Theme vs Custom") {
                    // Show difference between themes
                    showThemeComparison()
                }
            }
            
            Divider()
            
            // MARK: - Real-World Scenarios
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Real-World Scenarios")
                    .font(.headline)
                
                Button("Simulate App Event") {
                    // Simulate background task completion
                    simulateAppEvent()
                }
                
                Button("Show System Status") {
                    // System status notification
                    showSystemStatus()
                }
                
                Button("Quick Flash (1s)") {
                    // Very quick notification
                    let image = NSImage(named: NSImage.cautionName)
                    NimbusBezel.show(
                        image: image,
                        text: "Quick notification"
                    ).hide(after: .seconds(1))
                }
            }
        }
        .padding()
        .frame(maxWidth: 400)
    }
    
    // MARK: - Helper Methods
    
    private func showThemeComparison() {
        // Show default theme first
        let defaultImage = NSImage(named: NSImage.bluetoothTemplateName)
        NimbusBezel.show(image: defaultImage, text: "Default Theme")
            .hide(after: .seconds(2))
        
        // Show maritime theme after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let maritimeImage = NSImage(named: NSImage.bluetoothTemplateName)
            NimbusBezel.show(
                image: maritimeImage,
                text: "Maritime Theme",
                theme: MaritimeTheme()
            ).hide(after: .seconds(2))
        }
    }
    
    private func simulateAppEvent() {
        // Simulate a background operation
        let loadingImage = NSImage(named: NSImage.refreshTemplateName)
        NimbusBezel.show(image: loadingImage, text: "Processing...")
            .hide(after: .seconds(1))
        
        // Show completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let successImage = NSImage(named: NSImage.menuOnStateTemplateName)
            NimbusBezel.show(image: successImage, text: "Process Complete!")
                .hide(after: .seconds(2))
        }
    }
    
    private func showSystemStatus() {
        let statusImage = NSImage(named: NSImage.computerName)
        NimbusBezel.show(
            image: statusImage,
            text: "System Status: All Good"
        ).hide(after: .seconds(3))
    }
}

// MARK: - Previews

#Preview("Programmatic API") {
    BezelProgrammaticExamplesView()
}

#Preview("Maritime Theme") {
    BezelProgrammaticExamplesView()
        .environment(\.nimbusTheme, MaritimeTheme())
}

// MARK: - API Verification

struct APIVerificationView: View {
    var body: some View {
        VStack {
            Text("API Verification")
                .font(.headline)
            
            Button("Test Basic API") {
                // This should work without any SwiftUI context
                testBasicAPI()
            }
        }
        .padding()
    }
    
    private func testBasicAPI() {
        // Test all variations of the API
        let image = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
        
        // Basic image-only
        NimbusBezel.show(image: image).hide(after: .seconds(1))
        
        // With text  
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            NimbusBezel.show(image: image, text: "With text").hide(after: .seconds(1))
        }
        
        // With theme
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            NimbusBezel.show(image: image, theme: MaritimeTheme()).hide(after: .seconds(1))
        }
        
        // With text and theme
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
            NimbusBezel.show(image: image, text: "Custom theme", theme: MaritimeTheme()).hide(after: .seconds(1))
        }
    }
}

#Preview("API Verification") {
    APIVerificationView()
}

// MARK: - Usage Examples for Documentation

/*

## NimbusBezel - Programmatic Usage Examples

Perfect for any app that needs system-level notifications without SwiftUI complexity.

### Basic Usage
```swift
// Simple image bezel
let image = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
NimbusBezel.show(image: image).hide(after: .seconds(2))

// With text message
let successImage = NSImage(named: NSImage.statusAvailableName)
NimbusBezel.show(image: successImage, text: "Task completed!")
    .hide(after: .seconds(3))
```

### Custom Themes
```swift
// Use custom theme for branding
NimbusBezel.show(
    image: NSImage(named: NSImage.networkName),
    text: "Connected to server",
    theme: MaritimeTheme()
).hide(after: .seconds(4))
```

### Real-World Integration
```swift
@IBAction func exportData(_ sender: NSButton) {
    // Show processing
    let loadingImage = NSImage(named: NSImage.refreshTemplateName)
    NimbusBezel.show(image: loadingImage, text: "Exporting...")
        .hide(after: .seconds(1))
    
    // Perform export...
    exportDataToFile { success in
        DispatchQueue.main.async {
            if success {
                let successImage = NSImage(named: NSImage.menuOnStateTemplateName)
                NimbusBezel.show(image: successImage, text: "Export complete!")
                    .hide(after: .seconds(2))
            } else {
                let errorImage = NSImage(named: NSImage.cautionName)
                NimbusBezel.show(image: errorImage, text: "Export failed")
                    .hide(after: .seconds(3))
            }
        }
    }
}
```

### Menubar App Usage
```swift
func showVolumeChanged() {
    let volumeImage = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
    NimbusBezel.show(image: volumeImage).hide(after: .seconds(1))
}

func showNetworkStatus(_ connected: Bool) {
    let image = NSImage(named: connected ? NSImage.networkName : NSImage.cautionName)
    let message = connected ? "Network connected" : "Network disconnected"
    NimbusBezel.show(image: image, text: message).hide(after: .seconds(2))
}
```

*/

#endif