//
//  TextFieldTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 07.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func textFieldBasic() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    NimbusTextField("Name", text: .constant("John Doe"))
                    
                    NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter your email"))
                    
                    NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
                    
                    NimbusTextField("Disabled", text: .constant("Cannot edit"))
                        .disabled(true)
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldControlSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("ControlSize Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
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
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldStylingVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Styling Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Default", text: .constant("With border and background"))
                            
                            NimbusTextField("No Border", text: .constant("Background only"))
                                .bordered(false)
                            
                            NimbusTextField("No Background", text: .constant("Border only"))
                                .hasBackground(false)
                            
                            NimbusTextField("Plain", text: .constant("No styling"))
                                .bordered(false)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldCustomizations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    // Padding variations
                    VStack(spacing: 8) {
                        Text("Content Padding")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Default", text: .constant("Default padding"))
                            
                            NimbusTextField("Compact", text: .constant("Tight padding"))
                                .contentPadding(4)
                            
                            NimbusTextField("Spacious", text: .constant("Extra padding"))
                                .contentPadding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                        }
                    }
                    
                    // Border and corner variations
                    VStack(spacing: 8) {
                        Text("Border & Corner Variations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Thick Border", text: .constant("2px border"))
                                .borderWidth(2)
                            
                            NimbusTextField("Rounded", text: .constant("Custom corners"))
                                .cornerRadii(RectangleCornerRadii(12))
                            
                            NimbusTextField("Tall Field", text: .constant("Custom height"))
                                .minHeight(60)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldValueTypes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Value Types")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            NimbusTextField("Price", text: .constant("$29.99"))
                            
                            NimbusTextField("Quantity", text: .constant("5"))
                            
                            NimbusTextField("Percentage", text: .constant("85%"))
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
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
        ),
        as: .image,
        record: recording
    )
}

private var textFieldGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Name", text: .constant("John Doe"))
        
        NimbusTextField("Email", text: .constant("john@example.com"), prompt: Text("Enter email"))
        
        NimbusTextField("Custom", text: .constant("Rounded corners"))
            .cornerRadii(RectangleCornerRadii(8))
    }
}

// MARK: - Icon Tests

@MainActor
@Test func textFieldIconBasic() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Basic Icon Examples")
                            .font(.headline)
                        
                        VStack(spacing: 16) {
                            NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
                                .leadingIcon(Image(systemName: "magnifyingglass"))
                            
                            NimbusTextField("Email", text: .constant("john@example.com"))
                                .leadingIcon(Image(systemName: "envelope"))
                            
                            NimbusTextField("Password", text: .constant(""))
                                .trailingIcon(Image(systemName: "lock"))
                            
                            NimbusTextField("Username", text: .constant(""))
                                .leadingIcon(Image(systemName: "person.circle"))
                            
                            NimbusTextField("Settings", text: .constant("Configuration"))
                                .trailingIcon(Image(systemName: "gear"))
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldIconAlignment() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Leading Icons")
                            .font(.headline)
                        
                        VStack(spacing: 16) {
                            NimbusTextField("Default Spacing", text: .constant("Default"))
                                .leadingIcon(Image(systemName: "magnifyingglass"))
                            
                            NimbusTextField("Custom Spacing", text: .constant("Custom"))
                                .leadingIcon(Image(systemName: "magnifyingglass"))
                                .textFieldIconSpacing(12)
                            
                            NimbusTextField("Wide Spacing", text: .constant("Wide"))
                                .leadingIcon(Image(systemName: "magnifyingglass"))
                                .textFieldIconSpacing(16)
                        }
                    }
                    
                    VStack(spacing: 8) {
                        Text("Trailing Icons")
                            .font(.headline)
                        
                        VStack(spacing: 16) {
                            NimbusTextField("Settings", text: .constant("Configuration"))
                                .trailingIcon(Image(systemName: "gear"))
                            
                            NimbusTextField("Secure Field", text: .constant(""))
                                .trailingIcon(Image(systemName: "lock.fill"))
                                .textFieldIconSpacing(16)
                            
                            NimbusTextField("Custom Alignment", text: .constant("Manual"))
                                .icon(Image(systemName: "arrow.right"), alignment: .trailing)
                                .textFieldIconSpacing(8)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldIconControlSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Icons with Control Sizes")
                            .font(.headline)
                        
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
                    }
                    
                    VStack(spacing: 8) {
                        Text("Trailing Icons with Sizes")
                            .font(.headline)
                        
                        VStack(spacing: 16) {
                            NimbusTextField("Large Trailing", text: .constant("Large"))
                                .trailingIcon(Image(systemName: "arrow.right"))
                                .controlSize(.large)
                            
                            NimbusTextField("Regular Trailing", text: .constant("Regular"))
                                .trailingIcon(Image(systemName: "chevron.down"))
                                .controlSize(.regular)
                            
                            NimbusTextField("Small Trailing", text: .constant("Small"))
                                .trailingIcon(Image(systemName: "xmark"))
                                .controlSize(.small)
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldIconCustomViews() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Custom Icon Views")
                            .font(.headline)
                        
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
                            
                            NimbusTextField("Custom Badge", text: .constant("With notification"))
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
                            
                            NimbusTextField("Complex Icon", text: .constant("Advanced"))
                                .leadingIcon(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(.blue)
                                            .frame(width: 20, height: 20)
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12, weight: .bold))
                                    }
                                )
                        }
                    }
                    
                    VStack(spacing: 8) {
                        Text("Icon with Text Combinations")
                            .font(.headline)
                        
                        VStack(spacing: 16) {
                            NimbusTextField("Status Active", text: .constant("Online"))
                                .leadingIcon(
                                    HStack(spacing: 2) {
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 8, height: 8)
                                        Text("●")
                                            .foregroundColor(.green)
                                            .font(.system(size: 10))
                                    }
                                )
                            
                            NimbusTextField("Priority High", text: .constant("Important"))
                                .trailingIcon(
                                    HStack(spacing: 2) {
                                        Text("HIGH")
                                            .font(.system(size: 8, weight: .bold))
                                            .foregroundColor(.orange)
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.orange)
                                    }
                                )
                        }
                    }
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func textFieldIconThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 32) {
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
        ),
        as: .image,
        record: recording
    )
}

private var textFieldIconGrid: some View {
    VStack(spacing: 12) {
        NimbusTextField("Search", text: .constant(""), prompt: Text("Search..."))
            .leadingIcon(Image(systemName: "magnifyingglass"))
        
        NimbusTextField("Email", text: .constant("john@example.com"))
            .leadingIcon(Image(systemName: "envelope"))
        
        NimbusTextField("Password", text: .constant(""))
            .trailingIcon(Image(systemName: "lock"))
        
        NimbusTextField("Custom Spacing", text: .constant("Wide spacing"))
            .leadingIcon(Image(systemName: "person"))
            .textFieldIconSpacing(16)
    }
}
