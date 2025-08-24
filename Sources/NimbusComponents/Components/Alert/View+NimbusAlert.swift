//
//  View+NimbusAlert.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI

// MARK: - Core Alert Modifiers

public extension View {
    /// Basic alert with title and actions (using button array)
    func nimbusAlert(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        actions: [NimbusAlertButton]
    ) -> some View {
        nimbusAlert(
            title,
            isPresented: isPresented,
            presentationMode: .normal,
            style: .info,
            actions: actions,
            content: { EmptyView() },
            message: { EmptyView() }
        )
    }
    
    /// Alert with title, actions, and message (using button array)
    func nimbusAlert(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        actions: [NimbusAlertButton],
        @ViewBuilder message: @escaping () -> some View
    ) -> some View {
        nimbusAlert(
            title,
            isPresented: isPresented,
            presentationMode: .normal,
            style: .info,
            actions: actions,
            content: { EmptyView() },
            message: message
        )
    }
    
    /// Full-featured alert with all customization options (using button array)
    func nimbusAlert(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        presentationMode: NimbusAlertPresentationMode = .normal,
        style: NimbusAlertStyle = .info,
        actions: [NimbusAlertButton],
        @ViewBuilder content: @escaping () -> some View = { EmptyView() },
        @ViewBuilder message: @escaping () -> some View = { EmptyView() }
    ) -> some View {
        self
            .onChange(of: isPresented.wrappedValue) { _, isShowing in
                if isShowing {
                    let alert = NimbusAlert(
                        style: style,
                        title: title,
                        actions: actions,
                        onDismiss: { isPresented.wrappedValue = false },
                        messageContent: message,
                        customContent: content
                    )
                    
                    switch presentationMode {
                    case .normal:
                        // TODO: Implement normal presentation using overlay
                        // For now, fall back to modal
                        NimbusAlertWindow.showModal(alert: alert) { _ in
                            isPresented.wrappedValue = false
                        }
                    case .modal:
                        NimbusAlertWindow.showModal(alert: alert) { _ in
                            isPresented.wrappedValue = false
                        }
                    }
                }
            }
    }
    
    /// Confirmation dialog equivalent
    func nimbusConfirmationDialog(
        _ title: LocalizedStringKey,
        isPresented: Binding<Bool>,
        presentationMode: NimbusAlertPresentationMode = .modal,
        actions: [NimbusAlertButton]
    ) -> some View {
        nimbusAlert(
            title,
            isPresented: isPresented,
            presentationMode: presentationMode,
            style: .info,
            actions: actions,
            content: { EmptyView() },
            message: { EmptyView() }
        )
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