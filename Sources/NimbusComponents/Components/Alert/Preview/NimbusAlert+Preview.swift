//
//  NimbusAlert+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Modal Presentation Examples

#Preview("Info Modal Alert") {
    ModalAlertPreview(
        style: .info,
        title: "Information",
        message: "This is an informational modal alert that appears within the app window with a dimmed background."
    )
}

#Preview("Success Modal Alert") {
    ModalAlertPreview(
        style: .success,
        title: "Success!",
        message: "Your operation completed successfully."
    )
}

#Preview("Warning Modal Alert") {
    ModalAlertPreview(
        style: .warning,
        title: "Warning",
        message: "Please review your settings before continuing."
    )
}

#Preview("Error Modal Alert") {
    ModalAlertPreview(
        style: .error,
        title: "Error Occurred",
        message: "An unexpected error occurred. Please try again."
    )
}

#Preview("Modal Alert with Actions") {
    ModalAlertPreview(
        style: .info,
        title: "Confirmation Required",
        message: "Do you want to save your changes before closing?",
        actions: [
            NimbusAlertButton("Don't Save", role: .cancel) { print("Don't Save pressed") },
            NimbusAlertButton("Cancel") { print("Cancel pressed") },
            NimbusAlertButton("Save") { print("Save pressed") }
        ]
    )
}

#Preview("Modal Alert with Custom Content") {
    ModalAlertPreview(
        style: .warning,
        title: "Delete Items",
        message: "The following items will be permanently deleted:",
        actions: [
            NimbusAlertButton("Cancel", role: .cancel) { print("Cancelled") },
            NimbusAlertButton("Delete", role: .destructive) { print("Items deleted") }
        ],
        hasCustomContent: true
    )
}

// MARK: - Global Window Presentation Examples

#Preview("Global Info Alert") {
    GlobalAlertPreview(
        style: .info,
        title: "Global Information",
        message: "This alert appears as a separate window above all other applications."
    )
}

#Preview("Global Error Alert") {
    GlobalAlertPreview(
        style: .error,
        title: "System Error",
        message: "A system-level error occurred that requires immediate attention.",
        actions: [
            NimbusAlertButton("Restart", role: .destructive) { print("Restarting...") },
            NimbusAlertButton("Ignore") { print("Ignoring error") }
        ]
    )
}

#Preview("Global Modal Alert (View Modifier)") {
    GlobalModalAlertPreview()
}

// MARK: - Theme Variations

#Preview("Modal Alert - Maritime Theme") {
    ModalAlertPreview(
        style: .success,
        title: "Maritime Theme",
        message: "This modal alert uses the maritime theme with custom styling.",
        theme: MaritimeTheme()
    )
}

#Preview("Modal Alert - Custom Warm Theme") {
    ModalAlertPreview(
        style: .warning,
        title: "Custom Warm Theme",
        message: "This modal alert uses a custom warm theme with enhanced colors.",
        theme: CustomWarmTheme()
    )
}

// MARK: - Modal Alert Preview Container

struct ModalAlertPreview: View {
    let style: NimbusAlertStyle
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let actions: [NimbusAlertButton]
    let theme: NimbusTheming
    let hasCustomContent: Bool
    
    @State private var showAlert = false
    @State private var actionResult = "Tap 'Show Alert' to display the modal alert"
    
    init(
        style: NimbusAlertStyle,
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        actions: [NimbusAlertButton] = [NimbusAlertButton("OK") {}],
        theme: NimbusTheming = NimbusTheme.default,
        hasCustomContent: Bool = false
    ) {
        self.style = style
        self.title = title
        self.message = message
        self.actions = actions
        self.theme = theme
        self.hasCustomContent = hasCustomContent
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("NimbusAlert Modal Preview")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("In-App Modal Presentation")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 16) {
                // Sample content to show modal overlay effect
                ForEach(0..<3, id: \.self) { index in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue.opacity(0.1))
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sample Content \(index + 1)")
                                .fontWeight(.medium)
                            Text("This content will be dimmed when alert appears")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                Button("Show Alert") {
                    actionResult = "Alert is showing..."
                    showAlert = true
                }
                .buttonStyle(.primary)
                .controlSize(.large)
            }
            
