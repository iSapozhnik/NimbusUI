import SwiftUI
import NimbusCore

#if DEBUG
/// Preview and test examples for OnboardingWindow integration
public struct OnboardingWindowPreviewExamples {
    
    /// Example features for testing the window integration
    public static let sampleFeatures: [AnyFeature] = [
        // Standard image feature
        AnyFeature.imageFeature(
            title: "Welcome to Launchy",
            description: "Fast and easy app launcher and switcher, with a lot of features and customization options",
            image: Image(systemName: "sparkles"),
            imageSize: 100
        ),
        
        // Icon feature with custom size
        AnyFeature.iconFeature(
            title: "Quick Search",
            description: "Find and launch any app instantly with powerful search and filtering capabilities.",
            systemName: "magnifyingglass",
            iconSize: 80
        ),
        
        // Custom gradient content
        AnyFeature(
            title: "Beautiful Design",
            description: "Experience a stunning interface with smooth gradients and modern animations."
        ) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [.blue, .purple, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 120, height: 120)
                .levitatingFeatureContent()
        },
        
        // Complex custom view with multiple elements
        AnyFeature(
            title: "Advanced Features",
            description: "Unlock powerful capabilities with our comprehensive feature set designed for productivity."
        ) {
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: "gear")
                        .foregroundColor(.blue)
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                }
                .font(.title)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 80, height: 40)
                    .overlay(
                        Text("Pro")
                            .font(.caption)
                            .bold()
                    )
            }
            .levitatingFeatureContent()
        },
        
        // Animated content
        AnyFeature(
            title: "Smooth Animations",
            description: "Enjoy fluid transitions and delightful micro-interactions throughout your workflow."
        ) {
            Circle()
                .fill(Color.green.gradient)
                .frame(width: 80, height: 80)
                .scaleFeatureContent(scale: 1.2, duration: 3.5)
        },
        
        // Simple icon feature
        AnyFeature.iconFeature(
            title: "Keyboard Shortcuts",
            description: "Boost your productivity by launching and switching apps using customizable keyboard shortcuts.",
            systemName: "command",
            iconSize: 70
        ),
        
        // Custom form feature with NimbusUI components
        AnyFeature(
            title: "Setup Your Account",
            description: "Complete your profile to"
        ) {
            FormContentView()
        },
        
        // Final feature with custom content
        AnyFeature(
            title: "Ready to Start?",
            description: "Join thousands of users who have transformed their productivity with our powerful tools."
        ) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
            }
            .levitatingFeatureContent()
        }
    ]
    
    /// Test function to show onboarding window (for development/testing)
    public static func showTestWindow() {
        NimbusOnboarding.show(features: sampleFeatures)
    }
    
    /// Test function with custom theme
    public static func showTestWindowWithTheme() {
        NimbusOnboarding.show(features: sampleFeatures, theme: MaritimeTheme())
    }
}

private struct FormContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.nimbusTheme) private var theme
    @State private var fullName = ""
    @State private var email = ""
    @State private var company = ""
    @State private var launchOnLogin = false
    
    var body: some View {
        VStack(spacing: 12) {
            // Header section
            VStack(alignment: .leading, spacing: 6) {
                Text("Launch on login")
                    .font(.headline)
                    .fontWeight(.semibold)            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Input fields section
            VStack(spacing: 14) {
                NimbusToggleItem(
                    "Launch the app together with the system",
                    isOn: $launchOnLogin,
                    togglePosition: .leading
                )
                .toggleShape(.roundedRect(3))
                .controlSize(.small)
            }
        }
        .padding(24)
        .background(theme.backgroundColor(for: colorScheme))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: 320)
    }
}

#Preview("Onboarding Window Test") {
    VStack(spacing: 20) {
        Text("OnboardingWindow Integration Test")
            .font(.headline)
        
        Text("Use the buttons below to test window integration:")
            .font(.subheadline)
            .foregroundStyle(.secondary)
        
        Button("Show Onboarding Window (Default Theme)") {
            OnboardingWindowPreviewExamples.showTestWindow()
        }
        .buttonStyle(.primary)
        
        Button("Show Onboarding Window (Maritime Theme)") {
            OnboardingWindowPreviewExamples.showTestWindowWithTheme()
        }
        .buttonStyle(.accent)
    }
    .padding()
    .environment(\.nimbusTheme, NimbusTheme.default)
}
#endif
