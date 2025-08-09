import AppKit
import SwiftUI
import NimbusCore

/// A window controller that manages the display of OnboardingView in a dedicated NSWindow.
public class OnboardingWindowController: NSWindowController {
    private let features: [AnyFeature]
    private let theme: any NimbusTheming
    
    public init(features: [AnyFeature], theme: any NimbusTheming = NimbusTheme.default) {
        self.features = features
        self.theme = theme
        
        let window = OnboardingWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        super.init(window: window)
        
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContent() {
        guard let window = window else { return }
        
        let onboardingView = OnboardingView(features: features)
            .environment(\.nimbusTheme, theme)
        
        let hostingController = NSHostingController(rootView: onboardingView)
        window.contentViewController = hostingController
    }
    
    /// Shows the onboarding window
    public func show() {
        window?.makeKeyAndOrderFront(nil)
        DispatchQueue.main.async {
            self.window?.center()
        }
    }
    
    /// Closes the onboarding window
    public override func close() {
        window?.close()
    }
}
