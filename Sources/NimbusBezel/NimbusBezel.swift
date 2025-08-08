//
//  NimbusBezel.swift
//  NimbusBezel
//
//  Created by Ivan Sapozhnik on 08.08.25.
//

import AppKit
import SwiftUI
@_exported import NimbusCore

// This module provides the NimbusUI bezel system:
// - System-style notification bezels
// - Smooth presentation animations
// - Theme integration and customization
// - macOS system-like visual design
// - Programmatic API for standalone usage

// adapted from https://raw.githubusercontent.com/avaidyam/Parrot/refs/heads/master/MochaUI/SystemBezel.swift

/// Defines the positioning options for bezel display
public enum BezelPosition: CaseIterable {
    case center
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

/// A NimbusBezel is an on-screen view containing a quick message for the user.
///
/// NimbusBezel provides a programmatic API for standalone usage, perfect for menubar
/// applications and system-level notifications. It integrates with the NimbusUI theming
/// system for consistent styling across your application.
public class NimbusBezel: Hashable, Equatable {
    
    // MARK: - Configuration
    
    /// The theme used for styling the bezel
    private let theme: NimbusTheming
    
    /// The color scheme for appearance (light/dark mode)
    private let colorScheme: ColorScheme
    
    /// The position where the bezel should be displayed
    private let position: BezelPosition
    
    /// The currently displayed on-screen bezel. Changing this value causes the (possible)
    /// `oldValue` to be hidden and the (possible) `newValue` to be shown, if applicable.
    private static var currentBezel: NimbusBezel? = nil {
        didSet {
            let newValue = currentBezel
            if oldValue != nil && newValue == nil /* hide old! */ {
                oldValue!.performHide()
            } else if oldValue == nil && newValue != nil /* show new! */ {
                newValue!.performShow()
            } else if oldValue != nil && newValue != nil /* switch */ {
                oldValue!.performHide { newValue!.performShow() }
            } else /* nil->nil */ {}
        }
    }
    
    /// The queue of bezels awaiting on-screen display. If there are no bezels in the
    /// queue, and one is added, it is immediately displayed; otherwise, it is displayed
    /// only when all preceeding bezels have been displayed and hidden.
    private static var bezelQueue: [NimbusBezel] = [] {
        didSet {
            guard bezelQueue.count > 0 && currentBezel == nil else { return }
            currentBezel = bezelQueue.removeFirst()
            triggerNext()
        }
    }
    
    /// If a bezel declares an interval of time to be placed on-screen, after that delay
    /// the bezel will be hidden and the next (possible) bezel in the queue will be
    /// shown automatically.
    private static func triggerNext() {
        if let i = currentBezel?.hideInterval {
            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                currentBezel = bezelQueue.count > 0 ? bezelQueue.removeFirst() : nil
                triggerNext()
            }
        }
    }
    
    /// The internal window used by the bezel.
    private let window: NSWindow
    
    /// The internal effect view used by the bezel.
    private let effectView: NSVisualEffectView
    
    /// The interval of time the bezel should be displayed on-screen before it is
    /// automatically hidden.
    private var hideInterval: DispatchTimeInterval? = nil
    
    /// The view displayed within the bezel.
    public var contentView: NSView? = nil {
        didSet {
            oldValue?.removeFromSuperview()
            if let n = contentView {
                effectView.addSubview(n)
                let padding = theme.bezelContentPadding
                n.frame = effectView.bounds.insetBy(dx: padding, dy: padding)
            }
        }
    }
    
    /// The appearance of the bezel. If `nil`, it follows the system appearance.
    public var appearance: NSAppearance? = nil {
        didSet {
            window.appearance = appearance ?? NSAppearance.system
            effectView.appearance = window.appearance
        }
    }
    
    /// Creates a new default unqueued bezel with no content.
    /// Uses the default theme and automatically detects system color scheme.
    public convenience init(position: BezelPosition = .bottom) {
        self.init(theme: NimbusTheme.default, position: position)
    }
    
    /// Creates a new default unqueued bezel with specified theme.
    /// Automatically detects system color scheme.
    public convenience init(theme: NimbusTheming, position: BezelPosition = .bottom) {
        let systemColorScheme: ColorScheme = {
            let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
            return isDark ? .dark : .light
        }()
        
        self.init(theme: theme, colorScheme: systemColorScheme, position: position)
    }
    
