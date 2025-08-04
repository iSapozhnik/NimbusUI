//
//  ListRoundedCornerBehavior.swift
//  NimbusCore
//
//  Created by Claude on 04.08.25.
//

import SwiftUI

public enum ListRoundedCornerBehavior: String, Hashable, Equatable,
    Identifiable, CaseIterable, Codable, Sendable {
    case never
    case always
    case fixedHeight
    case variableHeight

    public var id: Self { self }

    public var negate: Self {
        switch self {
        case .never:
            .always
        case .always:
            .never
        case .fixedHeight:
            .variableHeight
        case .variableHeight:
            .fixedHeight
        }
    }

    public func isRounded(hasFixedHeight: Bool) -> Bool {
        switch self {
        case .never:
            false
        case .always:
            true
        case .fixedHeight:
            hasFixedHeight
        case .variableHeight:
            !hasFixedHeight
        }
    }
}