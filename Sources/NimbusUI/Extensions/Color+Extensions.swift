//
//  Color+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

extension Color {
    func lighter(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).lighter(amount: amount))
    }
    
    func darker(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).darker(amount: amount))
    }
    
    static func primaryColor(light: Color, dark: Color, scheme: ColorScheme) -> Color {
        scheme == .dark ? dark : light
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
