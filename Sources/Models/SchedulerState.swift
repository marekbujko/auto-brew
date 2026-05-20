import Foundation

/// State machine for the auto-update loop. `waitingForIdle` and
/// `waitingForSchedule` are the two armed-but-not-yet-running states (depending
/// on the chosen `TriggerMode`); `running` carries the current brew stage so
/// the menu bar icon can animate the actual phase.
enum SchedulerState: Equatable, Sendable {
    case idle
    case waitingForIdle
    case waitingForSchedule
    case running(BrewStage)
    case completed(Date)
    case failed(String)
}
