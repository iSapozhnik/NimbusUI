//
//  NSScreen+Extensions.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 08.08.25.
//

import AppKit

extension NSScreen {
    public static var current: NSScreen? {
        Self.screens.first { $0.frame.contains(NSEvent.mouseLocation) } ?? Self.main
    }
}
