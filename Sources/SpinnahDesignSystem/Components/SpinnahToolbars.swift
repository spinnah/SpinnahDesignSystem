//
//  SpinnahToolbars.swift v2
//  SpinnahDesignSystem
//
//  Unified toolbar components with consistent API patterns
//  Updated for API Standardization - DESIGN-13
//

import SwiftUI

// MARK: - Toolbar Button Configuration
public enum SpinnahToolbarButtonStyle {
    case primary        // borderedProminent with SpinnahPrimary
    case secondary      // bordered with SpinnahSecondary
    case icon           // compact icon-only version
    case destructive    // red prominent version
}

public enum SpinnahToolbarButtonSize {
    case regular, small
    
    var controlSize: ControlSize {
        switch self {
        case .regular: return .regular
        case .small: return .small
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .regular: return 16
        case .small: return 14
        }
    }
    
    var frameSize: CGFloat {
        switch self {
        case .regular: return 24
        case .small: return 20
        }
    }
}

// MARK: - Unified Toolbar Button Component
@MainActor
public struct SpinnahToolbarButton: View {
    let title: String?
    let systemImage: String?
    let style: SpinnahToolbarButtonStyle
    let size: SpinnahToolbarButtonSize
    let isDestructive: Bool
    let action: () -> Void
    
    // Icon-only initializer
    public init(
        systemImage: String,
        style: SpinnahToolbarButtonStyle = .icon,
        size: SpinnahToolbarButtonSize = .small,
        isDestructive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = nil
        self.systemImage = systemImage
        self.style = style
        self.size = size
        self.isDestructive = isDestructive
        self.action = action
    }
    
    // Text + Icon initializer
    public init(
        _ title: String,
        systemImage: String? = nil,
        style: SpinnahToolbarButtonStyle = .primary,
        size: SpinnahToolbarButtonSize = .regular,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.style = style
        self.size = size
        self.isDestructive = false
        self.action = action
    }
    
    public var body: some View {
        switch style {
        case .primary:
            Button(action: action) {
                buttonContent
            }
            .buttonStyle(.borderedProminent)
            .tint(buttonTint)
            .controlSize(size.controlSize)
            .help(helpText)
            
        case .secondary:
            Button(action: action) {
                buttonContent
            }
            .buttonStyle(.bordered)
            .tint(buttonTint)
            .controlSize(size.controlSize)
            .help(helpText)
            
        case .icon:
            Button(action: action) {
                buttonContent
            }
            .buttonStyle(.bordered)
            .tint(buttonTint)
            .controlSize(size.controlSize)
            .help(helpText)
            
        case .destructive:
            Button(action: action) {
                buttonContent
            }
            .buttonStyle(.borderedProminent)
            .tint(buttonTint)
            .controlSize(size.controlSize)
            .help(helpText)
        }
    }
    
    @ViewBuilder
    private var buttonContent: some View {
        if let title = title, style != .icon {
            // Text + Optional Icon
            HStack(spacing: 6) {
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: size.iconSize, weight: .medium))
                }
                Text(title)
                    .font(.system(size: size.iconSize, weight: .medium))
            }
        } else if let systemImage = systemImage {
            // Icon Only
            Image(systemName: systemImage)
                .font(.system(size: size.iconSize, weight: .medium))
                .foregroundStyle(iconColor)
                .frame(width: size.frameSize, height: size.frameSize)
        }
    }
    
    private var buttonTint: Color {
        if isDestructive {
            return .red
        }
        
        switch style {
        case .primary:
            return Color.spinnahPrimary
        case .secondary:
            return Color.spinnahSecondary
        case .icon:
            return Color.spinnahPrimary
        case .destructive:
            return .red
        }
    }
    
    private var iconColor: Color {
        if isDestructive {
            return .red
        }
        return Color.spinnahPrimary
    }
    
    private var helpText: String {
        if let title = title {
            return title
        } else if let systemImage = systemImage {
            return systemImage.replacingOccurrences(of: ".", with: " ").capitalized
        }
        return ""
    }
}

// MARK: - Simple Search Button
@MainActor
public struct SpinnahSearchButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.spinnahPrimary)
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.bordered)
        .controlSize(.small)
        .keyboardShortcut("f", modifiers: .command)
        .help("Search")
    }
}

// MARK: - Toolbar Extensions
@MainActor
public extension View {
    /// Applies Spinnah-branded toolbar styling
    func spinnahToolbar(
        title: String? = nil,
        showSearch: Bool = false,
        onSearch: (() -> Void)? = nil,
        @ToolbarContentBuilder content: () -> some ToolbarContent
    ) -> some View {
        self
            .toolbar {
                content()
                
                // Simple search button
                if showSearch, let onSearch = onSearch {
                    ToolbarItem(placement: .primaryAction) {
                        SpinnahSearchButton(action: onSearch)
                    }
                }
            }
            .toolbarBackground(.regularMaterial, for: .windowToolbar)
            .toolbarBackground(.visible, for: .windowToolbar)
            .navigationTitle(title ?? "")
    }
    
