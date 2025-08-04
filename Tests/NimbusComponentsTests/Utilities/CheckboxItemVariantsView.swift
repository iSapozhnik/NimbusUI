//
//  CheckboxItemVariantsView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 04.08.25.
//

import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents

/// Comprehensive checkbox variants view for snapshot testing
/// Tests all checkbox and checkbox item variations with consistent layouts
struct CheckboxItemVariantsView: View {
    @State private var basicChecked = true
    @State private var basicUnchecked = false
    @State private var itemChecked = true
    @State private var itemUnchecked = false
    @State private var sizeVariations = [false, true, false, true, false, true]
    @State private var strokeVariations = [true, true, true, true, true]
    @State private var itemVariations = [false, true, false, true]
    
    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Basic Checkbox States
            VStack(alignment: .leading, spacing: 12) {
                Text("Basic Checkbox States")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(false))
                        Text("Unchecked")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                        Text("Checked")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(false))
                            .disabled(true)
                        Text("Disabled")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                            .disabled(true)
                        Text("Disabled ✓")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Size Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Size Variations")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[0])
                            .size(16)
                        Text("16px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[1])
                            .size(20)
                        Text("20px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[2])
                            .size(24)
                        Text("24px (Default)")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[3])
                            .size(28)
                        Text("28px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[4])
                            .size(32)
                        Text("32px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: $sizeVariations[5])
                            .size(40)
                        Text("40px")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Corner Radii Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Corner Radii Variations")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                            .cornerRadii(RectangleCornerRadii(0))
                        Text("Square")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                            .cornerRadii(RectangleCornerRadii(4))
                        Text("Default")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                            .cornerRadii(RectangleCornerRadii(8))
                        Text("Rounded")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(true))
                            .cornerRadii(RectangleCornerRadii(12))
                        Text("Very Rounded")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Stroke Customization
            VStack(alignment: .leading, spacing: 12) {
                Text("Stroke Customization")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    // Stroke Width Variations
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: $strokeVariations[0])
                                .strokeWidth(1.0)
                            Text("Width: 1.0")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: $strokeVariations[1])
                                .strokeWidth(1.5)
                            Text("Width: 1.5")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: .constant(true))
                                .strokeWidth(2.0)
                            Text("Width: 2.0")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: $strokeVariations[2])
                                .strokeWidth(2.5)
                            Text("Width: 2.5")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: $strokeVariations[3])
                                .strokeWidth(3.0)
                            Text("Width: 3.0")
                                .font(.caption)
                        }
                    }
                    
                    // Line Cap Variations  
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: .constant(true))
                                .lineCap(.round)
                            Text("Round Cap")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: .constant(true))
                                .lineCap(.square)
                            Text("Square Cap")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            NimbusCheckbox(isOn: .constant(true))
                                .lineCap(.butt)
                            Text("Butt Cap")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // MARK: - Border Width Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Border Width Variations")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(false))
                            .borderWidth(1)
                        Text("Border: 1px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(false))
                            .borderWidth(2)
                        Text("Border: 2px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        NimbusCheckbox(isOn: .constant(false))
                            .borderWidth(3)
                        Text("Border: 3px")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Checkbox Items - Basic
            VStack(alignment: .leading, spacing: 12) {
                Text("Checkbox Items - Basic")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    NimbusCheckboxItem(
                        "Title Only Item",
                        isOn: $itemVariations[0]
                    )
                    
                    NimbusCheckboxItem(
                        "Title with Subtitle",
                        subtitle: "This is a subtitle with additional information",
                        isOn: $itemVariations[1]
                    )
                    
                    NimbusCheckboxItem(
                        "Disabled Item",
                        subtitle: "This item is disabled",
                        isOn: .constant(false)
                    )
                    .disabled(true)
                    
                    NimbusCheckboxItem(
                        "Disabled Checked",
                        subtitle: "This item is disabled and checked",
                        isOn: .constant(true)
                    )
                    .disabled(true)
                }
            }
            
            // MARK: - Checkbox Items - Position Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Checkbox Items - Position Variations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    NimbusCheckboxItem(
                        "Leading Position",
                        subtitle: "Checkbox on the left side",
                        isOn: $itemVariations[2],
                        checkboxPosition: .leading
                    )
                    
                    NimbusCheckboxItem(
                        "Trailing Position", 
                        subtitle: "Checkbox on the right side",
                        isOn: $itemVariations[3],
                        checkboxPosition: .trailing
                    )
                }
            }
            
            // MARK: - Checkbox Items - Alignment Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Checkbox Items - Vertical Alignment")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    NimbusCheckboxItem(
                        "Center Alignment",
                        subtitle: "Checkbox is centered vertically with the entire text content area",
                        isOn: .constant(true),
                        verticalAlignment: .center
                    )
                    
                    NimbusCheckboxItem(
                        "Baseline Alignment",
                        subtitle: "Checkbox aligns with the title text baseline, ignoring subtitle",
                        isOn: .constant(true),
                        verticalAlignment: .baseline
                    )
                }
            }
            
            // MARK: - Combined Customizations
            VStack(alignment: .leading, spacing: 12) {
                Text("Combined Customizations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    NimbusCheckboxItem(
                        "Custom Everything", 
                        subtitle: "Large size, rounded corners, thick stroke, wide spacing",
                        isOn: .constant(true)
                    )
                    .size(32)
                    .cornerRadii(RectangleCornerRadii(8))
                    .strokeWidth(2.5)
                    .lineCap(.round)
                    .borderWidth(2)
                    .environment(\.nimbusCheckboxItemSpacing, 16)
                    
                    NimbusCheckboxItem(
                        "Compact Configuration",
                        subtitle: "Small size, minimal styling, tight spacing",
                        isOn: .constant(false),
                        checkboxPosition: .trailing
                    )
                    .size(16)
                    .cornerRadii(RectangleCornerRadii(2))
                    .strokeWidth(1.0)
                    .lineCap(.square)
                    .environment(\.nimbusCheckboxItemSpacing, 8)
                }
            }
        }
        .padding()
    }
}
