//
//  RectangleCornerRadii+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public extension RectangleCornerRadii {
    static var zero: Self { .init(0) }

    init(_ radius: CGFloat) {
        self.init(
            topLeading: radius,
            bottomLeading: radius,
            bottomTrailing: radius,
            topTrailing: radius
        )
    }
}
