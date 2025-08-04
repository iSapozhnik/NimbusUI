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
        switch (withHover, withPressed) {
        case (true, false):
            switch style {
            case is PrimaryButtonStyle:
                Button(text) {}
                    .buttonStyle(PrimaryButtonStyle(isHovering: true))
                    .controlSize(.regular)
            case is SecondaryButtonStyle:
                Button(text) {}
                    .buttonStyle(SecondaryButtonStyle(isHovering: true))
                    .controlSize(.regular)
            case is AccentButtonStyle:
                Button(text) {}
                    .buttonStyle(AccentButtonStyle(isHovering: true))
                    .controlSize(.regular)
            case is PrimaryOutlineButtonStyle:
                Button(text) {}
                    .buttonStyle(PrimaryOutlineButtonStyle(isHovering: true))
                    .controlSize(.regular)
            case is SecondaryOutlineButtonStyle:
                Button(text) {}
                    .buttonStyle(SecondaryOutlineButtonStyle(isHovering: true))
                    .controlSize(.regular)
            default:
                // LinkButtonStyle and CloseButtonStyle don't support hover states in debug mode
                Button(text) {}
                    .buttonStyle(style)
                    .controlSize(.regular)
            }
        case (false, true):
            switch style {
            case is PrimaryButtonStyle:
                Button(text) {}
                    .buttonStyle(PrimaryButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is SecondaryButtonStyle:
                Button(text) {}
                    .buttonStyle(SecondaryButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is AccentButtonStyle:
                Button(text) {}
                    .buttonStyle(AccentButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is PrimaryOutlineButtonStyle:
                Button(text) {}
                    .buttonStyle(PrimaryOutlineButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is SecondaryOutlineButtonStyle:
                Button(text) {}
                    .buttonStyle(SecondaryOutlineButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is NimbusComponents.LinkButtonStyle:
                Button(text) {}
                    .buttonStyle(NimbusComponents.LinkButtonStyle(isPressed: true))
                    .controlSize(.regular)
            case is CloseButtonStyle:
                Button(text) {}
                    .buttonStyle(CloseButtonStyle(isPressed: true))
                    .controlSize(.regular)
            default:
                // Fallback for any unknown button styles
                Button(text) {}
                    .buttonStyle(style)
                    .controlSize(.regular)
            }
        default:
            Button(text) {}
                .buttonStyle(style)
                .controlSize(.regular)
        }
    }
    
    @ViewBuilder
    private func labelButton(text: String, systemImage: String, withHover: Bool = false, withPressed: Bool = false) -> some View {
        switch (withHover, withPressed) {
        case (true, false):
            switch style {
            case is PrimaryButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is SecondaryButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is AccentButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(AccentButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is PrimaryOutlineButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryOutlineButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is SecondaryOutlineButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryOutlineButtonStyle(isHovering: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            default:
                // LinkButtonStyle and CloseButtonStyle don't support hover states in debug mode
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(style)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            }
        case (false, true):
            switch style {
            case is PrimaryButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is SecondaryButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is AccentButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(AccentButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is PrimaryOutlineButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(PrimaryOutlineButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is SecondaryOutlineButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(SecondaryOutlineButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is NimbusComponents.LinkButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(NimbusComponents.LinkButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            case is CloseButtonStyle:
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(CloseButtonStyle(isPressed: true))
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            default:
                // Fallback for any unknown button styles
                Button(action: {}) {
                    Label(text, systemImage: systemImage)
                }
                .buttonStyle(style)
                .controlSize(.regular)
                .environment(\.nimbusButtonHasDivider, true)
            }
        default:
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

/// Accent button variants using AccentButtonStyle
public typealias AccentButtonVariants = ButtonVariantsView<AccentButtonStyle>

/// Secondary button variants using SecondaryButtonStyle  
public typealias SecondaryButtonVariants = ButtonVariantsView<SecondaryButtonStyle>

/// Primary outline button variants using PrimaryOutlineButtonStyle
public typealias PrimaryOutlineButtonVariants = ButtonVariantsView<PrimaryOutlineButtonStyle>

/// Secondary outline button variants using SecondaryOutlineButtonStyle
public typealias SecondaryOutlineButtonVariants = ButtonVariantsView<SecondaryOutlineButtonStyle>

/// Link button variants using NimbusComponents.LinkButtonStyle
public typealias LinkButtonVariants = ButtonVariantsView<NimbusComponents.LinkButtonStyle>

/// Close button variants using CloseButtonStyle
public typealias CloseButtonVariants = ButtonVariantsView<CloseButtonStyle>

// MARK: - Convenience Factory Methods

extension PrimaryButtonVariants {
    /// Creates button variants for primary button style
    public static func create() -> PrimaryButtonVariants {
        ButtonVariantsView(style: PrimaryButtonStyle())
    }
}

extension AccentButtonVariants {
    /// Creates button variants for accent button style
    public static func create() -> AccentButtonVariants {
        ButtonVariantsView(style: AccentButtonStyle())
    }
}

extension SecondaryButtonVariants {
    /// Creates button variants for secondary button style
    public static func create() -> SecondaryButtonVariants {
        ButtonVariantsView(style: SecondaryButtonStyle())
    }
}

extension PrimaryOutlineButtonVariants {
    /// Creates button variants for primary outline button style
    public static func create() -> PrimaryOutlineButtonVariants {
        ButtonVariantsView(style: PrimaryOutlineButtonStyle())
    }
}

extension SecondaryOutlineButtonVariants {
    /// Creates button variants for secondary outline button style
    public static func create() -> SecondaryOutlineButtonVariants {
        ButtonVariantsView(style: SecondaryOutlineButtonStyle())
    }
}

extension LinkButtonVariants {
    /// Creates button variants for link button style
    public static func create() -> LinkButtonVariants {
        ButtonVariantsView(style: NimbusComponents.LinkButtonStyle())
    }
}

extension CloseButtonVariants {
    /// Creates button variants for close button style
    public static func create() -> CloseButtonVariants {
        ButtonVariantsView(style: CloseButtonStyle())
    }
}
