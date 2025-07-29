//
//  SpinnahNavigationOrnaments.swift
//  SpinnahDesignSystem
//
//  Floating Liquid Glass navigation ornaments inspired by Apple Music macOS
//  True liquid glass implementation without solid background bars
//

import SwiftUI

// MARK: - Ornament Configuration
public enum SpinnahOrnamentStyle {
    case floating       // True liquid glass floating
    case subtle         // More transparent
    case prominent      // Slightly more opaque
}

public enum SpinnahOrnamentPosition {
    case top, bottom
    case topCenter, bottomCenter
    case custom(EdgeInsets)
    
    var alignment: Alignment {
        switch self {
        case .top, .topCenter: return .top
        case .bottom, .bottomCenter: return .bottom
        case .custom: return .bottom
        }
    }
    
    var edgePadding: EdgeInsets {
        switch self {
        case .top, .topCenter: return EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        case .bottom, .bottomCenter: return EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        case .custom: return EdgeInsets()
        }
    }
}

// MARK: - Main Ornament View Modifier
public extension View {
    /// Adds a floating liquid glass navigation ornament
    /// Mimics Apple Music's native macOS liquid glass implementation
    @MainActor
    func spinnahNavigationOrnament<Content: View>(
        position: SpinnahOrnamentPosition = .bottomCenter,
        style: SpinnahOrnamentStyle = .floating,
        isVisible: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.overlay(alignment: position.alignment) {
            if isVisible {
                SpinnahOrnamentContainer(style: style, position: position) {
                    content()
                }
                .transition(.asymmetric(
                    insertion: .scale(scale: 0.9).combined(with: .opacity),
                    removal: .scale(scale: 0.9).combined(with: .opacity)
                ))
                .padding(position.edgePadding)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isVisible)
    }
    
    /// Quick implementation for comic reader ornament
    @MainActor
    func spinnahComicReaderOrnament(
        isVisible: Bool = true,
        coverThumbnail: String? = nil,
        currentPage: Int = 1,
        totalPages: Int = 1,
        onStartOfIssue: @escaping () -> Void,
        onPreviousPage: @escaping () -> Void,
        onNextPage: @escaping () -> Void,
        onEndOfIssue: @escaping () -> Void
    ) -> some View {
        self.spinnahNavigationOrnament(isVisible: isVisible) {
            SpinnahComicReaderOrnament(
                coverThumbnail: coverThumbnail,
                currentPage: currentPage,
                totalPages: totalPages,
                onStartOfIssue: onStartOfIssue,
                onPreviousPage: onPreviousPage,
                onNextPage: onNextPage,
                onEndOfIssue: onEndOfIssue
            )
        }
    }
    
    /// Top navigation with title and action buttons
    @MainActor
    func spinnahTopNavigationOrnament(
        title: String,
        isVisible: Bool = true,
        showBack: Bool = false,
        showSearch: Bool = false,
        onBack: (() -> Void)? = nil,
        onSearch: (() -> Void)? = nil,
        customActions: (() -> [SpinnahTopNavigationAction])? = nil
    ) -> some View {
        self.spinnahNavigationOrnament(position: .topCenter, isVisible: isVisible) {
            SpinnahActionBarOrnament(
                title: title,
                showBack: showBack,
                showSearch: showSearch,
                onBack: onBack,
                onSearch: onSearch,
                customActions: customActions?() ?? []
            )
        }
    }
    
    /// Breadcrumb navigation ornament
    @MainActor
    func spinnahBreadcrumbOrnament(
        breadcrumbs: [SpinnahBreadcrumb],
        isVisible: Bool = true,
        onNavigate: @escaping (String) -> Void
    ) -> some View {
        self.spinnahNavigationOrnament(position: .topCenter, isVisible: isVisible) {
            SpinnahBreadcrumbOrnament(
                breadcrumbs: breadcrumbs,
                onNavigate: onNavigate
            )
        }
    }
}

// MARK: - Ornament Container
/// The liquid glass container that holds ornament content
@MainActor
private struct SpinnahOrnamentContainer<Content: View>: View {
    let style: SpinnahOrnamentStyle
    let position: SpinnahOrnamentPosition
    let content: () -> Content
    
    var body: some View {
        content()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(backgroundMaterial, in: RoundedRectangle(cornerRadius: 50))
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowOffset)
    }
    
