import AppKit
import SwiftUI
import NimbusCore

/// A window controller that manages the display of OnboardingView in a dedicated NSWindow.
public class OnboardingWindowController: NSWindowController {
    private let features: [AnyFeature]
    private let theme: (any NimbusTheming)?
    private var hostingController: NSViewController?
    
    public init(features: [AnyFeature], theme: (any NimbusTheming)? = nil) {
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
        
        // Create OnboardingView with theme integration
        let onboardingView = OnboardingView(features: features)
            .ignoresSafeArea()
            .environment(\.nimbusTheme, theme ?? NimbusTheme.default)
        
        // Create hosting controller
        let hostingController = NSHostingController(rootView: onboardingView)
        self.hostingController = hostingController
        window.setFrame(CGRect(origin: .zero, size: hostingController.view.fittingSize), display: true)
        
        // Set as window's content
        window.contentViewController = hostingController
    }
    
    /// Shows the onboarding window
    public func show() {
        window?.center()
        window?.makeKeyAndOrderFront(nil)
    }
    
    /// Closes the onboarding window
    public override func close() {
        window?.close()
    }
}
