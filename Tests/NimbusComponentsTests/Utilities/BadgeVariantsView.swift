//
//  BadgeVariantsView.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 05.08.25.
//

import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents

/// Comprehensive badge variants view for snapshot testing
/// Tests all primary and secondary badge variations with consistent layouts
struct BadgeVariantsView: View {
    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Primary Badge - Semantic Types
            VStack(alignment: .leading, spacing: 12) {
                Text("Primary Badge - Semantic Types")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        PrimaryBadge("Info", semanticType: .info)
                        Text("Info")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        PrimaryBadge("Success", semanticType: .success)
                        Text("Success")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        PrimaryBadge("Warning", semanticType: .warning)
                        Text("Warning")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        PrimaryBadge("Error", semanticType: .error)
                        Text("Error")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Secondary Badge - Semantic Types
            VStack(alignment: .leading, spacing: 12) {
                Text("Secondary Badge - Semantic Types")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        SecondaryBadge("Info", semanticType: .info)
                        Text("Info")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Success", semanticType: .success)
                        Text("Success")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Warning", semanticType: .warning)
                        Text("Warning")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Error", semanticType: .error)
                        Text("Error")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Control Size Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Control Size Variations")
                    .font(.headline)
                
                VStack(spacing: 16) {
                    // Primary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            PrimaryBadge("Large", semanticType: .info)
                                .controlSize(.large)
                            Text("Large")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Regular", semanticType: .success)
                                .controlSize(.regular)
                            Text("Regular")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Small", semanticType: .warning)
                                .controlSize(.small)
                            Text("Small")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Mini", semanticType: .error)
                                .controlSize(.mini)
                            Text("Mini")
                                .font(.caption)
                        }
                    }
                    
                    // Secondary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            SecondaryBadge("Large", semanticType: .info)
                                .controlSize(.large)
                            Text("Sec Large")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Regular", semanticType: .success)
                                .controlSize(.regular)
                            Text("Sec Regular")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Small", semanticType: .warning)
                                .controlSize(.small)
                            Text("Sec Small")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Mini", semanticType: .error)
                                .controlSize(.mini)
                            Text("Sec Mini")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // MARK: - Badge Type Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Badge Type Variations")
                    .font(.headline)
                
                VStack(spacing: 16) {
                    // Primary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            PrimaryBadge("Capsule", semanticType: .info)
                                .capsule()
                            Text("Capsule")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Rounded 4", semanticType: .success)
                                .roundedRect(4)
                            Text("Rounded 4")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Rounded 8", semanticType: .warning)
                                .roundedRect(8)
                            Text("Rounded 8")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Rounded 12", semanticType: .error)
                                .roundedRect(12)
                            Text("Rounded 12")
                                .font(.caption)
                        }
                    }
                    
                    // Secondary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            SecondaryBadge("Capsule", semanticType: .info)
                                .capsule()
                            Text("Sec Capsule")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Rounded 4", semanticType: .success)
                                .roundedRect(4)
                            Text("Sec Round 4")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Rounded 8", semanticType: .warning)
                                .roundedRect(8)
                            Text("Sec Round 8")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Rounded 12", semanticType: .error)
                                .roundedRect(12)
                            Text("Sec Round 12")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // MARK: - Border Width Variations (Secondary Only)
            VStack(alignment: .leading, spacing: 12) {
                Text("Border Width Variations (Secondary)")
                    .font(.headline)
                
                HStack(spacing: 16) {
                    VStack(spacing: 8) {
                        SecondaryBadge("Border 1", semanticType: .info)
                            .borderWidth(1)
                        Text("1px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Border 1.5", semanticType: .success)
                            .borderWidth(1.5)
                        Text("1.5px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Border 2", semanticType: .warning)
                            .borderWidth(2)
                        Text("2px")
                            .font(.caption)
                    }
                    
                    VStack(spacing: 8) {
                        SecondaryBadge("Border 3", semanticType: .error)
                            .borderWidth(3)
                        Text("3px")
                            .font(.caption)
                    }
                }
            }
            
