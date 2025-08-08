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
// - SwiftUI integration and standalone API

// adapted from https://raw.githubusercontent.com/avaidyam/Parrot/refs/heads/master/MochaUI/SystemBezel.swift

/// A NimbusBezel is an on-screen view containing a quick message for the user.
///
/// When the view is shown to the user, it appears as a floating window over all
/// applications, but will never become key. The user will probably not be interacting
/// with your app. The idea is to be as unobtrusive as possible, while still
/// showing the user the information you want them to see. Two examples are the
/// volume control, and a brief message saying that your settings have been saved.
///
/// NimbusBezel supports both SwiftUI integration via view modifiers and standalone usage
/// for menubar applications. It integrates with the NimbusUI theming system for consistent
/// styling across your application.
public class NimbusBezel: Hashable, Equatable {
    
    // MARK: - Configuration
    
    /// The theme used for styling the bezel
    private let theme: NimbusTheming
    
    /// The color scheme for appearance (light/dark mode)
    private let colorScheme: ColorScheme
    
    /// The currently displayed on-screen bezel. Changing this value causes the (possible)
    /// `oldValue` to be hidden and the (possible) `newValue` to be shown, if applicable.
    private static var currentBezel: NimbusBezel? = nil {
        didSet {
            let newValue = self.currentBezel
            if oldValue != nil && newValue == nil /* hide old! */ {
                oldValue!._hide()
            } else if oldValue == nil && newValue != nil /* show new! */ {
                newValue!._show()
            } else if oldValue != nil && newValue != nil /* switch */ {
                oldValue!._hide { newValue!._show() }
            } else /* nil->nil */ {}
        }
    }
    
    /// The queue of bezels awaiting on-screen display. If there are no bezels in the
    /// queue, and one is added, it is immediately displayed; otherwise, it is displayed
    /// only when all preceeding bezels have been displayed and hidden.
    private static var bezelQueue: [NimbusBezel] = [] {
        didSet {
            guard self.bezelQueue.count > 0 && self.currentBezel == nil else { return }
            self.currentBezel = self.bezelQueue.removeFirst()
            self._triggerNext()
        }
    }
    
