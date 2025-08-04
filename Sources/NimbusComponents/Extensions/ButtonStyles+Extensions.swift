//
//  ButtonStyles+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 21.07.25.
//

import SwiftUI

// MARK: - New Button Style Extensions

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self { .init() }
}

public extension ButtonStyle where Self == AccentButtonStyle {
    static var accent: Self { .init() }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self { .init() }
}

public extension ButtonStyle where Self == SecondaryOutlineButtonStyle {
    static var secondaryOutline: Self { .init() }
}

public extension ButtonStyle where Self == PrimaryOutlineButtonStyle {
    static var primaryOutline: Self { .init() }
}

public extension ButtonStyle where Self == LinkButtonStyle {
    static var nimbusLink: Self { .init() }
}

public extension ButtonStyle where Self == CloseButtonStyle {
    static var close: Self { .init() }
}

// MARK: - Legacy Extensions (Deprecated)

@available(*, deprecated, renamed: "primary", message: "Use `.primary` instead of `.primaryDefault`")
public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primaryDefault: Self { .init() }
}

@available(*, deprecated, renamed: "accent", message: "Use `.accent` instead of `.primaryProminent`")
public extension ButtonStyle where Self == AccentButtonStyle {
    static var primaryProminent: Self { .init() }
}

