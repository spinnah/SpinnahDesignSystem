# SpinnahDesignSystem

A comprehensive Liquid Glass design system for macOS 15+ that combines beautiful visual aesthetics with native Apple frameworks. Features the signature red-orange to golden-yellow gradient and leverages system components for automatic Liquid Glass effects.

## Overview

SpinnahDesignSystem provides a complete UI component library with:
- **Liquid Glass Materials**: Automatic glass effects using native SwiftUI components
- **Brand Integration**: Complete color system with the signature Spinnah gradient
- **macOS Native**: Built specifically for macOS 15+ with proper system integration
- **Developer Friendly**: Easy integration with comprehensive documentation

## Installation

### Swift Package Manager

Add SpinnahDesignSystem to your project using Xcode:

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter the repository URL: `[YOUR_REPOSITORY_URL]`
3. Select **Up to Next Major Version** and click **Add Package**

### Manual Installation

1. Download or clone this repository
2. Drag the `SpinnahDesignSystem` folder into your Xcode project
3. Ensure the package is added to your target dependencies

## Quick Start

Import the design system and start using components:

```swift
import SwiftUI
import SpinnahDesignSystem

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Use Spinnah buttons
            SpinnahButton("Get Started") {
                print("Button tapped!")
            }
            
            // Apply brand colors
            Text("Welcome to Spinnah")
                .foregroundStyle(Color.spinnahPrimary)
                .font(.largeTitle)
        }
        .spinnahGradientBackground() // Apply brand gradient
    }
}
```

## Color System

### Brand Colors

```swift
Color.spinnahPrimary        // Brand primary color (#d62800)
Color.spinnahSecondary      // Brand secondary color  
Color.spinnahAccent         // Brand accent color (#d62800)
```

### Gradient Colors

```swift
Color.spinnahGradientStart  // Fiery red-orange (#d62800)
Color.spinnahGradientEnd    // Golden yellow (#ffce00)
```

### Semantic Colors

```swift
// Background Colors
Color.spinnahBackgroundPrimary
Color.spinnahBackgroundSecondary

// Text Colors  
Color.spinnahTextPrimary
Color.spinnahTextSecondary

// Interactive Colors
Color.spinnahBorder
Color.spinnahLink
Color.spinnahDisabled
Color.spinnahPlaceholder

// Surface Colors
Color.spinnahSurfaceOverlay
Color.spinnahCardElevated
```

## Gradient System

### Pre-built Gradients

```swift
// Linear gradients
LinearGradient.spinnahPrimary     // Diagonal brand gradient
LinearGradient.spinnahHorizontal  // Left to right
LinearGradient.spinnahVertical    // Top to bottom
LinearGradient.spinnahSubtle      // Low opacity for backgrounds

// Radial gradients
RadialGradient.spinnahRadial      // Center-based radial
RadialGradient.spinnahSpotlight   // Spotlight effect

// Angular gradients
AngularGradient.spinnahAngular    // Full rotation
AngularGradient.spinnahConic      // Smooth conic gradient
```

### Custom Gradients

```swift
// Custom linear gradient
let gradient = SpinnahGradients.linear(
    startPoint: .topLeading,
    endPoint: .bottomTrailing,
    opacity: 0.8
)

// Custom radial gradient
let radial = SpinnahGradients.radial(
    center: .center,
    startRadius: 0,
    endRadius: 150
)

// Three-stop gradient
let threeStop = SpinnahGradients.threeStop(
    middleColor: .white,
    startPoint: .top,
    endPoint: .bottom
)
```

### Gradient View Modifiers

```swift
Text("Hello World")
    .spinnahGradientBackground()    // Apply as background
    .spinnahSubtleBackground()      // Subtle gradient background
    .spinnahGradientOverlay()       // Apply as overlay
```

## Button Components

### Primary Button

```swift
SpinnahButton("Save Document") {
    // Handle action
}
```

### Secondary Button

```swift
SpinnahSecondaryButton("Cancel") {
    // Handle action  
}
```

### Tertiary Button

```swift
SpinnahTertiaryButton("Learn More") {
    // Handle action
}
```

### Destructive Button

```swift
SpinnahDestructiveButton("Delete") {
    // Handle destructive action
}
```

## Card Components

### Content Cards

```swift
// Basic content card
SpinnahContentCard(
    title: "Welcome",
    subtitle: "Getting Started",
    systemImage: "sparkles",
    content: "Beautiful Liquid Glass components with your signature gradient."
)

// Action card with button
SpinnahActionCard(
    title: "Quick Actions",
    subtitle: "Get things done faster",
    systemImage: "bolt.fill",
    buttonTitle: "Start Now",
    buttonAction: { /* action */ }
)

// Stats card for metrics
SpinnahStatsCard(
    value: "2.4k",
    label: "Active Users",
    trend: .up,
    trendValue: "12%"
)

// Media card for content
SpinnahMediaCard(
    title: "Design System Demo",
    subtitle: "See it in action",
    systemImage: "play.circle.fill",
    isPlaying: $isPlaying,
    onPlayPause: { /* toggle playback */ }
)
```