    private var backgroundMaterial: Material {
        switch style {
        case .floating:
            return .regularMaterial
        case .subtle:
            return .thinMaterial
        case .prominent:
            return .thickMaterial
        }
    }
    
    private var shadowColor: Color {
        switch style {
        case .floating: return .black.opacity(0.1)
        case .subtle: return .black.opacity(0.05)
        case .prominent: return .black.opacity(0.15)
        }
    }
    
    private var shadowRadius: CGFloat {
        switch style {
        case .floating: return 12
        case .subtle: return 6
        case .prominent: return 16
        }
    }
    
    private var shadowOffset: CGFloat {
        switch position {
        case .top, .topCenter: return -3
        case .bottom, .bottomCenter: return 3
        case .custom: return 0
        }
    }
}

// MARK: - Top Navigation Data Structures
public struct SpinnahTopNavigationAction {
    public let id: String
    public let systemImage: String
    public let action: () -> Void
    
    public init(id: String, systemImage: String, action: @escaping () -> Void) {
        self.id = id
        self.systemImage = systemImage
        self.action = action
    }
}

public struct SpinnahBreadcrumb {
    public let id: String
    public let title: String
    public let isActive: Bool
    
    public init(id: String, title: String, isActive: Bool = false) {
        self.id = id
        self.title = title
        self.isActive = isActive
    }
}

// MARK: - Action Bar Ornament
@MainActor
public struct SpinnahActionBarOrnament: View {
    let title: String
    let showBack: Bool
    let showSearch: Bool
    let onBack: (() -> Void)?
    let onSearch: (() -> Void)?
    let customActions: [SpinnahTopNavigationAction]
    
    public init(
        title: String,
        showBack: Bool = false,
        showSearch: Bool = false,
        onBack: (() -> Void)? = nil,
        onSearch: (() -> Void)? = nil,
        customActions: [SpinnahTopNavigationAction] = []
    ) {
        self.title = title
        self.showBack = showBack
        self.showSearch = showSearch
        self.onBack = onBack
        self.onSearch = onSearch
        self.customActions = customActions
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Left Actions
            HStack(spacing: 8) {
                if showBack, let onBack = onBack {
                    SpinnahOrnamentButton(
                        systemImage: "chevron.left",
                        action: onBack
                    )
                    .help("Back")
                }
                
                // Custom left actions
                ForEach(customActions.prefix(2), id: \.id) { action in
                    SpinnahOrnamentButton(
                        systemImage: action.systemImage,
                        action: action.action
                    )
                }
            }
            
            // Center Title
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.spinnahTextPrimary)
                .lineLimit(1)
                .frame(minWidth: 120)
            
            // Right Actions
            HStack(spacing: 8) {
                if showSearch, let onSearch = onSearch {
                    SpinnahOrnamentButton(
                        systemImage: "magnifyingglass",
                        action: onSearch
                    )
                    .help("Search")
                }
                
                // Additional custom actions
                ForEach(customActions.dropFirst(2), id: \.id) { action in
                    SpinnahOrnamentButton(
                        systemImage: action.systemImage,
                        action: action.action
                    )
                }
            }
        }
    }
}

// MARK: - Breadcrumb Ornament
@MainActor
public struct SpinnahBreadcrumbOrnament: View {
    let breadcrumbs: [SpinnahBreadcrumb]
    let onNavigate: (String) -> Void
    
    public init(
        breadcrumbs: [SpinnahBreadcrumb],
        onNavigate: @escaping (String) -> Void
    ) {
        self.breadcrumbs = breadcrumbs
        self.onNavigate = onNavigate
    }
    
