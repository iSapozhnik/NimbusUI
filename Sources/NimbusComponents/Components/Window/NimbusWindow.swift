//
//  NimbusWindow.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI

final class NimbusWindow<Content>: NSWindow, ObservableObject where Content: View {
    @Binding private var isPresented: Bool
    
    private var view: NSView?

    private let transient: Bool
    
    init(
        isPresented: Binding<Bool>,
        transient: Bool = true,
        cornerRadii: RectangleCornerRadii,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.transient = transient

        super.init(
            contentRect: .zero,
            styleMask: [.fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        let view = NSHostingView(
            rootView: NimbusWindowContent(content: content)
//                .luminareSheetCornerRadii(cornerRadii)
                .environmentObject(self)
        )
        self.view = view

        self.isMovableByWindowBackground = isMovableByWindowBackground
        collectionBehavior.insert(.fullScreenAuxiliary)
        level = .floating
        backgroundColor = .clear
        contentView = view
        contentView?.wantsLayer = true
        ignoresMouseEvents = false
        isOpaque = false
        hasShadow = true
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        animationBehavior = .documentWindow

        DispatchQueue.main.async {
            self.display()
//            self.updatePosition()
        }
    }
    
    func setSize(_ size: CGSize) {
    }
}
