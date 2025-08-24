//
//  View+NimbusAlert.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI

// MARK: - Core Alert Modifiers

public extension View {
    /// Basic alert with title and actions
    func nimbusAlert(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        actions: [NimbusAlertButton]
    ) -> some View {
        nimbusAlert(
            title,
            message: nil,
            isPresented: isPresented,
            presentationMode: .normal,
            style: .info,
            actions: actions,
            customContent: { EmptyView() }
        )
    }
    
    /// Alert with title, message and actions
    func nimbusAlert(
        _ title: LocalizedStringKey,
        message: LocalizedStringKey?,
        isPresented: Binding<Bool>,
        actions: [NimbusAlertButton]
    ) -> some View {
        nimbusAlert(
            title,
            message: message,
            isPresented: isPresented,
            presentationMode: .normal,
            style: .info,
            actions: actions,
            customContent: { EmptyView() }
        )
    }
    
    /// Full-featured alert with all customization options
    func nimbusAlert(
        _ title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        isPresented: Binding<Bool>,
        presentationMode: NimbusAlertPresentationMode = .normal,
        style: NimbusAlertStyle = .info,
        actions: [NimbusAlertButton],
        @ViewBuilder customContent: @escaping () -> some View = { EmptyView() }
    ) -> some View {
        self.modifier(
            NimbusAlertModifier(
                title: title,
                message: message,
                isPresented: isPresented,
                presentationMode: presentationMode,
                style: style,
                actions: actions,
                customContent: customContent
            )
        )
    }
    
    /// Confirmation dialog equivalent
    func nimbusConfirmationDialog(
        _ title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        isPresented: Binding<Bool>,
        presentationMode: NimbusAlertPresentationMode = .modal,
        actions: [NimbusAlertButton]
    ) -> some View {
        nimbusAlert(
            title,
            message: message,
            isPresented: isPresented,
            presentationMode: presentationMode,
            style: .info,
            actions: actions,
            customContent: { EmptyView() }
        )
    }
}

// MARK: - Alert Modifier

private struct NimbusAlertModifier: ViewModifier {
    let title: LocalizedStringKey
    let message: LocalizedStringKey?
    @Binding var isPresented: Bool
    let presentationMode: NimbusAlertPresentationMode
    let style: NimbusAlertStyle
    let actions: [NimbusAlertButton]
    let customContent: () -> AnyView
    
    @State private var isShowingAlert = false
    
    init(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        isPresented: Binding<Bool>,
        presentationMode: NimbusAlertPresentationMode = .normal,
        style: NimbusAlertStyle = .info,
        actions: [NimbusAlertButton],
        @ViewBuilder customContent: @escaping () -> some View = { EmptyView() }
    ) {
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.presentationMode = presentationMode
        self.style = style
        self.actions = actions
        
        let content = customContent()
        if content is EmptyView {
            self.customContent = { AnyView(EmptyView()) }
        } else {
            self.customContent = { AnyView(content) }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { _, isShowing in
                if isShowing && !isShowingAlert {
                    showAlert()
                }
            }
    }
    
    private func showAlert() {
        // Prevent multiple alerts
        guard !isShowingAlert else { return }
        isShowingAlert = true
        
        var windowRef: NimbusAlertWindow?
        
        let alert = NimbusAlert(
            style: style,
            title: title,
            message: message,
            actions: actions,
            presentationMode: presentationMode,
            onDismiss: {
                windowRef?.closeWindow()
            },
            customContent: customContent
        )
        
        let window = NimbusAlertWindow(alert: alert) {
            DispatchQueue.main.async {
                self.isShowingAlert = false
                self.isPresented = false
            }
        }
        
        windowRef = window
        
        switch presentationMode {
        case .normal:
            window.show()
        case .modal:
            // Run modal on main thread but don't block current execution
            DispatchQueue.main.async {
                window.runModal()
            }
        }
    }
    
}

// MARK: - Convenience Extensions

public extension NimbusAlertButton {
    /// Create a standard OK button
    static func ok(action: @escaping () -> Void = {}) -> NimbusAlertButton {
        NimbusAlertButton("OK", role: nil, action: action)
    }
    
    /// Create a cancel button
    static func cancel(action: @escaping () -> Void = {}) -> NimbusAlertButton {
        NimbusAlertButton("Cancel", role: .cancel, action: action)
    }
    
    /// Create a destructive button
    static func destructive(_ title: LocalizedStringKey, action: @escaping () -> Void = {}) -> NimbusAlertButton {
        NimbusAlertButton(title, role: .destructive, action: action)
    }
    
    /// Create a custom button with title
    static func custom(_ title: LocalizedStringKey, role: ButtonRole? = nil, action: @escaping () -> Void = {}) -> NimbusAlertButton {
        NimbusAlertButton(title, role: role, action: action)
    }
}
