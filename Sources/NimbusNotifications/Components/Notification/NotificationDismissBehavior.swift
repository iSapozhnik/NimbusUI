//
//  NotificationDismissBehavior.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import Foundation

public enum NotificationDismissBehavior: Equatable, Sendable {
    case sticky                    // Manual dismiss only
    case temporary(TimeInterval)   // Auto-dismiss after seconds
}
