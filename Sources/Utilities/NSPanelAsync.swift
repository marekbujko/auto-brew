import AppKit

extension NSSavePanel {
    // NSOpenPanel is a subclass of NSSavePanel, so this single extension covers both.
    /// Awaitable wrapper around the AppKit modal panel APIs. Falls back to the
    /// app-modal `begin` variant when no key window is available (e.g. when
    /// invoked from a menu-bar-only state), since `beginSheetModal(for:)`
    /// requires an actual host window.
    @MainActor
    func runModalAsync() async -> NSApplication.ModalResponse {
        if let window = NSApp.keyWindow {
            return await withCheckedContinuation { cont in
                self.beginSheetModal(for: window) { cont.resume(returning: $0) }
            }
        } else {
            return await withCheckedContinuation { cont in
                self.begin { cont.resume(returning: $0) }
            }
        }
    }
}