    /// Creates a new default unqueued bezel with specified theme, color scheme, and position.
    /// This is the designated initializer.
    public init(theme: NimbusTheming, colorScheme: ColorScheme, position: BezelPosition = .bottom) {
        self.theme = theme
        self.colorScheme = colorScheme
        self.position = position
        
        let cornerRadius = theme.bezelCornerRadius
        let bezelSize = theme.bezelSize
        let bezelFrame = NSRect(x: 0, y: theme.bezelPositionOffset, 
                               width: bezelSize.width, height: bezelSize.height)
        
        window = NSWindow(contentRect: bezelFrame,
                         styleMask: .borderless, backing: .buffered, defer: false)
        effectView = NSVisualEffectView(frame: NSRect(origin: .zero, size: bezelSize))
        
        setupWindow()
        setupEffectView(cornerRadius: cornerRadius)
    }
    
    /// Sets up the window with theme-aware configuration
    private func setupWindow() {
        window.isMovable = false
        window.ignoresMouseEvents = true
        window.acceptsMouseMovedEvents = false
        window.backgroundColor = .clear
        window.isOpaque = false
        window.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.cursorWindow)))
        window.isReleasedWhenClosed = false
        window.collectionBehavior = [.canJoinAllSpaces, .ignoresCycle, .stationary,
                                    .fullScreenAuxiliary, .fullScreenDisallowsTiling]