### Card Styles

```swift
// Different visual styles
SpinnahCard(.elevated) { /* content */ }
SpinnahCard(.glass) { /* content */ }
SpinnahCard(.gradient) { /* content */ }
SpinnahCard(.outline) { /* content */ }
SpinnahCard(.compact) { /* content */ }
```

### Card Grid Layout

```swift
SpinnahCardGrid(columns: 2, spacing: 16) {
    SpinnahContentCard(/* ... */)
    SpinnahActionCard(/* ... */)
    SpinnahStatsCard(/* ... */)
    SpinnahMediaCard(/* ... */)
}
```

## Toolbar Components

### Basic Toolbar

```swift
NavigationView {
    ContentView()
        .spinnahToolbar(
            title: "Document",
            showSearch: true,
            searchBinding: $searchText
        ) {
            ToolbarItem(placement: .primaryAction) {
                SpinnahButton("Save") { /* save */ }
            }
        }
}
```

### Navigation Toolbar

```swift
NavigationView {
    ContentView()
        .spinnahNavigationToolbar(
            title: "My App",
            showSearch: true,
            searchBinding: $searchText
        ) {
            // Custom toolbar content
        }
}
```

### Toolbar Button Styles

```swift
// Available in toolbars
SpinnahToolbarButton.primary("Save") { /* action */ }
SpinnahToolbarButton.secondary("Cancel") { /* action */ }
SpinnahToolbarButton.icon("plus") { /* action */ }
```

## Navigation Ornaments

### Basic Ornament

```swift
ContentView()
    .spinnahNavigationOrnament(
        edge: .top,
        alignment: .center
    ) {
        HStack {
            Button("Home") { /* action */ }
            Button("Settings") { /* action */ }
        }
    }
```

### Tab Navigation Ornament

```swift
let tabs = [
    SpinnahNavigationTab(id: 1, title: "Documents", systemImage: "doc"),
    SpinnahNavigationTab(id: 2, title: "Media", systemImage: "photo"),
    SpinnahNavigationTab(id: 3, title: "Settings", systemImage: "gear")
]

ContentView()
    .spinnahTabOrnament(
        selectedTab: $selectedTab,
        tabs: tabs,
        edge: .bottom
    )
```

### Breadcrumb Navigation

```swift
let breadcrumbs = [
    SpinnahBreadcrumb(id: 1, title: "Home"),
    SpinnahBreadcrumb(id: 2, title: "Documents"),
    SpinnahBreadcrumb(id: 3, title: "Current", isActive: true)
]

ContentView()
    .spinnahBreadcrumbOrnament(
        breadcrumbs: breadcrumbs,
        onNavigate: { id in /* navigate */ },
        edge: .top
    )
```

### Media Controls Ornament

```swift
ContentView()
    .spinnahNavigationOrnament(edge: .bottom) {
        SpinnahMediaControlsOrnament(
            isPlaying: $isPlaying,
            onPlayPause: { /* toggle */ },
            onNext: { /* next track */ },
            onPrevious: { /* previous track */ },
            currentTrack: "Current Song"
        )
    }
```

## Design Philosophy

SpinnahDesignSystem follows Apple's design principles while adding the unique Spinnah brand identity:

### Liquid Glass Materials
- Uses native SwiftUI components for automatic Liquid Glass effects
- `.regularMaterial` backgrounds provide system-integrated glass
- Components float above content with proper visual hierarchy

### Brand Integration
- Signature red-orange (#d62800) to golden-yellow (#ffce00) gradient
- Consistent color system across all components
- Adaptive colors that work in light and dark modes

### Native Feel
- Leverages system frameworks for familiar interactions
- Proper keyboard shortcuts and accessibility support
- Follows macOS 15+ design guidelines

## Platform Support

- **macOS**: 15.0+
- **Swift**: 6.2+
- **Xcode**: 16.0+

## Architecture

```
SpinnahDesignSystem/
├── Core/
│   ├── SpinnahDesignSystem.swift    # Main module
│   ├── Colors.swift                 # Color extensions
│   └── Gradients.swift             # Gradient system
├── Components/
│   ├── SpinnahButtons.swift        # Button components
│   ├── SpinnahCards.swift          # Card components
│   ├── SpinnahToolbars.swift       # Toolbar system
│   └── SpinnahNavigationOrnaments.swift # Navigation ornaments
└── Resources/
    └── Colors.xcassets             # Color assets
```

## Best Practices

### Performance
- Use `.borderless` button styles on glass backgrounds
- Leverage system materials for automatic performance optimization
- Prefer native components over custom implementations

### Accessibility
- All components include proper accessibility labels
- High contrast support through semantic colors
- VoiceOver compatibility built-in

### Integration
- Import only what you need: `import SpinnahDesignSystem`
- Use view modifiers for consistent styling
- Follow SwiftUI composition patterns

## Examples

See the comprehensive preview implementations in each component file for detailed usage examples.

## License

[Your License Here]

## Contributing

[Contributing Guidelines Here]

## Support

For questions and support, please [contact information].

---

Built with ❤️ using SwiftUI and Apple's design guidelines.