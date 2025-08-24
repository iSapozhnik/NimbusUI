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
        self
            .onChange(of: isPresented.wrappedValue) { _, isShowing in
                if isShowing {
                    let alert = NimbusAlert(
                        style: style,
                        title: title,
                        message: message,
                        actions: actions,
                        onDismiss: { isPresented.wrappedValue = false },
                        customContent: customContent
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