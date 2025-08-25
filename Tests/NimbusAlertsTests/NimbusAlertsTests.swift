//
//  NimbusAlertsTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 25.08.25.
//

import Testing
import SwiftUI
@testable import NimbusAlerts

@Suite("NimbusAlerts Tests")
struct NimbusAlertsTests {
    
    @Test("NimbusAlert can be created")
    func testNimbusAlertCreation() {
        let alert = NimbusAlert(
            style: .info,
            title: "Test Alert",
            message: "Test message"
        )
        
        #expect(alert.style == .info)
        #expect(alert.title == "Test Alert")
        #expect(alert.message == "Test message")
    }
    
    @Test("NimbusAlertStyle provides correct icons")
    func testAlertStyleIcons() {
        #expect(NimbusAlertStyle.info.icon == "info.circle.fill")
        #expect(NimbusAlertStyle.success.icon == "checkmark.circle.fill")
        #expect(NimbusAlertStyle.warning.icon == "exclamationmark.triangle.fill")
        #expect(NimbusAlertStyle.error.icon == "xmark.circle.fill")
    }
    
    @Test("NimbusAlertButton convenience methods work")
    func testAlertButtonConvenience() {
        let okButton = NimbusAlertButton.ok()
        let cancelButton = NimbusAlertButton.cancel()
        let destructiveButton = NimbusAlertButton.destructive("Delete")
        
        #expect(okButton.title == "OK")
        #expect(okButton.role == nil)
        
        #expect(cancelButton.title == "Cancel")
        #expect(cancelButton.role == .cancel)
        
        #expect(destructiveButton.title == "Delete")
        #expect(destructiveButton.role == .destructive)
    }
}