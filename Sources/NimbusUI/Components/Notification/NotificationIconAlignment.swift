//
//  NotificationIconAlignment.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

/// Vertical alignment options for the notification icon relative to text content
public enum NotificationIconAlignment: String, CaseIterable, Sendable {
    case center    // Centers icon with entire text content (default)
    case baseline  // Aligns icon with first line text baseline  
    case top       // Aligns icon with top of text content
}
