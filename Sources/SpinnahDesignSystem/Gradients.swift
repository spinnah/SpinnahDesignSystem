//
//  Gradients.swift v1
//  SpinnahDesignSystem v2.0
//
//  Created by ShastLeLow on 7/24/25.
//

import SwiftUI

public extension LinearGradient {
    
    // MARK: - Spinnah Brand Gradients
    
    /// Primary brand gradient - diagonal from top-leading to bottom-trailing
    static let spinnahPrimary = LinearGradient(
        colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    /// Horizontal brand gradient - left to right
    static let spinnahHorizontal = LinearGradient(
        colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    /// Vertical brand gradient - top to bottom
    static let spinnahVertical = LinearGradient(
        colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
        startPoint: .top,
        endPoint: .bottom
    )
    
    /// Reverse diagonal brand gradient - top-trailing to bottom-leading
    static let spinnahReverse = LinearGradient(
        colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
        startPoint: .topTrailing,
        endPoint: .bottomLeading
    )
    
    /// Subtle brand gradient with reduced opacity for backgrounds
    static let spinnahSubtle = LinearGradient(
        colors: [
            Color.spinnahGradientStart.opacity(0.1),
            Color.spinnahGradientEnd.opacity(0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

public extension RadialGradient {
    
    // MARK: - Spinnah Radial Gradients
    
    /// Radial brand gradient from center
    static let spinnahRadial = RadialGradient(
        colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
        center: .center,
        startRadius: 0,
        endRadius: 200
    )
    
    /// Radial spotlight effect
    static let spinnahSpotlight = RadialGradient(
        colors: [
            Color.spinnahGradientEnd.opacity(0.8),
            Color.spinnahGradientStart.opacity(0.3),
            Color.clear
        ],
        center: .center,
        startRadius: 0,
        endRadius: 150
    )
}

public extension AngularGradient {
    
    // MARK: - Spinnah Angular Gradients
    
    /// Angular brand gradient - full rotation
    static let spinnahAngular = AngularGradient(
        colors: [
            Color.spinnahGradientStart,
            Color.spinnahGradientEnd,
            Color.spinnahGradientStart
        ],
        center: .center
    )
    
    /// Conic gradient with smooth transitions
    static let spinnahConic = AngularGradient(
        colors: [
            Color.spinnahGradientStart,
            Color.spinnahGradientEnd,
            Color.spinnahGradientStart.opacity(0.7),
            Color.spinnahGradientEnd.opacity(0.7),
            Color.spinnahGradientStart
        ],
        center: .center,
        startAngle: .degrees(0),
        endAngle: .degrees(360)
    )
}

// MARK: - Custom Gradient Functions

public struct SpinnahGradients {
    
    /// Creates a custom linear gradient with specified direction
    /// - Parameters:
    ///   - startPoint: Starting point of the gradient
    ///   - endPoint: Ending point of the gradient
    ///   - opacity: Opacity level for both colors (default: 1.0)
    /// - Returns: LinearGradient with brand colors
    public static func linear(
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        opacity: Double = 1.0
    ) -> LinearGradient {
        LinearGradient(
            colors: [
                Color.spinnahGradientStart.opacity(opacity),
                Color.spinnahGradientEnd.opacity(opacity)
            ],
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
    
    /// Creates a custom radial gradient
    /// - Parameters:
    ///   - center: Center point of the gradient
    ///   - startRadius: Starting radius
    ///   - endRadius: Ending radius
    ///   - opacity: Opacity level for both colors (default: 1.0)
    /// - Returns: RadialGradient with brand colors
    public static func radial(
        center: UnitPoint = .center,
        startRadius: CGFloat = 0,
        endRadius: CGFloat = 200,
        opacity: Double = 1.0
    ) -> RadialGradient {
        RadialGradient(
            colors: [
                Color.spinnahGradientStart.opacity(opacity),
                Color.spinnahGradientEnd.opacity(opacity)
            ],
            center: center,
            startRadius: startRadius,
            endRadius: endRadius
        )
    }
    
    /// Creates a three-stop gradient with a middle color
    /// - Parameters:
    ///   - middleColor: Color to use in the middle of the gradient
    ///   - startPoint: Starting point of the gradient
    ///   - endPoint: Ending point of the gradient
    /// - Returns: LinearGradient with three color stops
    public static func threeStop(
        middleColor: Color,
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing
    ) -> LinearGradient {
        LinearGradient(
            colors: [
                Color.spinnahGradientStart,
                middleColor,
                Color.spinnahGradientEnd
            ],
            startPoint: startPoint,
            endPoint: endPoint
        )
    }
}

// MARK: - Convenience View Modifiers

public extension View {
    
    /// Applies the primary Spinnah gradient as a background
    func spinnahGradientBackground() -> some View {
        self.background(LinearGradient.spinnahPrimary)
    }
    
    /// Applies a subtle Spinnah gradient as a background
    func spinnahSubtleBackground() -> some View {
        self.background(LinearGradient.spinnahSubtle)
    }
    
    /// Applies the primary Spinnah gradient as an overlay
    /// - Parameter blendMode: The blend mode to use (default: .normal)
    func spinnahGradientOverlay(blendMode: BlendMode = .normal) -> some View {
        self.overlay(LinearGradient.spinnahPrimary)
            .blendMode(blendMode)
    }
}
