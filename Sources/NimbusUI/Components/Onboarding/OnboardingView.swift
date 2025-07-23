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
                        .frame(width: 120, height: 120)
                        .modifier(LevitatingViewModifier())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 200)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to Launchy")
                            .font(.system(size: 32))
                            .bold()
                        Text("Fast and easy app launcher and switcher, with a lot of features and customization options")
                            .font(.system(size: 18, weight: .light))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                    }

                    Button(role: .none, action: {}) {
                        Label("Continue", systemImage: "arrow.right")
                            .labelStyle(
                                NimbusDividerLabelStyle(
                                    hasDivider: false,
                                    iconAlignment: .trailing,
                                    contentHorizontalPadding: contentPadding
                                )
                            )
                        
                    }
                    .buttonStyle(.primaryProminent)
                    .frame(height: 50)
                    .modifier(NimbusAspectRatioModifier())
                }
                .frame(height: 200)
            }
            .padding(80)

        }
        .frame(width: 600, height: 560)
    }
}

#Preview {
    OnboardingView()
}
