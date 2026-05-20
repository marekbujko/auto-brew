import Foundation
import UserNotifications
import os

/// Wrapper around `UNUserNotificationCenter`. `@unchecked Sendable` because
/// the delegate protocol forces `nonisolated` callbacks — the MainActor hop
/// then happens manually in the delegate methods.
@MainActor
final class NotificationManager: NSObject, @unchecked Sendable, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    private let logger = Logger(subsystem: "za.co.digitalfreedom.AutoBrew", category: "Notifications")
    private let center = UNUserNotificationCenter.current()

    nonisolated private static let missedRunCategory = "MISSED_RUN"
    nonisolated private static let pendingApprovalsCategory = "PENDING_APPROVALS"
    nonisolated private static let runNowAction = "RUN_NOW"
    nonisolated private static let skipAction = "SKIP"
    nonisolated private static let reviewApprovalsAction = "REVIEW_APPROVALS"

    /// Fires when the user taps "Update Now" on the missed-run notification —
    /// the bridge from notification action to scheduler.
    var onRunNowRequested: (@MainActor () -> Void)?

    /// Fires when the user taps "Review" on the pending-approvals notification.
    var onReviewApprovalsRequested: (@MainActor () -> Void)?

    override private init() {
        super.init()
        center.delegate = self

        let runAction = UNNotificationAction(
            identifier: Self.runNowAction,
            title: String(localized: "Update Now"),
            options: .foreground
        )
        let skipAction = UNNotificationAction(
            identifier: Self.skipAction,
            title: String(localized: "Skip"),
            options: .destructive
        )
        let missedCategory = UNNotificationCategory(
            identifier: Self.missedRunCategory,
            actions: [runAction, skipAction],
            intentIdentifiers: []
        )

        let reviewAction = UNNotificationAction(
            identifier: Self.reviewApprovalsAction,
            title: String(localized: "Review"),
            options: .foreground
        )
        let pendingCategory = UNNotificationCategory(
            identifier: Self.pendingApprovalsCategory,
            actions: [reviewAction],
            intentIdentifiers: []
        )

        center.setNotificationCategories([missedCategory, pendingCategory])
    }

    func requestAuthorization() async {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            logger.info("Notification authorization: \(granted)")
        } catch {
            logger.error("Notification authorization failed: \(error.localizedDescription)")
        }
    }

    func showMissedRunNotification() {
        let content = UNMutableNotificationContent()
        content.title = "AutoBrew"
        content.body = String(localized: "The scheduled brew update was missed. Run it now in the background?")
        content.sound = .default
        content.categoryIdentifier = Self.missedRunCategory

        let request = UNNotificationRequest(
            identifier: "missed-run-\(Date().timeIntervalSince1970)",
            content: content,
            trigger: nil
        )

        center.add(request) { [weak self] error in
            if let error {
                self?.logger.error("Failed to show notification: \(error.localizedDescription)")
            }
        }
    }

    /// Notifies the user that one or more major updates need their decision.
    /// `sampleNames` is a short preview shown in the body — keep the list
    /// short to avoid the notification getting truncated.
    func showPendingApprovals(count: Int, sampleNames: [String]) {
        guard count > 0 else { return }
        let content = UNMutableNotificationContent()
        content.title = "AutoBrew"
        let preview = sampleNames.prefix(3).joined(separator: ", ")
        let extra = count > sampleNames.count ? " +\(count - sampleNames.count) more" : ""
        content.body = String(localized: "\(count) updates need approval (\(preview)\(extra))")
        content.sound = .default
        content.categoryIdentifier = Self.pendingApprovalsCategory

        let request = UNNotificationRequest(
            identifier: "pending-approvals-\(Date().timeIntervalSince1970)",
            content: content,
            trigger: nil
        )
        center.add(request) { [weak self] error in
            if let error {
                self?.logger.error("Failed to show pending-approvals notification: \(error.localizedDescription)")
            }
        }
    }

    func showCompletionNotification(success: Bool, detail: String? = nil) {
        let content = UNMutableNotificationContent()
        content.title = "AutoBrew"
        content.body = success
            ? String(localized: "All Homebrew packages have been updated.")
            : String(localized: "Update failed: \(detail ?? "Unknown error")")
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: "completion-\(Date().timeIntervalSince1970)",
            content: content,
            trigger: nil
        )
        center.add(request)
    }

    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let actionID = response.actionIdentifier
        if actionID == Self.runNowAction {
            Task { @MainActor in
                onRunNowRequested?()
            }
        } else if actionID == Self.reviewApprovalsAction
                    || (actionID == UNNotificationDefaultActionIdentifier
                        && response.notification.request.content.categoryIdentifier == Self.pendingApprovalsCategory) {
            // Default tap on the pending-approvals notification also opens
            // the review view — most users tap the body, not the action.
            Task { @MainActor in
                onReviewApprovalsRequested?()
            }
        }
        completionHandler()
    }

    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
