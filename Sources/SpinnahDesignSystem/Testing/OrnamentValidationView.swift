//
//  OrnamentValidationView.swift v1
//  SpinnahDesignSystem - Testing v1.0
//
//  Validation playground for testing navigation ornaments over various backgrounds
//  Tests liquid glass materials and visual consistency
//

#if DEBUG
import SwiftUI

@MainActor
public struct OrnamentValidationView: View {
    @State private var selectedBackground = 0
    @State private var selectedStyle: SpinnahOrnamentStyle = .floating
    @State private var currentPage = 3
    @State private var totalPages = 24
    @State private var isPlaying = true
    @State private var showOrnament = true
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Controls Header
            VStack(spacing: 16) {
                Text("Navigation Ornament Validation")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                // Background Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Background Test")
                        .font(.headline)
                        .foregroundStyle(Color.spinnahTextPrimary)
                    
                    Picker("Background", selection: $selectedBackground) {
                        Text("Rainbow Gradient").tag(0)
                        Text("Spinnah Gradient").tag(1)
                        Text("Radial Rainbow").tag(2)
                        Text("Blue Ocean").tag(3)
                        Text("Sunset").tag(4)
                        Text("Forest").tag(5)
                        Text("Neon").tag(6)
                        Text("Solid Dark").tag(7)
                        Text("Solid Light").tag(8)
                    }
                    .pickerStyle(.segmented)
                }
                
                // Style Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ornament Style")
                        .font(.headline)
                        .foregroundStyle(Color.spinnahTextPrimary)
                    
                    Picker("Style", selection: $selectedStyle) {
                        Text("Floating").tag(SpinnahOrnamentStyle.floating)
                        Text("Subtle").tag(SpinnahOrnamentStyle.subtle)
                        Text("Prominent").tag(SpinnahOrnamentStyle.prominent)
                    }
                    .pickerStyle(.segmented)
                }
                
                // Controls
                HStack(spacing: 20) {
                    Toggle("Show Ornament", isOn: $showOrnament)
                    
                    Stepper("Page: \(currentPage)", value: $currentPage, in: 1...totalPages)
                    
                    Button(isPlaying ? "Pause" : "Play") {
                        isPlaying.toggle()
                    }
                    .buttonStyle(.bordered)
                }
                .font(.system(size: 14, weight: .medium))
            }
            .padding(20)
            .background(Color.spinnahBackgroundSecondary)
            
            Divider()
            
            // Test Area
            ZStack {
                // Background
                backgroundGradient
                
                // Content
                VStack(spacing: 40) {
                    Text("Test Content")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    
                    Text("Watch how the liquid glass ornament adapts to this background")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    
                    // Sample Cards to show depth
                    HStack(spacing: 20) {
                        ForEach(0..<3, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.white.opacity(0.2))
                                .frame(width: 120, height: 80)
                                .overlay(
                                    Text("Content")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Comic Reader Ornament
            .spinnahNavigationOrnament(
                style: selectedStyle,
                isVisible: showOrnament
            ) {
                SpinnahComicReaderOrnament(
                    coverThumbnail: "book.closed",
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onStartOfIssue: { currentPage = 1 },
                    onPreviousPage: { 
                        if currentPage > 1 { currentPage -= 1 }
                    },
                    onNextPage: { 
                        if currentPage < totalPages { currentPage += 1 }
                    },
                    onEndOfIssue: { currentPage = totalPages }
                )
            }
        }
    }
    
    @ViewBuilder
    private var backgroundGradient: some View {
        switch selectedBackground {
        case 0: // Rainbow Gradient
            LinearGradient(
                colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case 1: // Spinnah Gradient
            LinearGradient(
                colors: [Color.spinnahGradientStart, Color.spinnahGradientEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case 2: // Radial Rainbow
            RadialGradient(
                colors: [.yellow, .orange, .red, .purple, .blue, .green],
                center: .center,
                startRadius: 50,
                endRadius: 400
            )
            
        case 3: // Blue Ocean
            LinearGradient(
                colors: [.cyan, .blue, .indigo, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
            
        case 4: // Sunset
            LinearGradient(
                colors: [.orange, .pink, .purple, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case 5: // Forest
            LinearGradient(
                colors: [.green, .mint, .teal, .cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case 6: // Neon
            RadialGradient(
                colors: [.pink, .purple, .blue, .black],
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            
        case 7: // Solid Dark
            Color.black
            
        case 8: // Solid Light
            Color.white
            
        default:
            Color.clear
        }
    }
}

// MARK: - Media Controls Test Section
@MainActor
public struct MediaControlsValidationView: View {
    @State private var isPlaying = true
    @State private var selectedStyle: SpinnahOrnamentStyle = .floating
    @State private var showOrnament = true
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // Controls
            VStack(spacing: 16) {
                Text("Media Controls Validation")
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.spinnahTextPrimary)
                
                HStack(spacing: 20) {
                    Picker("Style", selection: $selectedStyle) {
                        Text("Floating").tag(SpinnahOrnamentStyle.floating)
                        Text("Subtle").tag(SpinnahOrnamentStyle.subtle)
                        Text("Prominent").tag(SpinnahOrnamentStyle.prominent)
                    }
                    .pickerStyle(.segmented)
                    
                    Toggle("Show Controls", isOn: $showOrnament)
                }
            }
            .padding(20)
            .background(Color.spinnahBackgroundSecondary)
            
            Divider()
            
            // Test Area
            ZStack {
                // Animated background
                LinearGradient(
                    colors: [Color.spinnahGradientStart, .purple, .blue, Color.spinnahGradientEnd],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                VStack(spacing: 40) {
                    Text("Media Player")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    
                    Text("Testing media controls ornament")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Media Controls Ornament
            .spinnahNavigationOrnament(
                style: selectedStyle,
                isVisible: showOrnament
            ) {
                SpinnahMediaControlsOrnament(
                    isPlaying: $isPlaying,
                    currentTrack: "Liquid Dreams",
                    currentArtist: "Spinnah Studios",
                    onPlayPause: { isPlaying.toggle() },
                    onNext: { print("Next track") },
                    onPrevious: { print("Previous track") }
                )
            }
        }
    }
}

// MARK: - Combined Validation View
@MainActor
public struct OrnamentTestingPlayground: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            OrnamentValidationView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Comic Reader")
                }
                .tag(0)
            
            MediaControlsValidationView()
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Media Controls")
                }
                .tag(1)
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

// MARK: - Preview Provider
struct OrnamentValidationView_Previews: PreviewProvider {
    static var previews: some View {
        OrnamentTestingPlayground()
            .previewDisplayName("Ornament Testing Playground")
    }
}

#endif
