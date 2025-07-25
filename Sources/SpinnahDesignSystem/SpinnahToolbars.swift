//
//  SpinnahToolbars.swift
//  SpinnahDesignSystem
//
//  Liquid Glass toolbar components that float above content with proper hierarchy
//  Leverages native SwiftUI components for automatic Liquid Glass materials
//

import SwiftUI

// MARK: - Toolbar Content Extensions
public extension View {
    /// Applies Spinnah-branded Liquid Glass toolbar styling
    /// Uses system components that automatically get Liquid Glass effects
    func spinnahToolbar(
        title: String? = nil,
        showSearch: Bool = false,
        searchBinding: Binding<String>? = nil,
        @ToolbarContentBuilder content: () -> some ToolbarContent
    ) -> some View {
        self
            .toolbar {
                content()
                
                // Auto-add search if requested
                if showSearch, let searchBinding = searchBinding {
                    ToolbarItem(placement: .primaryAction) {
                        SpinnahSearchButton(searchText: searchBinding)
                    }
                }
            }
            .toolbarBackground(.regularMaterial, for: .windowToolbar)
            .toolbarBackground(.visible, for: .windowToolbar)
            .navigationTitle(title ?? "")
    }
    
    /// Applies Spinnah-branded navigation toolbar with ornaments
    /// Perfect for main navigation interfaces
    func spinnahNavigationToolbar(
        title: String,
        showSearch: Bool = true,
        searchBinding: Binding<String>? = nil,
        @ToolbarContentBuilder content: () -> some ToolbarContent
    ) -> some View {
        self
            .toolbar {
                content()
                
                if showSearch, let searchBinding = searchBinding {
                    ToolbarItem(placement: .primaryAction) {
                        SpinnahSearchButton(searchText: searchBinding)
                    }
                }
            }
            .toolbarBackground(.regularMaterial, for: .windowToolbar)
            .toolbarBackground(.visible, for: .windowToolbar)
            .navigationTitle(title)
            .toolbarTitleDisplayMode(.automatic)
    }
}

// MARK: - Spinnah Search Button
/// Expandable search button that starts as circle and expands for entry
/// Uses Liquid Glass materials automatically via system button styles
public struct SpinnahSearchButton: View {
    @Binding private var searchText: String
    @State private var isExpanded = false
    @FocusState private var isSearchFocused: Bool
    
    public init(searchText: Binding<String>) {
        self._searchText = searchText
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            if isExpanded {
                TextField("Search", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .focused($isSearchFocused)
                    .frame(width: 180)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
            }
            
            Button(action: toggleSearch) {
                Image(systemName: isExpanded ? "xmark.circle.fill" : "magnifyingglass")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(isExpanded ? Color.spinnahSecondary : Color.spinnahPrimary)
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .keyboardShortcut("f", modifiers: .command)
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isExpanded)
    }
    
    private func toggleSearch() {
        withAnimation {
            isExpanded.toggle()
            if isExpanded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isSearchFocused = true
                }
            } else {
                searchText = ""
                isSearchFocused = false
            }
        }
    }
}

// MARK: - Spinnah Toolbar Button Styles
/// Primary toolbar button using Spinnah gradient
public struct SpinnahToolbarButtonPrimary: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    
    public init(_ title: String, systemImage: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.spinnahPrimary)
    }
}

/// Secondary toolbar button with subtle styling
public struct SpinnahToolbarButtonSecondary: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    
    public init(_ title: String, systemImage: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
        }
        .buttonStyle(.bordered)
        .tint(Color.spinnahSecondary)
    }
}

/// Icon-only toolbar button for compact layouts
public struct SpinnahToolbarButtonIcon: View {
    let systemImage: String
    let action: () -> Void
    let isDestructive: Bool
    
    public init(systemImage: String, isDestructive: Bool = false, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.isDestructive = isDestructive
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isDestructive ? .red : Color.spinnahPrimary)
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
        .help(systemImage) // Adds tooltip on hover
    }
}

// MARK: - Predefined Toolbar Content
/// Common toolbar configurations for quick implementation
public struct SpinnahToolbarContent {
    
    /// Standard document toolbar with New, Open, Save actions
    @MainActor
    public static func documentToolbar(
        onNew: @escaping () -> Void,
        onOpen: @escaping () -> Void,
        onSave: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigation) {
                SpinnahToolbarButtonIcon(systemImage: "doc.badge.plus", action: onNew)
                SpinnahToolbarButtonIcon(systemImage: "folder", action: onOpen)
            }
            
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButtonIcon(systemImage: "square.and.arrow.down", action: onSave)
            }
        }
    }
    
    /// Media toolbar with play/pause controls
    @MainActor
    public static func mediaToolbar(
        isPlaying: Bool,
        onPlayPause: @escaping () -> Void,
        onNext: @escaping () -> Void,
        onPrevious: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButtonIcon(systemImage: "backward.fill", action: onPrevious)
            }
            
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButtonIcon(
                    systemImage: isPlaying ? "pause.fill" : "play.fill",
                    action: onPlayPause
                )
            }
            
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButtonIcon(systemImage: "forward.fill", action: onNext)
            }
        }
    }
    
    /// Settings toolbar with preferences and help
    @MainActor
    public static func settingsToolbar(
        onPreferences: @escaping () -> Void,
        onHelp: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButtonIcon(systemImage: "questionmark.circle", action: onHelp)
            }
            
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButtonIcon(systemImage: "gearshape", action: onPreferences)
            }
        }
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SpinnahToolbars_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                Text("Content below toolbar")
                    .font(.largeTitle)
                    .foregroundStyle(Color.spinnahTextPrimary)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.spinnahBackgroundPrimary)
            .spinnahNavigationToolbar(title: "Spinnah App", searchBinding: .constant("")) {
                SpinnahToolbarContent.documentToolbar(
                    onNew: { print("New") },
                    onOpen: { print("Open") },
                    onSave: { print("Save") }
                )
            }
        }
        .previewDisplayName("Navigation Toolbar")
        
        NavigationStack {
            VStack {
                Text("Media Player Interface")
                    .font(.title)
                    .foregroundStyle(Color.spinnahTextPrimary)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.spinnahBackgroundSecondary)
            .spinnahToolbar(title: "Now Playing") {
                SpinnahToolbarContent.mediaToolbar(
                    isPlaying: true,
                    onPlayPause: { print("Play/Pause") },
                    onNext: { print("Next") },
                    onPrevious: { print("Previous") }
                )
            }
        }
        .previewDisplayName("Media Toolbar")
    }
}
#endif