    public var body: some View {
        HStack(spacing: 6) {
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

// MARK: - Comic Reader Ornament
@MainActor
public struct SpinnahComicReaderOrnament: View {
    let coverThumbnail: String?
    let currentPage: Int
    let totalPages: Int
    let onStartOfIssue: () -> Void
    let onPreviousPage: () -> Void
    let onNextPage: () -> Void
    let onEndOfIssue: () -> Void
    
    public init(
        coverThumbnail: String? = nil,
        currentPage: Int = 1,
        totalPages: Int = 1,
        onStartOfIssue: @escaping () -> Void,
        onPreviousPage: @escaping () -> Void,
        onNextPage: @escaping () -> Void,
        onEndOfIssue: @escaping () -> Void
    ) {
        self.coverThumbnail = coverThumbnail
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.onStartOfIssue = onStartOfIssue
        self.onPreviousPage = onPreviousPage
        self.onNextPage = onNextPage
        self.onEndOfIssue = onEndOfIssue
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Left Controls
            HStack(spacing: 8) {
                SpinnahOrnamentButton(
                    systemImage: "backward.end.fill",
                    action: onStartOfIssue
                )
                .help("Start of Issue")
                
                SpinnahOrnamentButton(
                    systemImage: "chevron.left",
                    action: onPreviousPage,
                    isDisabled: currentPage <= 1
                )
                .help("Previous Page")
            }
            
            // Center - Issue Cover & Info
            HStack(spacing: 12) {
                // Cover Thumbnail
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.spinnahGradientStart.opacity(0.3))
                        .frame(width: 36, height: 48)
                    
                    if let coverThumbnail = coverThumbnail {
                        // In real implementation, this would be AsyncImage
                        Image(systemName: coverThumbnail)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.spinnahPrimary)
                    } else {
                        Image(systemName: "book.closed")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.spinnahPrimary)
                    }
                }
                
                // Page Info
                VStack(alignment: .leading, spacing: 2) {
                    Text("Page \(currentPage) of \(totalPages)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.spinnahTextPrimary)
                    
                    Text("Issue #1")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.spinnahTextSecondary)
                }
            }
            .frame(minWidth: 120)
            
            // Right Controls
            HStack(spacing: 8) {
                SpinnahOrnamentButton(
                    systemImage: "chevron.right",
                    action: onNextPage,
                    isDisabled: currentPage >= totalPages
                )
                .help("Next Page")
                
                SpinnahOrnamentButton(
                    systemImage: "forward.end.fill",
                    action: onEndOfIssue
                )
                .help("End of Issue")
            }
        }
    }
}

// MARK: - Ornament Button Component
@MainActor
public struct SpinnahOrnamentButton: View {
    let systemImage: String
    let action: () -> Void
    let isDisabled: Bool
    
    public init(systemImage: String, action: @escaping () -> Void, isDisabled: Bool = false) {
        self.systemImage = systemImage
        self.action = action
        self.isDisabled = isDisabled
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(buttonColor)
                .frame(width: 28, height: 28)
        }
        .buttonStyle(.borderless)
        .disabled(isDisabled)
        .scaleEffect(isDisabled ? 0.9 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isDisabled)
    }
    
    private var buttonColor: Color {
        if isDisabled {
            return Color.spinnahTextSecondary.opacity(0.4)
        } else {
            return Color.spinnahPrimary
        }
    }
}

// MARK: - Media Controls Ornament (Future Use)
@MainActor
public struct SpinnahMediaControlsOrnament: View {
    @Binding var isPlaying: Bool
    let currentTrack: String?
    let currentArtist: String?
    let onPlayPause: () -> Void
    let onNext: () -> Void
    let onPrevious: () -> Void
    
    public init(
        isPlaying: Binding<Bool>,
        currentTrack: String? = nil,
        currentArtist: String? = nil,
        onPlayPause: @escaping () -> Void,
        onNext: @escaping () -> Void,
        onPrevious: @escaping () -> Void
    ) {
        self._isPlaying = isPlaying
        self.currentTrack = currentTrack
        self.currentArtist = currentArtist
        self.onPlayPause = onPlayPause
        self.onNext = onNext
        self.onPrevious = onPrevious
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            // Left Controls
            HStack(spacing: 8) {
                SpinnahOrnamentButton(systemImage: "backward.fill", action: onPrevious)
                SpinnahOrnamentButton(
                    systemImage: isPlaying ? "pause.fill" : "play.fill",
                    action: onPlayPause
                )
                SpinnahOrnamentButton(systemImage: "forward.fill", action: onNext)
            }
            
            // Center - Track Info
            if let currentTrack = currentTrack {
                HStack(spacing: 12) {
                    // Album Art Placeholder
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.spinnahGradientStart.opacity(0.3))
                        .frame(width: 36, height: 36)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(currentTrack)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.spinnahTextPrimary)
                            .lineLimit(1)
                        
                        if let currentArtist = currentArtist {
                            Text(currentArtist)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.spinnahTextSecondary)
                                .lineLimit(1)
                        }
                    }
                }
                .frame(minWidth: 120)
            }
            
            // Right Controls (Volume, etc. - placeholder for future)
            HStack(spacing: 8) {
                SpinnahOrnamentButton(systemImage: "speaker.2", action: {})
            }
        }
    }
}

