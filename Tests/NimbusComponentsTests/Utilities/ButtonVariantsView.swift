//
//  ButtonVariantsView.swift
//  NimbusUI
//
//  Created by Claude on 04.08.25.
//

import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents

/// Generic button variants view for testing all button styles with consistent layouts.
/// This utility eliminates code duplication between PrimaryButtonVariants, SecondaryButtonVariants, etc.
///
/// **Usage:**
/// ```swift
/// ButtonVariantsView(style: .primary)
/// ButtonVariantsView(style: .secondary)
/// ButtonVariantsView(style: .accent)
/// ```
public struct ButtonVariantsView<S: ButtonStyle>: View {
    private let style: S
    
    public init(style: S) {
        self.style = style
    }
    
    public var body: some View {
        VStack(spacing: 24) {
            // MARK: - ControlSize Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("ControlSize Variations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    Button("Large Primary") {}
                        .buttonStyle(style)
                        .controlSize(.large)
                    
                    Button("Regular Primary") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                    
                    Button("Small Primary") {}
                        .buttonStyle(style)
                        .controlSize(.small)
                    
                    Button("Mini Primary") {}
                        .buttonStyle(style)
                        .controlSize(.mini)
                }
            }
            
            // MARK: - Enhanced Button + Label API
            VStack(alignment: .leading, spacing: 12) {
                Text("Enhanced Button + Label API")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    // Plain text button (baseline)
                    Button("Plain Text Button") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                    
                    // Label with divider
                    Button(action: {}) {
                        Label("Save Document", systemImage: "doc.badge.plus")
                    }
                    .buttonStyle(style)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    
                    // Label without divider
                    Button(action: {}) {
                        Label("Export PDF", systemImage: "square.and.arrow.up")
                    }
                    .buttonStyle(style)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, false)
                    
                    // Icon alignment: trailing
                    Button(action: {}) {
                        Label("Next Step", systemImage: "arrow.right")
                    }
                    .buttonStyle(style)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    .environment(\.nimbusButtonIconAlignment, .trailing)
                    
