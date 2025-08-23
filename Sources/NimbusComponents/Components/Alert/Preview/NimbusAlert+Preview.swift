//
//  NimbusAlert+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Basic Alert Previews

#Preview("Info Alert") {
    NimbusAlert.info(
        title: "This is modal title",
        message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In cursus ipsum vel hendrerit commodo.",
        actions: [
            .cancel("Cancel"),
            .primary("Accept") { print("Accept tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Success Alert") {
    NimbusAlert.success(
        title: "This is modal title",
        message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In cursus ipsum vel hendrerit commodo.",
        actions: [
            .ok("Accept") { print("Accept tapped") },
            .cancel("Cancel")
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Warning Alert") {
    NimbusAlert.warning(
        title: "Destructive Action",
        message: "This action cannot be undone. Are you sure you want to continue?",
        actions: [
            .cancel("Cancel"),
            .destructive("Delete") { print("Delete tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Error Alert") {
    NimbusAlert.error(
        title: "Something went wrong",
        message: "An unexpected error occurred. Please try again later.",
        actions: [
            .ok("OK") { print("OK tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Convenience Method Previews

#Preview("Confirm Dialog") {
    NimbusAlert.confirmDialog(
        title: "Save changes?",
        message: "Your changes will be saved to the document.",
        confirmTitle: "Save",
        cancelTitle: "Don't Save",
        onConfirm: { print("Save confirmed") },
        onCancel: { print("Save cancelled") }
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Destructive Dialog") {
    NimbusAlert.destructiveDialog(
        title: "Delete Project",
        message: "This will permanently delete the project and all its files. This action cannot be undone.",
        destructiveTitle: "Delete",
        cancelTitle: "Cancel",
        onDestroy: { print("Project deleted") },
        onCancel: { print("Deletion cancelled") }
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("OK Dialog") {
    NimbusAlert.okDialog(
        title: "Update Available",
        message: "A new version of the app is available for download.",
        style: .info,
        okTitle: "Got it",
        onOK: { print("OK tapped") }
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Custom Content Preview

#Preview("Alert with Custom Content") {
    NimbusAlert(
        style: .info,
        title: "Custom Alert",
        message: "This alert contains custom content below:",
        actions: [
            .cancel("Cancel"),
            .primary("Continue") { print("Continue tapped") }
        ]
    ) {
        VStack(spacing: 12) {
            Rectangle()
                .fill(.blue.gradient)
                .frame(height: 80)
                .cornerRadius(8)
            
            Text("Custom content area")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Multiple Button Configurations

#Preview("Single Button") {
    NimbusAlert.info(
        title: "Single Action",
        message: "This alert has only one action button.",
        actions: [
            .primary("OK") { print("OK tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Three Buttons") {
    NimbusAlert.warning(
        title: "Multiple Actions",
        message: "Choose one of the available actions:",
        actions: [
            .default("Later") { print("Later tapped") },
            .cancel("Cancel"),
            .primary("Save") { print("Save tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Long Content Previews

#Preview("Long Title") {
    NimbusAlert.info(
        title: "This is a very long title that might wrap to multiple lines to test the layout behavior",
        message: "Short message.",
        actions: [
            .cancel("Cancel"),
            .primary("OK") { print("OK tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Long Message") {
    NimbusAlert.warning(
        title: "Long Content",
        message: """
        This is a very long message that contains multiple sentences and should wrap properly within the alert container. It tests how the alert handles extensive content while maintaining proper spacing and readability. The alert should resize appropriately to accommodate this content without breaking the overall layout or becoming unusable.
        
        This is a second paragraph to test multi-paragraph content handling.
        """,
        actions: [
            .cancel("Cancel"),
            .primary("Continue") { print("Continue tapped") }
        ]
    )
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Theme Variations

#Preview("Maritime Theme") {
    VStack(spacing: 20) {
        NimbusAlert.info(
            title: "Maritime Theme",
            message: "This alert uses the Maritime theme.",
            actions: [
                .cancel("Cancel"),
                .primary("Accept") { print("Accept tapped") }
            ]
        )
        .environment(\.nimbusTheme, MaritimeTheme())
    }
}

#Preview("Custom Warm Theme") {
    NimbusAlert.success(
        title: "Warm Theme",
        message: "This alert demonstrates the custom warm theme.",
        actions: [
            .ok("Great") { print("Great tapped") }
        ]
    )
    .environment(\.nimbusTheme, CustomWarmTheme())
}

// MARK: - Action Builder Syntax Preview

#Preview("Action Builder Syntax") {
    NimbusAlert(
        style: .info,
        title: "Action Builder",
        message: "This alert uses the action builder syntax."
    ) {
        NimbusAlertAction.cancel("Not now")
        NimbusAlertAction.default("Maybe later") { print("Maybe later") }
        NimbusAlertAction.primary("Yes, please") { print("Yes tapped") }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
}

// MARK: - Preview Container for Testing Modal Presentation

struct AlertPreviewContainer: View {
    @State private var showInfo = false
    @State private var showSuccess = false
    @State private var showWarning = false
    @State private var showError = false
    @State private var showConfirm = false
    
    var body: some View {
        VStack(spacing: 16) {
            Button("Show Info Alert") { showInfo = true }
                .buttonStyle(.primary)
            
            Button("Show Success Alert") { showSuccess = true }
                .buttonStyle(.accent)
            
            Button("Show Warning Alert") { showWarning = true }
                .buttonStyle(.secondary)
            
            Button("Show Error Alert") { showError = true }
                .buttonStyle(.primaryOutline)
            
            Button("Show Confirmation") { showConfirm = true }
                .buttonStyle(.secondaryOutline)
        }
        .padding()
        .nimbusInfoAlert(
            isPresented: $showInfo,
            title: "Information",
            message: "This is an informational alert."
        )
        .nimbusSuccessAlert(
            isPresented: $showSuccess,
            title: "Success",
            message: "Operation completed successfully."
        )
        .nimbusWarningAlert(
            isPresented: $showWarning,
            title: "Warning",
            message: "Please review your settings."
        )
        .nimbusErrorAlert(
            isPresented: $showError,
            title: "Error",
            message: "Something went wrong."
        )
        .nimbusConfirmationAlert(
            isPresented: $showConfirm,
            title: "Confirm Action",
            message: "Are you sure you want to proceed?",
            onConfirm: { print("Confirmed") }
        )
    }
}

#Preview("Modal Presentation Test") {
    AlertPreviewContainer()
        .environment(\.nimbusTheme, NimbusTheme.default)
}