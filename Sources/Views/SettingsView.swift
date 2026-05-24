import AppKit
import SwiftUI

/// Settings page rendered inside the menu-bar popover. Changes to the trigger
/// section restart `SchedulerService` immediately so the new mode takes effect
/// without an app relaunch.
struct SettingsView: View {
    @State private var settings = SettingsStore.shared
    @State private var scheduler = SchedulerService.shared
    @State private var brewManager = BrewManager.shared
    @State private var iconCacheSize: Int64 = 0
    @State private var cacheLastUpdated: String = "—"
    @State private var cacheError: String?
    var onBack: () -> Void

    var body: some View {
        ScrollView {
            HStack {
                Button(action: onBack) {
                    Label("Back", systemImage: "chevron.left")
                }
                .buttonStyle(.plain)
                Spacer()
                Text("Settings")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 44, height: 1)
            }
            .padding(.horizontal, 12)
            .padding(.top, 10)
            .padding(.bottom, 4)

            Divider()

            Form {
                Section("Update Trigger") {
                    Picker("Mode", selection: Binding(
                        get: { settings.triggerMode },
                        set: {
                            settings.triggerMode = $0
                            scheduler.restartScheduling()
                        }
                    )) {
                        Text("After Idle").tag(TriggerMode.idle)
                        Text("Scheduled Time").tag(TriggerMode.scheduled)
                    }
                    .pickerStyle(.segmented)

                    if settings.triggerMode == .idle {
                        HStack {
                            Text("Idle Duration")
                            Spacer()
                            Stepper(
                                "\(settings.idleMinutes) min",
                                value: Binding(
                                    get: { settings.idleMinutes },
                                    set: { settings.idleMinutes = $0 }
                                ),
                                in: 5...120,
                                step: 5
                            )
                        }
                    } else {
                        DatePicker(
                            "Time",
                            selection: scheduledTimeBinding,
                            displayedComponents: .hourAndMinute
                        )
                        .onChange(of: scheduledTimeBinding.wrappedValue) {
                            scheduler.restartScheduling()
                        }
                    }
                }

                UpdatePolicySection(defaults: Binding(
                    get: { settings.policyDefaults },
                    set: { settings.policyDefaults = $0 }
                ))

                Section("General") {
                    Toggle("Launch at Login", isOn: Binding(
                        get: { LoginItemManager.isEnabled },
                        set: { newValue in
                            let success = LoginItemManager.setEnabled(newValue)
                            settings.loginItemEnabled = success ? newValue : LoginItemManager.isEnabled
                        }
                    ))

                    Toggle("Show Notifications", isOn: Binding(
                        get: { settings.showNotifications },
                        set: { settings.showNotifications = $0 }
                    ))
                }

                Section(String(localized: "Snapshots")) {
                    Toggle(String(localized: "Snapshot apps before auto-upgrade"),
                           isOn: Binding(
                               get: { settings.autoSnapshotBeforeUpgrade },
                               set: { settings.autoSnapshotBeforeUpgrade = $0 }
                           ))
                    Text(String(localized: "Captures each cask's user data right before its automatic upgrade so the History view can roll back with one click if the upgrade breaks the app."))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    if settings.autoSnapshotBeforeUpgrade {
                        Stepper(
                            String(localized: "Skip snapshot when free disk is below \(settings.minFreeGBForSnapshot) GiB"),
                            value: Binding(
                                get: { settings.minFreeGBForSnapshot },
                                set: { settings.minFreeGBForSnapshot = $0 }
                            ),
                            in: 1...100, step: 1
                        )
                    }

                    Toggle(String(localized: "Auto-clean up old snapshots"),
                           isOn: Binding(
                               get: { settings.autoCleanupSnapshots },
                               set: { settings.autoCleanupSnapshots = $0 }
                           ))
                    if settings.autoCleanupSnapshots {
                        Stepper(String(localized: "Keep snapshots for \(settings.snapshotRetentionDays) days"),
                                value: Binding(
                                    get: { settings.snapshotRetentionDays },
                                    set: { settings.snapshotRetentionDays = $0 }
                                ),
                                in: 7...365, step: 7)
                    }
                    HStack {
                        Text(String(localized: "Snapshot storage"))
                        Spacer()
                        Button(String(localized: "Open in Finder")) {
                            let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
                                .appendingPathComponent("AutoBrew/Snapshots")
                            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                            NSWorkspace.shared.open(url)
                        }
                    }
                }

                Section(String(localized: "Icon Cache")) {
                    HStack {
                        Text(String(localized: "Cache size"))
                        Spacer()
                        Text(ByteFormatter.string(iconCacheSize))
                            .foregroundStyle(.secondary)
                            .monospacedDigit()
                    }
                    HStack {
                        Text(String(localized: "Last updated"))
                        Spacer()
                        Text(cacheLastUpdated)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                    }
                    Button(String(localized: "Clear Icon Cache"), role: .destructive) {
                        do {
                            try RemoteIconLoader.shared.clearCache()
                        } catch {
                            cacheError = error.localizedDescription
                        }
                        refreshCacheStats()
                    }
                }
                .task { refreshCacheStats() }
                .alert(String(localized: "Couldn't clear cache"),
                       isPresented: Binding(get: { cacheError != nil }, set: { if !$0 { cacheError = nil } }),
                       presenting: cacheError) { _ in
                    Button("OK") { cacheError = nil }
                } message: { msg in
                    Text(msg)
                }

                Section("Homebrew") {
                    HStack {
                        Text("Status")
                        Spacer()
                        if brewManager.isHomebrewInstalled {
                            Label("Installed", systemImage: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        } else {
                            Label("Not Found", systemImage: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }

                    if let path = brewManager.brewExecutable {
                        HStack {
                            Text("Path")
                            Spacer()
                            Text(path)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Updates") {
                    Button {
                        UpdaterService.shared.checkForUpdates()
                    } label: {
                        Label("Check for Updates", systemImage: "arrow.clockwise")
                    }
                    .disabled(!UpdaterService.shared.canCheckForUpdates)
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Brand")
                        Spacer()
                        Text("DigitalFreedom")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Operated by")
                        Spacer()
                        Text("Berger & Rosenstock GbR")
                            .foregroundStyle(.secondary)
                    }
                    Link(destination: URL(string: "https://support.digitalfreedom.co.za/help/767340152")!) {
                        HStack {
                            Label("Help & Support", systemImage: "questionmark.circle")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Link(destination: URL(string: "https://github.com/sponsors/marcelrgberger")!) {
                        HStack {
                            Label("Sponsor this Project", systemImage: "heart")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Link(destination: URL(string: "https://github.com/marcelrgberger/auto-brew")!) {
                        HStack {
                            Label("Source Code", systemImage: "chevron.left.forwardslash.chevron.right")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Legal") {
                    // Each row jumps directly into the standalone Legal window
                    // pre-selected on the chosen document. `NSApp.activate` is
                    // necessary because the menu-bar extra doesn't bring the
                    // app forward on its own.
                    ForEach(LegalDocument.allCases) { doc in
                        Button {
                            LegalNavigation.shared.requestedDocument = doc
                            NotificationCenter.default.post(name: .openLegalWindow, object: nil)
                            NSApp.activate(ignoringOtherApps: true)
                        } label: {
                            HStack {
                                Label(LocalizedStringKey(doc.titleKey), systemImage: icon(for: doc))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .formStyle(.grouped)
        }
        .frame(maxWidth: 320, maxHeight: 460)
    }

    private func icon(for document: LegalDocument) -> String {
        switch document {
        case .privacy: return "hand.raised"
        case .terms: return "doc.text"
        case .eula: return "doc.badge.gearshape"
        case .impressum: return "building.columns"
        case .trademark: return "r.square"
        case .openSource: return "shippingbox"
        }
    }

    /// Reads the on-disk icon cache directly so the size shown reflects
    /// reality (incl. files the loader hasn't seen yet this session).
    @MainActor
    private func refreshCacheStats() {
        iconCacheSize = RemoteIconLoader.shared.diskCacheSize()
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent("AutoBrew/IconCache")
        if let contents = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.contentModificationDateKey]),
           let newest = contents.compactMap({ try? $0.resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate }).max() {
            cacheLastUpdated = newest.formatted(.relative(presentation: .named))
        } else {
            cacheLastUpdated = String(localized: "Never")
        }
    }

    private var scheduledTimeBinding: Binding<Date> {
        Binding(
            get: {
                var comps = DateComponents()
                comps.hour = settings.scheduledHour
                comps.minute = settings.scheduledMinute
                return Calendar.current.date(from: comps) ?? Date()
            },
            set: { date in
                let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
                settings.scheduledHour = comps.hour ?? 3
                settings.scheduledMinute = comps.minute ?? 0
            }
        )
    }
}
