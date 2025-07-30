//
//  LiquidGlassDemoView.swift
//  DesignSystemTestApp
//
//  Demo playground for SpinnahDesignSystem's Liquid Glass and ornament components on macOS
//

import SwiftUI
import SpinnahDesignSystem

struct LiquidGlassDemoView: View {
    @State private var showTopOrnament = true
    @State private var showBreadcrumb = false
    @State private var showComicReader = false
    @State private var showBottomMedia = false
    @State private var ornamentStyle: SpinnahOrnamentStyle = .floating
    
    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                // Title
                Text("Liquid Glass & Navigation Ornaments")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                // Controls
                GroupBox(label: Label("Live Controls", systemImage: "slider.horizontal.3")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Picker("Ornament Style", selection: $ornamentStyle) {
                            Text("Floating").tag(SpinnahOrnamentStyle.floating)
                            Text("Subtle").tag(SpinnahOrnamentStyle.subtle)
                            Text("Prominent").tag(SpinnahOrnamentStyle.prominent)
                        }
                        .pickerStyle(.segmented)

                        Toggle("Show Top Action Bar", isOn: $showTopOrnament)
                        Toggle("Show Breadcrumb", isOn: $showBreadcrumb)
                        Toggle("Show Comic Reader", isOn: $showComicReader)
                        Toggle("Show Bottom Media Controls", isOn: $showBottomMedia)
                    }
                    .padding(.vertical, 4)
                }
                .padding(.horizontal)

                // Demo Content
                VStack(alignment: .leading, spacing: 24) {
                    Text("Resize the window and toggle ornaments to see true macOS liquid glass effects.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)

                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [Color.spinnahGradientStart, .purple, .blue, Color.spinnahGradientEnd],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                        )
                        .frame(height: 260)
                        .overlay(
                            Text("Background gradient area\n(Ornaments float above)")
                                .font(.title2)
                                .foregroundStyle(.white.opacity(0.85))
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: 740)
            .padding(.bottom, 80)
        }
        .background(Color.spinnahBackgroundPrimary)
        // Ornaments overlays
        
        .spinnahNavigationOrnament(
            position: .topCenter,
            style: ornamentStyle,
            isVisible: showTopOrnament
        ) {
            SpinnahActionBarOrnament(
                title: "Top Action Bar",
                customActions: [
                    SpinnahTopNavigationAction(id: "settings", systemImage: "gearshape") { print("Settings") }
                ]
            )
        }
        .spinnahNavigationOrnament(
            position: .topCenter,
            style: ornamentStyle,
            isVisible: showBreadcrumb
        ) {
            SpinnahBreadcrumbOrnament(
                breadcrumbs: [
                    SpinnahBreadcrumb(id: "home", title: "Home"),
                    SpinnahBreadcrumb(id: "demos", title: "Demos"),
                    SpinnahBreadcrumb(id: "liquid", title: "Liquid Glass", isActive: true)
                ],
                onNavigate: { id in print("Navigate to: \(id)") }
            )
        }
        .spinnahNavigationOrnament(
            position: .bottomCenter,
            style: ornamentStyle,
            isVisible: showComicReader
        ) {
            SpinnahComicReaderOrnament(
                coverThumbnail: "book.closed",
                currentPage: 5,
                totalPages: 32,
                onStartOfIssue: { print("Start") },
                onPreviousPage: { print("Previous") },
                onNextPage: { print("Next") },
                onEndOfIssue: { print("End") }
            )
        }
        .spinnahNavigationOrnament(
            position: .bottomCenter,
            style: ornamentStyle,
            isVisible: showBottomMedia
        ) {
            SpinnahMediaControlsOrnament(
                isPlaying: .constant(true),
                currentTrack: "Spinnah Theme Song",
                currentArtist: "Design System",
                onPlayPause: { print("Play/Pause") },
                onNext: { print("Next") },
                onPrevious: { print("Previous") }
            )
        }
    }
}

#Preview {
    LiquidGlassDemoView()
}
