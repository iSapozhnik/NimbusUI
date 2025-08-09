import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusOnboarding

@Test func onboardingSystemExists() async throws {
    // Basic test to ensure the onboarding module compiles and imports successfully
    #expect(true, "Onboarding module should compile and import successfully")
}

@Test func featureWithCustomContent() async throws {
    // Test that we can create a Feature with custom SwiftUI content
    let feature = Feature(
        title: "Test Feature",
        description: "Test description"
    ) {
        Text("Custom content")
            .foregroundColor(.blue)
    }
    
    #expect(feature.title == "Test Feature")
    #expect(feature.description == "Test description")
    #expect(feature.id != UUID()) // Should have a valid UUID
}

@Test func anyFeatureWrapper() async throws {
    // Test that AnyFeature correctly wraps different Feature types
    let imageFeature = Feature(
        title: "Image Feature",
        description: "Contains an image"
    ) {
        Image(systemName: "star")
    }
    
    let textFeature = Feature(
        title: "Text Feature", 
        description: "Contains text"
    ) {
        Text("Hello World")
    }
    
    let anyImageFeature = AnyFeature(imageFeature)
    let anyTextFeature = AnyFeature(textFeature)
    
    #expect(anyImageFeature.title == "Image Feature")
    #expect(anyTextFeature.title == "Text Feature")
}

@Test func convenienceFeatureFunctions() async throws {
    // Test convenience functions for creating common feature types
    let imageFeature = imageFeature(
        title: "Image Test",
        description: "Test image feature",
        image: Image(systemName: "heart")
    )
    
    let iconFeature = iconFeature(
        title: "Icon Test",
        description: "Test icon feature", 
        systemName: "gear"
    )
    
    #expect(imageFeature.title == "Image Test")
    #expect(iconFeature.title == "Icon Test")
}

@Test func onboardingViewWithMixedContent() async throws {
    // Test that OnboardingView can handle mixed content types
    let features: [AnyFeature] = [
        AnyFeature.imageFeature(
            title: "Image Feature",
            description: "Standard image",
            image: Image(systemName: "star")
        ),
        AnyFeature(
            title: "Custom Feature", 
            description: "Custom content"
        ) {
            VStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50)
                Text("Custom")
            }
        }
    ]
    
    let onboardingView = OnboardingView(features: features)
    #expect(onboardingView.features.count == 2)
    #expect(onboardingView.features[0].title == "Image Feature")
    #expect(onboardingView.features[1].title == "Custom Feature")
}