//        window.setValue(true, forKey: "preventsActivation") // Private API ⚠️
        window.appearance = colorScheme == .dark ? NSAppearance(named: .darkAqua) : NSAppearance(named: .aqua)
        
        window.contentView = effectView
        window.contentView?.superview?.wantsLayer = true // root
    }
    
    /// Sets up the effect view with theme-aware configuration
    private func setupEffectView(cornerRadius: CGFloat) {
        effectView.state = .active
        effectView.blendingMode = .behindWindow
        effectView.maskImage = maskImage(cornerRadius: cornerRadius)
        effectView.appearance = window.appearance
        effectView.material = theme.bezelBlurMaterial
    }
    
    /// Creates a new unqueued bezel with an image.
    public convenience init(image: NSImage?, position: BezelPosition = .bottom) {
        self.init(position: position)
        let imageView = BezelImageView()
        imageView.image = image
        setupContentView(imageView)
    }
    
    /// Creates a new unqueued bezel with an image and text.
    public convenience init(image: NSImage?, text: String?, position: BezelPosition = .bottom) {
        self.init(position: position)
        let imageTextView = BezelImageTextView()
        imageTextView.image = image
        imageTextView.text = text
        setupContentView(imageTextView)
    }
    
    /// Creates a new unqueued bezel with an image and optional theme.
    public convenience init(image: NSImage?, theme: NimbusTheming, position: BezelPosition = .bottom) {
        self.init(theme: theme, position: position)
        let imageView = BezelImageView()
        imageView.image = image
        setupContentView(imageView)
    }
    
    /// Creates a new unqueued bezel with an image, text and optional theme.
    public convenience init(image: NSImage?, text: String?, theme: NimbusTheming, position: BezelPosition = .bottom) {
        self.init(theme: theme, position: position)
        let imageTextView = BezelImageTextView()
        imageTextView.image = image
        imageTextView.text = text
        setupContentView(imageTextView)
    }
    
    /// Creates a new unqueued bezel with an image, theme, and color scheme.
    public convenience init(image: NSImage?, theme: NimbusTheming, colorScheme: ColorScheme, position: BezelPosition = .bottom) {
        self.init(theme: theme, colorScheme: colorScheme, position: position)
        let imageView = BezelImageView()
        imageView.image = image
        setupContentView(imageView)
    }
    
    /// Creates a new unqueued bezel with an image, text, theme, and color scheme.
    public convenience init(image: NSImage?, text: String?, theme: NimbusTheming, colorScheme: ColorScheme, position: BezelPosition = .bottom) {
        self.init(theme: theme, colorScheme: colorScheme, position: position)
        let imageTextView = BezelImageTextView()
        imageTextView.image = image
        imageTextView.text = text
        setupContentView(imageTextView)
    }
    
    /// Helper method to set up content view with theme-aware padding
    private func setupContentView(_ view: NSView) {
        contentView = view
    }
    
    /// Set the visual appearance of the bezel. If `nil`, the bezel takes on
    /// the current system (dark/light) appearance.
    @discardableResult
    public func appearance(_ appearance: NSAppearance?) -> Self {
        self.appearance = appearance
        return self
    }
    
    /// Queues the bezel for display, or displays it immediately if possible.
    @discardableResult
    public func show() -> Self {
        NimbusBezel.bezelQueue.append(self)
        return self
    }
    
    /// If `interval` is `nil`, the bezel is removed from the queue if possible,
    /// or hidden if visible on-screen. If `interval` is defined, then it is set
    /// to be removed after that period of visibility on screen. (show() must occur.)
    @discardableResult
    public func hide(after interval: DispatchTimeInterval? = nil) -> Self {
        if NimbusBezel.currentBezel == self && interval == nil { // we're visible, hide NOW
            NimbusBezel.currentBezel = nil
        } else if NimbusBezel.currentBezel != self && interval == nil { // we're queued, dequeue
            NimbusBezel.bezelQueue.remove(self)
        } else if NimbusBezel.currentBezel == self && interval != nil && hideInterval == nil { // set the autohide now
            hideInterval = interval
            NimbusBezel.triggerNext()
        } else {
            hideInterval = interval
        }
        return self
    }
    
    
    /// Actually set the bezel frame and animate its display on-screen.
    private func performShow(_ handler: @escaping () -> () = {}) {
        positionBezel()
        
        window.alphaValue = 0.0
        window.orderFront(nil)

        NSAnimationContext.runAnimationGroup({
            $0.duration = theme.bezelShowAnimationDuration
            $0.timingFunction = CAMediaTimingFunction(name: .easeIn)
            window.animator().alphaValue = 1.0
        }, completionHandler: handler)
    }
    
    /// Actually hide the bezel and animate it off-screen.
    private func performHide(_ handler: @escaping () -> () = {}) {
        window.alphaValue = 1.0
        NSAnimationContext.runAnimationGroup({
            $0.duration = theme.bezelHideAnimationDuration
            $0.timingFunction = CAMediaTimingFunction(name: .easeOut)
            window.animator().alphaValue = 0.0
        }, completionHandler: {
            self.window.close()
            handler()
        })
    }
    
    /// The round-rect frame the bezel should clip to.
    private func maskImage(cornerRadius: CGFloat) -> NSImage {
        let edge = 2.0 * cornerRadius + 1.0
        let size = NSSize(width: edge, height: edge)
        let inset = NSEdgeInsets(
            top: cornerRadius,
            left: cornerRadius,
            bottom: cornerRadius,
            right: cornerRadius
        )
        
        let maskImage = NSImage(size: size, flipped: false) {
            let bezierPath = NSBezierPath(
                roundedRect: $0,
                xRadius: cornerRadius,
                yRadius: cornerRadius
            )
            NSColor.black.set()
            bezierPath.fill()
            return true
        }
        
        maskImage.capInsets = inset
        maskImage.resizingMode = .stretch
        return maskImage
    }
    
    /// Positions the bezel according to its configured position.
    private func positionBezel() {
        guard let mainScreen = NSScreen.current else { return }
        let screenFrame = mainScreen.frame
        let bezelSize = window.frame.size
        var newFrame = window.frame
        
        switch position {
        case .center:
            // Center horizontally and vertically
            newFrame.origin.x = (screenFrame.width - bezelSize.width) / 2
            newFrame.origin.y = (screenFrame.height - bezelSize.height) / 2
            
        case .top:
            // Center horizontally, position from top
            newFrame.origin.x = (screenFrame.width - bezelSize.width) / 2
            newFrame.origin.y = screenFrame.height - bezelSize.height - theme.bezelTopOffset
            
        case .bottom:
            // Center horizontally, position from bottom
            newFrame.origin.x = (screenFrame.width - bezelSize.width) / 2
            newFrame.origin.y = theme.bezelBottomOffset
            
        case .topLeading:
            // Position from top-left corner
            newFrame.origin.x = theme.bezelHorizontalOffset
            newFrame.origin.y = screenFrame.height - bezelSize.height - theme.bezelTopOffset
            
        case .topTrailing:
            // Position from top-right corner
            newFrame.origin.x = screenFrame.width - bezelSize.width - theme.bezelHorizontalOffset
            newFrame.origin.y = screenFrame.height - bezelSize.height - theme.bezelTopOffset
            
        case .bottomLeading:
            // Position from bottom-left corner
            newFrame.origin.x = theme.bezelHorizontalOffset
            newFrame.origin.y = theme.bezelBottomOffset
            
        case .bottomTrailing:
            // Position from bottom-right corner
            newFrame.origin.x = screenFrame.width - bezelSize.width - theme.bezelHorizontalOffset
            newFrame.origin.y = theme.bezelBottomOffset
        }
        
        window.setFrame(newFrame, display: true, animate: false)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    public static func ==(_ lhs: NimbusBezel, _ rhs: NimbusBezel) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

// MARK: - Static Convenience API

public extension NimbusBezel {
    /// Shows a bezel with an image using the default theme
    /// Perfect for menubar apps that need system-level notifications
    @discardableResult
    static func show(image: NSImage?, position: BezelPosition = .bottom) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, position: position)
        return bezel.show()
    }
    
    /// Shows a bezel with an image and text using the default theme
    /// Perfect for menubar apps that need system-level notifications
    @discardableResult
    static func show(image: NSImage?, text: String?, position: BezelPosition = .bottom) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, text: text, position: position)
        return bezel.show()
    }
    
    /// Shows a bezel with an image using a custom theme
    /// Perfect for menubar apps that need system-level notifications with custom styling
    @discardableResult
    static func show(image: NSImage?, theme: NimbusTheming, position: BezelPosition = .bottom) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, theme: theme, position: position)
        return bezel.show()
    }
    
    /// Shows a bezel with an image and text using a custom theme
    /// Perfect for menubar apps that need system-level notifications with custom styling
    @discardableResult
    static func show(image: NSImage?, text: String?, theme: NimbusTheming, position: BezelPosition = .bottom) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, text: text, theme: theme, position: position)
        return bezel.show()
    }
}

