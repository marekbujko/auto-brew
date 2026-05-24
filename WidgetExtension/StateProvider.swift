import Foundation
import WidgetKit

/// Decodes the latest `WidgetState.json` written by the main app into a
/// `TimelineEntry`. Lives entirely inside the sandboxed extension, so
/// the App Group container is its only window into the main app's
/// world; touching `~/Library/Application Support/AutoBrew/` directly
/// would silently fail.
struct AutoBrewStateProvider: TimelineProvider {
    typealias Entry = AutoBrewWidgetEntry

    /// App-Group identifier — must match the main app's
    /// `WidgetStateWriter.appGroupIdentifier`. Kept as a hard-coded
    /// constant rather than read from `Bundle.main` because the
    /// extension has its own bundle and pulling it from elsewhere would
    /// introduce a chicken-and-egg dependency at load time.
    static let appGroupIdentifier = "group.za.co.digitalfreedom.AutoBrew"

    func placeholder(in context: Context) -> AutoBrewWidgetEntry {
        AutoBrewWidgetEntry(date: Date(), state: .empty)
    }

    func getSnapshot(in context: Context, completion: @escaping (AutoBrewWidgetEntry) -> Void) {
        completion(loadEntry())
    }

    /// Single-entry timeline with an explicit 30-minute refresh hint.
    /// `WidgetCenter.reloadAllTimelines()` from the main app supersedes
    /// the hint as soon as anything user-visible changes, so the hint is
    /// only a fallback for the "main app is closed and nothing
    /// happened" case.
    func getTimeline(in context: Context, completion: @escaping (Timeline<AutoBrewWidgetEntry>) -> Void) {
        let entry = loadEntry()
        let refresh = Date().addingTimeInterval(60 * 30)
        completion(Timeline(entries: [entry], policy: .after(refresh)))
    }

    private func loadEntry() -> AutoBrewWidgetEntry {
        guard let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Self.appGroupIdentifier) else {
            return AutoBrewWidgetEntry(date: Date(), state: .empty)
        }
        let url = container.appendingPathComponent("WidgetState.json")
        guard let data = try? Data(contentsOf: url) else {
            return AutoBrewWidgetEntry(date: Date(), state: .empty)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let state = try? decoder.decode(WidgetState.self, from: data) else {
            // A corrupt file should not panic the widget — render the
            // empty state and let the next successful write recover.
            return AutoBrewWidgetEntry(date: Date(), state: .empty)
        }
        return AutoBrewWidgetEntry(date: Date(), state: state)
    }
}

struct AutoBrewWidgetEntry: TimelineEntry {
    let date: Date
    let state: WidgetState
}
