//
//  NimbusBezelModifier.swift
//  NimbusBezel
//
//  Created by Ivan Sapozhnik on 08.08.25.
//

import SwiftUI
import AppKit
import NimbusCore

// MARK: - DispatchTimeInterval Extension

extension DispatchTimeInterval {
    var timeInterval: TimeInterval {
        switch self {
        case .nanoseconds(let value):
            return TimeInterval(value) / TimeInterval(NSEC_PER_SEC)
        case .microseconds(let value):
            return TimeInterval(value) / TimeInterval(USEC_PER_SEC)
        case .milliseconds(let value):
            return TimeInterval(value) / 1000.0
        case .seconds(let value):
            return TimeInterval(value)
        case .never:
            return .infinity
        @unknown default:
            return 0
        }
    }
}

struct NimbusBezelModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Bezel configuration
    @Binding var isPresented: Bool
    let image: NSImage?
    let text: String?
    let autoDismissAfter: DispatchTimeInterval?
    
    // Internal state
    @State private var bezel: NimbusBezel?
    @State private var dismissTimer: Timer?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    showBezel()
                } else {
                    dismissBezel()
                }
            }
            .onAppear {
                if isPresented {
                    showBezel()
                }
            }
    }
    
    private func showBezel() {
        // Cancel any existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        // Create new bezel with current theme and color scheme
        let newBezel: NimbusBezel
        if let text = text {
            newBezel = NimbusBezel(image: image, text: text, theme: theme, colorScheme: colorScheme)
        } else {
            newBezel = NimbusBezel(image: image, theme: theme, colorScheme: colorScheme)
        }
        
        // Show the bezel - let it manage its own queue
        newBezel.show()
        
        self.bezel = newBezel
        
        // Set up our own auto-dismiss timer if specified
        if let dismissInterval = autoDismissAfter {
            let timeInterval = dismissInterval.timeInterval
            dismissTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
                dismissBezel()
            }
        }
    }
    
    private func dismissBezel() {
        // Cancel any existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        // Hide the bezel immediately (user dismissed)
        bezel?.hide()
        bezel = nil
        
        // Reset the binding after a brief delay to avoid feedback loop
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPresented = false
        }
    }
}

// MARK: - SwiftUI View Extension

public extension View {
    /// Presents a bezel overlay with customizable content
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls bezel visibility
    ///   - image: Optional image to display in the bezel
    ///   - text: Optional text to display in the bezel
    ///   - autoDismissAfter: Optional auto-dismiss interval
    /// - Returns: A view with the bezel overlay capability
    func nimbusBezel(
        isPresented: Binding<Bool>,
        image: NSImage? = nil,
        text: String? = nil,
        autoDismissAfter: DispatchTimeInterval? = nil
    ) -> some View {
        modifier(
            NimbusBezelModifier(
                isPresented: isPresented,
                image: image,
                text: text,
                autoDismissAfter: autoDismissAfter
            )
        )
    }
    
    /// Presents a bezel overlay with a system image
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls bezel visibility
    ///   - systemImageName: System image name to display in the bezel
    ///   - autoDismissAfter: Optional auto-dismiss interval
    /// - Returns: A view with the bezel overlay capability
    func nimbusBezel(
        isPresented: Binding<Bool>,
        systemImageName: String,
        autoDismissAfter: DispatchTimeInterval? = nil
    ) -> some View {
        let image = NSImage(named: systemImageName)
        return nimbusBezel(
            isPresented: isPresented,
            image: image,
            autoDismissAfter: autoDismissAfter
        )
    }
    
    /// Presents a bezel overlay with a system image and text
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls bezel visibility
    ///   - systemImageName: System image name to display in the bezel
    ///   - text: Text to display in the bezel
    ///   - autoDismissAfter: Optional auto-dismiss interval
    /// - Returns: A view with the bezel overlay capability
    func nimbusBezel(
        isPresented: Binding<Bool>,
        systemImageName: String,
        text: String,
        autoDismissAfter: DispatchTimeInterval? = nil
    ) -> some View {
        let image = NSImage(named: systemImageName)
        return nimbusBezel(
            isPresented: isPresented,
            image: image,
            text: text,
            autoDismissAfter: autoDismissAfter
        )
    }
}