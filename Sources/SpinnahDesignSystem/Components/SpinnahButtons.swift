//
//  SpinnahButtons.swift v2
//  SpinnahDesignSystem v1.0
//
//  Created by ShastLeLow on 7/24/25.
//  Updated for API Standardization - DESIGN-13
//

import SwiftUI

// MARK: - Button Configuration
public enum SpinnahButtonStyle {
    case primary        // Gradient with borderedProminent
    case secondary      // Bordered with tint
    case tertiary       // Plain text style
    case destructive    // Red borderedProminent
}

public enum SpinnahButtonSize {
    case regular, large
    
    var controlSize: ControlSize {
        switch self {
        case .regular: return .regular
        case .large: return .large
        }
    }
    
    var padding: EdgeInsets {
        switch self {
        case .regular: return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .large: return EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .regular: return 14
        case .large: return 16
        }
    }
}

// MARK: - Unified Button Component
@MainActor
public struct SpinnahButton: View {
    let title: String
    let style: SpinnahButtonStyle
    let size: SpinnahButtonSize
    let action: () -> Void
    
    public init(
        _ title: String,
        style: SpinnahButtonStyle = .primary,
        size: SpinnahButtonSize = .large,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        switch style {
        case .primary:
            Button(action: action) {
                Text(title)
                    .font(.system(size: size.fontSize, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(size.padding)
            }
            .buttonStyle(.borderedProminent)
            .tint(
                LinearGradient(
                    colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .controlSize(size.controlSize)
            
        case .secondary:
            Button(action: action) {
                Text(title)
                    .font(.system(size: size.fontSize, weight: .medium, design: .rounded))
                    .padding(size.padding)
            }
            .buttonStyle(.bordered)
            .tint(Color.spinnahPrimary)
            .controlSize(size.controlSize)
            
        case .tertiary:
            Button(action: action) {
                Text(title)
                    .font(.system(size: size.fontSize, weight: .medium, design: .rounded))
                    .padding(size.padding)
            }
            .buttonStyle(.plain)
            .foregroundStyle(Color.spinnahPrimary)
            
        case .destructive:
            Button(action: action) {
                Text(title)
                    .font(.system(size: size.fontSize, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(size.padding)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .controlSize(size.controlSize)
        }
    }
    
    private var textColor: Color {
        switch style {
        case .primary, .destructive:
            return .white
        case .secondary:
            return Color.spinnahPrimary
        case .tertiary:
            return Color.spinnahPrimary
        }
    }
}

// MARK: - Button Style Extensions
@MainActor
private extension View {
    func applyButtonStyle(for style: SpinnahButtonStyle) -> some View {
        switch style {
        case .primary, .destructive:
            return AnyView(self.buttonStyle(.borderedProminent))
        case .secondary:
            return AnyView(self.buttonStyle(.bordered))
        case .tertiary:
            return AnyView(self.buttonStyle(.plain))
        }
    }
}

public extension SpinnahButton {
    /// Primary button with Spinnah gradient (most common)
    static func primary(
        _ title: String,
        size: SpinnahButtonSize = .large,
        action: @escaping () -> Void
    ) -> SpinnahButton {
        SpinnahButton(title, style: .primary, size: size, action: action)
    }
    
    /// Secondary button (bordered with tint)
    static func secondary(
        _ title: String,
        size: SpinnahButtonSize = .large,
        action: @escaping () -> Void
    ) -> SpinnahButton {
        SpinnahButton(title, style: .secondary, size: size, action: action)
    }
    
    /// Tertiary button (plain text)
    static func tertiary(
        _ title: String,
        size: SpinnahButtonSize = .large,
        action: @escaping () -> Void
    ) -> SpinnahButton {
        SpinnahButton(title, style: .tertiary, size: size, action: action)
    }
    
    /// Destructive button (red prominent)
    static func destructive(
        _ title: String,
        size: SpinnahButtonSize = .large,
        action: @escaping () -> Void
    ) -> SpinnahButton {
        SpinnahButton(title, style: .destructive, size: size, action: action)
    }
}

// MARK: - Preview Provider
#Preview("Button Styles") {
    ScrollView {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("Primary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton.primary("Get Started") {
                    print("Primary button tapped!")
                }
                
                SpinnahButton.primary("Compact Primary", size: .regular) {
                    print("Compact primary tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Secondary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton.secondary("Learn More") {
                    print("Secondary button tapped!")
                }
                
                SpinnahButton.secondary("Compact Secondary", size: .regular) {
                    print("Compact secondary tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Tertiary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton.tertiary("Skip for now") {
                    print("Tertiary button tapped!")
                }
                
                SpinnahButton.tertiary("Compact Tertiary", size: .regular) {
                    print("Compact tertiary tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Destructive Actions")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton.destructive("Delete Account") {
                    print("Destructive button tapped!")
                }
                
                SpinnahButton.destructive("Delete", size: .regular) {
                    print("Compact destructive tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Button Combinations")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                HStack(spacing: 12) {
                    SpinnahButton.secondary("Cancel") {
                        print("Cancel tapped!")
                    }
                    
                    SpinnahButton.primary("Save") {
                        print("Save tapped!")
                    }
                }
                
                HStack(spacing: 12) {
                    SpinnahButton.tertiary("Maybe Later", size: .regular) {
                        print("Maybe later tapped!")
                    }
                    
                    SpinnahButton.secondary("Learn More", size: .regular) {
                        print("Learn more tapped!")
                    }
                    
                    SpinnahButton.primary("Get Started", size: .regular) {
                        print("Get started tapped!")
                    }
                }
            }
        }
        .padding()
    }
    .background(Color.spinnahBackgroundPrimary)
}

