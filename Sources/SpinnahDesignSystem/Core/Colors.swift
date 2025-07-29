//
//  Colors.swift v1
//  SpinnahDesignSystem v1.0
//
//  Created by ShastLeLow on 7/24/25.
//

import SwiftUI

public extension Color {
    
    // MARK: - Spinnah Brand Colors
    
    /// Primary brand color - adapts based on appearance
    static let spinnahPrimary = Color("SpinnahPrimary", bundle: .module)
    
    /// Secondary brand color - adapts based on appearance
    static let spinnahSecondary = Color("SpinnahSecondary", bundle: .module)
    
    /// Accent color for highlights and CTAs
    static let spinnahAccent = Color("SpinnahAccent", bundle: .module)
    
    /// Gradient start color
    static let spinnahGradientStart = Color("SpinnahGradientStart", bundle: .module)
    
    /// Gradient end color
    static let spinnahGradientEnd = Color("SpinnahGradientEnd", bundle: .module)
    
    // MARK: - Background Colors
        static let spinnahBackgroundPrimary = Color("SpinnahBackgroundPrimary", bundle: .module)
        static let spinnahBackgroundSecondary = Color("SpinnahBackgroundSecondary", bundle: .module)
        
    // MARK: - Text Colors
        static let spinnahTextPrimary = Color("SpinnahTextPrimary", bundle: .module)
        static let spinnahTextSecondary = Color("SpinnahTextSecondary", bundle: .module)
        
    // MARK: - Interactive Colors
        static let spinnahBorder = Color("SpinnahBorder", bundle: .module)
        static let spinnahLink = Color("SpinnahLink", bundle: .module)
        static let spinnahDisabled = Color("SpinnahDisabled", bundle: .module)
        static let spinnahPlaceholder = Color("SpinnahPlaceholder", bundle: .module)
        
    // MARK: - Surface Colors
        static let spinnahSurfaceOverlay = Color("SpinnahSurfaceOverlay", bundle: .module)
        static let spinnahCardElevated = Color("SpinnahCardElevated", bundle: .module)
}
