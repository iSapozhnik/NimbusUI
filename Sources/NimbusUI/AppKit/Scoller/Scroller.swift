//
//  Scroller.swift
//  CustomAppKitScroller
//
//  Created by ChatGPT on 2025-08-02.
//

import Cocoa
import Foundation
import QuartzCore

enum ScrollerType {
    case horizontal
    case vertical
}

class Scroller: NSScroller {

    // MARK: - Configuration
    var knobCornerRadius: CGFloat = 2
    var knobInsetVertical: CGFloat = 6
    var knobInsetHorizontal: CGFloat = 3
    var slotCornerRadius: CGFloat = 5
    var slotInset: CGFloat = 3

    private var type: ScrollerType = .vertical
    private var trackingArea: NSTrackingArea!
    private var isInitialized = false

    // MARK: - Init

    init(withType scrollerType: ScrollerType) {
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

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit() {
        guard !isInitialized else { return }
        isInitialized = true

        wantsLayer = true
        layer?.opacity = 0.3

        trackingArea = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeInActiveApp, .mouseMoved], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }

    // MARK: - Value Override

    override var floatValue: Float {
        get {
            super.floatValue
        }
        set {
            super.floatValue = newValue
            updateAlpha(1.0, animated: true)
            rescheduleFadeOut()
        }
    }

    // MARK: - Drawing

    override func draw(_ dirtyRect: NSRect) {
        drawKnobSlot(in: bounds, highlight: false)
        drawKnob()
    }

    override func drawKnob() {
        NSColor.systemGray.setFill()

        let dx = (type == .horizontal) ? 0 : knobInsetVertical
        let dy = (type == .horizontal) ? knobInsetHorizontal : 0

        let knobFrame = rect(for: .knob).insetBy(dx: dx, dy: dy)
        NSBezierPath(roundedRect: knobFrame, xRadius: knobCornerRadius, yRadius: knobCornerRadius).fill()
    }

//    override func drawKnobSlot(in rect: NSRect, highlight: Bool) {
//        NSColor(white: 0.6, alpha: 0.1).setFill()
//        let slotFrame = rect(for: .knobSlot).insetBy(dx: slotInset, dy: slotInset)
//        NSBezierPath(roundedRect: slotFrame, xRadius: slotCornerRadius, yRadius: slotCornerRadius).fill()
//    }

    // MARK: - Mouse Tracking

    override func updateTrackingAreas() {
        if trackingAreas.contains(trackingArea) {
            removeTrackingArea(trackingArea)
        }

        trackingArea = NSTrackingArea(rect: bounds, options: [.mouseEnteredAndExited, .activeInActiveApp, .mouseMoved], owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        updateAlpha(1.0, animated: true)
        cancelPreviousFadeOut()
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        fadeOut()
    }

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        updateAlpha(1.0, animated: false)
    }

    // MARK: - Alpha Handling

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
