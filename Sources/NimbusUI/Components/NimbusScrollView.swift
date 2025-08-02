//
//  NimbusScrollView.swift
//  NimbusUI
//
//  Created by Claude Code on 02.08.25.
//

import SwiftUI
import Cocoa

/// A SwiftUI wrapper for NSScrollView with custom themed scrollers
public struct NimbusScrollView<Content: View>: NSViewRepresentable {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    // Core scroller environment overrides
    @Environment(\.nimbusScrollerWidth) private var overrideScrollerWidth
    @Environment(\.nimbusScrollerKnobWidth) private var overrideScrollerKnobWidth
    @Environment(\.nimbusScrollerKnobPadding) private var overrideScrollerKnobPadding
    @Environment(\.nimbusScrollerSlotCornerRadius) private var overrideSlotCornerRadius
    @Environment(\.nimbusScrollerShowScrollerSlot) private var overrideShowSlot
    
    // Legacy environment overrides (keeping for backward compatibility)
    @Environment(\.nimbusScrollerKnobCornerRadius) private var overrideKnobCornerRadius
    @Environment(\.nimbusScrollerKnobInsetVertical) private var overrideKnobInsetVertical
    @Environment(\.nimbusScrollerKnobInsetHorizontal) private var overrideKnobInsetHorizontal
    @Environment(\.nimbusScrollerSlotInset) private var overrideSlotInset
    @Environment(\.nimbusScrollerInitialOpacity) private var overrideInitialOpacity
    @Environment(\.nimbusScrollerFadeOpacity) private var overrideFadeOpacity
    @Environment(\.nimbusScrollerFadeDelay) private var overrideFadeDelay
    @Environment(\.nimbusScrollerAnimationDuration) private var overrideAnimationDuration
    
    private let content: Content
    private var showsVerticalScrollIndicator: Bool
    private var showsHorizontalScrollIndicator: Bool
    private var showsScrollerSlot: Bool
    private let contentInsets: NSEdgeInsets
    
    /// Creates a NimbusScrollView with the specified content and configuration
    /// - Parameters:
    ///   - contentInsets: Insets applied to the content within the scroll view
    ///   - content: The scrollable content
    public init(
        contentInsets: NSEdgeInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        @ViewBuilder content: () -> Content
    ) {
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = true
        self.showsScrollerSlot = true
        self.contentInsets = contentInsets
        self.content = content()
    }
    
    public func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        
        // Configure scroll view behavior
        scrollView.hasVerticalScroller = showsVerticalScrollIndicator
        scrollView.hasHorizontalScroller = showsHorizontalScrollIndicator
        scrollView.autohidesScrollers = false
        scrollView.scrollerStyle = .overlay
        scrollView.contentInsets = contentInsets
        
        // Configure document view with SwiftUI content
        let hostingView = NSHostingView(rootView: content)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = hostingView
        
        // Configure custom scrollers
        configureScrollers(for: scrollView)
        
