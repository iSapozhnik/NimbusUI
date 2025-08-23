//
//  SwiftUIView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.08.25.
//

import SwiftUI
import NimbusCore

struct NimbusWindowContent<Content>: View where Content: View {
    @EnvironmentObject private var window: NimbusWindow<Content>
    
//    @Environment(\.nimbusCornerRadii) private var cornerRadii
    let cornerRadii: RectangleCornerRadii = .init(12)
    
    @ViewBuilder private var content: () -> Content

    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            ZStack {
                backgroundWindow()
                content()
//                windowBorder()
            }
            .fixedSize()
            .onGeometryChange(for: CGSize.self, of: \.size, action: window.setSize(_:))
            .frame(minWidth: 12, minHeight: 12, alignment: .top)

            Spacer(minLength: 0)
        }
    }
    
    func backgroundWindow() -> some View {
        ZStack {
//            VisualEffectView(
//                material: .fullScreenUI,
//                blendingMode: .behindWindow
//            )
        }
        .modifier(
            NimbusBackgroundEffectModifier(
                material: .fullScreenUI,
                blendingMode: .behindWindow
            )
        )
        .clipShape(.rect(cornerRadii: cornerRadii))
    }
}

#Preview {
    NimbusWindowContent {
        Text("Hello, world!")
            .padding()
    }
}
