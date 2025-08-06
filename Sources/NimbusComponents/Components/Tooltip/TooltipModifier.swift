//
//  TooltipModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Size Measurement (Reference Implementation Pattern)

struct TooltipModifier: ViewModifier {
    @Environment(\.nimbusTheme) private var theme
    
    // Tooltip configuration
    @Binding var isPresented: Bool
    let title: String
    let subtitle: String?
    let icon: Image?
    let position: TooltipPosition
    let hoverDelay: TimeInterval?
    let onDismiss: (() -> Void)?
    
    // Hover-specific configuration
    let enableHover: Bool
    
    // Internal state for animations and hover handling
    @State private var isTooltipVisible = false
    @State private var isHovering = false
    @State private var hoverTimer: Timer?
    @State private var anchorFrame: CGRect = .zero
    // Size measurement using reference implementation pattern
    @State private var contentWidth: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    @State private var screenBounds: CGRect = .zero
    
    // Theme-based environment values
    @Environment(\.nimbusTooltipOffsetDistance) private var offsetDistance
    @Environment(\.nimbusTooltipArrowSize) private var arrowSize
    @Environment(\.nimbusTooltipShowAnimation) private var showAnimation
    @Environment(\.nimbusTooltipHideAnimation) private var hideAnimation
    @Environment(\.nimbusTooltipHoverDelay) private var environmentHoverDelay
    @Environment(\.nimbusTooltipAdaptivePositioning) private var adaptivePositioning
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        subtitle: String? = nil,
        icon: Image? = nil,
        position: TooltipPosition = .top,
        hoverDelay: TimeInterval? = nil,
        enableHover: Bool = true,
        onDismiss: (() -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.position = position
        self.hoverDelay = hoverDelay
        self.enableHover = enableHover
        self.onDismiss = onDismiss
    }
    
    func body(content: Content) -> some View {
        content
//            .background(
//                GeometryReader { geometry in
//                    Color.clear
//                        .onAppear {
//                            anchorFrame = geometry.frame(in: .global)
//                            updateScreenBounds()
//                        }
//                        .onChange(of: geometry.frame(in: .global)) { _, newFrame in
//                            anchorFrame = newFrame
//                            updateScreenBounds()
//                        }
//                }
//            )
            .overlay(
                // Match reference implementation: GeometryReader with no alignment
                GeometryReader { geometry in
                    if isTooltipVisible {
                        tooltipContent
                            .background(sizeMeasurer)
                            .fixedSize(horizontal: true, vertical: false)
                            .fixedSize()
                            .offset(
                                x: calculateOffsetX(geometry),
                                y: calculateOffsetY(geometry)
                            )
                            .animation(effectiveShowAnimation, value: isTooltipVisible)
                            .zIndex(1000)
                    }
                }
            )
            .onHover { hovering in
                if enableHover {
                    handleHover(hovering)
                }
            }
            .onChange(of: isPresented) { _, newValue in
                if newValue && !enableHover {
                    showTooltip()
                } else if !newValue {
                    hideTooltip()
                }
            }
            .onAppear {
                if isPresented && !enableHover {
                    showTooltip()
                }
            }
    }
    
    // MARK: - Private Computed Properties
    
    private var effectiveHoverDelay: TimeInterval {
        hoverDelay ?? environmentHoverDelay ?? theme.tooltipHoverDelay
    }
    
    private var effectiveOffsetDistance: CGFloat {
        offsetDistance ?? theme.tooltipOffsetDistance
    }
    
    private var effectiveArrowSize: CGFloat {
        arrowSize ?? theme.tooltipArrowSize
    }
    
    private var effectiveShowAnimation: Animation {
        showAnimation ?? theme.tooltipShowAnimation
    }
    
    private var effectiveHideAnimation: Animation {
        hideAnimation ?? theme.tooltipHideAnimation
    }
    
    private var actualPosition: TooltipPosition {
        if effectiveAdaptivePositioning && !screenBounds.isEmpty {
            return TooltipPosition.adaptivePosition(
                anchorFrame: anchorFrame,
                screenBounds: screenBounds,
                tooltipSize: currentTooltipSize,
                preferredPosition: position
            )
        }
        return position
    }
    
