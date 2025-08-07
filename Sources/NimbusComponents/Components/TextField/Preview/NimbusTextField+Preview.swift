//
//  NimbusTextField+Preview.swift
//  NimbusUI
//
//  Created by AI Assistant on 07.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - NimbusTextField Previews

#Preview("TextField - Basic Examples") {
    Group {
        VStack(spacing: 16) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter your email"))
        
        NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
        
        NimbusTextField("Disabled", text: .constant("Cannot edit"))
            .disabled(true)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Control Sizes") {
    Group {
        VStack(spacing: 16) {
        NimbusTextField("Extra Large", text: .constant("Sample Text"))
            .controlSize(.extraLarge)
        
        NimbusTextField("Large", text: .constant("Sample Text"))
            .controlSize(.large)
        
        NimbusTextField("Regular", text: .constant("Sample Text"))
            .controlSize(.regular)
        
        NimbusTextField("Small", text: .constant("Sample Text"))
            .controlSize(.small)
        
        NimbusTextField("Mini", text: .constant("Sample Text"))
            .controlSize(.mini)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Styling Variations") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Default", text: .constant("With border and background"))
            
            NimbusTextField("No Border", text: .constant("Background only"))
                .bordered(false)
            
            NimbusTextField("No Background", text: .constant("Border only"))
                .hasBackground(false)
            
            NimbusTextField("Plain", text: .constant("No styling"))
                .bordered(false)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Custom Styling") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Custom Padding", text: .constant("Extra padding"))
                .contentPadding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            
            NimbusTextField("Custom Border", text: .constant("Thick border"))
                .borderWidth(2)
            
            NimbusTextField("Rounded", text: .constant("Custom corners"))
                .cornerRadii(RectangleCornerRadii(12))
            
            NimbusTextField("Tall Field", text: .constant("Custom height"))
                .minHeight(60)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Value Types") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Price", text: .constant("$29.99"))
            
            NimbusTextField("Quantity", text: .constant("5"))
            
            NimbusTextField("Percentage", text: .constant("85%"))
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Different Themes") {
    Group {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Nimbus Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, NimbusTheme.default)
                }
                
                VStack(spacing: 8) {
                    Text("Maritime Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, MaritimeTheme())
                }
                
                VStack(spacing: 8) {
                    Text("Custom Warm Theme")
                        .font(.headline)
                    textFieldGrid
                        .environment(\.nimbusTheme, CustomWarmTheme())
                }
            }
            .padding()
        }
    }
}

private var textFieldGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter email"))
        
        NimbusTextField("Custom", text: .constant("Rounded corners"))
            .cornerRadii(RectangleCornerRadii(8))
    }
}

// MARK: - Icon Examples

#Preview("TextField - Basic Icon Examples") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
                .leadingIcon(Image(systemName: "magnifyingglass"))
            
            NimbusTextField("Email", text: .constant("john@example.com"))
                .leadingIcon(Image(systemName: "envelope"))
            
            NimbusTextField("Password", text: .constant(""))
                .trailingIcon(Image(systemName: "lock"))
            
            NimbusTextField("Username", text: .constant(""))
                .leadingIcon(Image(systemName: "person.circle"))
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Icon Alignment & Spacing") {
    Group {
        VStack(spacing: 16) {
            Text("Leading Icons")
                .font(.headline)
            
            NimbusTextField("Default Spacing", text: .constant("Default"))
                .leadingIcon(Image(systemName: "magnifyingglass"))
            
            NimbusTextField("Custom Spacing", text: .constant("Custom"))
                .leadingIcon(Image(systemName: "magnifyingglass"))
                .textFieldIconSpacing(12)
            
            Text("Trailing Icons")
                .font(.headline)
            
            NimbusTextField("Settings", text: .constant("Configuration"))
                .trailingIcon(Image(systemName: "gear"))
            
            NimbusTextField("Secure Field", text: .constant(""))
                .trailingIcon(Image(systemName: "lock.fill"))
                .textFieldIconSpacing(16)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Icons with Control Sizes") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Extra Large", text: .constant("Sample Text"))
                .leadingIcon(Image(systemName: "magnifyingglass"))
                .controlSize(.extraLarge)
            
            NimbusTextField("Large", text: .constant("Sample Text"))
                .leadingIcon(Image(systemName: "envelope"))
                .controlSize(.large)
            
            NimbusTextField("Regular", text: .constant("Sample Text"))
                .leadingIcon(Image(systemName: "person"))
                .controlSize(.regular)
            
            NimbusTextField("Small", text: .constant("Sample Text"))
                .leadingIcon(Image(systemName: "lock"))
                .controlSize(.small)
            
            NimbusTextField("Mini", text: .constant("Sample Text"))
                .leadingIcon(Image(systemName: "gear"))
                .controlSize(.mini)
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Custom Icon Views") {
    Group {
        VStack(spacing: 16) {
            NimbusTextField("Colored Icon", text: .constant("Custom color"))
                .leadingIcon(
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                )
            
            NimbusTextField("Multiple Icons", text: .constant("Complex layout"))
                .leadingIcon(
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                    }
                    .foregroundColor(.yellow)
                )
            
            NimbusTextField("Custom View", text: .constant("With badge"))
                .trailingIcon(
                    ZStack {
                        Circle()
                            .fill(.red)
                            .frame(width: 16, height: 16)
                        Text("!")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                )
        }
        .padding()
        .environment(\.nimbusTheme, NimbusTheme.default)
    }
}

#Preview("TextField - Icons with Different Themes") {
    Group {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text("Nimbus Theme")
                        .font(.headline)
                    textFieldIconGrid
                        .environment(\.nimbusTheme, NimbusTheme.default)
                }
                
                VStack(spacing: 8) {
                    Text("Maritime Theme")
                        .font(.headline)
                    textFieldIconGrid
                        .environment(\.nimbusTheme, MaritimeTheme())
                }
                
                VStack(spacing: 8) {
                    Text("Custom Warm Theme")
                        .font(.headline)
                    textFieldIconGrid
                        .environment(\.nimbusTheme, CustomWarmTheme())
                }
            }
            .padding()
        }
    }
}

private var textFieldIconGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
            .leadingIcon(Image(systemName: "magnifyingglass"))
        
        NimbusTextField("Email", text: .constant("john@example.com"))
            .leadingIcon(Image(systemName: "envelope"))
        
        NimbusTextField("Password", text: .constant(""))
            .trailingIcon(Image(systemName: "lock"))
    }
}