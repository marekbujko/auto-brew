import AppKit
import SwiftUI

@Observable
@MainActor
final class CaskIconCache {
    static let shared = CaskIconCache()
    private var cache: [String: NSImage] = [:]
    private var checkedTokens: Set<String> = []

    func icon(for token: String, appNames: [String]) -> NSImage? {
        if let cached = cache[token] { return cached }
        if checkedTokens.contains(token) { return nil }
        checkedTokens.insert(token)

        for appName in appNames {
            let path = "/Applications/\(appName)"
            if FileManager.default.fileExists(atPath: path) {
                let image = NSWorkspace.shared.icon(forFile: path)
                cache[token] = image
                return image
            }
        }
        return nil
    }
}

struct CaskIconView: View {
    let token: String
    let appNames: [String]
    let size: CGFloat
    @State private var cache = CaskIconCache.shared

    var body: some View {
        if let icon = cache.icon(for: token, appNames: appNames) {
            Image(nsImage: icon)
                .resizable()
                .interpolation(.high)
                .scaledToFit()
                .frame(width: size, height: size)
        } else {
            fallback
        }
    }

    private var fallback: some View {
        Image(systemName: "shippingbox.fill")
            .resizable().scaledToFit()
            .padding(size * 0.2)
            .foregroundStyle(.secondary)
            .frame(width: size, height: size)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: size * 0.18))
    }
}
