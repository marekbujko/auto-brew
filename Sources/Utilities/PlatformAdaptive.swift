import SwiftUI

/// SwiftUI modifiers that pick the most native surface treatment for the
/// host macOS version. macOS 26 (Tahoe) ships Liquid Glass — when the binary
/// runs there we adopt it; on macOS 14/15 we fall back to the classic
/// translucent materials so the UI keeps its native look on every release.
extension View {
    /// `.symbolEffect(.rotate, isActive:)` requires macOS 15.
    /// Fall back to `.pulse` on macOS 14 so the "work in progress" cue stays visible.
    @ViewBuilder
    func rotatingSymbolEffect(isActive: Bool) -> some View {
        if #available(macOS 15, *) {
            self.symbolEffect(.rotate, isActive: isActive)
        } else {
            self.symbolEffect(.pulse, isActive: isActive)
        }
    }

    /// Subtle card surface — Liquid Glass on macOS 26+, quaternary fill before.
    @ViewBuilder
    func adaptiveGlassCard(cornerRadius: CGFloat) -> some View {
        if #available(macOS 26, *) {
            self.glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
        } else {
            self.background(.quaternary, in: RoundedRectangle(cornerRadius: cornerRadius))
        }
    }

    /// Subtle pill surface — Liquid Glass on macOS 26+, tertiary fill before.
    /// When `tint` is supplied, the glass picks it up; the legacy fallback
    /// uses `tint.opacity(0.2)` to match the prior look.
    @ViewBuilder
    func adaptiveGlassCapsule(tint: Color? = nil) -> some View {
        if #available(macOS 26, *) {
            if let tint {
                self.glassEffect(.regular.tint(tint), in: .capsule)
            } else {
                self.glassEffect(.regular, in: .capsule)
            }
        } else {
            if let tint {
                self.background(tint.opacity(0.2), in: Capsule())
            } else {
                self.background(.tertiary, in: Capsule())
            }
        }
    }

    /// Primary action button — Glass Prominent on macOS 26+, Bordered Prominent before.
    @ViewBuilder
    func adaptiveProminentButtonStyle() -> some View {
        if #available(macOS 26, *) {
            self.buttonStyle(.glassProminent)
        } else {
            self.buttonStyle(.borderedProminent)
        }
    }

    /// Secondary action button — Glass on macOS 26+, Bordered before.
    @ViewBuilder
    func adaptiveBorderedButtonStyle() -> some View {
        if #available(macOS 26, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(.bordered)
        }
    }
}
