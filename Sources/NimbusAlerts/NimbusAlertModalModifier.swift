//
//  NimbusAlertModalModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 25.08.25.
//

import SwiftUI
import NimbusCore

struct NimbusAlertModalModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusAlertDimOpacity) private var dimOpacity
    @Environment(\.nimbusAlertAnimationDuration) private var animationDuration
    
    // Alert configuration
    @Binding var isPresented: Bool
    let style: NimbusAlertStyle
    let title: LocalizedStringKey
    let message: LocalizedStringKey?
    let actions: [NimbusAlertButton]
    let customContent: AnyView?
    let onDismiss: (() -> Void)?
    
    // Internal state for animations
    @State private var isAlertVisible = false
    
    private var effectiveDimOpacity: Double {
        dimOpacity ?? theme.alertDimOpacity(for: colorScheme)
    }
    
    private var effectiveAnimationDuration: Double {
        animationDuration ?? theme.alertAnimationDuration
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isAlertVisible {
                    modalOverlay
                        .transition(.opacity.combined(with: .scale(scale: 0.95)))
                        .zIndex(999)
                }
            }
            .onChange(of: isPresented) { oldValue, newValue in
                if newValue {
                    showAlert()
                } else {
                    dismissAlert()
                }
            }
            .onAppear {
                if isPresented {
                    showAlert()
                }
            }
    }
    
    @ViewBuilder
    private var modalOverlay: some View {
        ZStack {
            // Dimmed background
            Color.black
                .opacity(effectiveDimOpacity)
                .ignoresSafeArea(.all)
                .onTapGesture {
                    // Dismiss on background tap
                    dismissAlert()
                    onDismiss?()
                }
            
            // Alert content
            alertView
        }
    }
    
    private var alertView: some View {
        NimbusAlert(
            style: style,
            title: title,
            message: message,
            actions: actions,
            presentationMode: .modal,
            onDismiss: {
                dismissAlert()
                onDismiss?()
            }
        ) {
            if let customContent = customContent {
                customContent
            } else {
                EmptyView()
            }
        }
        .frame(maxWidth: 400)
        .padding(.horizontal, 20)
    }
    
    private func showAlert() {
        let animation = Animation.easeOut(duration: effectiveAnimationDuration)
        withAnimation(animation) {
            isAlertVisible = true
        }
    }
    
    private func dismissAlert() {
        let animation = Animation.easeIn(duration: effectiveAnimationDuration * 0.8)
        withAnimation(animation) {
            isAlertVisible = false
        }
        
        // Reset the binding after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + effectiveAnimationDuration) {
            isPresented = false
        }
    }
}
