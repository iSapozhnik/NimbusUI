//
//  ToggleTests.swift
//  NimbusUI
//
//  Created by Ivan Sapozhnik on 06.08.25.
//

import Testing
import SwiftUI
@testable import NimbusCore
@testable import NimbusComponents
import SnapshotTesting

private let recording = false

@MainActor
@Test func toggleBasic() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        NimbusToggle(isOn: .constant(false))
                        Text("Off")
                    }
                    
                    HStack(spacing: 12) {
                        NimbusToggle(isOn: .constant(true))
                        Text("On")
                    }
                    
                    HStack(spacing: 12) {
                        NimbusToggle(isOn: .constant(false))
                            .disabled(true)
                        Text("Disabled Off")
                    }
                    
                    HStack(spacing: 12) {
                        NimbusToggle(isOn: .constant(true))
                            .disabled(true)
                        Text("Disabled On")
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
@Test func toggleShapes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Toggle Shapes")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Circle:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .circularToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .circularToggle()
                                }
                            }
                            
                            HStack {
                                Text("Square:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .squareToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .squareToggle()
                                }
                            }
                            
                            HStack {
                                Text("Pill:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .pillToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .pillToggle()
                                }
                            }
                            
                            HStack {
                                Text("Rounded (8pt):")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .roundedToggle(cornerRadius: 8)
                                    NimbusToggle(isOn: .constant(true))
                                        .roundedToggle(cornerRadius: 8)
                                }
                            }
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
@Test func toggleSizes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Toggle Sizes")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Mini:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .miniToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .miniToggle()
                                }
                            }
                            
                            HStack {
                                Text("Small:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .smallToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .smallToggle()
                                }
                            }
                            
                            HStack {
                                Text("Regular:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .regularToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .regularToggle()
                                }
                            }
                            
                            HStack {
                                Text("Large:")
                                Spacer()
                                HStack(spacing: 8) {
                                    NimbusToggle(isOn: .constant(false))
                                        .largeToggle()
                                    NimbusToggle(isOn: .constant(true))
                                        .largeToggle()
                                }
                            }
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
@Test func toggleItems() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        NimbusToggleItem(
                            "Enable Notifications",
                            subtitle: "Receive app alerts and updates",
                            isOn: .constant(true)
                        )
                        
                        NimbusToggleItem(
                            "Dark Mode",
                            subtitle: "Use dark theme throughout the app",
                            isOn: .constant(false)
                        )
                        
                        NimbusToggleItem(
                            "Leading Toggle",
                            subtitle: "Toggle positioned on the left",
                            isOn: .constant(true),
                            togglePosition: .leading
                        )
                        
                        NimbusToggleItem(
                            "Simple Setting",
                            isOn: .constant(false)
                        )
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
@Test func toggleCustomizations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        Text("Custom Configurations")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Tight Padding:")
                                Spacer()
                                NimbusToggle(isOn: .constant(true))
                                    .toggleKnobPadding(2)
                                    .circularToggle()
                            }
                            
                            HStack {
                                Text("Spacious Square:")
                                Spacer()
                                NimbusToggle(isOn: .constant(false))
                                    .squareToggle()
                                    .toggleKnobPadding(8)
                                    .toggleKnobSize(22)
                            }
                            
                            HStack {
                                Text("Custom Track:")
                                Spacer()
                                NimbusToggle(isOn: .constant(true))
                                    .trackWidth(80)
                                    .trackHeight(32)
                                    .toggleKnobSize(24)
                                    .toggleKnobPadding(4)
                            }
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
@Test func toggleThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
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
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}

@MainActor
@Test func toggleItemThemeVariations() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 25) {
                    VStack(spacing: 8) {
                        Text("NimbusTheme.default")
                            .font(.headline)
                        NimbusToggleItem(
                            "Example Setting",
                            subtitle: "This demonstrates theme integration",
                            isOn: .constant(true)
                        )
                    }
                    
                    VStack(spacing: 8) {
                        Text("MaritimeTheme")
                            .font(.headline)
                        NimbusToggleItem(
                            "Example Setting",
                            subtitle: "This demonstrates theme integration",
                            isOn: .constant(true)
                        )
                        .environment(\.nimbusTheme, MaritimeTheme())
                    }
                    
                    VStack(spacing: 8) {
                        Text("CustomWarmTheme")
                            .font(.headline)
                        NimbusToggleItem(
                            "Example Setting",
                            subtitle: "This demonstrates theme integration",
                            isOn: .constant(false)
                        )
                        .environment(\.nimbusTheme, CustomWarmTheme())
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
@Test func toggleItemCustomShapes() async throws {
    assertSnapshot(
        of: SnapshotUtility.view(
            from: ShowcaseView {
                VStack(spacing: 4) {
                    NimbusToggleItem(
                        "Circle Toggle",
                        subtitle: "Traditional circular toggle",
                        isOn: .constant(true)
                    )
                    .circularToggle()
                    
                    NimbusToggleItem(
                        "Square Toggle",
                        subtitle: "Modern square toggle",
                        isOn: .constant(false)
                    )
                    .squareToggle()
                    
                    NimbusToggleItem(
                        "Pill Toggle",
                        subtitle: "Fully rounded toggle",
                        isOn: .constant(true)
                    )
                    .pillToggle()
                    
                    NimbusToggleItem(
                        "Rounded Toggle",
                        subtitle: "Custom corner radius",
                        isOn: .constant(false)
                    )
                    .roundedToggle(cornerRadius: 6)
                }
                .padding()
            }
            .environment(\.nimbusTheme, NimbusTheme.default)
        ),
        as: .image,
        record: recording
    )
}