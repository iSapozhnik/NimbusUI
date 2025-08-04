import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusNotifications

@Test func notificationSystemBasics() async throws {
    // Test that NotificationType cases exist
    let infoType = NotificationType.info
    let successType = NotificationType.success
    let warningType = NotificationType.warning
    let errorType = NotificationType.error
    
    #expect(infoType == .info)
    #expect(successType == .success)
    #expect(warningType == .warning) 
    #expect(errorType == .error)
}

@Test func notificationDismissBehaviorTypes() async throws {
    // Test that NotificationDismissBehavior cases exist
    let sticky = NotificationDismissBehavior.sticky
    let temporary = NotificationDismissBehavior.temporary(3.0)
    
    #expect(sticky == .sticky)
    
    // Test temporary behavior
    if case .temporary(let duration) = temporary {
        #expect(duration == 3.0)
    } else {
        #expect(Bool(false), "Expected temporary behavior")
    }
}