//
//  Color+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

extension Color {
    func lighter(by amount: Double = 0.2) -> Color {
        return self.adjustBrightness(by: abs(amount))
    }
    
    func darker(by amount: Double = 0.2) -> Color {
        return self.adjustBrightness(by: -abs(amount))
    }
    
    private func adjustBrightness(by amount: Double) -> Color {
        var nsColor = NSColor(self)
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        nsColor = nsColor.usingColorSpace(.deviceRGB) ?? nsColor
        nsColor.getHue(
            &hue,
            saturation: &saturation,
            brightness: &brightness,
            alpha: &alpha
        )
        let newBrightness = min(max(brightness + CGFloat(amount), 0), 1)
        return Color(
            hue: Double(hue),
            saturation: Double(saturation),
            brightness: Double(newBrightness),
            opacity: Double(alpha)
        )
    }
}

