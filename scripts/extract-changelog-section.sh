#!/usr/bin/env bash
#
# Print the CHANGELOG.md section that matches the requested version.
#
# Usage:
#   extract-changelog-section.sh <changelog-path> <version>
#
# Section boundaries are the `## [<version>]` heading and the next `## `
# heading (or end-of-file). Output is the section body without its own
# heading line — callers compose the surrounding markdown (release-notes
# title, Sparkle <description> wrapper, etc.). Exit code 0 even when the
# version is absent; caller decides whether that is fatal or a fallback.

set -euo pipefail

CHANGELOG_PATH="${1:?changelog path required}"
VERSION="${2:?version required}"

if [ ! -f "$CHANGELOG_PATH" ]; then
  echo "extract-changelog-section: $CHANGELOG_PATH not found" >&2
  exit 0
fi

# Match `## [<version>]` (Keep-a-Changelog) — the trailing `]` is what
# distinguishes a real section heading from a free-text mention of the
# version string elsewhere in the file.
awk -v ver="$VERSION" '
  BEGIN { in_section = 0 }
  /^## \[/ {
    if (in_section) { exit }
    # Strip the leading `## [` and check the version up to the closing `]`.
    line = $0
    sub(/^## \[/, "", line)
    closing = index(line, "]")
    if (closing == 0) { next }
    section_version = substr(line, 1, closing - 1)
    if (section_version == ver) {
      in_section = 1
      next
    }
  }
  # Reference-link definitions at the bottom of the file (Keep-a-Changelog
  # convention: `[<version>]: <url>`) end the last section too — without
  # this guard the trailing link block bleeds into the body of the oldest
  # entry.
  in_section && /^\[[A-Za-z0-9._-]+\]: / { exit }
  in_section { print }
' "$CHANGELOG_PATH"
