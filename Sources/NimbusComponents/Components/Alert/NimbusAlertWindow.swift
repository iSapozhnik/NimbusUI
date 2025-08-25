//
//  NimbusAlertWindow.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

public final class NimbusAlertWindow: NSWindow {
    private var completion: (() -> Void)?
    private var isModal: Bool = false
    
    public init(alert: NimbusAlert, completion: (() -> Void)? = nil) {
        self.completion = completion
        
        super.init(
            contentRect: .zero,
            styleMask: [.fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        setupWindow()
        setupContent(alert: alert)
        centerOnScreen()
    }
    
    public override var canBecomeKey: Bool { true }
    public override var canBecomeMain: Bool { true }
    
    private func setupWindow() {
        isMovableByWindowBackground = true
        backgroundColor = .clear
        isOpaque = false
        hasShadow = false
        level = .modalPanel
        titlebarAppearsTransparent = true
        isReleasedWhenClosed = false
        ignoresMouseEvents = false
        titleVisibility = .hidden
        animationBehavior = .alertPanel
        collectionBehavior.insert(.fullScreenAuxiliary)
    }
    
    private func setupContent(alert: NimbusAlert) {
        let alertContainer = NimbusAlertContainer(alert: alert) { [weak self] in
            self?.closeWindow()
        }
        
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let hostingView = NSHostingView(rootView: alertContainer)
        hostingView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(hostingView)
        NSLayoutConstraint.activate([
            hostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            hostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            hostingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            hostingView.widthAnchor.constraint(lessThanOrEqualToConstant: 400)
        ])
        
        contentView = view

        sizeToContent()
    }
    
    private func sizeToContent() {
        guard let contentView = contentView else { return }
        
        let fittingSize = contentView.fittingSize
        let newSize = NSSize(
            width: max(400, fittingSize.width),
            height: fittingSize.height
        )
        
        setContentSize(newSize)
        centerOnScreen()
    }
    
    private func centerOnScreen() {
        // Get the best available screen - prefer main screen as fallback
        guard let screen = NSScreen.current ?? NSScreen.main else {
            NSLog("Alert: No screen available for positioning")
            return
        }
        
        let screenRect = screen.visibleFrame
        let windowRect = frame
        
        // Calculate centered position
        var newOrigin = NSPoint(
            x: screenRect.midX - windowRect.width / 2,
            y: screenRect.midY - windowRect.height / 2
        )
        
        let padding: CGFloat = 20
        
        // Horizontal bounds checking
        let minX = screenRect.minX + padding
        let maxX = screenRect.maxX - windowRect.width - padding
        newOrigin.x = min(maxX, max(minX, newOrigin.x))
        
        // Vertical bounds checking
        let minY = screenRect.minY + padding
        let maxY = screenRect.maxY - windowRect.height - padding
        newOrigin.y = min(maxY, max(minY, newOrigin.y))
        
        // Account for menu bar and dock by ensuring we're in the visible frame
        if newOrigin.y + windowRect.height > screenRect.maxY {
            newOrigin.y = screenRect.maxY - windowRect.height - padding
        }
        
        setFrameOrigin(newOrigin)
    }
    
    public func closeWindow() {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.2
            context.timingFunction = CAMediaTimingFunction(name: .easeIn)
            self.animator().alphaValue = 0.0
        }) {
            if self.isModal {
                NSApp.stopModal()
            }

            self.close()
            self.completion?()
        }
    }
    
    public func runModal() {
        guard !isModal else {
            return
        }
        
        isModal = true
        DispatchQueue.main.async {
            NSApp.runModal(for: self)
        }
    }
    
    public func show() {
        isModal = false
        makeKeyAndOrderFront(nil)
    }
}

// MARK: - Alert Container

private struct NimbusAlertContainer: View {
    let alert: NimbusAlert
    let onDismiss: () -> Void
    
    var body: some View {
        alert
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


// MARK: - Static Presentation Methods

public extension NimbusAlertWindow {
    static func showModal(
        alert: NimbusAlert,
        completion: (() -> Void)? = nil
    ) {
        let window = NimbusAlertWindow(alert: alert, completion: completion)
        window.runModal()
    }
    
    static func show(
        alert: NimbusAlert,
        completion: (() -> Void)? = nil
    ) {
        let window = NimbusAlertWindow(alert: alert, completion: completion)
        window.show()
    }
}
