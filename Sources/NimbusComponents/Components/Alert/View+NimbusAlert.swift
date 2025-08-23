//
//  View+NimbusAlert.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI

// MARK: - SwiftUI View Modifiers

public extension View {
    func nimbusAlert(
        isPresented: Binding<Bool>,
        alert: @escaping () -> NimbusAlert
    ) -> some View {
        onChange(of: isPresented.wrappedValue) { _, isShowing in
            if isShowing {
                let alertInstance = alert()
                NimbusAlertWindow.showModal(alert: alertInstance) { _ in
                    isPresented.wrappedValue = false
                }
            }
        }
    }
    
    func nimbusAlert(
        isPresented: Binding<Bool>,
        style: NimbusAlertStyle,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        actions: [NimbusAlertAction] = []
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert(
                style: style,
                title: title,
                message: message,
                actions: actions
            )
        }
    }
    
    func nimbusConfirmationAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.confirmDialog(
                title: title,
                message: message,
                confirmTitle: confirmTitle,
                cancelTitle: cancelTitle,
                onConfirm: {
                    onConfirm()
                    isPresented.wrappedValue = false
                },
                onCancel: {
                    onCancel()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
    
    func nimbusDestructiveAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        destructiveTitle: String = "Delete",
        cancelTitle: String = "Cancel",
        onDestroy: @escaping () -> Void,
        onCancel: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.destructiveDialog(
                title: title,
                message: message,
                destructiveTitle: destructiveTitle,
                cancelTitle: cancelTitle,
                onDestroy: {
                    onDestroy()
                    isPresented.wrappedValue = false
                },
                onCancel: {
                    onCancel()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
    
    func nimbusInfoAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.okDialog(
                title: title,
                message: message,
                style: .info,
                okTitle: okTitle,
                onOK: {
                    onOK()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
    
    func nimbusSuccessAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.okDialog(
                title: title,
                message: message,
                style: .success,
                okTitle: okTitle,
                onOK: {
                    onOK()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
    
    func nimbusWarningAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.okDialog(
                title: title,
                message: message,
                style: .warning,
                okTitle: okTitle,
                onOK: {
                    onOK()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
    
    func nimbusErrorAlert(
        isPresented: Binding<Bool>,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> some View {
        nimbusAlert(isPresented: isPresented) {
            NimbusAlert.okDialog(
                title: title,
                message: message,
                style: .error,
                okTitle: okTitle,
                onOK: {
                    onOK()
                    isPresented.wrappedValue = false
                }
            )
        }
    }
}

// MARK: - Static Presentation Methods

public extension NimbusAlert {
    static func showModal(
        _ alert: NimbusAlert,
        completion: ((NSApplication.ModalResponse) -> Void)? = nil
    ) -> NSApplication.ModalResponse {
        return NimbusAlertWindow.showModal(alert: alert, completion: completion)
    }
    
    static func show(
        _ alert: NimbusAlert,
        completion: ((NSApplication.ModalResponse) -> Void)? = nil
    ) {
        NimbusAlertWindow.show(alert: alert, completion: completion)
    }
    
    // MARK: - Quick Static Methods
    
    @discardableResult
    static func showConfirmModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.confirmDialog(
            title: title,
            message: message,
            confirmTitle: confirmTitle,
            cancelTitle: cancelTitle,
            onConfirm: onConfirm,
            onCancel: onCancel
        )
        return showModal(alert)
    }
    
    @discardableResult
    static func showDestructiveModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        destructiveTitle: String = "Delete",
        cancelTitle: String = "Cancel",
        onDestroy: @escaping () -> Void = {},
        onCancel: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.destructiveDialog(
            title: title,
            message: message,
            destructiveTitle: destructiveTitle,
            cancelTitle: cancelTitle,
            onDestroy: onDestroy,
            onCancel: onCancel
        )
        return showModal(alert)
    }
    
    @discardableResult
    static func showInfoModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.okDialog(
            title: title,
            message: message,
            style: .info,
            okTitle: okTitle,
            onOK: onOK
        )
        return showModal(alert)
    }
    
    @discardableResult
    static func showSuccessModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.okDialog(
            title: title,
            message: message,
            style: .success,
            okTitle: okTitle,
            onOK: onOK
        )
        return showModal(alert)
    }
    
    @discardableResult
    static func showWarningModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.okDialog(
            title: title,
            message: message,
            style: .warning,
            okTitle: okTitle,
            onOK: onOK
        )
        return showModal(alert)
    }
    
    @discardableResult
    static func showErrorModal(
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        okTitle: String = "OK",
        onOK: @escaping () -> Void = {}
    ) -> NSApplication.ModalResponse {
        let alert = NimbusAlert.okDialog(
            title: title,
            message: message,
            style: .error,
            okTitle: okTitle,
            onOK: onOK
        )
        return showModal(alert)
    }
}
