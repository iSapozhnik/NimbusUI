//
//  ShowcaseView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 03.08.25.
//

import SwiftUI

struct ShowcaseView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack {
            VStack {
                Text("Light Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                content()
                    .environment(\.colorScheme, .light)
            }
            .padding()
            .background(.gray)
            
            VStack {
                Text("Dark Mode")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                content()
                    .environment(\.colorScheme, .dark)
            }
            .padding()
            .background(.black)
        }
    }
}
