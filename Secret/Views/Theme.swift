import SwiftUI
#if os(iOS)
import UIKit
#endif

// Centralized theme for colors, spacing, and corner radii
enum Theme {
    static let cornerRadius: CGFloat = 16
    static let smallRadius: CGFloat = 10
    static let shadowRadius: CGFloat = 8
    static let spacing: CGFloat = 12

    // Colors used across the app
    static let cream = Color("cream")
    static let accentPink = Color(red: 0.95, green: 0.4, blue: 0.5)
    static let deepRose = Color(red: 0.7, green: 0.05, blue: 0.2)
    static let burgundy = Color(red: 0.4, green: 0.0, blue: 0.1)
}

// Lightweight haptic helper for cute micro-interactions
enum Haptics {
    static func lightTap() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
}
