import Foundation
import SwiftUI

/// Observable mirror of every user-facing preference. Each property writes
/// through to `UserDefaults` via `didSet` so the only place that needs to
/// know about storage keys is this file.
@Observable
@MainActor
final class SettingsStore {
    static let shared = SettingsStore()

    private let defaults = UserDefaults.standard

    var triggerMode: TriggerMode {
        didSet { defaults.set(triggerMode.rawValue, forKey: "triggerMode") }
    }

    var idleMinutes: Int {
        didSet { defaults.set(idleMinutes, forKey: "idleMinutes") }
    }

    var scheduledHour: Int {
        didSet { defaults.set(scheduledHour, forKey: "scheduledHour") }
    }

    var scheduledMinute: Int {
        didSet { defaults.set(scheduledMinute, forKey: "scheduledMinute") }
    }

    var lastRunDate: Date? {
        didSet { defaults.set(lastRunDate, forKey: "lastRunDate") }
    }

    var loginItemEnabled: Bool {
        didSet { defaults.set(loginItemEnabled, forKey: "loginItemEnabled") }
    }

    var showNotifications: Bool {
        didSet { defaults.set(showNotifications, forKey: "showNotifications") }
    }

    var snapshotRetentionDays: Int {
        didSet { defaults.set(snapshotRetentionDays, forKey: "snapshotRetentionDays") }
    }

    var autoCleanupSnapshots: Bool {
        didSet { defaults.set(autoCleanupSnapshots, forKey: "autoCleanupSnapshots") }
    }

    var onboardingCompleted: Bool {
        didSet { defaults.set(onboardingCompleted, forKey: "onboardingCompleted") }
    }

    /// Per-bump policy defaults for casks and formulae. Stored as JSON because
    /// `UserDefaults` can't represent nested enums on its own.
    var policyDefaults: UpdatePolicyDefaults {
        didSet {
            if let data = try? JSONEncoder().encode(policyDefaults) {
                defaults.set(data, forKey: "policyDefaults")
            }
        }
    }

    /// Per-package opt-outs from the policy defaults.
    var packageOverrides: [PackagePolicyOverride] {
        didSet {
            if let data = try? JSONEncoder().encode(packageOverrides) {
                defaults.set(data, forKey: "packageOverrides")
            }
        }
    }

    var didRunToday: Bool {
        guard let last = lastRunDate else { return false }
        return Calendar.current.isDateInToday(last)
    }

    private init() {
        let d = UserDefaults.standard

        if let raw = d.string(forKey: "triggerMode"),
           let mode = TriggerMode(rawValue: raw) {
            triggerMode = mode
        } else {
            triggerMode = .idle
        }

        let idle = d.integer(forKey: "idleMinutes")
        idleMinutes = idle > 0 ? idle : 30

        if d.object(forKey: "scheduledHour") != nil {
            scheduledHour = d.integer(forKey: "scheduledHour")
        } else {
            scheduledHour = 3
        }

        scheduledMinute = d.integer(forKey: "scheduledMinute")

        lastRunDate = d.object(forKey: "lastRunDate") as? Date
        loginItemEnabled = d.bool(forKey: "loginItemEnabled")

        if d.object(forKey: "showNotifications") != nil {
            showNotifications = d.bool(forKey: "showNotifications")
        } else {
            showNotifications = true
        }

        let retention = d.integer(forKey: "snapshotRetentionDays")
        snapshotRetentionDays = retention > 0 ? retention : 90
        autoCleanupSnapshots = d.bool(forKey: "autoCleanupSnapshots")

        onboardingCompleted = d.bool(forKey: "onboardingCompleted")

        if let data = d.data(forKey: "policyDefaults"),
           let decoded = try? JSONDecoder().decode(UpdatePolicyDefaults.self, from: data) {
            policyDefaults = decoded
        } else {
            policyDefaults = .safeDefaults
        }

        if let data = d.data(forKey: "packageOverrides"),
           let decoded = try? JSONDecoder().decode([PackagePolicyOverride].self, from: data) {
            packageOverrides = decoded
        } else {
            packageOverrides = []
        }
    }
}
