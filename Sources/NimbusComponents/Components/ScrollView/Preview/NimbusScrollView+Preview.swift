//
//  NimbusScrollView+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

// MARK: - Previews

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
