import Foundation

/// When the scheduler kicks off a brew run — after user idle, or at a fixed
/// time of day. Persisted in settings.
enum TriggerMode: String, CaseIterable, Codable, Sendable {
    case idle
    case scheduled
}