        return scrollView
    }
    
    public func updateNSView(_ scrollView: NSScrollView, context: Context) {
        // Update scroll indicator visibility
        scrollView.hasVerticalScroller = showsVerticalScrollIndicator
        scrollView.hasHorizontalScroller = showsHorizontalScrollIndicator
        scrollView.contentInsets = contentInsets
        
        // Update content
        if let hostingView = scrollView.documentView as? NSHostingView<Content> {
            hostingView.rootView = content
        }
        
        // Update scroller configuration
        configureScrollers(for: scrollView)
    }
    
    private func configureScrollers(for scrollView: NSScrollView) {
        // Configure vertical scroller
        if showsVerticalScrollIndicator {
            let verticalScroller = Scroller(withType: .vertical)
            configureScroller(verticalScroller)
            scrollView.verticalScroller = verticalScroller
        }
        
        // Configure horizontal scroller
        if showsHorizontalScrollIndicator {
            let horizontalScroller = Scroller(withType: .horizontal)
            configureScroller(horizontalScroller)
            scrollView.horizontalScroller = horizontalScroller
        }
        
        // Configure slot visibility
        if let horizontalScroller = scrollView.horizontalScroller as? Scroller {
            horizontalScroller.showScrollerSlot = showsScrollerSlot
        }
        if let verticalScroller = scrollView.verticalScroller as? Scroller {
            verticalScroller.showScrollerSlot = showsScrollerSlot
        }
    }
    
    private func configureScroller(_ scroller: Scroller) {
        // Configure theme and color scheme
        scroller.theme = theme
        scroller.colorScheme = colorScheme
        
        // Apply core scroller configuration with environment overrides
        scroller.scrollerWidth = overrideScrollerWidth ?? theme.scrollerWidth
        scroller.scrollerKnobWidth = overrideScrollerKnobWidth ?? theme.scrollerKnobWidth
        scroller.scrollerKnobPadding = overrideScrollerKnobPadding ?? theme.scrollerKnobPadding
        scroller.scrollerSlotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        scroller.showScrollerSlot = overrideShowSlot ?? theme.scrollerShowSlot
        
        // Apply legacy configuration for backward compatibility
        scroller.knobCornerRadius = overrideKnobCornerRadius ?? theme.scrollerKnobCornerRadius
        scroller.knobInsetVertical = overrideKnobInsetVertical ?? theme.scrollerKnobInsetVertical
        scroller.knobInsetHorizontal = overrideKnobInsetHorizontal ?? theme.scrollerKnobInsetHorizontal
        scroller.slotCornerRadius = overrideSlotCornerRadius ?? theme.scrollerSlotCornerRadius
        scroller.slotInset = overrideSlotInset ?? theme.scrollerSlotInset
        
        // Set initial opacity
        let initialOpacity = overrideInitialOpacity ?? theme.scrollerInitialOpacity
        scroller.layer?.opacity = Float(initialOpacity)
    }
    
    // MARK: - Scroller Visibility Modifiers
    
    /// Controls the visibility of the vertical scroller
    /// - Parameter shows: Whether to show the vertical scroller
    /// - Returns: A new NimbusScrollView instance with updated vertical scroller visibility
    public func showsVerticalScroller(_ shows: Bool) -> NimbusScrollView {
        var newScrollView = self
        newScrollView.showsVerticalScrollIndicator = shows
        return newScrollView
    }
    
    /// Controls the visibility of the horizontal scroller
    /// - Parameter shows: Whether to show the horizontal scroller
    /// - Returns: A new NimbusScrollView instance with updated horizontal scroller visibility
    public func showsHorizontalScroller(_ shows: Bool) -> NimbusScrollView {
        var newScrollView = self
        newScrollView.showsHorizontalScrollIndicator = shows
        return newScrollView
    }
    
    /// Controls the visibility of both vertical and horizontal scrollers
    /// - Parameters:
    ///   - vertical: Whether to show the vertical scroller
    ///   - horizontal: Whether to show the horizontal scroller
    /// - Returns: A new NimbusScrollView instance with updated scroller visibility
    public func showsScrollers(vertical: Bool, horizontal: Bool) -> NimbusScrollView {
        var newScrollView = self
        newScrollView.showsVerticalScrollIndicator = vertical
        newScrollView.showsHorizontalScrollIndicator = horizontal
        return newScrollView
    }
    
    /// Hides both vertical and horizontal scrollers
    /// - Returns: A new NimbusScrollView instance with both scrollers hidden
    public func hideScrollers() -> NimbusScrollView {
        return showsScrollers(vertical: false, horizontal: false)
    }

    /// Sets the scroller slot visibility
    /// - Parameter show: Whether to show the scroller slot
    /// - Returns: A new NimbusScrollView instance with updated scroller slot visibility
    public func showScrollerSlot(_ show: Bool) -> NimbusScrollView {
        var newScrollView = self
        newScrollView.showsScrollerSlot = show
        return newScrollView
    }
}

// MARK: - Convenience Modifiers

public extension View {
    /// Sets the scroller track width
    func scrollerWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusScrollerWidth, width)
    }
    
    /// Sets the knob width (thickness)
    func knobWidth(_ width: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobWidth, width)
    }
    
    /// Sets the knob padding within the slot
    func knobPadding(_ padding: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobPadding, padding)
    }
    
    /// Sets the slot corner radius
    func slotCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusScrollerSlotCornerRadius, radius)
    }
    
    /// Sets the scroller slot visibility
    func showScrollerSlot(_ show: Bool) -> some View {
        environment(\.nimbusScrollerShowScrollerSlot, show)
    }
    
    // Legacy modifiers (keeping for backward compatibility)
    
    /// Sets the knob corner radius for the scroller (legacy)
    func knobCornerRadius(_ radius: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobCornerRadius, radius)
    }
    
    /// Sets the knob insets for the scroller (legacy)
    func knobInsets(vertical: CGFloat, horizontal: CGFloat) -> some View {
        environment(\.nimbusScrollerKnobInsetVertical, vertical)
            .environment(\.nimbusScrollerKnobInsetHorizontal, horizontal)
    }
    
    /// Sets the slot inset for the scroller (legacy)
    func slotInset(_ inset: CGFloat) -> some View {
        environment(\.nimbusScrollerSlotInset, inset)
    }
    
    /// Sets the initial opacity for the scroller (legacy)
    func initialOpacity(_ opacity: CGFloat) -> some View {
        environment(\.nimbusScrollerInitialOpacity, opacity)
    }
    
    /// Sets the fade properties for the scroller (legacy)
    func fadeProperties(opacity: CGFloat, delay: TimeInterval, duration: TimeInterval) -> some View {
        environment(\.nimbusScrollerFadeOpacity, opacity)
            .environment(\.nimbusScrollerFadeDelay, delay)
            .environment(\.nimbusScrollerAnimationDuration, duration)
    }
}

// MARK: - Preview

private struct NimbusScrollViewPreview: View {
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            Text("NimbusScrollView Showcase")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(theme.primaryTextColor(for: colorScheme))
            
