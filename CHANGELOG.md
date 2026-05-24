# Changelog

All notable changes to AutoBrew are recorded here, newest first. Format
follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); version
numbers follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
with the project-specific convention that new macOS major-version
support counts as a **minor** bump (not a patch).

The release workflow extracts the section matching the current
`MARKETING_VERSION` from this file and uses it as the GitHub Release body
and the Sparkle update dialog's release notes — keep entries short,
user-facing, and free of internal jargon.

## [Unreleased]

### Added
- One-click rollback from the failed-update notification — picks the most recent failed cask that still has its pre-upgrade snapshot on disk and offers Roll Back as a destructive notification action.
- Manual cask upgrades from BrewStore now take the same pre-upgrade snapshot and create a History row, just like the automatic auto-update path.
- Update History view shows per-cask outcomes (succeeded / failed / unclear) instead of a single aggregate status, attributed via a dedicated parser of `brew upgrade --cask` output.
- Shortcuts.app, Siri and Spotlight actions: **Install Cask**, **Snapshot App**, and **Roll Back Last Cask Upgrade** — all via the system AppIntents framework, no Bridge or helper app needed.
- **AutoBrew Status widget** for the desktop and Notification Center — three sizes show pending approvals, recent auto-upgrade outcomes with per-cask icons, and a destructive Roll Back link on the large size that triggers the same restore path as the failed-update notification. Reads from an App Group container so the sandboxed widget extension stays decoupled from the main app.
- **Download size shown before installing a cask** — BrewStore's detail view issues a single HTTP HEAD against the DMG URL on appear and renders the size (or "unknown" when the server hides Content-Length). Sizes are cached in memory for the rest of the session.
- Release notes for every version are now driven by `CHANGELOG.md`. The same body shows up on the GitHub release page and inside Sparkle's update dialog.
- Sparkle delta updates: each new release ships a `BinaryDelta`-generated patch from the previous build, so the in-app upgrade downloads a fraction of the full ZIP when the user is on the immediately-prior version.

### Changed
- `UpgradeHistory.json` schema now stores a three-state `outcome` field. Files written by an earlier build with `succeeded: Bool` are still readable — your history is not lost on upgrade.

## [2.3.0] — 2026-05-23

### Added
- Pre-upgrade auto-snapshots: every automatic cask upgrade captures a snapshot of the app's user data first so a broken update can be rolled back from the new Update History view.
- Update History sidebar entry in BrewStore lists every auto-upgrade with a one-click rollback button when the snapshot is still on disk.
- ETag-cached cask catalog: BrewStore's daily background refresh almost always returns 304 Not Modified now, saving ~50 MB per refresh.
- Platform-adaptive UI through a single `PlatformAdaptive.swift` helper — Liquid Glass on macOS 26, classic materials on macOS 14/15.
- Homebrew tap is bumped automatically from the release workflow so the cask never drifts behind the binary.

### Changed
- Minimum macOS version lowered to 14 (Sonoma); building still requires Xcode 26+.

## [2.2.2] — 2026-05-22

### Fixed
- Snapshots no longer abort on protected container-manager metadata files. A single locked sibling under `~/Library/Containers/` could previously kill the whole snapshot.

## [2.2.1] — 2026-05-21

### Added
- Help, Sponsor and Source Code links in the BrewStore sidebar.

### Fixed
- Bumped GitHub Actions images to v5 for the new Node.js 24 runtime.

## [2.2.0] — 2026-05-21

### Added
- Full Homebrew GUI (BrewStore) with Discover/Categories/Installed/Snapshots/Updates sections.
- AppSnapshot engine — capture, restore, export/import, transactional restore with rollback siblings.

### Changed
- CI reshaped per release channel (development / test / beta / main).

## [2.0.0] — 2025-03-25

### Added
- First public release. Menu-bar app that orchestrates `brew update → outdated → policy gate → upgrade → cleanup` with idle or scheduled triggers, sleep/wake recovery, and a selective per-bump-type update policy.

[Unreleased]: https://github.com/marcelrgberger/auto-brew/compare/v2.3.0...HEAD
[2.3.0]: https://github.com/marcelrgberger/auto-brew/releases/tag/v2.3.0
[2.2.2]: https://github.com/marcelrgberger/auto-brew/releases/tag/v2.2.2
[2.2.1]: https://github.com/marcelrgberger/auto-brew/releases/tag/v2.2.1
[2.2.0]: https://github.com/marcelrgberger/auto-brew/releases/tag/v2.2.0
[2.0.0]: https://github.com/marcelrgberger/auto-brew/releases/tag/v2.0.0
