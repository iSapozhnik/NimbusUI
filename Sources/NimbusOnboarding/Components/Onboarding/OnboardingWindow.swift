import AppKit

/// A specialized NSWindow for displaying onboarding content.
/// Features a clean, borderless design with full content view and only a close button.
public class OnboardingWindow: NSWindow {
    
    public override init(
        contentRect: NSRect,
        styleMask style: NSWindow.StyleMask,
        backing backingStoreType: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: style,
            backing: backingStoreType,
            defer: flag
        )
        
        configureWindow()
    }
    
    private func configureWindow() {
        // Window appearance
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        isMovableByWindowBackground = true
        
        hasShadow = true
        
        // Hide minimize and full screen buttons, keep only close button
        standardWindowButton(.miniaturizeButton)?.isHidden = true
        standardWindowButton(.zoomButton)?.isHidden = true
        
        // Window behavior
        isReleasedWhenClosed = false
    }
}
