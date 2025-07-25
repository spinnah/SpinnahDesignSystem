//
//  SpinnahNavigationOrnaments.swift
//  SpinnahDesignSystem
//
//  Navigation components that use ornament-like floating behavior
//  Inspired by visionOS ornaments but designed for macOS with Liquid Glass
//

import SwiftUI

// MARK: - Navigation Ornament Types
public enum SpinnahOrnamentEdge {
    case top, bottom, leading, trailing
    case topLeading, topTrailing, bottomLeading, bottomTrailing
}

public enum SpinnahOrnamentAlignment {
    case center, leading, trailing
}

// MARK: - Main Navigation Ornament View Modifier
public extension View {
    /// Adds a floating navigation ornament to any edge of the view
    /// Mimics visionOS ornament behavior with Liquid Glass materials
    func spinnahNavigationOrnament<Content: View>(
        edge: SpinnahOrnamentEdge = .top,
        alignment: SpinnahOrnamentAlignment = .center,
        offset: CGSize = .zero,
        isVisible: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.overlay(alignment: ornamentOverlayAlignment(edge: edge, alignment: alignment)) {
            if isVisible {
                SpinnahOrnamentContainer(edge: edge, offset: offset) {
                    content()
                }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.8).combined(with: .opacity),
                    removal: .scale(scale: 0.8).combined(with: .opacity)
                ))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isVisible)
    }
    
    /// Quick implementation for common tab-style navigation ornament
    func spinnahTabOrnament(
        selectedTab: Binding<Int>,
        tabs: [SpinnahNavigationTab],
        edge: SpinnahOrnamentEdge = .bottom
    ) -> some View {
        self.spinnahNavigationOrnament(edge: edge) {
            SpinnahTabNavigationOrnament(selectedTab: selectedTab, tabs: tabs)
        }
    }
    
    /// Quick implementation for breadcrumb navigation ornament
    func spinnahBreadcrumbOrnament(
        breadcrumbs: [SpinnahBreadcrumb],
        onNavigate: @escaping (Int) -> Void,
        edge: SpinnahOrnamentEdge = .top
    ) -> some View {
        self.spinnahNavigationOrnament(edge: edge, alignment: .leading) {
            SpinnahBreadcrumbOrnament(breadcrumbs: breadcrumbs, onNavigate: onNavigate)
        }
    }
}

// MARK: - Ornament Container
/// The glass container that holds ornament content
private struct SpinnahOrnamentContainer<Content: View>: View {
    let edge: SpinnahOrnamentEdge
    let offset: CGSize
    let content: () -> Content
    
    var body: some View {
        content()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 2)
            .offset(offset)
            .offset(edgeOffset)
    }
    
    /// Provides proper spacing from window edges
    private var edgeOffset: CGSize {
        switch edge {
        case .top: return CGSize(width: 0, height: -20)
        case .bottom: return CGSize(width: 0, height: 20)
        case .leading: return CGSize(width: -20, height: 0)
        case .trailing: return CGSize(width: 20, height: 0)
        case .topLeading: return CGSize(width: -20, height: -20)
        case .topTrailing: return CGSize(width: 20, height: -20)
        case .bottomLeading: return CGSize(width: -20, height: 20)
        case .bottomTrailing: return CGSize(width: 20, height: 20)
        }
    }
}

// MARK: - Tab Navigation Ornament
public struct SpinnahNavigationTab {
    public let id: Int
    public let title: String
    public let systemImage: String
    
    public init(id: Int, title: String, systemImage: String) {
        self.id = id
        self.title = title
        self.systemImage = systemImage
    }
}

public struct SpinnahTabNavigationOrnament: View {
    @Binding var selectedTab: Int
    let tabs: [SpinnahNavigationTab]
    
    public init(selectedTab: Binding<Int>, tabs: [SpinnahNavigationTab]) {
        self._selectedTab = selectedTab
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(tabs, id: \.id) { tab in
                Button(action: { selectedTab = tab.id }) {
                    HStack(spacing: 6) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 14, weight: .medium))
                        
                        if selectedTab == tab.id {
                            Text(tab.title)
                                .font(.system(size: 13, weight: .medium))
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing).combined(with: .opacity),
                                    removal: .move(edge: .trailing).combined(with: .opacity)
                                ))
                        }
                    }
                    .foregroundStyle(selectedTab == tab.id ? Color.spinnahPrimary : Color.spinnahTextSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        selectedTab == tab.id ?
                        Color.spinnahPrimary.opacity(0.1) :
                        Color.clear,
                        in: RoundedRectangle(cornerRadius: 8)
                    )
                }
                .buttonStyle(.borderless)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedTab)
            }
        }
    }
}

