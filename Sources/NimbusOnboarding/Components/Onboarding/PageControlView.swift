import SwiftUI

/// Displays page control indicators for onboarding (dots for current/total pages).
public struct PageControlView: View {
    public let currentIndex: Int
    public let total: Int
    public init(currentIndex: Int, total: Int) {
        self.currentIndex = currentIndex
        self.total = total
    }
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \ .self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.accentColor : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
} 