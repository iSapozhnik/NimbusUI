//
//  DirectionalSwipeGestureModifier.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

/// Directional swipe gesture modifier for notification dismissal that adapts to presentation style
struct DirectionalSwipeGestureModifier: ViewModifier {
    
    let presentationStyle: NotificationPresentationStyle
    let onDismiss: () -> Void
    
    @State private var offset: CGSize = .zero
    @State private var isDragging: Bool = false
    
    private let dismissThreshold: CGFloat = 50  // Swipe distance required to dismiss
    
    func body(content: Content) -> some View {
        content
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        isDragging = true
                        offset = calculateOffset(for: value.translation)
                    }
                    .onEnded { value in
                        isDragging = false
                        
                        if shouldDismiss(translation: value.translation) {
                            animateOffScreen()
                        } else {
                            snapBackToPosition()
                        }
                    }
            )
    }
    
    /// Calculates the offset based on presentation style and drag translation
    private func calculateOffset(for translation: CGSize) -> CGSize {
        switch presentationStyle {
        case .slideFromTop, .bounce:
            // Swipe up to dismiss - allow upward movement, rubber band downward
            if translation.height <= 0 {
                return CGSize(width: 0, height: translation.height)
            } else {
                let rubberBandY = rubberBandOffset(distance: translation.height)
                return CGSize(width: 0, height: rubberBandY)
            }
            
        case .slideFromBottom:
            // Swipe down to dismiss - allow downward movement, rubber band upward
            if translation.height >= 0 {
                return CGSize(width: 0, height: translation.height)
            } else {
                let rubberBandY = -rubberBandOffset(distance: -translation.height)
                return CGSize(width: 0, height: rubberBandY)
            }
            
        case .slideFromLeading:
            // Swipe left to dismiss - allow leftward movement, rubber band rightward
            if translation.width <= 0 {
                return CGSize(width: translation.width, height: 0)
            } else {
                let rubberBandX = rubberBandOffset(distance: translation.width)
                return CGSize(width: rubberBandX, height: 0)
            }
            
        case .slideFromTrailing:
            // Swipe right to dismiss - allow rightward movement, rubber band leftward
            if translation.width >= 0 {
                return CGSize(width: translation.width, height: 0)
            } else {
                let rubberBandX = -rubberBandOffset(distance: -translation.width)
                return CGSize(width: rubberBandX, height: 0)
            }
            
        case .fadeIn, .scale:
            // Support both up and down swipes
            if abs(translation.height) > abs(translation.width) {
                // Vertical gesture dominant
                return CGSize(width: 0, height: translation.height)
            } else {
                // Allow some horizontal movement but prefer vertical
                let dampedX = translation.width * 0.3
                return CGSize(width: dampedX, height: translation.height)
            }
        }
    }
    
    /// Determines if the gesture should trigger dismissal
    private func shouldDismiss(translation: CGSize) -> Bool {
        switch presentationStyle {
        case .slideFromTop, .bounce:
            return translation.height < -dismissThreshold
            
        case .slideFromBottom:
            return translation.height > dismissThreshold
            
        case .slideFromLeading:
            return translation.width < -dismissThreshold
            
        case .slideFromTrailing:
            return translation.width > dismissThreshold
            
        case .fadeIn, .scale:
            // Allow dismissal in either vertical direction
            return abs(translation.height) > dismissThreshold
        }
    }
    
    /// Animates the notification off-screen before dismissing
    private func animateOffScreen() {
        let offScreenOffset: CGSize
        
        switch presentationStyle {
        case .slideFromTop, .bounce:
            offScreenOffset = CGSize(width: 0, height: -200)
        case .slideFromBottom:
            offScreenOffset = CGSize(width: 0, height: 200)
        case .slideFromLeading:
            offScreenOffset = CGSize(width: -300, height: 0)
        case .slideFromTrailing:
            offScreenOffset = CGSize(width: 300, height: 0)
        case .fadeIn, .scale:
            // Use the direction of the gesture
            offScreenOffset = offset.height < 0 ? CGSize(width: 0, height: -200) : CGSize(width: 0, height: 200)
        }
        
        withAnimation(.easeOut(duration: 0.3)) {
            offset = offScreenOffset
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
    
    /// Snaps the notification back to original position
    private func snapBackToPosition() {
        withAnimation(.smooth(duration: 0.3, extraBounce: 0.3)) {
            offset = .zero
        }
    }
    
    /// Applies rubber band resistance to constrained movement
    private func rubberBandOffset(distance: CGFloat, limit: CGFloat = 20.0, maxOffset: CGFloat = 60) -> CGFloat {
        if distance <= limit {
            return distance
        } else {
            let excess = distance - limit
            let normalizedExcess = excess / limit
            let rubberBandAmount = (maxOffset - limit) * (1.0 - 1.0 / (1.0 + normalizedExcess * 0.5))
            return limit + rubberBandAmount
        }
    }
}

// MARK: - View Extension

extension View {
    /// Add directional swipe-to-dismiss gesture that adapts to presentation style
    func directionalSwipeToDismiss(
        presentationStyle: NotificationPresentationStyle,
        onDismiss: @escaping () -> Void
    ) -> some View {
        modifier(DirectionalSwipeGestureModifier(
            presentationStyle: presentationStyle,
            onDismiss: onDismiss
        ))
    }
    
    /// Legacy support - simple swipe-up-to-dismiss gesture
    func swipeUpToDismiss(onDismiss: @escaping () -> Void) -> some View {
        directionalSwipeToDismiss(presentationStyle: .slideFromTop, onDismiss: onDismiss)
    }
}
