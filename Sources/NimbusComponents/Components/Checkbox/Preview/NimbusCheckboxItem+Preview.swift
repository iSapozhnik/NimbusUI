//
//  NimbusCheckboxItem+Preview.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 02.08.25.
//

import SwiftUI

// MARK: - Previews

#Preview("Basic Checkbox Item States") {
    @Previewable @State var isChecked1 = false
    @Previewable @State var isChecked2 = true
    @Previewable @State var isChecked3 = false
    @Previewable @State var isChecked4 = true
    
    VStack(spacing: 20) {
        NimbusCheckboxItem("The first line of content", isOn: $isChecked1)
        
        NimbusCheckboxItem(
            "The first line of content",
            subtitle: "The second & supportive line",
            isOn: $isChecked2
        )
        
        NimbusCheckboxItem(
            "Disabled unchecked",
            subtitle: "This item is disabled",
            isOn: $isChecked3
        )
        .disabled(true)
        
        NimbusCheckboxItem(
            "Disabled checked",
            subtitle: "This item is also disabled",
            isOn: $isChecked4
        )
        .disabled(true)
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Checkbox Position Variations") {
    @Previewable @State var isChecked1 = true
    @Previewable @State var isChecked2 = true
    
    VStack(spacing: 20) {
        Text("Leading Checkbox (Default)")
            .font(.headline)
        
        NimbusCheckboxItem(
            "The first line of content",
            subtitle: "The second & supportive line",
            isOn: $isChecked1,
            checkboxPosition: .leading
        )
        
        Text("Trailing Checkbox")
            .font(.headline)
        
        NimbusCheckboxItem(
            "The first line of content",
            subtitle: "The second & supportive line",
            isOn: $isChecked2,
            checkboxPosition: .trailing
        )
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Theme Variations") {
    @Previewable @State var isChecked1 = true
    @Previewable @State var isChecked2 = true
    @Previewable @State var isChecked3 = true
    
    VStack(spacing: 30) {
        VStack(spacing: 15) {
            Text("Default Theme")
                .font(.headline)
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line",
                isOn: $isChecked1
            )
        }
        .environment(\.nimbusTheme, NimbusTheme.default)
        
        VStack(spacing: 15) {
            Text("Maritime Theme")
                .font(.headline)
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line",
                isOn: $isChecked2
            )
        }
        .environment(\.nimbusTheme, MaritimeTheme())
        
        VStack(spacing: 15) {
            Text("Custom Warm Theme")
                .font(.headline)
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line",
                isOn: $isChecked3
            )
        }
        .environment(\.nimbusTheme, CustomWarmTheme())
    }
    .padding()
}

#Preview("Environment Overrides") {
    @Previewable @State var isChecked1 = true
    @Previewable @State var isChecked2 = true
    @Previewable @State var isChecked3 = true
    @Previewable @State var isChecked4 = true
    
    VStack(spacing: 20) {
        Text("Default Spacing")
        NimbusCheckboxItem(
            "Default spacing",
            subtitle: "Standard theme values",
            isOn: $isChecked1
        )
        
        Text("Custom Item Spacing")
        NimbusCheckboxItem(
            "Wide item spacing",
            subtitle: "Checkbox and text spaced further apart",
            isOn: $isChecked2
        )
        .environment(\.nimbusCheckboxItemSpacing, 24)
        
        Text("Custom Text Spacing")
        NimbusCheckboxItem(
            "Custom text spacing",
            subtitle: "Title and subtitle spaced further apart",
            isOn: $isChecked3
        )
        .environment(\.nimbusCheckboxItemTextSpacing, 12)
        
        Text("Custom Padding & Height")
        NimbusCheckboxItem(
            "Custom padding",
            subtitle: "More padding and minimum height",
            isOn: $isChecked4
        )
        .environment(\.nimbusCheckboxItemPadding, 24)
        .environment(\.nimbusCheckboxItemMinHeight, 60)
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Vertical Alignment Options") {
    @Previewable @State var isChecked1 = true
    @Previewable @State var isChecked2 = true
    @Previewable @State var isChecked3 = true
    @Previewable @State var isChecked4 = true
    
    VStack(spacing: 25) {
        VStack(spacing: 15) {
            Text("Center Alignment (Default)")
                .font(.headline)
            
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line",
                isOn: $isChecked1,
                checkboxPosition: .leading,
                verticalAlignment: .center
            )
            
            NimbusCheckboxItem(
                "The first line of content", 
                subtitle: "The second & supportive line",
                isOn: $isChecked2,
                checkboxPosition: .trailing,
                verticalAlignment: .center
            )
        }
        
        VStack(spacing: 15) {
            Text("Baseline Alignment")
                .font(.headline)
            
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line",
                isOn: $isChecked3,
                checkboxPosition: .leading,
                verticalAlignment: .baseline
            )
            
            NimbusCheckboxItem(
                "The first line of content",
                subtitle: "The second & supportive line", 
                isOn: $isChecked4,
                checkboxPosition: .trailing,
                verticalAlignment: .baseline
            )
        }
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}

#Preview("Long Content Handling") {
    @Previewable @State var isChecked1 = true
    @Previewable @State var isChecked2 = true
    
    VStack(spacing: 20) {
        NimbusCheckboxItem(
            "This is a very long title that should wrap properly across multiple lines to test the layout behavior",
            subtitle: "And this is also a very long subtitle that provides additional context and should also wrap properly across multiple lines",
            isOn: $isChecked1,
            checkboxPosition: .leading
        )
        
        NimbusCheckboxItem(
            "This is a very long title that should wrap properly across multiple lines to test the layout behavior",
            subtitle: "And this is also a very long subtitle that provides additional context and should also wrap properly across multiple lines",
            isOn: $isChecked2,
            checkboxPosition: .trailing
        )
    }
    .environment(\.nimbusTheme, NimbusTheme.default)
    .padding()
}
