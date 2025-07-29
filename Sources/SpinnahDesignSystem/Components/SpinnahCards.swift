//
//  SpinnahCards.swift v2
//  SpinnahDesignSystem
//
//  Beautiful card components with Liquid Glass materials and Spinnah branding
//  Multiple variants for different content types and elevations
//  Updated for API Standardization - DESIGN-13
//

import SwiftUI

// MARK: - Card Styles
public enum SpinnahCardStyle {
    case elevated       // Floating card with shadow
    case glass          // Liquid Glass material
    case gradient       // Spinnah gradient background
    case outline        // Bordered card
    case compact        // Minimal padding
}

public enum SpinnahCardSize {
    case small, medium, large, custom(CGSize)
    
    var minHeight: CGFloat {
        switch self {
        case .small: return 120
        case .medium: return 200
        case .large: return 300
        case .custom(let size): return size.height
        }
    }
}

// MARK: - Base Card Component
@MainActor
public struct SpinnahCard<Content: View>: View {
    let style: SpinnahCardStyle
    let size: SpinnahCardSize
    let content: () -> Content
    
    public init(
        style: SpinnahCardStyle = .elevated,
        size: SpinnahCardSize = .medium,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.style = style
        self.size = size
        self.content = content
    }
    
    public var body: some View {
        content()
            .frame(minHeight: size.minHeight)
            .padding(cardPadding)
            .background(cardBackground)
            .overlay(cardOverlay)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: cardShadowColor, radius: cardShadowRadius, x: 0, y: cardShadowOffset)
    }
    
    private var cardPadding: EdgeInsets {
        switch (style, size) {
        case (.compact, _): return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        case (_, .small): return EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        default: return EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        }
    }
    
    @ViewBuilder
    private var cardBackground: some View {
        switch style {
        case .elevated:
            Color.spinnahBackgroundPrimary
        case .glass:
            Color.clear.background(.regularMaterial)
        case .gradient:
            LinearGradient(
                colors: [Color.spinnahGradientStart.opacity(0.1), Color.spinnahGradientEnd.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .outline:
            Color.spinnahBackgroundPrimary
        case .compact:
            Color.spinnahBackgroundSecondary
        }
    }
    
    @ViewBuilder
    private var cardOverlay: some View {
        if style == .outline {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.spinnahBorder, lineWidth: 1)
        }
    }
    
    private var cardShadowColor: Color {
        switch style {
        case .elevated: return .black.opacity(0.1)
        case .glass: return .black.opacity(0.05)
        case .gradient: return Color.spinnahPrimary.opacity(0.1)
        default: return .clear
        }
    }
    
    private var cardShadowRadius: CGFloat {
        switch style {
        case .elevated: return 8
        case .glass: return 4
        case .gradient: return 6
        default: return 0
        }
    }
    
    private var cardShadowOffset: CGFloat {
        switch style {
        case .elevated: return 4
        case .glass: return 2
        case .gradient: return 3
        default: return 0
        }
    }
}

// MARK: - Content Cards
@MainActor
public struct SpinnahContentCard: View {
    let title: String
    let subtitle: String?
    let systemImage: String?
    let content: String?
    let style: SpinnahCardStyle
    
    public init(
        title: String,
        subtitle: String? = nil,
        systemImage: String? = nil,
        content: String? = nil,
        style: SpinnahCardStyle = .elevated
    ) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.content = content
        self.style = style
    }
    
    public var body: some View {
        SpinnahCard(style: style) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    if let systemImage = systemImage {
                        Image(systemName: systemImage)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(Color.spinnahPrimary)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.spinnahTextPrimary)
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.spinnahTextSecondary)
                        }
                    }
                    
                    Spacer()
                }
                
                if let content = content {
                    Text(content)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.spinnahTextPrimary)
                        .lineLimit(nil)
                }
            }
        }
    }
}

// MARK: - Action Cards
@MainActor
public struct SpinnahActionCard: View {
    let title: String
    let description: String?
    let systemImage: String
    let action: () -> Void
    let style: SpinnahCardStyle
    
    public init(
        title: String,
        description: String? = nil,
        systemImage: String,
        style: SpinnahCardStyle = .elevated,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
        self.style = style
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            SpinnahCard(style: style, size: .small) {
                VStack(spacing: 8) {
                    Image(systemName: systemImage)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                    
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.spinnahTextPrimary)
                    
                    if let description = description {
                        Text(description)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.spinnahTextSecondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.plain)
        .scaleEffect(1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: false)
    }
}

// MARK: - Stats Cards
@MainActor
public struct SpinnahStatsCard: View {
    let value: String
    let label: String
    let trend: String?
    let isPositive: Bool?
    let style: SpinnahCardStyle
    