            if !actionResult.isEmpty {
                Text(actionResult)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
        .frame(width: 400, height: 500)
        .environment(\.nimbusTheme, theme)
        .nimbusModalAlert(
            isPresented: $showAlert,
            style: style,
            title: title,
            message: message,
            actions: actions,
            onDismiss: {
                actionResult = "Alert was dismissed"
            }
        ) {
            if hasCustomContent {
                customContentView
            }
        }
    }
    
    @ViewBuilder
    private var customContentView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(["Document 1.txt", "Document 2.pdf", "Image.jpg"], id: \.self) { filename in
                    VStack(spacing: 4) {
                        Image(systemName: filename.contains(".jpg") ? "photo" : "doc.text")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        Text(filename)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                    }
                    .padding(8)
                    .background(.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            Text("3 items selected")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Global Alert Preview Container

struct GlobalAlertPreview: View {
    let style: NimbusAlertStyle
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let actions: [NimbusAlertButton]
    let theme: NimbusTheming
    
    @State private var actionResult = "Tap 'Show Global Alert' to display the system-level alert"
    
    init(
        style: NimbusAlertStyle,
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        actions: [NimbusAlertButton] = [NimbusAlertButton("OK") {}],
        theme: NimbusTheming = NimbusTheme.default
    ) {
        self.style = style
        self.title = title
        self.message = message
        self.actions = actions
        self.theme = theme
    }
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("NimbusAlert Global Preview")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("System-Level Window Presentation")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 16) {
                Text("Global alerts appear as separate windows above all applications, perfect for system-level notifications and critical alerts.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                
                Button("Show Global Alert") {
                    actionResult = "Global alert window opened..."
                    showGlobalAlert()
                }
                .buttonStyle(.accent)
                .controlSize(.large)
            }
            
            if !actionResult.isEmpty {
                Text(actionResult)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding()
//        .frame(width: 400, height: 300)
        .environment(\.nimbusTheme, theme)
    }
    
    private func showGlobalAlert() {
        let alert = NimbusAlert(
            style: style,
            title: title,
            message: message,
            actions: actions,
            presentationMode: .modal,
            onDismiss: {
                actionResult = "Global alert was dismissed"
            }
        )
        
        // Show as modal window
        NimbusAlertWindow.showModal(alert: alert) {
            print("Global alert completion")
        }
    }
}

// MARK: - Global Modal Alert Preview (View Modifier Testing)

struct GlobalModalAlertPreview: View {
    @State private var showModalAlert = false
    @State private var showNonModalAlert = false
    @State private var resultText = "Test both global alert presentation modes"
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Global Alert Testing")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Test both modal and non-modal global alerts using view modifiers")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                Button("Show Global Modal Alert") {
                    resultText = "Modal alert showing - app should be blocked"
                    showModalAlert = true
                }
                .buttonStyle(.accent)
                .controlSize(.large)
                
                Button("Show Global Non-Modal Alert") {
                    resultText = "Non-modal alert showing - app should remain interactive"
                    showNonModalAlert = true
                }
                .buttonStyle(.primary)
                .controlSize(.large)
            }
            
            Text(resultText)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .frame(width: 400, height: 350)
        .nimbusAlert(
            "Global Modal Alert",
            message: "This is a modal global alert. You should not be able to interact with the app until you dismiss this alert.",
            isPresented: $showModalAlert,
            presentationMode: .modal,
            style: .warning,
            actions: [
                .cancel { print("Modal alert cancelled") },
                .custom("OK") { print("Modal alert confirmed") }
            ]
        )
        .nimbusAlert(
            "Global Non-Modal Alert", 
            message: "This is a non-modal global alert. You should still be able to interact with the app while this alert is visible.",
            isPresented: $showNonModalAlert,
            presentationMode: .normal,
            style: .info,
            actions: [
                .ok { print("Non-modal alert dismissed") }
            ]
        )
        .onChange(of: showModalAlert) { _, newValue in
            if !newValue {
                resultText = "Modal alert was dismissed - app is interactive again"
            }
        }
        .onChange(of: showNonModalAlert) { _, newValue in
            if !newValue {
                resultText = "Non-modal alert was dismissed"
            }
        }
    }
}
