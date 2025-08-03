//
//  Color+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

extension Color {
    /// Initializes a Color from a hex string.
    /// 
    /// Supports various hex formats:
    /// - "#F1D1A7" or "#f1d1a7" (with hash prefix)
    /// - "F1D1A7" or "f1d1a7" (without hash prefix)
    /// - "0xFF1D1A7" (with 0x prefix)
    /// 
    /// - Parameter hex: The hex string to parse
    /// - Returns: A Color initialized from the hex string, or a fallback color if parsing fails
    init(hex: String) {
        // Clean the hex string - remove prefixes and whitespace
        let cleanHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "0x", with: "")
            .uppercased()
        
        // Validate hex string length
        guard cleanHex.count == 6 else {
            // Fallback to a neutral gray color (#808080)
            self.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
            return
        }
        
        // Parse hex components
        guard let hexValue = UInt32(cleanHex, radix: 16) else {
            // Fallback to a neutral gray color (#808080)
            self.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
            return
        }
        
        // Extract RGB components
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        // Initialize Color in sRGB color space
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
    
    func lighter(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).lighter(amount: amount))
    }
    
    func darker(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).darker(amount: amount))
    }
    
    /// Creates an adaptive color that switches between light and dark variants based on color scheme
    static func adaptiveColor(light: Color, dark: Color, scheme: ColorScheme) -> Color {
        scheme == .dark ? dark : light
    }
    
    @available(*, deprecated, renamed: "adaptiveColor(light:dark:scheme:)")
    static func primaryColor(light: Color, dark: Color, scheme: ColorScheme) -> Color {
        adaptiveColor(light: light, dark: dark, scheme: scheme)
    }
    
    /// Calculates the relative luminance of the color for contrast determination
    var luminance: Double {
        let nsColor = NSColor(self)
        guard let rgbColor = nsColor.usingColorSpace(.genericRGB) else { return 0.5 }
        
        let red = Double(rgbColor.redComponent)
        let green = Double(rgbColor.greenComponent)
        let blue = Double(rgbColor.blueComponent)
        
        // Convert RGB to linear values
        func linearize(_ component: Double) -> Double {
            if component <= 0.03928 {
                return component / 12.92
            } else {
                return pow((component + 0.055) / 1.055, 2.4)
            }
        }
        
        let linearRed = linearize(red)
        let linearGreen = linearize(green)
        let linearBlue = linearize(blue)
        
        // Calculate relative luminance using standard weights
        return 0.2126 * linearRed + 0.7152 * linearGreen + 0.0722 * linearBlue
    }
    
    /// Returns the hexadecimal string representation of the color
    var hexString: String {
        let nsColor = NSColor(self)
        guard let rgbColor = nsColor.usingColorSpace(.genericRGB) else { return "#000000" }
        
        let red = Int(round(rgbColor.redComponent * 255))
        let green = Int(round(rgbColor.greenComponent * 255))
        let blue = Int(round(rgbColor.blueComponent * 255))
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
    
    /// Mixes this color with another color by a specified percentage
    /// - Parameters:
    ///   - color: The color to mix with
    ///   - percentage: The mix percentage (0.0 = all this color, 1.0 = all other color)
    /// - Returns: A new color that is a blend of the two colors
    func mix(with color: Color, by percentage: CGFloat) -> Color {
        let clampedPercentage = max(0.0, min(1.0, percentage))
        
        let selfNSColor = NSColor(self)
        let otherNSColor = NSColor(color)
        
        guard let selfRGB = selfNSColor.usingColorSpace(.genericRGB),
              let otherRGB = otherNSColor.usingColorSpace(.genericRGB) else {
            return self // Fallback to original color if conversion fails
        }
        
        // Mix RGB components using linear interpolation
        let red = selfRGB.redComponent * (1.0 - clampedPercentage) + otherRGB.redComponent * clampedPercentage
        let green = selfRGB.greenComponent * (1.0 - clampedPercentage) + otherRGB.greenComponent * clampedPercentage
        let blue = selfRGB.blueComponent * (1.0 - clampedPercentage) + otherRGB.blueComponent * clampedPercentage
        let alpha = selfRGB.alphaComponent * (1.0 - clampedPercentage) + otherRGB.alphaComponent * clampedPercentage
        
        return Color(nsColor: NSColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}

extension NSColor {
    func lighter(amount : CGFloat = 0.25) -> NSColor {
        return hueColorWithBrightnessAmount(amount: 1 + amount)
    }
    
    func darker(amount : CGFloat = 0.25) -> NSColor {
        return hueColorWithBrightnessAmount(amount: 1 - amount)
    }
    
    private func hueColorWithBrightnessAmount(amount: CGFloat) -> NSColor {
        var hue         : CGFloat = 0
        var saturation  : CGFloat = 0
        var brightness  : CGFloat = 0
        var alpha       : CGFloat = 0
        
        let convertedColor = self.usingColorSpace(.genericRGB) ?? NSColor.magenta
        convertedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let color = NSColor( hue: hue,
                             saturation: saturation,
                             brightness: brightness * amount,
                             alpha: alpha )
        return color
        
    }
}
