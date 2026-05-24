# Homebrew/cask Upstream Submission

This folder holds the material for submitting AutoBrew to the official
[`Homebrew/homebrew-cask`](https://github.com/Homebrew/homebrew-cask)
catalog. After the PR is merged, users install AutoBrew with
`brew install --cask autobrew` directly — no `brew tap …` needed — and
the personal `marcelrgberger/homebrew-tap` becomes optional.

## Status

**Not yet submitted.** The cask draft (`autobrew.rb` in this folder) is
written to upstream conventions but the submission is gated on the
prerequisites below. Once they are met, follow the workflow further down
to open the PR.

## Prerequisites

1. **DMG must be code-signed**, not just notarised. `brew audit
   --new --strict --online` runs `spctl -a -t open --context
   context:primary-signature -v` against the downloaded `.dmg` — an
   unsigned container fails the audit even when the embedded `.app`
   is correctly notarised. The release workflow was patched on
   2026-05-24 to add a `codesign --sign "Developer ID Application: …"
   --options runtime --timestamp` step before `notarytool submit`. The
   first release built **after** that patch is the earliest candidate
   for the submission.
2. **Repository "notability"**. Homebrew/cask refuses brand-new GitHub
   repositories below the notability threshold (currently <30 forks,
   <30 watchers and <75 stars). The audit prints the rule literally
   under `GitHub repository not notable enough`. The expected outcome
   is that the maintainers either ask you to wait, or you add a brief
   note in the PR body referencing the project's track record (releases,
   community impact, sister apps) — see the PR template below.
3. **Recent stable release on the `main` branch** with the DMG-signing
   fix applied. Bump version to whatever comes next (likely 2.3.1 if the
   change is workflow-only) and trigger `04. Release Build` so the new
   DMG carries both the `.app` and `.dmg` signatures.

## Verification before opening the PR

Run these checks once a release with the DMG-signing fix is published:

```bash
# Use a scratch slot inside the personal tap so brew can resolve the cask.
TAP_CASK=/opt/homebrew/Library/Taps/marcelrgberger/homebrew-tap/Casks/autobrew.rb
BACKUP=/tmp/autobrew-tap-cask-backup.rb
cp "$TAP_CASK" "$BACKUP"
cp docs/homebrew-cask-submission/autobrew.rb "$TAP_CASK"

brew style --cask marcelrgberger/tap/autobrew
brew audit --new --strict --online --cask marcelrgberger/tap/autobrew

cp "$BACKUP" "$TAP_CASK"
```

Expected results after the DMG-signing fix:

- `brew style` — no offenses.
- `brew audit` — one remaining offense: **GitHub repository not notable
  enough**. Reference this explicitly in the PR body.

## Submission workflow

The destination is `Homebrew/homebrew-cask`. Cask files live under
`Casks/<first-letter>/<token>.rb`, so this one belongs at
`Casks/a/autobrew.rb`.

```bash
# 1. Fork via the GitHub UI or:
gh repo fork Homebrew/homebrew-cask --remote=false

# 2. Clone the fork.
git clone https://github.com/marcelrgberger/homebrew-cask
cd homebrew-cask

# 3. Branch.
git checkout -b add-autobrew

# 4. Place the cask file.
mkdir -p Casks/a
cp ~/Developer/projects/auto-brew/docs/homebrew-cask-submission/autobrew.rb Casks/a/autobrew.rb

# 5. Final local audit against the upstream tap rules.
brew style --cask homebrew/cask/autobrew
brew audit --new --strict --online --cask homebrew/cask/autobrew

# 6. Commit + push.
git add Casks/a/autobrew.rb
git -c commit.gpgsign=false commit -m "Add AutoBrew"
git push origin add-autobrew

# 7. Open the PR with the body template below.
gh pr create --repo Homebrew/homebrew-cask --base master --head marcelrgberger:add-autobrew \
  --title "Add AutoBrew" \
  --body-file ~/Developer/projects/auto-brew/docs/homebrew-cask-submission/PR_BODY.md
```

## PR body template

Paste this into the PR description (or store it as `PR_BODY.md` here
when you are ready to open the PR):

```markdown
- [ ] Have you followed the [contribution guidelines](https://docs.brew.sh/Homebrew-and-Python.html#contributing)?
- [x] Have you ensured that your commits follow the [commit style guide](https://docs.brew.sh/Formula-Cookbook#commit)?
- [x] Have you checked that there aren't other [open pull requests](https://github.com/Homebrew/homebrew-cask/pulls) for the same change?
- [x] Have you run `brew audit --new --strict --online --cask autobrew` locally?
- [x] Have you run `brew style --cask autobrew` locally?

## What is AutoBrew?

AutoBrew is a free, open-source macOS menu-bar app that automates
`brew update → brew outdated → policy-gated brew upgrade → brew
cleanup` for the user — and ships a full BrewStore GUI for browsing
the cask catalog plus an AppSnapshot engine that backs up an app's
user data before each upgrade so a broken update can be rolled back
in one click.

The app deploys to macOS 14 (Sonoma) and up, is signed with my
Developer ID, notarised, and distributed through GitHub releases.
Source code at https://github.com/marcelrgberger/auto-brew.

## Notability

The audit reports the standard "GitHub repository not notable enough"
warning. AutoBrew has been publicly released since March 2025 (v2.0.0)
with a steady release cadence, ships a meaningful user-facing
workflow that complements Homebrew itself (not a wrapper), and has
the same code-signing + notarisation hygiene as the other casks in
the catalog. I would appreciate your review on the substance even if
the star count is below the heuristic.
```

## After the PR merges

1. Update the project README so the recommended install path is
   `brew install --cask autobrew` directly (the personal tap becomes
   the fallback for pre-release channels only).
2. Optionally archive `marcelrgberger/homebrew-tap` once stable
   releases live upstream — keep it alive only for the test/beta
   pre-release tags.
3. Drop the "Bump Homebrew tap" step from `build-and-release.yml` —
   homebrew-cask's `livecheck` block + their `BrewTestBot` will
   handle version bumps automatically.