                    // Custom content padding
                    Button(action: {}) {
                        Label("Custom Padding", systemImage: "square.grid.2x2")
                    }
                    .buttonStyle(style)
                    .controlSize(.regular)
                    .environment(\.nimbusButtonHasDivider, true)
                    .environment(\.nimbusButtonContentPadding, 16)
                }
            }
            
            // MARK: - Aspect Ratio System
            VStack(alignment: .leading, spacing: 12) {
                Text("Aspect Ratio System")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Square button (ideal for icons)
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusAspectRatio, 1.0)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                        
                        Button(action: {}) {
                            Image(systemName: "play.fill")
                        }
                        .buttonStyle(style)
                        .controlSize(.small)
                        .environment(\.nimbusAspectRatio, 1.0)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                    }
                    
                    // Wide banner button
                    Button("Get Started - Call to Action") {}
                        .buttonStyle(style)
                        .controlSize(.large)
                        .environment(\.nimbusAspectRatio, 3.0)
                        .environment(\.nimbusAspectRatioHasFixedHeight, true)
                    
                    // Custom ratio with flexible height
                    Button("Flexible Height") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusAspectRatio, 2.5)
                        .environment(\.nimbusAspectRatioContentMode, .fit)
                        .environment(\.nimbusAspectRatioHasFixedHeight, false)
                }
            }
            
            // MARK: - Environment Overrides
            VStack(alignment: .leading, spacing: 12) {
                Text("Environment Overrides")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    // Custom corner radii
                    Button("Custom Corner Radii") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(16))
                    
                    // Custom height
                    Button("Custom Height") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusMinHeight, 60)
                    
                    // Custom horizontal padding
                    Button("Custom Padding") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusHorizontalPadding, 32)
                    
                    // Custom elevation
                    Button("High Elevation") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusElevation, .high)
                    
                    // Combined overrides
                    Button("Combined Overrides") {}
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonCornerRadii, RectangleCornerRadii(24))
                        .environment(\.nimbusMinHeight, 56)
                        .environment(\.nimbusHorizontalPadding, 28)
                        .environment(\.nimbusElevation, .medium)
                }
            }
            
            // MARK: - Interactive States
            VStack(alignment: .leading, spacing: 12) {
                Text("Interactive States")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Normal state
                        Button("Normal") {}
                            .buttonStyle(style)
                            .controlSize(.regular)
                        
                        // Hover state (requires style-specific handling)
                        normalButton(text: "Hover", withHover: true)
                        
                        // Pressed state (requires style-specific handling)
                        normalButton(text: "Pressed", withPressed: true)
                    }
                    
                    // Interactive states with labels
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Label("Normal", systemImage: "star.fill")
                        }
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                        
                        labelButton(text: "Hover", systemImage: "star.fill", withHover: true)
                        labelButton(text: "Pressed", systemImage: "star.fill", withPressed: true)
                    }
                }
            }
            
            // MARK: - Button States & Roles
            VStack(alignment: .leading, spacing: 12) {
                Text("Button States & Roles")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack(spacing: 12) {
                        // Enabled button
                        Button("Enabled") {}
                            .buttonStyle(style)
                            .controlSize(.regular)
                        
                        // Disabled button
                        Button("Disabled") {}
                            .buttonStyle(style)
                            .controlSize(.regular)
                            .disabled(true)
                    }
                    
                    HStack(spacing: 12) {
                        // Cancel role
                        Button("Cancel", role: .cancel) {}
                            .buttonStyle(style)
                            .controlSize(.regular)
                        
                        // Destructive role
                        Button("Delete", role: .destructive) {}
                            .buttonStyle(style)
                            .controlSize(.regular)
                    }
                    
                    // Combined: Label with role
                    HStack(spacing: 12) {
                        Button(role: .cancel) {
                            // Action
                        } label: {
                            Label("Cancel Upload", systemImage: "xmark.circle")
                        }
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                        
                        Button(role: .destructive) {
                            // Action
                        } label: {
                            Label("Delete File", systemImage: "trash")
                        }
                        .buttonStyle(style)
                        .controlSize(.regular)
                        .environment(\.nimbusButtonHasDivider, true)
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: - Helper Methods for Interactive States
    
    @ViewBuilder
    private func normalButton(text: String, withHover: Bool = false, withPressed: Bool = false) -> some View {
        if withHover {
            if style is PrimaryButtonStyle {
                Button(text) {}
                    .buttonStyle(PrimaryButtonStyle(isHovering: true))
                    .controlSize(.regular)
            } else if style is SecondaryButtonStyle {
                Button(text) {}
                    .buttonStyle(SecondaryButtonStyle(isHovering: true))
                    .controlSize(.regular)
            } else {
                Button(text) {}
                    .buttonStyle(style)
                    .controlSize(.regular)
            }
        } else if withPressed {
            if style is PrimaryButtonStyle {
                Button(text) {}
                    .buttonStyle(PrimaryButtonStyle(isPressed: true))
                    .controlSize(.regular)
            } else if style is SecondaryButtonStyle {
                Button(text) {}
                    .buttonStyle(SecondaryButtonStyle(isPressed: true))
                    .controlSize(.regular)
            } else {
                Button(text) {}
                    .buttonStyle(style)
                    .controlSize(.regular)
            }
        } else {
            Button(text) {}
                .buttonStyle(style)
                .controlSize(.regular)
        }
    }
    
    @ViewBuilder
    private func labelButton(text: String, systemImage: String, withHover: Bool = false, withPressed: Bool = false) -> some View {
        if withHover {
            if style is PrimaryButtonStyle {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            } else if style is SecondaryButtonStyle {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            } else {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(style)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            }
        } else if withPressed {
            if style is PrimaryButtonStyle {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            } else if style is SecondaryButtonStyle {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            } else {
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(style)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            }
        } else {
            Button(action: {}) {
                Label(text, systemImage: systemImage)
            }
            .buttonStyle(style)
            .controlSize(.regular)
            .environment(\.nimbusButtonHasDivider, true)
        }
    }
}

// MARK: - Concrete Type Aliases for Convenience

/// Primary button variants using PrimaryButtonStyle
public typealias PrimaryButtonVariants = ButtonVariantsView<PrimaryButtonStyle>

/// Secondary button variants using SecondaryButtonStyle  
public typealias SecondaryButtonVariants = ButtonVariantsView<SecondaryButtonStyle>

// MARK: - Convenience Factory Methods

extension PrimaryButtonVariants {
    /// Creates button variants for primary button style
    public static func create() -> PrimaryButtonVariants {
        ButtonVariantsView(style: PrimaryButtonStyle())
    }
}

extension SecondaryButtonVariants {
    /// Creates button variants for secondary button style
    public static func create() -> SecondaryButtonVariants {
        ButtonVariantsView(style: SecondaryButtonStyle())
    }
}