    /// If a bezel declares an interval of time to be placed on-screen, after that delay
    /// the bezel will be hidden and the next (possible) bezel in the queue will be
    /// shown automatically.
    private static func _triggerNext() {
        if let i = self.currentBezel?.hideInterval {
            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                self.currentBezel = self.bezelQueue.count > 0 ? self.bezelQueue.removeFirst() : nil
                self._triggerNext()
            }
        }
    }
    
    //
    //
    //
    
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
            if let n = self.contentView {
                self.effectView.addSubview(n)
                let padding = theme.bezelContentPadding
                n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
            }
        }
    }
    
    /// The appearance of the bezel. If `nil`, it follows the system appearance.
    public var appearance: NSAppearance? = nil {
        didSet {
            self.window.appearance = self.appearance ?? NSAppearance.system
            self.effectView.appearance = self.window.appearance
        }
    }
    
    /// Creates a new default unqueued bezel with no content.
    /// Uses the default theme and automatically detects system color scheme.
    public convenience init() {
        self.init(theme: NimbusTheme.default)
    }
    
    /// Creates a new default unqueued bezel with specified theme.
    /// Automatically detects system color scheme.
    public convenience init(theme: NimbusTheming) {
        let systemColorScheme: ColorScheme = {
            let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
            return isDark ? .dark : .light
        }()
        
        self.init(theme: theme, colorScheme: systemColorScheme)
    }
    
    /// Creates a new default unqueued bezel with specified theme and color scheme.
    /// This is the designated initializer.
    public init(theme: NimbusTheming, colorScheme: ColorScheme) {
        self.theme = theme
        self.colorScheme = colorScheme
        
        let cornerRadius = theme.bezelCornerRadius
        let bezelSize = theme.bezelSize
        let bezelFrame = NSRect(x: 0, y: theme.bezelPositionOffset, 
                               width: bezelSize.width, height: bezelSize.height)
        
        self.window = NSWindow(contentRect: bezelFrame,
                               styleMask: .borderless, backing: .buffered, defer: false)
        self.effectView = NSVisualEffectView(frame: NSRect(origin: .zero, size: bezelSize))
        
        self._setupWindow()
        self._setupEffectView(cornerRadius: cornerRadius)
    }
    
    /// Sets up the window with theme-aware configuration
    private func _setupWindow() {
        self.window.isMovable = false
        self.window.ignoresMouseEvents = true
        self.window.acceptsMouseMovedEvents = false
        self.window.backgroundColor = .clear
        self.window.isOpaque = false
        self.window.level = NSWindow.Level(rawValue: NSWindow.Level.RawValue(CGWindowLevelForKey(.cursorWindow)))
        self.window.isReleasedWhenClosed = false
        self.window.collectionBehavior = [.canJoinAllSpaces, .ignoresCycle, .stationary,
                                          .fullScreenAuxiliary, .fullScreenDisallowsTiling]
        self.window.setValue(true, forKey: "preventsActivation")
        self.window.appearance = colorScheme == .dark ? NSAppearance(named: .darkAqua) : NSAppearance(named: .aqua)
        
        self.window.contentView = self.effectView
        self.window.contentView?.superview?.wantsLayer = true // root
    }
    
    /// Sets up the effect view with theme-aware configuration
    private func _setupEffectView(cornerRadius: CGFloat) {
        self.effectView.state = .active
        self.effectView.blendingMode = .behindWindow
        self.effectView.maskImage = self._maskImage(cornerRadius: cornerRadius)
        self.effectView.appearance = self.window.appearance
        self.effectView.material = theme.bezelBlurMaterial
    }
    
    /// Creates a new unqueued bezel with an image.
    public convenience init(image: NSImage?) {
        self.init()
        let t = BezelImageView()
        t.image = image
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
    }
    
    /// Creates a new unqueued bezel with an image and text.
    public convenience init(image: NSImage?, text: String?) {
        self.init()
        let t = BezelImageTextView()
        t.image = image
        t.text = text
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
    }
    
    /// Creates a new unqueued bezel with an image and optional theme.
    public convenience init(image: NSImage?, theme: NimbusTheming) {
        self.init(theme: theme)
        let t = BezelImageView()
        t.image = image
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = self.theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
    }
    
    /// Creates a new unqueued bezel with an image, text and optional theme.
    public convenience init(image: NSImage?, text: String?, theme: NimbusTheming) {
        self.init(theme: theme)
        let t = BezelImageTextView()
        t.image = image
        t.text = text
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = self.theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
    }
    
    /// Creates a new unqueued bezel with an image, theme, and color scheme.
    public convenience init(image: NSImage?, theme: NimbusTheming, colorScheme: ColorScheme) {
        self.init(theme: theme, colorScheme: colorScheme)
        let t = BezelImageView()
        t.image = image
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = self.theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
    }
    
    /// Creates a new unqueued bezel with an image, text, theme, and color scheme.
    public convenience init(image: NSImage?, text: String?, theme: NimbusTheming, colorScheme: ColorScheme) {
        self.init(theme: theme, colorScheme: colorScheme)
        let t = BezelImageTextView()
        t.image = image
        t.text = text
        self.contentView = t // doesn't trigger .didset
        if let n = self.contentView { // replace .didset
            self.effectView.addSubview(n)
            let padding = self.theme.bezelContentPadding
            n.frame = self.effectView.bounds.insetBy(dx: padding, dy: padding)
        }
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
        } else if NimbusBezel.currentBezel == self && interval != nil && self.hideInterval == nil { // set the autohide now
            self.hideInterval = interval
            NimbusBezel._triggerNext()
        } else {
            self.hideInterval = interval
        }
        return self
    }
    
    //
    //
    //
    
    /// Actually set the bezel frame and animate its display on-screen.
    private func _show(_ handler: @escaping () -> () = {}) {
        self._centerBezel()
        
        self.window.alphaValue = 0.0
        self.window.orderFront(nil)

        NSAnimationContext.runAnimationGroup({
            $0.duration = theme.bezelShowAnimationDuration
            self.window.animator().alphaValue = 1.0
        }, completionHandler: handler)
    }
    
    /// Actually hide the bezel and animate it off-screen.
    private func _hide(_ handler: @escaping () -> () = {}) {
        self.window.alphaValue = 1.0
        NSAnimationContext.runAnimationGroup({
            $0.duration = theme.bezelHideAnimationDuration
            self.window.animator().alphaValue = 0.0
        }, completionHandler: {
            self.window.close()
            handler()
        })
    }
    
    /// The round-rect frame the bezel should clip to.
    private func _maskImage(cornerRadius c: CGFloat) -> NSImage {
        let edge = 2.0 * c + 1.0
        let size = NSSize(width: edge, height: edge)
        let inset = NSEdgeInsets(top: c, left: c, bottom: c, right: c)
        
        let maskImage = NSImage(size: size, flipped: false) {
            let bezierPath = NSBezierPath(roundedRect: $0, xRadius: c, yRadius: c)
            NSColor.black.set()
            bezierPath.fill()
            return true
        }
        
        maskImage.capInsets = inset
        maskImage.resizingMode = .stretch
        return maskImage
    }
    
    /// Centers the bezel in its system-default position.
    private func _centerBezel() {
        guard let mainScreen = NSScreen.main else { return }
        let screenHorizontalMidPoint = mainScreen.frame.size.width / 2
        var newFrame = self.window.frame
        newFrame.origin.x = screenHorizontalMidPoint - (self.window.frame.size.width / 2)
        self.window.setFrame(newFrame, display: true, animate: false)
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
    static func show(image: NSImage?) -> NimbusBezel {
        let bezel = NimbusBezel(image: image)
        return bezel.show()
    }
    
    /// Shows a bezel with an image and text using the default theme
    /// Perfect for menubar apps that need system-level notifications
    @discardableResult
    static func show(image: NSImage?, text: String?) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, text: text)
        return bezel.show()
    }
    
    /// Shows a bezel with an image using a custom theme
    /// Perfect for menubar apps that need system-level notifications with custom styling
    @discardableResult
    static func show(image: NSImage?, theme: NimbusTheming) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, theme: theme)
        return bezel.show()
    }
    
    /// Shows a bezel with an image and text using a custom theme
    /// Perfect for menubar apps that need system-level notifications with custom styling
    @discardableResult
    static func show(image: NSImage?, text: String?, theme: NimbusTheming) -> NimbusBezel {
        let bezel = NimbusBezel(image: image, text: text, theme: theme)
        return bezel.show()
    }
}

