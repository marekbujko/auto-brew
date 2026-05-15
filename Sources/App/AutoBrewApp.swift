import SwiftUI

@main
struct AutoBrewApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var scheduler = SchedulerService.shared

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
        } label: {
            MenuBarIcon(state: scheduler.state)
        }
        .menuBarExtraStyle(.window)

        Window("BrewStation", id: "brewstation") {
            BrewStationWindow()
        }
        .defaultSize(width: 1000, height: 680)
        .commands {
            CommandGroup(replacing: .newItem) { }
        }
    }
}