            // MARK: - Content Padding Variations
            VStack(alignment: .leading, spacing: 12) {
                Text("Content Padding Variations")
                    .font(.headline)
                
                VStack(spacing: 16) {
                    // Primary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            PrimaryBadge("Default", semanticType: .info)
                            Text("Default")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Tight", semanticType: .success)
                                .contentPadding(2)
                            Text("Tight (2px)")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Spacious", semanticType: .warning)
                                .contentPadding(16)
                            Text("Spacious (16px)")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Custom", semanticType: .error)
                                .contentPadding(top: 8, leading: 20, bottom: 8, trailing: 20)
                            Text("Custom")
                                .font(.caption)
                        }
                    }
                    
                    // Secondary badges
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            SecondaryBadge("Default", semanticType: .info)
                            Text("Sec Default")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Tight", semanticType: .success)
                                .contentPadding(2)
                            Text("Sec Tight")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Spacious", semanticType: .warning)
                                .contentPadding(16)
                            Text("Sec Spacious")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Custom", semanticType: .error)
                                .contentPadding(top: 8, leading: 20, bottom: 8, trailing: 20)
                            Text("Sec Custom")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // MARK: - Badge with Icons
            VStack(alignment: .leading, spacing: 12) {
                Text("Badges with Icons")
                    .font(.headline)
                
                VStack(spacing: 16) {
                    // Primary badges with icons
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            PrimaryBadge("New", systemImage: "star.fill", semanticType: .info)
                            Text("Primary + Icon")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                                .roundedRect(6)
                            Text("Primary Rounded")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            PrimaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                                .controlSize(.large)
                            Text("Primary Large")
                                .font(.caption)
                        }
                    }
                    
                    // Secondary badges with icons
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            SecondaryBadge("New", systemImage: "star.fill", semanticType: .info)
                            Text("Secondary + Icon")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Done", systemImage: "checkmark.circle.fill", semanticType: .success)
                                .roundedRect(6)
                                .borderWidth(2)
                            Text("Secondary Rounded")
                                .font(.caption)
                        }
                        
                        VStack(spacing: 8) {
                            SecondaryBadge("Alert", systemImage: "exclamationmark.triangle.fill", semanticType: .warning)
                                .controlSize(.large)
                                .borderWidth(1.5)
                            Text("Secondary Large")
                                .font(.caption)
                        }
                    }
                }
            }
            
            // MARK: - Long Text Badges
            VStack(alignment: .leading, spacing: 12) {
                Text("Long Text Badges")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    PrimaryBadge("This is a very long badge text that should adapt its width", semanticType: .info)
                        .capsule()
                    
                    SecondaryBadge("Another long text example with secondary styling", semanticType: .success)
                        .roundedRect(8)
                        .borderWidth(1.5)
                    
                    PrimaryBadge("Mixed Long", systemImage: "star.fill", semanticType: .warning)
                        .roundedRect(6)
                        .controlSize(.small)
                }
            }
            
            // MARK: - Combined Customizations
            VStack(alignment: .leading, spacing: 12) {
                Text("Combined Customizations")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    PrimaryBadge("Everything Custom", semanticType: .info)
                        .roundedRect(10)
                        .controlSize(.large)
                        .contentPadding(top: 12, leading: 24, bottom: 12, trailing: 24)
                    
                    SecondaryBadge("Full Customization", systemImage: "gear.circle.fill", semanticType: .success)
                        .roundedRect(8)
                        .controlSize(.regular)
                        .borderWidth(2.5)
                        .contentPadding(top: 6, leading: 16, bottom: 6, trailing: 16)
                    
                    PrimaryBadge("Compact Design", systemImage: "bolt.fill", semanticType: .warning)
                        .roundedRect(4)
                        .controlSize(.mini)
                        .contentPadding(1)
                }
            }
        }
        .padding()
    }
}