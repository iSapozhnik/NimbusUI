//
//  Scroller.swift
//  CustomAppKitScroller
//
//  Created by ChatGPT on 2025-08-02.
//

import Cocoa
import Foundation
import QuartzCore
import SwiftUI

public enum ScrollerType {
    case horizontal
    case vertical
}

public class Scroller: NSScroller {
    
    // MARK: - Theme Integration
    
    /// Theme reference for accessing design tokens and colors
    public var theme: NimbusTheming = NimbusTheme.default
    public var colorScheme: ColorScheme = .light
    
    // MARK: - Core Configuration Properties
    
    /// Total width/height of the scroller track
    public var scrollerWidth: CGFloat = 16 {
        didSet { needsDisplay = true }
    }
    
    /// Width/height of the draggable knob
    public var scrollerKnobWidth: CGFloat = 6 {
        didSet { needsDisplay = true }
    }
    
    /// Padding between knob and slot edges
    public var scrollerKnobPadding: CGFloat = 2 {
        didSet { needsDisplay = true }
    }
    
    /// Corner radius of the slot background
    public var scrollerSlotCornerRadius: CGFloat = 4 {
        didSet { needsDisplay = true }
    }
    
    /// Auto-calculated knob corner radius (based on knob width and padding)
    public var scrollerKnobCornerRadius: CGFloat {
        (scrollerKnobWidth - scrollerKnobPadding) / 2
    }

    /// Should show scroller slot
    public var showScrollerSlot: Bool = true {
        didSet { needsDisplay = true }
    }
    
    // MARK: - Legacy Properties (for backward compatibility)
    
    var knobCornerRadius: CGFloat = 2
    var knobInsetVertical: CGFloat = 6
    var knobInsetHorizontal: CGFloat = 3
    var slotCornerRadius: CGFloat = 5
    var slotInset: CGFloat = 3
    
    // MARK: - Internal State
    
    private var type: ScrollerType = .vertical
    private var trackingArea: NSTrackingArea!
    private var isInitialized = false
    
    // MARK: - Initialization
    
    public init(withType scrollerType: ScrollerType) {
        self.type = scrollerType
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        guard !isInitialized else { return }
        isInitialized = true
        
        // Configure scroller appearance and behavior
        wantsLayer = true
        layer?.opacity = 0.3
        
        // Set scroller style for modern appearance
        scrollerStyle = .overlay
        knobStyle = .default
        
        setupTrackingArea()
    }
    
