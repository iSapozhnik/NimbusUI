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
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Image Bezel") {
                showImageBezel = true
            }
            .nimbusBezel(
                isPresented: $showImageBezel,
                systemImageName: NSImage.touchBarAudioOutputVolumeHighTemplateName,
                autoDismissAfter: .seconds(2)
            )
            
            Button("Show Text Bezel") {
                showTextBezel = true
            }
            .nimbusBezel(
                isPresented: $showTextBezel,
                systemImageName: NSImage.statusAvailableName,
                text: "Saved!",
                autoDismissAfter: .seconds(2)
            )
            
            Button("Show Custom Theme Bezel") {
                showCustomBezel = true
            }
            .environment(\.nimbusTheme, MaritimeTheme())
            .nimbusBezel(
                isPresented: $showCustomBezel,
                systemImageName: NSImage.networkName,
                text: "Connected",
                autoDismissAfter: .seconds(3)
            )
        }
        .padding()
    }
}

// MARK: - Standalone API Examples (for menubar apps)

struct BezelStandaloneExampleView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Standalone Image Bezel") {
                // Perfect for menubar apps - no SwiftUI context needed
                let image = NSImage(named: NSImage.touchBarAudioOutputVolumeHighTemplateName)
                NimbusBezel.show(image: image)
                    .hide(after: .seconds(2))
            }
            
            Button("Show Standalone Text Bezel") {
                // With text and image
                let image = NSImage(named: NSImage.statusAvailableName)
                NimbusBezel.show(
                    image: image,
                    text: "Task Complete!"
                ).hide(after: .seconds(2))
            }
            
            Button("Show Custom Theme Standalone") {
                // With custom theme for consistent branding
                let image = NSImage(named: NSImage.networkName)
                NimbusBezel.show(
                    image: image,
                    text: "Connected",
                    theme: MaritimeTheme()
                ).hide(after: .seconds(3))
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