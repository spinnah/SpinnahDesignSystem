//  ------------------------------------------
//  ColorValidationView.swift v1
//  SpinnahDesignSystem v1.0
//
//  Created by ShastLeLow on 7/28/25.
//
//  This is a SwiftUI view for validating the color system in the
//  SpinnahDesignSystem package. It displays all brand colors,
//  semantic colors, and gradient system in both light and dark modes.
//  ------------------------------------------

import SwiftUI

struct ColorValidationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("SpinnahDesignSystem Color Validation")
                    .font(.largeTitle)
                    .bold()
                
                // Brand Colors Section
                ColorSection(title: "Brand Colors") {
                    ColorSwatch(name: "SpinnahPrimary", color: .spinnahPrimary)
                    ColorSwatch(name: "SpinnahSecondary", color: .spinnahSecondary)
                    ColorSwatch(name: "SpinnahAccent", color: .spinnahAccent)
                }
                
                // Gradient Test
                GradientSection()
                
                // Interactive Colors Section
                                ColorSection(title: "Interactive Colors") {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("Link Color Text")
                                                .foregroundColor(.spinnahLink)
                                            Spacer()
                                            Rectangle()
                                                .fill(Color.spinnahBorder)
                                                .frame(width: 60, height: 2)
                                        }
                                        
                                        HStack {
                                            Text("Disabled Text")
                                                .foregroundColor(.spinnahDisabled)
                                                .padding(8)
                                                .background(Color.spinnahBackgroundSecondary)
                                                .cornerRadius(4)
                                            
                                            Spacer()
                                            
                                            Text("Placeholder text")
                                                .foregroundColor(.spinnahPlaceholder)
                                                .padding(8)
                                                .background(Color.spinnahBackgroundPrimary)
                                                .cornerRadius(4)
                                        }
                                    }
                                }
                // Background & Text Combinations
                AccessibilitySection()
            }
            .padding()
        }
    }
}

struct ColorSection<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .bold()
            
            content()
        }
    }
}

struct ColorSwatch: View {
    let name: String
    let color: Color
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 60, height: 40)
                .cornerRadius(8)
            
            Text(name)
                .font(.body)
            
            Spacer()
        }
    }
}

struct GradientSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Gradient System")
                .font(.headline)
                .bold()
            
            Rectangle()
                .fill(LinearGradient.spinnahPrimary)
                .frame(height: 60)
                .cornerRadius(12)
                .overlay(
                    Text("SpinnahBrand Gradient")
                        .foregroundColor(.white)
                        .bold()
                )
        }
    }
}

struct AccessibilitySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Background & Text Accessibility")
                .font(.headline)
                .bold()
            
            VStack(spacing: 8) {
                HStack {
                    Text("Primary on Primary BG")
                        .foregroundColor(.spinnahTextPrimary)
                        .padding()
                        .background(Color.spinnahBackgroundPrimary)
                        .cornerRadius(8)
                    
                    Text("Secondary on Secondary BG")
                        .foregroundColor(.spinnahTextSecondary)
                        .padding()
                        .background(Color.spinnahBackgroundSecondary)
                        .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    ColorValidationView()
}