    private func setupTrackingArea() {
        if let existingTrackingArea = trackingArea {
            removeTrackingArea(existingTrackingArea)
        }
        
        trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseEnteredAndExited, .activeInActiveApp, .mouseMoved],
            owner: self,
            userInfo: nil
        )
        addTrackingArea(trackingArea)
    }
    
    // MARK: - Value Override
    
    public override var floatValue: Float {
        get {
            super.floatValue
        }
        set {
            super.floatValue = newValue
            updateAlpha(1.0, animated: true)
            rescheduleFadeOut()
        }
    }
    
    // MARK: - Drawing Implementation
    
    public override func draw(_ dirtyRect: NSRect) {
        drawKnobSlot(in: bounds, highlight: false)
        drawKnob()
    }
    
    public override func drawKnobSlot(in rect: NSRect, highlight: Bool) {
        guard showScrollerSlot else { return }
        
        // Use theme colors for slot background
        let slotColor = NSColor(theme.tertiaryBackgroundColor(for: colorScheme))
        slotColor.setFill()
        
        // Calculate slot frame based on scroller width
        var slotFrame = rect
        if type == .vertical {
            // Vertical scroller: center slot horizontally
            let slotWidth = scrollerWidth
            slotFrame.origin.x = (rect.width - slotWidth) / 2
            slotFrame.size.width = slotWidth
        } else {
            // Horizontal scroller: center slot vertically
            let slotHeight = scrollerWidth
            slotFrame.origin.y = (rect.height - slotHeight) / 2
            slotFrame.size.height = slotHeight
        }
        
        // Draw slot with corner radius
        let slotPath = NSBezierPath(roundedRect: slotFrame, 
                                   xRadius: scrollerSlotCornerRadius, 
                                   yRadius: scrollerSlotCornerRadius)
        slotPath.fill()
    }
    
    public override func drawKnob() {
        // Use theme colors for knob
        let knobColor = NSColor(theme.accentColor(for: colorScheme))
        knobColor.setFill()
        
        // Get the knob frame with proper centering and padding
        let knobFrame = calculateKnobFrame()
        
        // Draw knob with auto-calculated corner radius
        let knobPath = NSBezierPath(roundedRect: knobFrame,
                                   xRadius: scrollerKnobCornerRadius,
                                   yRadius: scrollerKnobCornerRadius)
        knobPath.fill()
    }
    
    // MARK: - Rect Calculations
    
    public override func rect(for partCode: NSScroller.Part) -> NSRect {
        switch partCode {
        case .knob:
            return calculateKnobFrame()
        case .knobSlot:
            return calculateSlotFrame()
        default:
            return super.rect(for: partCode)
        }
    }
    
    private func calculateSlotFrame() -> NSRect {
        var slotFrame = bounds
        
        if type == .vertical {
            // Vertical scroller: center slot horizontally
            let slotWidth = scrollerWidth
            slotFrame.origin.x = (bounds.width - slotWidth) / 2
            slotFrame.size.width = slotWidth
        } else {
            // Horizontal scroller: center slot vertically
            let slotHeight = scrollerWidth
            slotFrame.origin.y = (bounds.height - slotHeight) / 2
            slotFrame.size.height = slotHeight
        }
        
        return slotFrame
    }
    
    private func calculateKnobFrame() -> NSRect {
        let slotFrame = calculateSlotFrame()
        var knobFrame = NSRect.zero
        
        if type == .vertical {
            // Vertical scroller
            let availableHeight = slotFrame.height - (2 * scrollerKnobPadding)
            let knobHeight = max(scrollerKnobWidth, availableHeight * CGFloat(knobProportion))
            
            // Calculate the actual travel distance (accounting for knob size and padding)
            let travelDistance = availableHeight - knobHeight
            let scrollPosition = max(0, min(travelDistance, travelDistance * CGFloat(floatValue)))
            
            knobFrame.origin.x = slotFrame.origin.x + (slotFrame.width - scrollerKnobWidth) / 2
            knobFrame.origin.y = slotFrame.origin.y + 2 * scrollerKnobPadding + scrollPosition
            knobFrame.size.width = scrollerKnobWidth
            knobFrame.size.height = knobHeight - 2 * scrollerKnobPadding
        } else {
            // Horizontal scroller
            let availableWidth = slotFrame.width - (2 * scrollerKnobPadding)
            let knobWidth = max(scrollerKnobWidth, availableWidth * CGFloat(knobProportion))
            
            // Calculate the actual travel distance (accounting for knob size and padding)
            let travelDistance = availableWidth - knobWidth
            let scrollPosition = max(0, min(travelDistance, travelDistance * CGFloat(floatValue)))
            
            knobFrame.origin.x = slotFrame.origin.x + 2 * scrollerKnobPadding + scrollPosition
            knobFrame.origin.y = slotFrame.origin.y + (slotFrame.height - scrollerKnobWidth) / 2
            knobFrame.size.width = knobWidth - 2 * scrollerKnobPadding
            knobFrame.size.height = scrollerKnobWidth
        }
        
        return knobFrame
    }
    
    // MARK: - Mouse Tracking
    
    public override func updateTrackingAreas() {
        setupTrackingArea()
    }
    
    public override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        updateAlpha(1.0, animated: true)
        cancelPreviousFadeOut()
    }
    
    public override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        fadeOut()
    }
    
    public override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        updateAlpha(1.0, animated: false)
    }
    
    // MARK: - Alpha/Fade Handling
    
    @objc private func fadeOut() {
        updateAlpha(0.3, animated: true, animationDuration: 0.25)
    }
    
    private func rescheduleFadeOut() {
        cancelPreviousFadeOut()
        perform(#selector(fadeOut), with: nil, afterDelay: 1.0)
    }
    
    private func cancelPreviousFadeOut() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(fadeOut), object: nil)
    }
    
    private func updateAlpha(_ newAlpha: CGFloat, animated: Bool, animationDuration duration: TimeInterval = 0.1) {
        wantsLayer = true
        guard let layer = self.layer else { return }
        
        if animated {
            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = layer.presentation()?.opacity ?? layer.opacity
            fade.toValue = Float(newAlpha)
            fade.duration = duration
            fade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            layer.add(fade, forKey: "fadeOpacity")
        }
        
        layer.opacity = Float(newAlpha)
    }
}
