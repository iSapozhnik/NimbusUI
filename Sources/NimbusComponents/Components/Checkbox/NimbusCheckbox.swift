//
//  NimbusCheckbox.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI
import NimbusCore

/// A checkbox component that mimics SwiftUI's Toggle API but renders as a checkbox.
/// Supports theming, disabled states, and smooth animations with a custom-drawn checkmark.
public struct NimbusCheckbox: View {
    @Binding private var isOn: Bool
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    // Environment overrides
    @Environment(\.nimbusCheckboxSize) private var overrideSize
    @Environment(\.nimbusCheckboxCornerRadii) private var overrideCornerRadii
    @Environment(\.nimbusCheckboxBorderWidth) private var overrideBorderWidth
    @Environment(\.nimbusCheckboxStrokeWidth) private var overrideStrokeWidth
    @Environment(\.nimbusCheckboxLineCap) private var overrideLineCap
    
    @State private var isHovering: Bool = false
    
    /// Creates a checkbox with the specified binding.
    /// - Parameter isOn: A binding to the checked state of the checkbox
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    public var body: some View {
        let size = overrideSize ?? theme.checkboxSize
        let cornerRadii = overrideCornerRadii ?? theme.checkboxCornerRadii
        let borderWidth = overrideBorderWidth ?? theme.checkboxBorderWidth
        let strokeWidth = overrideStrokeWidth ?? theme.checkboxStrokeWidth
        let lineCap = overrideLineCap ?? theme.checkboxLineCap
        let color = theme.accentColor(for: colorScheme)
        Button(action: {
            if isEnabled {
                isOn.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                    .fill(isOn ? color.gradient : Color.clear.gradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                            .stroke(
                                isOn ? color.darker(by: 0.1) : theme.borderColor(for: colorScheme),
                                lineWidth: borderWidth
                            )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadii.topLeading)
                            .fill(isHovering && !isOn ? theme.secondaryBackgroundColor(for: colorScheme) : .clear)
                    )
                
                CheckmarkView(
                    isAnimating: isOn,
                    strokeWidth: strokeWidth,
                    lineCap: lineCap,
                    size: size
                )
                .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .frame(width: size, height: size)
        .onHover { hovering in
            if isEnabled {
                withAnimation(theme.animationFast) {
                    isHovering = hovering
                }
            }
        }
    }
}

/// Custom CGPath-based checkmark with stroke animation
private struct CheckmarkView: View {
    let isAnimating: Bool
    let strokeWidth: CGFloat
    let lineCap: CGLineCap
    let size: CGFloat
    
    @State private var strokeProgress: CGFloat = 0.0
    
    var body: some View {
        CheckmarkShape(strokeEnd: strokeProgress)
            .stroke(
                Color.white,
                style: StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: lineCap,
                    lineJoin: .round
                )
            )
            .frame(width: checkmarkSize, height: checkmarkSize)
            .onChange(of: isAnimating) { _, newValue in
                if newValue {
                    // Reset stroke progress and animate
//                    strokeProgress = 0.0
                    
                    // Smooth stroke animation
                    withAnimation(.easeInOut(duration: 0.15)) {
                        strokeProgress = 1.0
                    }
                } else {
                    // Quick stroke reset
                    withAnimation(.easeInOut(duration: 0.15)) {
                        strokeProgress = 0.0
                    }
                }
            }
            .onAppear {
                strokeProgress = isAnimating ? 1.0 : 0.0
            }
    }
    
    /// Checkmark size relative to checkbox size (about 60% of checkbox size)
    private var checkmarkSize: CGFloat {
        size * 0.8
    }
}

/// Custom shape for drawing an animated checkmark using CGPath
private struct CheckmarkShape: Shape {
    var strokeEnd: CGFloat
    
    var animatableData: CGFloat {
        get { strokeEnd }
        set { strokeEnd = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Normalized control points for checkmark (inside unit square)
        let startPoint = CGPoint(x: 0.2, y: 0.5)   // Left edge midY
        let middlePoint = CGPoint(x: 0.45, y: 0.75) // Bottom area, slightly left of center
        let endPoint = CGPoint(x: 0.8, y: 0.25)    // Top right area
        
        // Scale points to actual rect size
        let scaledStart = CGPoint(
            x: startPoint.x * rect.width + rect.minX,
            y: startPoint.y * rect.height + rect.minY
        )
        let scaledMiddle = CGPoint(
            x: middlePoint.x * rect.width + rect.minX,
            y: middlePoint.y * rect.height + rect.minY
        )
        let scaledEnd = CGPoint(
            x: endPoint.x * rect.width + rect.minX,
            y: endPoint.y * rect.height + rect.minY
        )
        
        // Create the checkmark path
        if strokeEnd > 0 {
            path.move(to: scaledStart)
            
            if strokeEnd <= 0.5 {
                // First half: draw from start to middle
                let progress = strokeEnd * 2 // Scale to 0-1 for first segment
                let currentPoint = CGPoint(
                    x: scaledStart.x + (scaledMiddle.x - scaledStart.x) * progress,
                    y: scaledStart.y + (scaledMiddle.y - scaledStart.y) * progress
                )
                path.addLine(to: currentPoint)
            } else {
                // First half complete, draw second half
                path.addLine(to: scaledMiddle)
                
                let progress = (strokeEnd - 0.5) * 2 // Scale to 0-1 for second segment
                let currentPoint = CGPoint(
                    x: scaledMiddle.x + (scaledEnd.x - scaledMiddle.x) * progress,
                    y: scaledMiddle.y + (scaledEnd.y - scaledMiddle.y) * progress
                )
                path.addLine(to: currentPoint)
            }
        }
        
        return path
    }
}
