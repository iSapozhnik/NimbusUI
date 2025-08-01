import Testing
import SwiftUI
@testable import NimbusUI

// Helper function to check if two hex colors are approximately equal
// Due to color space conversions, exact matches are unreliable
func hexColorsApproximatelyEqual(_ color1: String, _ color2: String, tolerance: Int = 15) -> Bool {
    func hexToRGB(_ hex: String) -> (Int, Int, Int) {
        let cleanHex = hex.replacingOccurrences(of: "#", with: "")
        guard cleanHex.count == 6, let hexValue = UInt32(cleanHex, radix: 16) else {
            return (0, 0, 0)
        }
        let red = Int((hexValue & 0xFF0000) >> 16)
        let green = Int((hexValue & 0x00FF00) >> 8)
        let blue = Int(hexValue & 0x0000FF)
        return (red, green, blue)
    }
    
    let rgb1 = hexToRGB(color1)
    let rgb2 = hexToRGB(color2)
    
    return abs(rgb1.0 - rgb2.0) <= tolerance &&
           abs(rgb1.1 - rgb2.1) <= tolerance &&
           abs(rgb1.2 - rgb2.2) <= tolerance
}

@Test func hexColorInitialization() async throws {
    // Test various hex formats
    let color1 = Color(hex: "#F1D1A7")  // With hash prefix
    let color2 = Color(hex: "F1D1A7")   // Without hash prefix  
    let color3 = Color(hex: "#f1d1a7")  // Lowercase with hash
    let color4 = Color(hex: "f1d1a7")   // Lowercase without hash
    let color5 = Color(hex: "0xF1D1A7") // With 0x prefix
    
    // Test that all formats produce the same output (consistency)
    #expect(color1.hexString == color2.hexString)
    #expect(color2.hexString == color3.hexString)
    #expect(color3.hexString == color4.hexString)
    #expect(color4.hexString == color5.hexString)
    
    // Test that the colors are not the fallback gray
    let grayFallback = Color(hex: "invalid").hexString
    #expect(color1.hexString != grayFallback)
    #expect(color2.hexString != grayFallback)
    #expect(color3.hexString != grayFallback)
    #expect(color4.hexString != grayFallback)
    #expect(color5.hexString != grayFallback)
    
    // Test that different valid colors produce different outputs
    let primaryColor = Color(hex: "#F1D1A7")
    let dangerColor = Color(hex: "#EE7671") 
    let accentColor = Color(hex: "#5584E4")
    let backgroundColor = Color(hex: "#FDF8F1")
    
    #expect(primaryColor.hexString != dangerColor.hexString)
    #expect(dangerColor.hexString != accentColor.hexString)
    #expect(accentColor.hexString != backgroundColor.hexString)
}

@Test func hexColorFallbackHandling() async throws {
    // Test invalid hex strings fall back to gray
    let invalidColor1 = Color(hex: "invalid")
    let invalidColor2 = Color(hex: "#ZZZ")
    let invalidColor3 = Color(hex: "")
    let invalidColor4 = Color(hex: "#F1D1A")  // Too short
    let invalidColor5 = Color(hex: "#F1D1A7FF") // Too long
    
    // All invalid colors should fall back to the same gray
    #expect(invalidColor1.hexString == invalidColor2.hexString)
    #expect(invalidColor2.hexString == invalidColor3.hexString)
    #expect(invalidColor3.hexString == invalidColor4.hexString)
    #expect(invalidColor4.hexString == invalidColor5.hexString)
    
    // Verify they don't match valid colors 
    let validColor = Color(hex: "#F1D1A7")
    #expect(invalidColor1.hexString != validColor.hexString)
}

@Test func customWarmThemeIntegration() async throws {
    let theme = CustomWarmTheme()
    
    // Test that the theme colors are correctly initialized with hex values
    let primaryLight = theme.primaryColor(for: .light)
    let primaryDark = theme.primaryColor(for: .dark)
    let accent = theme.accentColor(for: .light)
    let error = theme.errorColor(for: .light)
    let background = theme.backgroundColor(for: .light)
    
    // Verify dark mode variants are different from light mode
    #expect(primaryDark.hexString != primaryLight.hexString)
    
    // Verify that all colors are different from each other (not fallback colors)
    #expect(primaryLight.hexString != accent.hexString)
    #expect(accent.hexString != error.hexString)
    #expect(error.hexString != background.hexString)
    
    // Verify that hex color initializer produces consistent results
    let directHexColor = Color(hex: "#F1D1A7")
    #expect(primaryLight.hexString == directHexColor.hexString)
    
    // Verify that invalid hex doesn't match valid theme colors
    let invalidColor = Color(hex: "invalid")
    #expect(invalidColor.hexString != primaryLight.hexString)
}