    /// Navigation toolbar variant
    func spinnahNavigationToolbar(
        title: String,
        showSearch: Bool = true,
        onSearch: (() -> Void)? = nil,
        @ToolbarContentBuilder content: () -> some ToolbarContent
    ) -> some View {
        self
            .toolbar {
                content()
                
                if showSearch, let onSearch = onSearch {
                    ToolbarItem(placement: .primaryAction) {
                        SpinnahSearchButton(action: onSearch)
                    }
                }
            }
            .toolbarBackground(.regularMaterial, for: .windowToolbar)
            .toolbarBackground(.visible, for: .windowToolbar)
            .navigationTitle(title)
            .toolbarTitleDisplayMode(.automatic)
    }
}

// MARK: - Convenience Extensions
@MainActor
public extension SpinnahToolbarButton {
    /// Primary toolbar button
    static func primary(
        _ title: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) -> SpinnahToolbarButton {
        SpinnahToolbarButton(title, systemImage: systemImage, style: .primary, action: action)
    }
    
    /// Secondary toolbar button
    static func secondary(
        _ title: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) -> SpinnahToolbarButton {
        SpinnahToolbarButton(title, systemImage: systemImage, style: .secondary, action: action)
    }
    
    /// Icon-only toolbar button
    static func icon(
        _ systemImage: String,
        size: SpinnahToolbarButtonSize = .small,
        isDestructive: Bool = false,
        action: @escaping () -> Void
    ) -> SpinnahToolbarButton {
        SpinnahToolbarButton(
            systemImage: systemImage,
            style: .icon,
            size: size,
            isDestructive: isDestructive,
            action: action
        )
    }
    
    /// Destructive toolbar button
    static func destructive(
        _ title: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) -> SpinnahToolbarButton {
        SpinnahToolbarButton(title, systemImage: systemImage, style: .destructive, action: action)
    }
}

// MARK: - Predefined Toolbar Content
@MainActor
public struct SpinnahToolbarContent {
    
    /// Standard document toolbar with New, Open, Save actions
    public static func documentToolbar(
        onNew: @escaping () -> Void,
        onOpen: @escaping () -> Void,
        onSave: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigation) {
                SpinnahToolbarButton.icon("doc.badge.plus", action: onNew)
                SpinnahToolbarButton.icon("folder", action: onOpen)
            }
            
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButton.icon("square.and.arrow.down", action: onSave)
            }
        }
    }
    
    /// Media toolbar with play/pause controls
    public static func mediaToolbar(
        isPlaying: Bool,
        onPlayPause: @escaping () -> Void,
        onNext: @escaping () -> Void,
        onPrevious: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButton.icon("backward.fill", action: onPrevious)
            }
            
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButton.icon(
                    isPlaying ? "pause.fill" : "play.fill",
                    action: onPlayPause
                )
            }
            
            ToolbarItem(placement: .navigation) {
                SpinnahToolbarButton.icon("forward.fill", action: onNext)
            }
        }
    }
    
    /// Settings toolbar with preferences and help
    public static func settingsToolbar(
        onPreferences: @escaping () -> Void,
        onHelp: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButton.icon("questionmark.circle", action: onHelp)
            }
            
            ToolbarItem(placement: .primaryAction) {
                SpinnahToolbarButton.icon("gearshape", action: onPreferences)
            }
        }
    }
    
    /// Editing toolbar with common text actions
    public static func editingToolbar(
        onBold: @escaping () -> Void,
        onItalic: @escaping () -> Void,
        onUnderline: @escaping () -> Void
    ) -> some ToolbarContent {
        Group {
            ToolbarItemGroup(placement: .navigation) {
                SpinnahToolbarButton.icon("bold", action: onBold)
                SpinnahToolbarButton.icon("italic", action: onItalic)
                SpinnahToolbarButton.icon("underline", action: onUnderline)
            }
        }
    }
}

// MARK: - Preview Provider
#Preview("Toolbar Buttons") {
    NavigationStack {
        VStack(spacing: 40) {
            Text("Unified Toolbar Testing")
                .font(.largeTitle)
                .foregroundStyle(Color.spinnahTextPrimary)
            
            VStack(spacing: 20) {
                Text("Individual Button Styles")
                    .font(.headline)
                
                HStack(spacing: 12) {
                    SpinnahToolbarButton.primary("Save", systemImage: "square.and.arrow.down") {
                        print("Primary toolbar button")
                    }
                    
                    SpinnahToolbarButton.secondary("Export", systemImage: "square.and.arrow.up") {
                        print("Secondary toolbar button")
                    }
                    
                    SpinnahToolbarButton.icon("gearshape") {
                        print("Icon button")
                    }
                    
                    SpinnahToolbarButton.icon("trash", isDestructive: true) {
                        print("Destructive icon")
                    }
                }
                
                HStack(spacing: 12) {
                    SpinnahSearchButton {
                        print("Search triggered")
                    }
                    
                    SpinnahToolbarButton.destructive("Delete", systemImage: "trash") {
                        print("Destructive button")
                    }
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.spinnahBackgroundPrimary)
        .spinnahNavigationToolbar(title: "Toolbar Testing", onSearch: { print("Search") }) {
            SpinnahToolbarContent.documentToolbar(
                onNew: { print("New") },
                onOpen: { print("Open") },
                onSave: { print("Save") }
            )
        }
    }
}