public class BezelImageView: NSView {
    
    private lazy var imageView: NSImageView = {
        let v = NSImageView()
        v.wantsLayer = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.imageScaling = .scaleProportionallyUpOrDown
        return v
    }()
    
    public var image: NSImage? {
        get { return self.imageView.image }
        set { self.imageView.image = newValue }
    }
    
    //
    //
    //
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    public func setup() {
        self.addSubview(self.imageView)
        
        self.leftAnchor.constraint(equalTo: self.imageView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: self.imageView.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
    }
    
    public override var allowsVibrancy: Bool { return true }
}

public class BezelImageTextView: NSView {
    
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
    
    public var image: NSImage? {
        get { return self.imageView.image }
        set { self.imageView.image = newValue }
    }
    
    public var text: String? {
        get { return self.textField.stringValue }
        set { self.textField.stringValue = newValue ?? "" }
    }
    
    public var font: NSFont? {
        get { return self.textField.font }
        set { self.textField.font = newValue }
    }
    
    //
    //
    //
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    public func setup() {
        self.addSubview(self.imageView)
        self.addSubview(self.textField)
        
        self.leftAnchor.constraint(equalTo: self.imageView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: self.imageView.rightAnchor).isActive = true
        self.topAnchor.constraint(equalTo: self.imageView.topAnchor).isActive = true
        
        self.leftAnchor.constraint(equalTo: self.textField.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: self.textField.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor).isActive = true
        
        self.imageView.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: -10).isActive = true
    }
    
    public override var allowsVibrancy: Bool { return true }
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
            // Pre-10.14 fallback
            return NSAppearance(named: isDark ? .vibrantDark : .vibrantLight) ?? NSAppearance(named: .aqua)!
        }
    }
    
    /// Notification posted when the system appearance changes
    public static let systemAppearanceDidChangeNotification = NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification")
}
