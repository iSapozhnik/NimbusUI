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
    private let showsVerticalScrollIndicator: Bool
    private let showsHorizontalScrollIndicator: Bool
    private let contentInsets: NSEdgeInsets
    
    /// Creates a NimbusScrollView with the specified content and configuration
    /// - Parameters:
    ///   - showsVerticalScrollIndicator: Whether to show the vertical scroll indicator
    ///   - showsHorizontalScrollIndicator: Whether to show the horizontal scroll indicator
    ///   - contentInsets: Insets applied to the content within the scroll view
    ///   - content: The scrollable content
    public init(
        showsVerticalScrollIndicator: Bool = true,
        showsHorizontalScrollIndicator: Bool = true,
        contentInsets: NSEdgeInsets = NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        @ViewBuilder content: () -> Content
    ) {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
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
                
                NimbusScrollView(
                    showsVerticalScrollIndicator: false,
                    showsHorizontalScrollIndicator: true
                ) {
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
                .scrollerWidth(20)
                .knobWidth(8)
                .knobPadding(3)
                .slotCornerRadius(8)
                .frame(height: 250)
                .background(theme.backgroundColor(for: colorScheme))
                .cornerRadius(12)
                
                Text("Custom styling applied: Scroller width: 20, Knob width: 8, Knob padding: 3, Slot corner radius: 8")
                    .font(.caption)
                    .foregroundColor(theme.tertiaryTextColor(for: colorScheme))
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