            // Basic Scroll View with Vertical Content
            VStack(alignment: .leading, spacing: 12) {
                Text("Vertical Scrolling Content")
                    .font(.headline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                NimbusScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(1...50, id: \.self) { index in
                            HStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(theme.accentColor(for: colorScheme).opacity(0.6))
                                    .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Item \(index)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                                    
                                    Text("This is a scrollable item with some content to demonstrate vertical scrolling.")
                                        .font(.caption)
                                        .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(theme.secondaryBackgroundColor(for: colorScheme))
                            .cornerRadius(8)
                        }
                    }
                    .padding(16)
                }
                .frame(height: 300)
                .background(theme.backgroundColor(for: colorScheme))
                .cornerRadius(12)
            }
            
            // Horizontal Scrolling Content
            VStack(alignment: .leading, spacing: 12) {
                Text("Horizontal Scrolling Content")
                    .font(.headline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                NimbusScrollView {
                    HStack(spacing: 16) {
                        ForEach(1...20, id: \.self) { index in
                            VStack(spacing: 8) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(theme.accentColor(for: colorScheme).opacity(0.8))
                                    .frame(width: 80, height: 80)
                                
                                Text("Card \(index)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(theme.primaryTextColor(for: colorScheme))
                            }
                            .padding(12)
                            .background(theme.secondaryBackgroundColor(for: colorScheme))
                            .cornerRadius(8)
                        }
                    }
                    .padding(16)
                }
                .showsScrollers(vertical: false, horizontal: true)
                .frame(height: 150)
                .background(theme.backgroundColor(for: colorScheme))
                .cornerRadius(12)
            }
            
            // Custom Styled Scroll View
            VStack(alignment: .leading, spacing: 12) {
                Text("Custom Scroller Styling")
                    .font(.headline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                NimbusScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(1...30, id: \.self) { index in
                            Text("Custom styled scroll item \(index)")
                                .font(.body)
                                .foregroundColor(theme.primaryTextColor(for: colorScheme))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(theme.tertiaryBackgroundColor(for: colorScheme))
                                .cornerRadius(6)
                        }
                    }
                    .padding(16)
                }
                .showScrollerSlot(false)
                .showsHorizontalScroller(false)
                .scrollerWidth(20)
                .knobWidth(8)
                .knobPadding(2)
                .slotCornerRadius(0)
                .frame(height: 250)
                .background(theme.backgroundColor(for: colorScheme))
                .cornerRadius(12)
                
                Text("Custom styling applied: Scroller width: 20, Knob width: 8, Knob padding: 3, Slot corner radius: 8")
                    .font(.caption)
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
            }
            
            // Scroller Visibility Examples
            VStack(alignment: .leading, spacing: 12) {
                Text("Scroller Visibility Modifiers")
                    .font(.headline)
                    .foregroundColor(theme.secondaryTextColor(for: colorScheme))
                
                HStack(spacing: 16) {
                    // No scrollers
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hidden Scrollers")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(theme.primaryTextColor(for: colorScheme))
                        
                        NimbusScrollView {
                            VStack(spacing: 8) {
                                ForEach(1...20, id: \.self) { index in
                                    Text("Item \(index)")
                                        .font(.caption)
                                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(theme.tertiaryBackgroundColor(for: colorScheme))
                                        .cornerRadius(4)
                                }
                            }
                            .padding(12)
                        }
                        .hideScrollers()
                        .frame(width: 150, height: 120)
                        .background(theme.backgroundColor(for: colorScheme))
                        .cornerRadius(8)
                        
                        Text("Using .hideScrollers()")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                    
                    // Vertical only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Vertical Only")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(theme.primaryTextColor(for: colorScheme))
                        
                        NimbusScrollView {
                            VStack(spacing: 8) {
                                ForEach(1...20, id: \.self) { index in
                                    Text("Item \(index)")
                                        .font(.caption)
                                        .foregroundColor(theme.primaryTextColor(for: colorScheme))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(theme.tertiaryBackgroundColor(for: colorScheme))
                                        .cornerRadius(4)
                                }
                            }
                            .padding(12)
                        }
                        .showsHorizontalScroller(false)
                        .frame(width: 150, height: 120)
                        .background(theme.backgroundColor(for: colorScheme))
                        .cornerRadius(8)
                        
                        Text("Using .showsHorizontalScroller(false)")
                            .font(.caption2)
                            .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
                    }
                }
            }
            
            Spacer()
        }
        .padding(24)
        .background(theme.backgroundColor(for: colorScheme))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview("Default Theme") {
    NimbusScrollViewPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
}

#Preview("Maritime Theme") {
    NimbusScrollViewPreview()
        .environment(\.nimbusTheme, MaritimeTheme())
}

#Preview("Custom Theme") {
    NimbusScrollViewPreview()
        .environment(\.nimbusTheme, CustomWarmTheme())
}

#Preview("Dark Mode") {
    NimbusScrollViewPreview()
        .environment(\.nimbusTheme, NimbusTheme.default)
        .preferredColorScheme(.dark)
}