    private var effectiveAdaptivePositioning: Bool {
        adaptivePositioning ?? theme.tooltipAdaptivePositioning
    }
    
    /// Tooltip content view that allows natural sizing before positioning
    private var tooltipContent: some View {
        NimbusTooltip(
            title: title,
            subtitle: subtitle,
            icon: icon,
            position: actualPosition
        )
    }
    
    /// Size measurer view using reference implementation pattern
    private var sizeMeasurer: some View {
        GeometryReader { g in
            Text("")
                .onAppear {
                    // Use measured size from tooltip content
                    self.contentWidth = g.size.width
                    self.contentHeight = g.size.height
                }
        }
    }
    
    /// Current tooltip size for positioning calculations
    private var currentTooltipSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    
    /// Calculate horizontal offset using reference implementation approach
    private func calculateOffsetX(_ geometry: GeometryProxy) -> CGFloat {
        let spacing = effectiveOffsetDistance
        let arrowSize = effectiveArrowSize
        
        // Use exact reference implementation formulas with measured content size
        switch actualPosition {
        case .leading:
            // Position left: move left by tooltip width + margin + arrow
            return -(contentWidth + spacing + arrowSize)
        case .trailing:
            // Position right: move right by anchor width + margin + arrow
            return geometry.size.width + spacing + arrowSize
        case .top, .bottom:
            // Center horizontally: (anchor width - tooltip width) / 2 - reference line 423
            return (geometry.size.width - contentWidth) / 2
        }
    }
    
    /// Calculate vertical offset using reference implementation approach
    private func calculateOffsetY(_ geometry: GeometryProxy) -> CGFloat {
        let spacing = effectiveOffsetDistance
        let arrowSize = effectiveArrowSize
        
        // Use exact reference implementation formulas - reference lines 429-435
        switch actualPosition {
        case .top:
            // Position above: -(contentHeight + margin + arrowHeight) - reference line 430
            return -(contentHeight + spacing + arrowSize)
        case .bottom:
            // Position below: anchorHeight + margin + arrowHeight - reference line 432
            return geometry.size.height + spacing + arrowSize
        case .leading, .trailing:
            // Center vertically: (anchor height - tooltip height) / 2 - reference line 434
            return (geometry.size.height - contentHeight) / 2
        }
    }
    
    // MARK: - Private Methods
    
    private func handleHover(_ hovering: Bool) {
        isHovering = hovering
        
        if hovering {
            // Start hover delay timer
            hoverTimer = Timer.scheduledTimer(withTimeInterval: effectiveHoverDelay, repeats: false) { _ in
                if isHovering {
                    showTooltip()
                }
            }
        } else {
            // Cancel hover timer and hide tooltip
            hoverTimer?.invalidate()
            hoverTimer = nil
            hideTooltip()
        }
    }
    
    private func showTooltip() {
        // Cancel any existing timer
        hoverTimer?.invalidate()
        hoverTimer = nil
        
        withAnimation(effectiveShowAnimation) {
            isTooltipVisible = true
        }
        
        // Update binding if controlled externally
        if !isPresented {
            isPresented = true
        }
    }
    
    private func hideTooltip() {
        // Cancel any existing timer
        hoverTimer?.invalidate()
        hoverTimer = nil
        
        withAnimation(effectiveHideAnimation) {
            isTooltipVisible = false
        }
        
        // Update binding if controlled externally
        if isPresented {
            isPresented = false
        }
        
        // Call dismiss handler
        onDismiss?()
    }
    
    private func updateScreenBounds() {
        #if os(macOS)
        if let screen = NSScreen.main {
            screenBounds = screen.visibleFrame
        }
        #elseif os(iOS)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            screenBounds = window.bounds
        }
        #endif
    }
}

// MARK: - Hover-Only Tooltip Modifier

struct HoverTooltipModifier: ViewModifier {
    let title: String
    let subtitle: String?
    let icon: Image?
    let position: TooltipPosition
    let hoverDelay: TimeInterval?
    
    @State private var showTooltip = false
    
    func body(content: Content) -> some View {
        content
            .modifier(
                TooltipModifier(
                    isPresented: $showTooltip,
                    title: title,
                    subtitle: subtitle,
                    icon: icon,
                    position: position,
                    hoverDelay: hoverDelay,
                    enableHover: true
                )
            )
    }
}
