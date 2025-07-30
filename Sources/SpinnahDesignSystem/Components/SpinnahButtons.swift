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
    case liquidGlass    // Apple liquid glass effect
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
    
    // New tint parameter for liquidGlass style only
    let liquidGlassTint: LinearGradient?
    
    public init(
        _ title: String,
        style: SpinnahButtonStyle = .primary,
        size: SpinnahButtonSize = .large,
        liquidGlassTint: LinearGradient? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.action = action
        self.liquidGlassTint = liquidGlassTint
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
            .tint(Color.spinnahSecondary)
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
            
        case .liquidGlass:
            Button(action: action) {
                Text(title)
                    .font(.system(size: size.fontSize, weight: .medium, design: .rounded))
                    .padding(size.padding)
                    .liquidGlass(tint: liquidGlassTint)
            }
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
        case .liquidGlass:
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
        case .liquidGlass:
            return AnyView(self) // No additional buttonStyle for liquidGlass
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
    
    /// Liquid Glass button (Apple liquid glass effect)
    /// - Parameters:
    ///   - title: Button title
    ///   - size: Button size
    ///   - tint: Optional gradient tint for the liquid glass effect. Defaults to blue/green gradient.
    ///   - action: Button action closure
    static func liquidGlass(
        _ title: String,
        size: SpinnahButtonSize = .large,
        tint: LinearGradient? = LinearGradient(
            colors: [Color.blue, Color.green],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        action: @escaping () -> Void
    ) -> SpinnahButton {
        SpinnahButton(title, style: .liquidGlass, size: size, liquidGlassTint: tint, action: action)
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
            
            VStack(spacing: 16) {
                Text("Liquid Glass Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                // Blue/Green (Aqua Glass)
                SpinnahButton.liquidGlass("Aqua Glass") {
                    print("Liquid glass tapped!")
                }
                
                // Light Blue/Orange (Warm Glass)
                SpinnahButton.liquidGlass(
                    "Warm Glass",
                    size: .regular,
                    tint: LinearGradient(
                        colors: [Color.cyan.opacity(0.8), Color.orange.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                ) {
                    print("Warm liquid glass tapped!")
                }
                
                // Orange/Yellow (Solid Vibrant)
                SpinnahButton.liquidGlass(
                    "Vibrant Glass",
                    size: .large,
                    tint: LinearGradient(
                        colors: [Color.orange.opacity(0.9), Color.yellow.opacity(0.9)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                ) {
                    print("Vibrant liquid glass tapped!")
                }
            }
        }
        .padding()
    }
    .background(Color.spinnahBackgroundPrimary)
}

// MARK: - Liquid Glass Modifier
@MainActor
private extension View {
    @ViewBuilder
    func liquidGlass(tint: LinearGradient? = nil) -> some View {
        self
            .padding(0) // Remove any internal padding
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .glassEffect()
                    if let tint = tint {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(tint)
                            .opacity(0.6)
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

