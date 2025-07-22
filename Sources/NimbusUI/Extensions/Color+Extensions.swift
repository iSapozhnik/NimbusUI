//
//  Color+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

//extension Color {
//    func lighter(by amount: Double = 0.2) -> Color {
//        return self.adjustBrightness(by: abs(amount))
//    }
//    
//    func darker(by amount: Double = 0.2) -> Color {
//        return self.adjustBrightness(by: -abs(amount))
//    }
//    
//    private func adjustBrightness(by amount: Double) -> Color {
//        var nsColor = NSColor(self)
//        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
//        nsColor = nsColor.usingColorSpace(.deviceRGB) ?? nsColor
//        nsColor.getHue(
//            &hue,
//            saturation: &saturation,
//            brightness: &brightness,
//            alpha: &alpha
//        )
//        let newBrightness = min(max(brightness + CGFloat(amount), 0), 1)
//        return Color(
//            hue: Double(hue),
//            saturation: Double(saturation),
//            brightness: Double(newBrightness),
//            opacity: Double(alpha)
//        )
//    }
//}

extension Color {
    func lighter(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).lighter(amount: amount))
    }
    
    func darker(by amount: Double = 0.2) -> Color {
        Color(nsColor: NSColor(self).darker(amount: amount))
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
