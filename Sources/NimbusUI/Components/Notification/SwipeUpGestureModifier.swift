//
//  SimpleSwipeGestureModifier.swift
//  NimbusUI
//
//  Created by Claude Code on 03.08.25.
//

import SwiftUI

/// Simple swipe-up gesture modifier for notification dismissal
struct SwipeUpGestureModifier: ViewModifier {
    
    let onDismiss: () -> Void
    
    @State private var offset: CGSize = .zero
    @State private var isDragging: Bool = false
    
    private let dismissThreshold: CGFloat = -50  // Swipe up 50 points to dismiss
    
    func body(content: Content) -> some View {
        content
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        
                        if value.translation.height <= 0 {
                            // Upward movement - allow normal movement
                            offset = CGSize(width: 0, height: value.translation.height)
                        } else {
                            // Downward movement - apply rubber band resistance
                            let rubberBandOffset = rubberBandOffset(distance: value.translation.height, limit: 20.0)
                            offset = CGSize(width: 0, height: rubberBandOffset)
                        }
                    }
                    .onEnded { value in
                        isDragging = false
                        
                        // Check if swipe up threshold was met
                        if value.translation.height < dismissThreshold {
                            // Animate notification off-screen then dismiss
                            withAnimation(.easeOut(duration: 0.3)) {
                                offset = CGSize(width: 0, height: -200)
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onDismiss()
                            }
                        } else {
                            // Snap back to original position
                            withAnimation(.smooth(duration: 0.3, extraBounce: 0.3)) {
                                offset = .zero
                            }
                        }
                    }
            )
    }
    
    func rubberBandOffset(distance: CGFloat, limit: CGFloat = 20.0, maxOffset: CGFloat = 60) -> CGFloat {
        if distance <= limit {
            // Within limit - normal movement
            return distance
        } else {
            // Beyond limit - apply rubber band resistance
            let excess = distance - limit
            let normalizedExcess = excess / limit
            let rubberBandAmount = (maxOffset - limit) * (1.0 - 1.0 / (1.0 + normalizedExcess * 0.5))
            return limit + rubberBandAmount
        }
    }
}

// MARK: - View Extension

extension View {
    /// Add simple swipe-up-to-dismiss gesture
    func swipeUpToDismiss(onDismiss: @escaping () -> Void) -> some View {
        modifier(SwipeUpGestureModifier(onDismiss: onDismiss))
    }
}
