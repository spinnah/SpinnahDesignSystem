//
//  ContentView.swift
//  DesignSystemTestApp
//
//  Created by ShastLeLow on 7/29/25.
//
//  Main navigation view for testing SpinnahDesignSystem components
//

import SwiftUI
import SpinnahDesignSystem

struct ContentView: View {
    @State private var selectedCategory: ComponentCategory = .overview
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationSplitView {
            // Sidebar with component categories
            List(ComponentCategory.allCases, id: \.self, selection: $selectedCategory) { category in
                NavigationLink(value: category) {
                    Label(category.displayName, systemImage: category.iconName)
                }
            }
            .navigationTitle("Design System")
        } detail: {
            // Detail view showing selected component category
            ComponentTestView(category: selectedCategory)
                .navigationTitle(selectedCategory.displayName)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Toggle(isOn: $isDarkMode) {
                            Image(systemName: isDarkMode ? "moon.fill" : "sun.max")
                        }
                        .toggleStyle(.button)
                    }
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

enum ComponentCategory: CaseIterable {
    case overview
    case liquidGlass
    case components
    case gallery
    
    var displayName: String {
        switch self {
        case .overview: return "Overview"
        case .liquidGlass: return "Liquid Glass"
        case .components: return "Components"
        case .gallery: return "Gallery"
        }
    }
    
    var iconName: String {
        switch self {
        case .overview: return "house"
        case .liquidGlass: return "drop.fill"
        case .components: return "square.grid.2x2"
        case .gallery: return "photo.on.rectangle"
        }
    }
}

struct ComponentTestView: View {
    let category: ComponentCategory
    
    var body: some View {
        switch category {
        case .liquidGlass:
            LiquidGlassDemoView()
        case .overview:
            OverviewView()
        case .components:
            ComponentsView()
        case .gallery:
            GalleryView()
        }
    }
}

// MARK: - Category Views

struct OverviewView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("SpinnahDesignSystem TestApp")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Component validation and testing environment")
                .font(.title2)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 10) {
                Label("Test components in real environment", systemImage: "checkmark.circle")
                Label("Support window resizing and dark/light modes", systemImage: "checkmark.circle")
                Label("Component gallery for demos", systemImage: "checkmark.circle")
                Label("Liquid Glass ornament validation", systemImage: "checkmark.circle")
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Overview")
    }
}

struct ComponentsView: View {
    @State private var selectedComponent: String = "Buttons"
    
    let componentTypes = ["Buttons", "Text Fields", "Cards", "Navigation", "Forms"]
    
    var body: some View {
        VStack {
            Text("Component Testing")
                .font(.largeTitle)
                .padding()
            
            Picker("Component Type", selection: $selectedComponent) {
                ForEach(componentTypes, id: \.self) { component in
                    Text(component).tag(component)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(0..<8) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                            .frame(height: 100)
                            .overlay {
                                Text("\(selectedComponent) \(index + 1)")
                                    .font(.caption)
                            }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Components")
    }
}

struct GalleryView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Component Gallery")
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    ForEach(0..<12) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.regularMaterial)
                            .frame(height: 120)
                            .overlay {
                                VStack {
                                    Image(systemName: "sparkles")
                                        .font(.title)
                                        .foregroundColor(.blue)
                                    Text("Demo \(index + 1)")
                                        .font(.caption)
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Gallery")
    }
}

#Preview {
    ContentView()
}
