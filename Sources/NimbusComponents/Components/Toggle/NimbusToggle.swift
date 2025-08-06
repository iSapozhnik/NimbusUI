//
//  NimbusToggle.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

/// A toggle switch component that mimics SwiftUI's Toggle API but renders as an interactive toggle switch.
/// Supports theming, disabled states, drag gestures, and configurable knob shapes with smooth animations.
public struct NimbusToggle: View {
    @Binding private var isOn: Bool
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusToggleKnobSize) private var overrideKnobSize
    @Environment(\.nimbusToggleKnobPadding) private var overrideKnobPadding
    @Environment(\.nimbusToggleShape) private var overrideShapeString
    @Environment(\.nimbusToggleTrackWidth) private var overrideTrackWidth
    @Environment(\.nimbusToggleTrackHeight) private var overrideTrackHeight
    @Environment(\.nimbusToggleAnimationSpring) private var overrideAnimationSpring
    
    @State private var isHovering: Bool = false
    @State private var knobOffset: CGFloat = 0
    @State private var isDragging: Bool = false
    
    /// Creates a toggle switch with the specified binding.
    /// - Parameter isOn: A binding to the toggle state of the switch
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        let knobSize = overrideKnobSize ?? theme.toggleKnobSize
        let knobPadding = overrideKnobPadding ?? theme.toggleKnobPadding
        let toggleShape = parseToggleShape(overrideShapeString ?? theme.toggleDefaultShapeStyle)
        let trackWidth = overrideTrackWidth ?? toggleShape.recommendedTrackWidth(knobSize: knobSize, knobPadding: knobPadding)
        let trackHeight = overrideTrackHeight ?? toggleShape.trackHeight(knobSize: knobSize, knobPadding: knobPadding)
        let animationSpring = overrideAnimationSpring ?? theme.toggleAnimationSpring
        
        let maxKnobOffset = toggleShape.knobTravelDistance(
            trackWidth: trackWidth,
            knobSize: knobSize,
            knobPadding: knobPadding
        )
        
        Button(action: {
            if isEnabled && !isDragging {
                toggle()
            }
        }) {
            ZStack(alignment: .leading) {
                // Track background
                toggleShape.trackShape(
                    knobSize: knobSize,
                    knobPadding: knobPadding,
                    trackWidth: trackWidth,
                    trackHeight: trackHeight
                )
                .fill(trackBackgroundColor)
                .overlay(
                    toggleShape.trackShape(
                        knobSize: knobSize,
                        knobPadding: knobPadding,
                        trackWidth: trackWidth,
                        trackHeight: trackHeight
                    )
                    .stroke(trackBorderColor, lineWidth: 1)
                )
                
                // Knob
                toggleShape.knobShape(for: knobSize)
                    .fill(knobColor)
                    .frame(width: knobSize, height: knobSize)
                    .shadow(color: knobShadowColor, radius: 2, x: 0, y: 1)
                    .offset(x: knobPadding + knobOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if isEnabled {
                                    isDragging = true
                                    let newOffset = max(0, min(maxKnobOffset, value.translation.width + (isOn ? maxKnobOffset : 0)))
                                    knobOffset = newOffset
                                }
                            }
                            .onEnded { value in
                                if isEnabled {
                                    let threshold = maxKnobOffset / 2
                                    let shouldToggle = (knobOffset > threshold) != isOn
                                    
                                    if shouldToggle {
                                        toggle()
                                    } else {
                                        // Animate back to original position
                                        withAnimation(animationSpring) {
                                            knobOffset = isOn ? maxKnobOffset : 0
                                        }
                                    }
                                    
                                    isDragging = false
                                }
                            }
                    )
            }
        }
        .buttonStyle(.plain)
        .frame(width: trackWidth, height: trackHeight)
        .onHover { hovering in
            if isEnabled {
                withAnimation(theme.animationFast) {
                    isHovering = hovering
                }
            }
        }
        .onChange(of: isOn) { _, newValue in
            if !isDragging {
                withAnimation(animationSpring) {
                    knobOffset = newValue ? maxKnobOffset : 0
                }
            }
        }
        .onAppear {
            // Set initial knob position without animation
            let knobSize = overrideKnobSize ?? theme.toggleKnobSize
            let knobPadding = overrideKnobPadding ?? theme.toggleKnobPadding
            let toggleShape = parseToggleShape(overrideShapeString ?? theme.toggleDefaultShapeStyle)
            let trackWidth = overrideTrackWidth ?? toggleShape.recommendedTrackWidth(knobSize: knobSize, knobPadding: knobPadding)
            let maxOffset = toggleShape.knobTravelDistance(
                trackWidth: trackWidth,
                knobSize: knobSize,
                knobPadding: knobPadding
            )
            knobOffset = isOn ? maxOffset : 0
        }
    }
    
    // MARK: - Private Methods
    
    private func toggle() {
        isOn.toggle()
    }
    
    private func parseToggleShape(_ shapeString: String) -> NimbusToggleShape {
        switch shapeString.lowercased() {
        case "circle":
            return .circle
        case "square":
            return .square
        case "pill":
            return .pill
        default:
            // Check if it's a rounded rect with radius
            if shapeString.hasPrefix("roundedRect(") && shapeString.hasSuffix(")") {
                let radiusString = String(shapeString.dropFirst(12).dropLast(1))
                if let radius = Double(radiusString) {
                    return .roundedRect(radius)
                }
            }
            return .circle // Default fallback
        }
    }
    
    // MARK: - Computed Colors
    
    private var trackBackgroundColor: Color {
        if isOn {
            return theme.accentColor(for: colorScheme)
        } else if isHovering {
            return theme.secondaryBackgroundColor(for: colorScheme)
        } else {
            return theme.tertiaryBackgroundColor(for: colorScheme)
        }
    }
    
    private var trackBorderColor: Color {
        if isOn {
            return theme.accentColor(for: colorScheme).darker(by: 0.1)
        } else {
            return theme.borderColor(for: colorScheme)
        }
    }
    
    private var knobColor: Color {
        if isEnabled {
            return Color.white
        } else {
            return theme.tertiaryTextColor(for: colorScheme)
        }
    }
    
    private var knobShadowColor: Color {
        return Color.black.opacity(isEnabled ? 0.2 : 0.1)
    }
}

// MARK: - Color Extensions

private extension Color {
    func darker(by percentage: CGFloat) -> Color {
        return self.opacity(1.0 - percentage)
    }
}