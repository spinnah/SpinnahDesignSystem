//
//  OrnamentValidationView.swift
//  DesignSystemTestApp
//
//  Created by ShastLeLow on 7/29/25.
//
//  Validation view for testing Liquid Glass ornament components
//

import SwiftUI
import SpinnahDesignSystem

struct OrnamentValidationView: View {
    @State private var showingDarkMode = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Liquid Glass Ornament Testing")
                    .font(.largeTitle)
                    .padding()
                
                // Test different ornament sizes and styles
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    
                    // Test ornaments will go here
                    ForEach(0..<6) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                            .frame(height: 120)
                            .overlay {
                                Text("Ornament \(index + 1)")
                                    .font(.caption)
                            }
                    }
                }
                .padding()
                
                // Dark/Light mode toggle
                Toggle("Dark Mode Testing", isOn: $showingDarkMode)
                    .padding()
            }
        }
        .preferredColorScheme(showingDarkMode ? .dark : .light)
        .navigationTitle("Liquid Glass Validation")
    }
}

#Preview {
    OrnamentValidationView()
}