// MARK: - Preview Provider
#if DEBUG
struct SpinnahNavigationOrnaments_Previews: PreviewProvider {
    static var previews: some View {
        // Top Navigation Action Bar Preview
        VStack {
            Spacer()
            
            Text("Main Content Area")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Text("Content flows here with top navigation floating above")
                .font(.body)
                .foregroundStyle(Color.spinnahTextSecondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [Color.spinnahGradientStart, .purple, .blue, Color.spinnahGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .spinnahTopNavigationOrnament(
            title: "Comic Library",
            showBack: true,
            showSearch: true,
            onBack: { print("Navigate Back") },
            onSearch: { print("Open Search") },
            customActions: {
                [
                    SpinnahTopNavigationAction(id: "settings", systemImage: "gearshape") {
                        print("Settings")
                    }
                ]
            }
        )
        .previewDisplayName("Top Action Bar Ornament")
        
        // Breadcrumb Navigation Preview
        VStack {
            Spacer()
            
            Text("Page Content")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Text("Breadcrumb navigation floating above")
                .font(.body)
                .foregroundStyle(Color.spinnahTextSecondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RadialGradient(
                colors: [.orange, .pink, .purple, .blue],
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
        )
        .spinnahBreadcrumbOrnament(
            breadcrumbs: [
                SpinnahBreadcrumb(id: "home", title: "Library"),
                SpinnahBreadcrumb(id: "comics", title: "Comics"),
                SpinnahBreadcrumb(id: "marvel", title: "Marvel"),
                SpinnahBreadcrumb(id: "current", title: "Spider-Man #1", isActive: true)
            ],
            onNavigate: { id in print("Navigate to: \(id)") }
        )
        .previewDisplayName("Breadcrumb Ornament")
        
        // Comic Reader Preview
        VStack {
            Spacer()
            
            Text("Comic Reader Content")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Text("Your comic pages display here")
                .font(.body)
                .foregroundStyle(Color.spinnahTextSecondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            // Wild gradient for testing liquid glass effect
            LinearGradient(
                colors: [
                    .red, .orange, .yellow, .green, .blue, .purple, .pink,
                    Color.spinnahGradientStart, Color.spinnahGradientEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .spinnahComicReaderOrnament(
            coverThumbnail: "book.closed",
            currentPage: 3,
            totalPages: 24,
            onStartOfIssue: { print("Start of Issue") },
            onPreviousPage: { print("Previous Page") },
            onNextPage: { print("Next Page") },
            onEndOfIssue: { print("End of Issue") }
        )
        .previewDisplayName("Comic Reader Ornament")
        
        // Combined Top and Bottom Ornaments
        VStack {
            Spacer()
            
            Text("Full Navigation Demo")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Text("Both top breadcrumbs and bottom controls")
                .font(.body)
                .foregroundStyle(Color.spinnahTextSecondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [.cyan, .blue, .indigo, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .spinnahBreadcrumbOrnament(
            breadcrumbs: [
                SpinnahBreadcrumb(id: "library", title: "Library"),
                SpinnahBreadcrumb(id: "comics", title: "Comics"),
                SpinnahBreadcrumb(id: "current", title: "Issue #1", isActive: true)
            ],
            onNavigate: { id in print("Navigate to: \(id)") }
        )
        .spinnahComicReaderOrnament(
            coverThumbnail: "book.closed",
            currentPage: 5,
            totalPages: 32,
            onStartOfIssue: { print("Start") },
            onPreviousPage: { print("Previous") },
            onNextPage: { print("Next") },
            onEndOfIssue: { print("End") }
        )
        .previewDisplayName("Combined Navigation")
        
        // Media Controls Preview
        VStack {
            Spacer()
            
            Text("Media Player Content")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            // Different gradient for comparison
            RadialGradient(
                colors: [Color.spinnahGradientStart, .purple, .blue, Color.spinnahGradientEnd],
                center: .center,
                startRadius: 50,
                endRadius: 400
            )
        )
        .spinnahNavigationOrnament(position: .bottomCenter) {
            SpinnahMediaControlsOrnament(
                isPlaying: .constant(true),
                currentTrack: "Spinnah Theme Song",
                currentArtist: "Design System",
                onPlayPause: { print("Play/Pause") },
                onNext: { print("Next") },
                onPrevious: { print("Previous") }
            )
        }
        .previewDisplayName("Media Controls Ornament")
    }
}
#endif
