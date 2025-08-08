//
//  NimbusBezel+Preview.swift
//  NimbusBezel
//
//  Created by Ivan Sapozhnik on 08.08.25.
//

import SwiftUI
import AppKit

#if DEBUG

// MARK: - SwiftUI Integration Examples

struct BezelSwiftUIExampleView: View {
    @State private var showImageBezel = false
    @State private var showTextBezel = false
    @State private var showCustomBezel = false
    @State private var showPersistentBezel = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SwiftUI Bezel Integration - Fixed Timing")
                .font(.headline)
                .padding(.bottom)
            
            Button("Show 2s Image Bezel") {
                showImageBezel = true
            }
            .nimbusBezel(
                isPresented: $showImageBezel,
                systemImageName: NSImage.touchBarAudioOutputVolumeHighTemplateName,
                autoDismissAfter: .seconds(2)
            )
            
            Button("Show 3s Text Bezel") {
                showTextBezel = true
            }
            .nimbusBezel(
                isPresented: $showTextBezel,
                systemImageName: NSImage.statusAvailableName,
                text: "Will auto-dismiss after 3 seconds",
                autoDismissAfter: .seconds(3)
            )
            
            Button("Show 5s Custom Theme Bezel") {
                showCustomBezel = true
            }
            .environment(\.nimbusTheme, MaritimeTheme())
            .nimbusBezel(
                isPresented: $showCustomBezel,
                systemImageName: NSImage.networkName,
                text: "Maritime theme - 5 second display",
                autoDismissAfter: .seconds(5)
            )
            
            HStack {
                Button("Show Persistent") {
                    showPersistentBezel = true
                }
                
                Button("Hide Persistent") {
                    showPersistentBezel = false
                }
                .disabled(!showPersistentBezel)
            }
            .nimbusBezel(
                isPresented: $showPersistentBezel,
                systemImageName: NSImage.infoName,
                text: "Persistent bezel - manual dismiss only"
                // No autoDismissAfter - must be manually dismissed
            )
        }
        .padding()
    }
}

// MARK: - Standalone API Examples (for menubar apps)

struct BezelStandaloneExampleView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Standalone API - For Menubar Apps")
                .font(.headline)
                .padding(.bottom)
            
            Button("Show 2s Standalone Image Bezel") {
                // Perfect for menubar apps - no SwiftUI context needed
                let image = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
                NimbusBezel.show(image: image)
                    .hide(after: .seconds(2))
            }
            
            Button("Show 3s Standalone Text Bezel") {
                // With text and image
                let image = NSImage(named: NSImage.statusAvailableName)
                NimbusBezel.show(
                    image: image,
                    text: "Standalone API - 3 seconds"
                ).hide(after: .seconds(3))
            }
            
            Button("Show 4s Custom Theme Standalone") {
                // With custom theme for consistent branding
                let image = NSImage(named: NSImage.networkName)
                NimbusBezel.show(
                    image: image,
                    text: "Maritime theme - 4 seconds",
                    theme: MaritimeTheme()
                ).hide(after: .seconds(4))
            }
            
            Button("Show Immediate Hide Test") {
                // Test that immediate hide works
                let image = NSImage(named: NSImage.cautionName)
                _ = NimbusBezel.show(
                    image: image,
                    text: "This will hide in 1 second"
                ).hide(after: .seconds(1))
            }
        }
        .padding()
    }
}

// MARK: - Previews

#Preview("SwiftUI Integration") {
    BezelSwiftUIExampleView()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Standalone API") {
    BezelStandaloneExampleView()
}

#Preview("Maritime Theme") {
    BezelSwiftUIExampleView()
        .environment(\.nimbusTheme, MaritimeTheme())
}

#endif