//
//  NimbusAlertWindow.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

public final class NimbusAlertWindow: NSWindow {
    private var completion: ((NSApplication.ModalResponse) -> Void)?
    private var isModal: Bool = false
    
    public init(alert: NimbusAlert, completion: ((NSApplication.ModalResponse) -> Void)? = nil) {
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
    
    private func setupWindow() {
        isMovableByWindowBackground = true
        backgroundColor = .clear
        isOpaque = false
        hasShadow = false
        level = .modalPanel
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        animationBehavior = .alertPanel
        collectionBehavior.insert(.fullScreenAuxiliary)
    }
    
    private func setupContent(alert: NimbusAlert) {
        let alertContainer = NimbusAlertContainer(alert: alert) { [weak self] response in
            self?.closeWithResponse(response)
        }
        
        let hostingView = NSHostingView(rootView: alertContainer)
//        hostingView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView = hostingView

        DispatchQueue.main.async {
            self.sizeToContent()
        }
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
        if let screen = NSScreen.current {
            let screenRect = screen.visibleFrame
            let windowRect = frame
            let newOrigin = NSPoint(
                x: screenRect.midX - windowRect.width / 2,
                y: screenRect.midY - windowRect.height / 2
            )
            setFrameOrigin(newOrigin)
        }
    }
    
    private func closeWithResponse(_ response: NSApplication.ModalResponse) {
        if isModal {
            NSApp.stopModal(withCode: response)
        }
        
        close()
        completion?(response)
    }
    
    @discardableResult
    public func runModal() -> NSApplication.ModalResponse {
        isModal = true
        makeKeyAndOrderFront(nil)
        return NSApp.runModal(for: self)
    }
    
    public func show() {
        isModal = false
        makeKeyAndOrderFront(nil)
    }
}

// MARK: - Alert Container

private struct NimbusAlertContainer: View {
    let alert: NimbusAlert
    let onResponse: (NSApplication.ModalResponse) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Semi-transparent background overlay
            Color.clear
                .onTapGesture {
                    // Prevent dismissal by clicking background
                }
            
            alert
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
        .onKeyDown { event in
            handleKeyDown(event)
        }
    }
    
    private func handleKeyDown(_ event: NSEvent) {
        switch event.keyCode {
        case 53: // Escape key
            onResponse(.cancel)
        case 36: // Return key
            onResponse(.OK)
        default:
            break
        }
    }
}

// MARK: - Key Handling Extension

private extension View {
    func onKeyDown(perform action: @escaping (NSEvent) -> Void) -> some View {
        background(KeyEventHandlingView(onKeyDown: action))
    }
}

private struct KeyEventHandlingView: NSViewRepresentable {
    let onKeyDown: (NSEvent) -> Void
    
    func makeNSView(context: Context) -> NSView {
        let view = KeyHandlerNSView()
        view.onKeyDown = onKeyDown
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

private class KeyHandlerNSView: NSView {
    var onKeyDown: ((NSEvent) -> Void)?
    
    override var acceptsFirstResponder: Bool { true }
    
    override func keyDown(with event: NSEvent) {
        onKeyDown?(event)
        super.keyDown(with: event)
    }
}

// MARK: - Static Presentation Methods

public extension NimbusAlertWindow {
    @discardableResult
    static func showModal(
        alert: NimbusAlert,
        completion: ((NSApplication.ModalResponse) -> Void)? = nil
    ) -> NSApplication.ModalResponse {
        let window = NimbusAlertWindow(alert: alert, completion: completion)
        return window.runModal()
    }
    
    static func show(
        alert: NimbusAlert,
        completion: ((NSApplication.ModalResponse) -> Void)? = nil
    ) {
        let window = NimbusAlertWindow(alert: alert, completion: completion)
        window.show()
    }
}