class BezelImageView: NSView {
    
    private lazy var imageView: NSImageView = {
        let v = NSImageView()
        v.wantsLayer = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.imageScaling = .scaleProportionallyUpOrDown
        return v
    }()
    
    var image: NSImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        addSubview(imageView)
        
        leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
}

class BezelImageTextView: NSView {
    
    private lazy var imageView: NSImageView = {
        let v = NSImageView()
        v.wantsLayer = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.imageScaling = .scaleProportionallyUpOrDown
        return v
    }()
    
    private lazy var textField: NSTextField = {
        let v = NSTextField()
        v.wantsLayer = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = NSFont.systemFont(ofSize: 16.0, weight: .regular)
        v.isSelectable = false
        v.isEnabled = true
        v.isBezeled = false
        v.isBordered = false
        v.drawsBackground = false
        v.isContinuous = false
        v.isEditable = false
        v.textColor = .labelColor
        v.lineBreakMode = .byTruncatingTail
        v.alignment = .center
        // TODO: set hugging and resistance priorities
        return v
    }()
    
    var image: NSImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    var text: String? {
        get { return textField.stringValue }
        set { textField.stringValue = newValue ?? "" }
    }
    
    var font: NSFont? {
        get { return textField.font }
        set { textField.font = newValue }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func setup() {
        addSubview(imageView)
        addSubview(textField)
        
        leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        
        leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        
        imageView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10).isActive = true
    }
}

// MARK: - Extensions

extension Array where Element: Equatable {
    /// Removes the first occurrence of the specified element from the array
    @discardableResult
    mutating func remove(_ element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        return remove(at: index)
    }
}

extension NSAppearance {
    /// Returns the current system appearance (light or dark)
    public static var system: NSAppearance {
        // Use UserDefaults for better Swift integration than CFPreferences
        let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
        
        // Fallback to effectiveAppearance if available (macOS 10.14+)
        if #available(macOS 10.14, *) {
            let fallback = NSApp.effectiveAppearance
            return NSAppearance(named: isDark ? .darkAqua : .aqua) ?? fallback
        } else {
            // Pre-10.14 fallback - aqua should always be available
            let fallbackAppearance = NSAppearance(named: isDark ? .vibrantDark : .vibrantLight)
            return fallbackAppearance ?? NSAppearance(named: .aqua) ?? NSAppearance()
        }
    }
    
    /// Notification posted when the system appearance changes
    public static let systemAppearanceDidChangeNotification = NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification")
}
