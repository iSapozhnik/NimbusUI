//
//  ControlSizeUtility.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

/// Utility for mapping SwiftUI ControlSize to button metrics and design tokens
public struct ControlSizeUtility {
    
    /// Button metrics for different control sizes
    public struct ButtonMetrics {
        public let height: CGFloat
        public let horizontalPadding: CGFloat
        public let fontSize: CGFloat
        public let iconSize: CGFloat
        
        public init(height: CGFloat, horizontalPadding: CGFloat, fontSize: CGFloat, iconSize: CGFloat) {
            self.height = height
            self.horizontalPadding = horizontalPadding
            self.fontSize = fontSize
            self.iconSize = iconSize
        }
    }
    
    /// Default button metrics for each control size
    public static let defaultMetrics: [ControlSize: ButtonMetrics] = [
        .extraLarge: ButtonMetrics(height: 60, horizontalPadding: 28, fontSize: 19, iconSize: 22),
        .large: ButtonMetrics(height: 52, horizontalPadding: 24, fontSize: 17, iconSize: 20),
        .regular: ButtonMetrics(height: 44, horizontalPadding: 20, fontSize: 15, iconSize: 18),
        .small: ButtonMetrics(height: 36, horizontalPadding: 16, fontSize: 13, iconSize: 16),
        .mini: ButtonMetrics(height: 28, horizontalPadding: 12, fontSize: 11, iconSize: 14)
    ]
    
    /// Get button metrics for a given control size
    /// - Parameter controlSize: The SwiftUI ControlSize to get metrics for
    /// - Returns: ButtonMetrics for the specified control size, defaults to .regular if not found
    public static func metrics(for controlSize: ControlSize) -> ButtonMetrics {
        return defaultMetrics[controlSize] ?? defaultMetrics[.regular]!
    }
    
    /// Get button height for a given control size
    /// - Parameter controlSize: The SwiftUI ControlSize
    /// - Returns: Height value for the control size
    public static func height(for controlSize: ControlSize) -> CGFloat {
        return metrics(for: controlSize).height
    }
    
    /// Get horizontal padding for a given control size
    /// - Parameter controlSize: The SwiftUI ControlSize
    /// - Returns: Horizontal padding value for the control size
    public static func horizontalPadding(for controlSize: ControlSize) -> CGFloat {
        return metrics(for: controlSize).horizontalPadding
    }
    
    /// Get font size for a given control size
    /// - Parameter controlSize: The SwiftUI ControlSize
    /// - Returns: Font size value for the control size
    public static func fontSize(for controlSize: ControlSize) -> CGFloat {
        return metrics(for: controlSize).fontSize
    }
    
    /// Get icon size for a given control size
    /// - Parameter controlSize: The SwiftUI ControlSize
    /// - Returns: Icon size value for the control size
    public static func iconSize(for controlSize: ControlSize) -> CGFloat {
        return metrics(for: controlSize).iconSize
    }
}

// MARK: - Theme Integration

public extension ControlSizeUtility {
    
    /// Get theme-aware button height with controlSize support
    /// - Parameters:
    ///   - controlSize: The SwiftUI ControlSize
    ///   - theme: The NimbusTheming instance
    ///   - override: Optional environment override value
    /// - Returns: Height value from theme or controlSize default
    static func height(for controlSize: ControlSize, theme: NimbusTheming, override: CGFloat? = nil) -> CGFloat {
        if let override = override {
            return override
        }
        
        // Use theme-specific heights if available, otherwise fall back to utility defaults
        switch controlSize {
        case .extraLarge:
            return theme.buttonHeightExtraLarge ?? ControlSizeUtility.height(for: .extraLarge)
        case .large:
            return theme.buttonHeightLarge ?? ControlSizeUtility.height(for: .large)
        case .regular:
            return theme.buttonHeightRegular ?? ControlSizeUtility.height(for: .regular)
        case .small:
            return theme.buttonHeightSmall ?? ControlSizeUtility.height(for: .small)
        case .mini:
            return theme.buttonHeightMini ?? ControlSizeUtility.height(for: .mini)
        @unknown default:
            return theme.buttonHeightRegular ?? ControlSizeUtility.height(for: .regular)
        }
    }
    
    /// Get theme-aware horizontal padding with controlSize support
    /// - Parameters:
    ///   - controlSize: The SwiftUI ControlSize
    ///   - theme: The NimbusTheming instance
    ///   - override: Optional environment override value
    /// - Returns: Padding value from theme or controlSize default
    static func horizontalPadding(for controlSize: ControlSize, theme: NimbusTheming, override: CGFloat? = nil) -> CGFloat {
        if let override = override {
            return override
        }
        
        // Use theme-specific padding if available, otherwise fall back to utility defaults
        switch controlSize {
        case .extraLarge:
            return theme.buttonPaddingExtraLarge ?? ControlSizeUtility.horizontalPadding(for: .extraLarge)
        case .large:
            return theme.buttonPaddingLarge ?? ControlSizeUtility.horizontalPadding(for: .large)
        case .regular:
            return theme.buttonPaddingRegular ?? ControlSizeUtility.horizontalPadding(for: .regular)
        case .small:
            return theme.buttonPaddingSmall ?? ControlSizeUtility.horizontalPadding(for: .small)
        case .mini:
            return theme.buttonPaddingMini ?? ControlSizeUtility.horizontalPadding(for: .mini)
        @unknown default:
            return theme.buttonPaddingRegular ?? ControlSizeUtility.horizontalPadding(for: .regular)
        }
    }
    
    /// Get theme-aware font size with controlSize support
    /// - Parameters:
    ///   - controlSize: The SwiftUI ControlSize
    ///   - theme: The NimbusTheming instance
    /// - Returns: Font size value from theme or controlSize default
    static func fontSize(for controlSize: ControlSize, theme: NimbusTheming) -> CGFloat {
        // Use theme-specific font sizes if available, otherwise fall back to utility defaults
        switch controlSize {
        case .extraLarge:
            return theme.buttonFontSizeExtraLarge ?? ControlSizeUtility.fontSize(for: .extraLarge)
        case .large:
            return theme.buttonFontSizeLarge ?? ControlSizeUtility.fontSize(for: .large)
        case .regular:
            return theme.buttonFontSizeRegular ?? ControlSizeUtility.fontSize(for: .regular)
        case .small:
            return theme.buttonFontSizeSmall ?? ControlSizeUtility.fontSize(for: .small)
        case .mini:
            return theme.buttonFontSizeMini ?? ControlSizeUtility.fontSize(for: .mini)
        @unknown default:
            return theme.buttonFontSizeRegular ?? ControlSizeUtility.fontSize(for: .regular)
        }
    }
}