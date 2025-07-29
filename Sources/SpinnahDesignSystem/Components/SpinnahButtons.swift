//
//  SpinnahButtons.swift v1
//  SpinnahDesignSystem v1.0
//
//  Created by ShastLeLow on 7/24/25.
//

import SwiftUI

public struct SpinnahButton: View {
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
        }
        .buttonStyle(.borderedProminent)
        .tint(
            LinearGradient(
                colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .controlSize(.large)
    }
}

public struct SpinnahSecondaryButton: View {
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
        }
        .buttonStyle(.bordered)
        .tint(Color.spinnahPrimary)
        .controlSize(.large)
    }
}

public struct SpinnahTertiaryButton: View {
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
        .foregroundStyle(Color.spinnahPrimary)
    }
}

public struct SpinnahDestructiveButton: View {
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .controlSize(.large)
    }
}

public struct SpinnahCompactButton: View {
    let title: String
    let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .buttonStyle(.borderedProminent)
        .tint(
            LinearGradient(
                colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .controlSize(.regular)
    }
}

#Preview("Light Mode") {
    ScrollView {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("Primary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton("Get Started") {
                    print("Primary button tapped!")
                }
                
                SpinnahCompactButton("Compact Primary") {
                    print("Compact primary tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Secondary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahSecondaryButton("Learn More") {
                    print("Secondary button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Text Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahTertiaryButton("Skip for now") {
                    print("Tertiary button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Destructive Actions")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahDestructiveButton("Delete Account") {
                    print("Destructive button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Button Combinations")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                HStack(spacing: 12) {
                    SpinnahSecondaryButton("Cancel") {
                        print("Cancel tapped!")
                    }
                    
                    SpinnahButton("Save") {
                        print("Save tapped!")
                    }
                }
            }
        }
        .padding()
    }
    .background(Color.spinnahBackgroundPrimary)
}

#Preview("Dark Mode") {
    ScrollView {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text("Primary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahButton("Get Started") {
                    print("Primary button tapped!")
                }
                
                SpinnahCompactButton("Compact Primary") {
                    print("Compact primary tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Secondary Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahSecondaryButton("Learn More") {
                    print("Secondary button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Text Buttons")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahTertiaryButton("Skip for now") {
                    print("Tertiary button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Destructive Actions")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                SpinnahDestructiveButton("Delete Account") {
                    print("Destructive button tapped!")
                }
            }
            
            VStack(spacing: 16) {
                Text("Button Combinations")
                    .font(.headline)
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                HStack(spacing: 12) {
                    SpinnahSecondaryButton("Cancel") {
                        print("Cancel tapped!")
                    }
                    
                    SpinnahButton("Save") {
                        print("Save tapped!")
                    }
                }
            }
        }
        .padding()
    }
    .background(Color.spinnahBackgroundPrimary)
    .preferredColorScheme(.dark)
}
