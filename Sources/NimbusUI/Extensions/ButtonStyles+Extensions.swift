//
//  ButtonStyles+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

public extension ButtonStyle where Self == PrimaryDefaultButtonStyle {
    static var primaryDefault: Self { .init() }
}

public extension ButtonStyle where Self == PrimaryProminentButtonStyle {
    static var primaryProminent: Self { .init() }
}

public extension ButtonStyle where Self == SecondaryBorderedButtonStyle {
    static var secondaryBordered: Self { .init() }
}
