import SwiftUI
import NimbusCore

/// A view modifier that conditionally applies a mask based on a boolean state.
private struct ConditionalMaskModifier<Mask: View>: ViewModifier {
    let isActive: Bool
    let mask: Mask
    
    func body(content: Content) -> some View {
        if isActive {
            content
        } else {
            content.mask(mask)
        }
    }
}

/// Displays a single onboarding feature page with generic content.
public struct FeaturePageView<Content: View>: View where Content: View {
    public let feature: Feature<Content>
    
    public init(feature: Feature<Content>) {
        self.feature = feature
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            feature.content
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(feature.title)
                    .font(.system(size: 32))
                    .bold()
                Text(feature.description)
                    .font(.system(size: 18, weight: .light))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

/// Convenience version for AnyFeature (type-erased)
public struct AnyFeaturePageView: View {
    public let feature: AnyFeature
    @State private var isHovered: Bool = false
    
    @Environment(\.nimbusTheme) private var theme
    @Environment(\.nimbusAnimationFast) private var overrideAnimationFast
    
    private var animationFast: Animation {
        overrideAnimationFast ?? theme.animationFast
    }
    
    public init(feature: AnyFeature) {
        self.feature = feature
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            feature.content
                .onHover { hovering in
                    withAnimation(animationFast) {
                        isHovered = hovering
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 200)
                .modifier(ConditionalMaskModifier(
                    isActive: isHovered,
                    mask: LinearGradient(
                        gradient: .smooth(
                            from: Color.black.opacity(1),
                            to: Color.black.opacity(0.1),
                            curve: .easeInOut,
                            steps: 2
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                ))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(feature.title)
                    .font(.system(size: 32))
                    .bold()
                Text(feature.description)
                    .font(.system(size: 18, weight: .light))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    let feature = Feature(
        title: "Organize Your Apps",
        description: "Effortlessly group your most-used applications into custom folders for even faster access. Keep your workspace tidy and find what you need in an instant."
    ) {
        Image(systemName: "folder")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .modifier(LevitatingViewModifier())
    }
    FeaturePageView(feature: feature)
}
