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
    AlertPreviewContainer(
        alertType: .info,
        title: "Information",
        message: "This is an informational alert using the new API."
    )
}

#Preview("Success Alert") {
    AlertPreviewContainer(
        alertType: .success,
        title: "Success!",
        message: "Your operation completed successfully."
    )
}

#Preview("Warning Alert") {
    AlertPreviewContainer(
        alertType: .warning,
        title: "Warning",
        message: "Please review your settings before continuing."
    )
}

#Preview("Error Alert") {
    AlertPreviewContainer(
        alertType: .error,
        title: "Error Occurred",
        message: "An unexpected error occurred. Please try again."
    )
}

// MARK: - Action Variations

#Preview("Single Button Alert") {
    AlertPreviewContainer(
        alertType: .singleButton,
        title: "Simple Alert",
        message: "This alert has only one action button."
    )
}

#Preview("Two Button Alert") {
    AlertPreviewContainer(
        alertType: .twoButtons,
        title: "Confirmation",
        message: "Do you want to save your changes?"
    )
}

#Preview("Three Button Alert") {
    AlertPreviewContainer(
        alertType: .threeButtons,
        title: "Multiple Options",
        message: "Choose one of the available actions."
    )
}

#Preview("Destructive Alert") {
    AlertPreviewContainer(
        alertType: .destructive,
        title: "Delete Item",
        message: "This action cannot be undone."
    )
}

// MARK: - Custom Content

#Preview("Alert with Custom Content") {
    AlertPreviewContainer(
        alertType: .customContent,
        title: "Custom Alert",
        message: "This alert contains custom content."
    )
}

#Preview("Alert with Long Content") {
    AlertPreviewContainer(
        alertType: .longContent,
        title: "Long Content Alert",
        message: """
        This is a very long message that contains multiple sentences and should wrap properly within the alert container. It tests how the alert handles extensive content while maintaining proper spacing and readability.
        
        This is a second paragraph to test multi-paragraph content handling.
        """
    )
}

// MARK: - Presentation Modes

#Preview("Modal Presentation") {
    AlertPreviewContainer(
        alertType: .modalPresentation,
        title: "Modal Alert",
        message: "This alert uses modal presentation."
    )
}

#Preview("Confirmation Dialog") {
    AlertPreviewContainer(
        alertType: .confirmationDialog,
        title: "Save Changes?",
        message: "Your changes will be saved to the document."
    )
}

// MARK: - Theme Variations

#Preview("Default Theme") {
    AlertPreviewContainer(
        alertType: .info,
        title: "Default Theme",
        message: "This alert uses the default theme.",
        theme: NimbusTheme.default
    )
}

#Preview("Maritime Theme") {
    AlertPreviewContainer(
        alertType: .success,
        title: "Maritime Theme",
        message: "This alert uses the maritime theme.",
        theme: MaritimeTheme()
    )
}

#Preview("Custom Warm Theme") {
    AlertPreviewContainer(
        alertType: .warning,
        title: "Warm Theme",
        message: "This alert uses a custom warm theme.",
        theme: CustomWarmTheme()
    )
}

// MARK: - Preview Container

struct AlertPreviewContainer: View {
    enum AlertType {
        case info, success, warning, error
        case singleButton, twoButtons, threeButtons, destructive
        case customContent, longContent
        case modalPresentation, confirmationDialog
    }
    
    let alertType: AlertType
    let title: String
    let message: String
    let theme: NimbusTheming
    
    @State private var showAlert = false
    @State private var alertResult = ""
    
    init(
        alertType: AlertType,
        title: String,
        message: String = "",
        theme: NimbusTheming = NimbusTheme.default
    ) {
        self.alertType = alertType
        self.title = title
        self.message = message
        self.theme = theme
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("NimbusAlert Preview")
                .font(.title2)
            
            if !alertResult.isEmpty {
                Text(alertResult)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            
            Button("Show Alert") {
                showAlert = true
            }
            .buttonStyle(.primary)
        }
        .padding()
        .frame(width: 320, height: 200)
        .environment(\.nimbusTheme, theme)
        .background(alertModifier)
    }
    
    @ViewBuilder
    private var alertModifier: some View {
        switch alertType {
        case .info:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .info,
                    actions: [
                        NimbusAlertButton.ok { alertResult = "OK pressed" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .success:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .success,
                    actions: [
                        NimbusAlertButton.ok { alertResult = "Success acknowledged" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .warning:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .warning,
                    actions: [
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Proceed") { alertResult = "Proceeding..." }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .error:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .error,
                    actions: [
                        NimbusAlertButton.custom("Retry") { alertResult = "Retrying..." },
                        NimbusAlertButton.ok { alertResult = "OK pressed" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .singleButton:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    actions: [
                        NimbusAlertButton.ok { alertResult = "Single button pressed" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .twoButtons:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    actions: [
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Save") { alertResult = "Saved!" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .threeButtons:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    actions: [
                        NimbusAlertButton.custom("Later") { alertResult = "Later chosen" },
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Save") { alertResult = "Saved!" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .destructive:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .warning,
                    actions: [
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.destructive("Delete") { alertResult = "Deleted!" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .customContent:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    style: .info,
                    actions: [
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Continue") { alertResult = "Continuing with custom content..." }
                    ],
                    content: {
                        VStack(spacing: 12) {
                            Rectangle()
                                .fill(.blue.gradient)
                                .frame(height: 60)
                                .cornerRadius(8)
                            
                            Text("Custom content area")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    },
                    message: {
                        Text(message)
                    }
                )
            
        case .longContent:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    actions: [
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Continue") { alertResult = "Continuing with long content..." }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .modalPresentation:
            Color.clear
                .nimbusAlert(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    presentationMode: .modal,
                    actions: [
                        NimbusAlertButton.ok { alertResult = "Modal alert dismissed" }
                    ],
                    message: {
                        Text(message)
                    }
                )
            
        case .confirmationDialog:
            Color.clear
                .nimbusConfirmationDialog(
                    LocalizedStringKey(title),
                    isPresented: $showAlert,
                    actions: [
                        NimbusAlertButton.destructive("Don't Save") { alertResult = "Not saved" },
                        NimbusAlertButton.cancel { alertResult = "Cancelled" },
                        NimbusAlertButton.custom("Save") { alertResult = "Saved!" }
                    ]
                )
        }
    }
}

// MARK: - Helper Types

struct EmptyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}