// MARK: - Breadcrumb Navigation Ornament
public struct SpinnahBreadcrumb {
    public let id: Int
    public let title: String
    public let isActive: Bool
    
    public init(id: Int, title: String, isActive: Bool = false) {
        self.id = id
        self.title = title
        self.isActive = isActive
    }
}

public struct SpinnahBreadcrumbOrnament: View {
    let breadcrumbs: [SpinnahBreadcrumb]
    let onNavigate: (Int) -> Void
    
    public init(breadcrumbs: [SpinnahBreadcrumb], onNavigate: @escaping (Int) -> Void) {
        self.breadcrumbs = breadcrumbs
        self.onNavigate = onNavigate
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(breadcrumbs.enumerated()), id: \.element.id) { index, breadcrumb in
                Group {
                    Button(action: { onNavigate(breadcrumb.id) }) {
                        Text(breadcrumb.title)
                            .font(.system(size: 13, weight: breadcrumb.isActive ? .semibold : .regular))
                            .foregroundStyle(breadcrumb.isActive ? Color.spinnahPrimary : Color.spinnahTextSecondary)
                    }
                    .buttonStyle(.borderless)
                    .disabled(breadcrumb.isActive)
                    
                    if index < breadcrumbs.count - 1 {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(Color.spinnahTextSecondary.opacity(0.6))
                    }
                }
            }
        }
    }
}

// MARK: - Media Controls Ornament
public struct SpinnahMediaControlsOrnament: View {
    @Binding var isPlaying: Bool
    let onPlayPause: () -> Void
    let onNext: () -> Void
    let onPrevious: () -> Void
    let currentTrack: String?
    
    public init(
        isPlaying: Binding<Bool>,
        onPlayPause: @escaping () -> Void,
        onNext: @escaping () -> Void,
        onPrevious: @escaping () -> Void,
        currentTrack: String? = nil
    ) {
        self._isPlaying = isPlaying
        self.onPlayPause = onPlayPause
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.currentTrack = currentTrack
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            if let currentTrack = currentTrack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Now Playing")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.spinnahTextSecondary)
                    Text(currentTrack)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.spinnahTextPrimary)
                        .lineLimit(1)
                }
                .frame(maxWidth: 120)
                
                Divider()
                    .frame(height: 20)
            }
            
            HStack(spacing: 8) {
                Button(action: onPrevious) {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                }
                .buttonStyle(.borderless)
                
                Button(action: onPlayPause) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                }
                .buttonStyle(.borderless)
                
                Button(action: onNext) {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

// MARK: - Helper Functions
private func ornamentOverlayAlignment(edge: SpinnahOrnamentEdge, alignment: SpinnahOrnamentAlignment) -> Alignment {
    switch (edge, alignment) {
    case (.top, .center): return .top
    case (.top, .leading): return .topLeading
    case (.top, .trailing): return .topTrailing
    case (.bottom, .center): return .bottom
    case (.bottom, .leading): return .bottomLeading
    case (.bottom, .trailing): return .bottomTrailing
    case (.leading, _): return .leading
    case (.trailing, _): return .trailing
    case (.topLeading, _): return .topLeading
    case (.topTrailing, _): return .topTrailing
    case (.bottomLeading, _): return .bottomLeading
    case (.bottomTrailing, _): return .bottomTrailing
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SpinnahNavigationOrnaments_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Beautiful Content")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Spacer()
            
            Text("Your app content flows here")
                .font(.body)
                .foregroundStyle(Color.spinnahTextSecondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.spinnahBackgroundPrimary)
        .spinnahTabOrnament(
            selectedTab: .constant(1),
            tabs: [
                SpinnahNavigationTab(id: 0, title: "Home", systemImage: "house"),
                SpinnahNavigationTab(id: 1, title: "Library", systemImage: "books.vertical"),
                SpinnahNavigationTab(id: 2, title: "Settings", systemImage: "gearshape")
            ]
        )
        .spinnahBreadcrumbOrnament(
            breadcrumbs: [
                SpinnahBreadcrumb(id: 0, title: "Home"),
                SpinnahBreadcrumb(id: 1, title: "Projects"),
                SpinnahBreadcrumb(id: 2, title: "Current Project", isActive: true)
            ],
            onNavigate: { _ in print("Navigate") }
        )
        .spinnahNavigationOrnament(edge: .bottom, alignment: .center, offset: CGSize(width: 0, height: -40)) {
            SpinnahMediaControlsOrnament(
                isPlaying: .constant(true),
                onPlayPause: { print("Play/Pause") },
                onNext: { print("Next") },
                onPrevious: { print("Previous") },
                currentTrack: "Spinnah Theme"
            )
        }
        .previewDisplayName("Navigation Ornaments")
    }
}
#endif
