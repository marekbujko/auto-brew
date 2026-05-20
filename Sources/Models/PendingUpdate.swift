import Foundation

/// State of a pending major update awaiting user input.
enum ApprovalDecision: Codable, Sendable, Equatable {
    case pending
    case approved(at: Date)
    case rejected(at: Date)
}

extension ApprovalDecision {
    var isPending: Bool {
        if case .pending = self { return true } else { return false }
    }

    var isApproved: Bool {
        if case .approved = self { return true } else { return false }
    }

    var isRejected: Bool {
        if case .rejected = self { return true } else { return false }
    }
}

/// One update waiting for the user's decision. Lives in `PendingUpdatesStore`
/// and is shown in the BrewStore's "Pending Approvals" section. The `id`
/// stays stable across runs so SwiftUI lists don't lose selection when the
/// store reloads.
struct PendingUpdate: Codable, Sendable, Equatable, Identifiable {
    let id: UUID
    let token: String
    let displayName: String
    let kind: PackageKind
    let currentVersion: String
    let availableVersion: String
    let bumpType: VersionBumpType
    /// When this exact `availableVersion` was first observed. Resets when a
    /// newer version comes through.
    let firstSeen: Date
    var decision: ApprovalDecision

    init(
        id: UUID = UUID(),
        token: String,
        displayName: String,
        kind: PackageKind,
        currentVersion: String,
        availableVersion: String,
        bumpType: VersionBumpType,
        firstSeen: Date,
        decision: ApprovalDecision = .pending
    ) {
        self.id = id
        self.token = token
        self.displayName = displayName
        self.kind = kind
        self.currentVersion = currentVersion
        self.availableVersion = availableVersion
        self.bumpType = bumpType
        self.firstSeen = firstSeen
        self.decision = decision
    }
}
