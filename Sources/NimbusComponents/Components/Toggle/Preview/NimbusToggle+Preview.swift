//
//  NimbusToggle+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import SwiftUI
import NimbusCore

// MARK: - Previews

#Preview("Basic Toggle States") {
    @Previewable @State var isToggled = false
    
    VStack(spacing: 20) {
        HStack {
            NimbusToggle(isOn: $isToggled)
            Text("Interactive Toggle")
        }
        
        HStack {
            NimbusToggle(isOn: .constant(false))
            Text("Off")
        }
        
        HStack {
            NimbusToggle(isOn: .constant(true))
            Text("On")
        }
        
        HStack {
            NimbusToggle(isOn: .constant(false))
                .disabled(true)
            Text("Disabled Off")
        }
        
        HStack {
            NimbusToggle(isOn: .constant(true))
                .disabled(true)
            Text("Disabled On")
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Theme Variations") {
    @Previewable @State var isToggled = true
    
    VStack(spacing: 25) {
        VStack(spacing: 8) {
            Text("NimbusTheme.default")
                .font(.headline)
            HStack(spacing: 16) {
                NimbusToggle(isOn: .constant(false))
                NimbusToggle(isOn: .constant(true))
            }
        }
        
        VStack(spacing: 8) {
            Text("MaritimeTheme")
                .font(.headline)
            HStack(spacing: 16) {
                NimbusToggle(isOn: .constant(false))
                NimbusToggle(isOn: .constant(true))
            }
            .environment(\.nimbusTheme, MaritimeTheme())
        }
        
        VStack(spacing: 8) {
            Text("CustomWarmTheme")
                .font(.headline)
            HStack(spacing: 16) {
                NimbusToggle(isOn: .constant(false))
                NimbusToggle(isOn: .constant(true))
            }
            .environment(\.nimbusTheme, CustomWarmTheme())
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Toggle Shapes") {
    @Previewable @State var circleToggle = false
    @Previewable @State var squareToggle = true
    @Previewable @State var pillToggle = false
    @Previewable @State var roundedToggle = true
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Toggle Shapes")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Circle (Default):")
                    Spacer()
                    NimbusToggle(isOn: $circleToggle)
                        .circularToggle()
                }
                
                HStack {
                    Text("Square:")
                    Spacer()
                    NimbusToggle(isOn: $squareToggle)
                        .squareToggle()
                }
                
                HStack {
                    Text("Pill:")
                    Spacer()
                    NimbusToggle(isOn: $pillToggle)
                        .pillToggle()
                }
                
                HStack {
                    Text("Rounded Rect (8pt):")
                    Spacer()
                    NimbusToggle(isOn: $roundedToggle)
                        .roundedToggle(cornerRadius: 8)
                }
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Control Sizes") {
    @Previewable @State var miniToggle = true
    @Previewable @State var smallToggle = false
    @Previewable @State var regularToggle = true
    @Previewable @State var largeToggle = false
    @Previewable @State var extraLargeToggle = true
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("ControlSize Integration")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Mini:")
                    Spacer()
                    NimbusToggle(isOn: $miniToggle)
                        .controlSize(.mini)
                }
                
                HStack {
                    Text("Small:")
                    Spacer()
                    NimbusToggle(isOn: $smallToggle)
                        .controlSize(.small)
                }
                
                HStack {
                    Text("Regular:")
                    Spacer()
                    NimbusToggle(isOn: $regularToggle)
                        .controlSize(.regular)
                }
                
                HStack {
                    Text("Large:")
                    Spacer()
                    NimbusToggle(isOn: $largeToggle)
                        .controlSize(.large)
                }
                
                HStack {
                    Text("Extra Large:")
                    Spacer()
                    NimbusToggle(isOn: $extraLargeToggle)
                        .controlSize(.extraLarge)
                }
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Custom Configurations") {
    @Previewable @State var config1 = false
    @Previewable @State var config2 = true
    @Previewable @State var config3 = false
    @Previewable @State var config4 = true
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Custom Configurations")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Tight Padding:")
                    Spacer()
                    NimbusToggle(isOn: $config1)
                        .toggleKnobPadding(2)
                        .circularToggle()
                }
                
                HStack {
                    Text("Spacious Square:")
                    Spacer()
                    NimbusToggle(isOn: $config2)
                        .squareToggle()
                        .toggleKnobPadding(8)
                        .toggleKnobSize(22)
                }
                
                HStack {
                    Text("Quick Animation:")
                    Spacer()
                    NimbusToggle(isOn: $config3)
                        .quickToggle()
                        .pillToggle()
                }
                
                HStack {
                    Text("Custom Track:")
                    Spacer()
                    NimbusToggle(isOn: $config4)
                        .trackWidth(80)
                        .trackHeight(32)
                        .toggleKnobSize(24)
                        .toggleKnobPadding(4)
                }
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Animation Styles") {
    @Previewable @State var bouncyToggle = false
    @Previewable @State var smoothToggle = false
    @Previewable @State var quickToggle = false
    
    VStack(spacing: 20) {
        VStack(spacing: 8) {
            Text("Animation Styles")
                .font(.headline)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Bouncy:")
                    Spacer()
                    NimbusToggle(isOn: $bouncyToggle)
                        .bouncyToggle()
                }
                
                HStack {
                    Text("Smooth:")
                    Spacer()
                    NimbusToggle(isOn: $smoothToggle)
                        .smoothToggle()
                }
                
                HStack {
                    Text("Quick:")
                    Spacer()
                    NimbusToggle(isOn: $quickToggle)
                        .quickToggle()
                }
            }
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}