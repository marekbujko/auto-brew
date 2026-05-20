import SwiftUI

/// SwiftUI entry point. The `MenuBarExtra` is the primary surface; the two
/// auxiliary `Window` scenes (BrewStore, Legal) are only opened on demand via
/// `OpenWindowOnNotification`, which is why `File > New` is suppressed on both.
@main
struct AutoBrewApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var scheduler = SchedulerService.shared

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
        } label: {
            MenuBarIcon(state: scheduler.state)
                .modifier(OpenWindowOnNotification(windowID: "brewstore", notification: .openBrewStoreWindow))
                .modifier(OpenWindowOnNotification(windowID: "legal", notification: .openLegalWindow))
        }
        .menuBarExtraStyle(.window)

        Window("BrewStore", id: "brewstore") {
            BrewStoreWindow()
                .modifier(OpenWindowOnNotification(windowID: "brewstore", notification: .openBrewStoreWindow))
        }
        .defaultSize(width: 1000, height: 680)
        .commands {
            CommandGroup(replacing: .newItem) { }
        }

        Window("Legal", id: "legal") {
            LegalView()
        }
        .defaultSize(width: 760, height: 640)
        .commands {
            // No File > New for the Legal window — it's read-only content.
            CommandGroup(replacing: .newItem) { }
        }
    }
}

/// Bridges `NotificationCenter` events to SwiftUI's `openWindow` action.
/// Used because `@Environment(\.openWindow)` is only accessible from a `View`,
/// but our entry points (URL handler, menu commands, AppDelegate callbacks)
/// live outside the view tree.
private struct OpenWindowOnNotification: ViewModifier {
    let windowID: String
    let notification: Notification.Name
    @Environment(\.openWindow) private var openWindow

    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: notification)) { _ in
                openWindow(id: windowID)
            }
    }
}