    public init(
        value: String,
        label: String,
        trend: String? = nil,
        isPositive: Bool? = nil,
        style: SpinnahCardStyle = .glass
    ) {
        self.value = value
        self.label = label
        self.trend = trend
        self.isPositive = isPositive
        self.style = style
    }
    
    public var body: some View {
        SpinnahCard(style: style, size: .small) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(value)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.spinnahPrimary)
                    
                    Spacer()
                    
                    if let trend = trend, let isPositive = isPositive {
                        HStack(spacing: 4) {
                            Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                                .font(.system(size: 12, weight: .semibold))
                            Text(trend)
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundStyle(isPositive ? .green : .red)
                    }
                }
                
                Text(label)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.spinnahTextSecondary)
            }
        }
    }
}

// MARK: - Media Cards
@MainActor
public struct SpinnahMediaCard: View {
    let title: String
    let artist: String?
    let duration: String?
    let artwork: String? // SF Symbol name for preview
    let isPlaying: Bool
    let onPlayPause: () -> Void
    
    public init(
        title: String,
        artist: String? = nil,
        duration: String? = nil,
        artwork: String? = nil,
        isPlaying: Bool = false,
        onPlayPause: @escaping () -> Void
    ) {
        self.title = title
        self.artist = artist
        self.duration = duration
        self.artwork = artwork
        self.isPlaying = isPlaying
        self.onPlayPause = onPlayPause
    }
    
    public var body: some View {
        SpinnahCard(style: .glass, size: .medium) {
            HStack(spacing: 16) {
                // Artwork placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.spinnahGradientStart.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: artwork ?? "music.note")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.spinnahTextPrimary)
                        .lineLimit(1)
                    
                    if let artist = artist {
                        Text(artist)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.spinnahTextSecondary)
                            .lineLimit(1)
                    }
                    
                    if let duration = duration {
                        Text(duration)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.spinnahTextSecondary.opacity(0.8))
                    }
                }
                
                Spacer()
                
                Button(action: onPlayPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(Color.spinnahPrimary)
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

// MARK: - Card Layout Helpers
@MainActor
public struct SpinnahCardGrid<Content: View>: View {
    let columns: Int
    let spacing: CGFloat
    let content: () -> Content
    
    public init(columns: Int = 2, spacing: CGFloat = 16, @ViewBuilder content: @escaping () -> Content) {
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
            spacing: spacing
        ) {
            content()
        }
    }
}

// MARK: - Preview Provider
#Preview("Spinnah Cards") {
    ScrollView {
        LazyVStack(spacing: 20) {
            // Content Cards
            SpinnahContentCard(
                title: "Welcome to Spinnah",
                subtitle: "Design System v2.0",
                systemImage: "sparkles",
                content: "Beautiful Liquid Glass components with your signature red-orange to golden-yellow gradient.",
                style: .elevated
            )
            
            // Action Cards Grid
            SpinnahCardGrid(columns: 3) {
                SpinnahActionCard(
                    title: "Create",
                    description: "New project",
                    systemImage: "plus.circle.fill",
                    style: .glass
                ) { print("Create") }
                
                SpinnahActionCard(
                    title: "Import",
                    description: "From file",
                    systemImage: "square.and.arrow.down",
                    style: .outline
                ) { print("Import") }
                
                SpinnahActionCard(
                    title: "Settings",
                    description: "Preferences",
                    systemImage: "gearshape.fill",
                    style: .gradient
                ) { print("Settings") }
            }
            
            // Stats Cards
            HStack(spacing: 16) {
                SpinnahStatsCard(
                    value: "1,247",
                    label: "Total Projects",
                    trend: "+12%",
                    isPositive: true
                )
                
                SpinnahStatsCard(
                    value: "98.5%",
                    label: "Success Rate",
                    trend: "-0.3%",
                    isPositive: false
                )
            }
            
            // Media Card
            SpinnahMediaCard(
                title: "Liquid Dreams",
                artist: "Spinnah Studios",
                duration: "3:42",
                artwork: "music.quarternote.3",
                isPlaying: true,
                onPlayPause: { print("Play/Pause") }
            )
        }
        .padding(20)
    }
    .background(Color.spinnahBackgroundPrimary)
}
