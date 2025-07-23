//
//  SwiftUIView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 23.07.25.
//

import SwiftUI
import FluidGradient

struct OnboardingView: View {
    @Environment(\.nimbusLabelContentHorizontalMediumPadding) var contentPadding
    
    var body: some View {
        ZStack {
            FluidGradient(blobs: [.red, .green, .blue],
                          highlights: [.yellow, .orange, .purple],
                          speed: 1,
                          blur: 0.85)
            .overlay(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.white.opacity(0), location: 0),
                        .init(color: Color.white, location: 1)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 80, height: 80)
                        .modifier(LevitatingViewModifier())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome to Launchy")
                        .font(.system(size: 32))
                        .bold()
                    Text("It's a fun and quick app launcher and switcher")
                        .font(.system(size: 18, weight: .light))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                HStack {
                    Button(role: .none, action: {}) {
                        Label("Next", systemImage: "arrow.right")
                            .labelStyle(
                                NimbusDividerLabelStyle(
                                    hasDivider: false,
                                    iconAlignment: .trailing,
                                    contentHorizontalPadding: contentPadding
                                )
                            )
                        
                    }
                    .buttonStyle(.primaryProminent)
                    .frame(height: 40)
                    .modifier(NimbusAspectRatioModifier())
                    
                }
            }
            .padding(80)

        }
        .frame(width: 500, height: 400)
    }
}

#Preview {
    OnboardingView()
}
