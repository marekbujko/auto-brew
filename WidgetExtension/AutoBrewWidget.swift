import SwiftUI
import WidgetKit

/// AutoBrew's single widget — three families share the same data
/// source but render distinct surfaces (see `AutoBrewWidgetEntryView`).
struct AutoBrewWidget: Widget {
    let kind: String = "AutoBrewStatus"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AutoBrewStateProvider()) { entry in
            AutoBrewWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName(String(localized: "AutoBrew Status"))
        .description(String(localized: "Pending approvals, recent auto-upgrades, and one-tap rollback for the latest failed cask."))
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

@main
struct AutoBrewWidgetBundle: WidgetBundle {
    var body: some Widget {
        AutoBrewWidget()
    }
}
