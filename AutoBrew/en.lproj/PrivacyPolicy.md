# PRIVACY POLICY

## AutoBrew

**Effective Date:** May 2026
**Last Updated:** May 2026

**Service operated by:** DigitalFreedom — a brand of Berger & Rosenstock GbR

**Data Controller (legal entity):**
Berger & Rosenstock GbR (trading as DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germany

Authorized Representatives: Marcel R. G. Berger, Jasmin Rosenstock
VAT-ID: DE455096022

Contact (general): hello@digitalfreedom.co.za
Contact (data protection): data-protection@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

## 1. INTRODUCTION

This Privacy Policy explains how DigitalFreedom (a brand of Berger & Rosenstock GbR — "we", "us", "our") handles data in connection with the AutoBrew application ("AutoBrew", "the Software").

AutoBrew is **open source under the MIT License**, **completely free**, and distributed directly as a notarized DMG and via a Homebrew tap — not through the Apple App Store or the Google Play Store. We do not run a backend, do not host user accounts, and do not collect, transmit, store or process any personal data on our servers.

We adopt the European Union General Data Protection Regulation (GDPR) as the strictest baseline and apply it as a global floor — the protections below apply to every user, regardless of country.

---

## 2. ZERO DATA COLLECTION

**We do not collect any personal data.**

AutoBrew runs entirely on your Mac. There is no AutoBrew account, no telemetry, no analytics, no crash reporter, no remote configuration. Because we do not process personal data under our control, most operator-side GDPR obligations (international-transfer paperwork, processor agreements, breach notification on our side) do not apply to us as the publisher of the Software. Section 6 nonetheless describes the rights available to you under applicable law.

---

## 3. DATA STORED LOCALLY ON YOUR DEVICE

AutoBrew stores the following data locally. **None of this leaves your Mac unless you choose to share it.**

### 3.1 Settings (UserDefaults)

- Trigger mode (idle / scheduled)
- Idle threshold (minutes) and scheduled time
- Last-run timestamp
- Launch-at-login preference
- Notification preference
- Snapshot retention settings
- Update-policy defaults (patch/minor/major × cask/formula) and per-package overrides
- Onboarding state

### 3.2 Update Policy State (Application Support)

- `UpdateLedger.json` — when each `(kind, token, version)` first appeared as outdated, so the cool-off window can be measured. Tokens are Homebrew package names; no user identifiers.
- `PendingUpdates.json` — major-update entries awaiting your decision (approve / reject).

### 3.3 Icon Cache (Application Support)

- Cached PNGs of cask icons fetched via the iTunes Search API (anonymous lookup by app name) and icon.horse as a fallback. Stored under `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 App Snapshots (Application Support)

- ZIP-bundled copies of `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers`, etc. for apps you explicitly snapshot. Stored under `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Logs (os.Logger)

- Diagnostic events written via the unified Apple logging system. Visible in Console.app. Not transmitted anywhere.

You can delete all locally stored data by removing AutoBrew, its support folder (`~/Library/Application Support/AutoBrew/`), and its UserDefaults plist (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. NETWORK ACTIVITY

AutoBrew makes outbound requests in three situations. None of them transmit personal data.

### 4.1 Homebrew package operations

AutoBrew shells out to the `brew` binary you installed locally. The Homebrew project then contacts `formulae.brew.sh`, GitHub, CDN mirrors, and individual cask download URLs. We have no relationship with those endpoints — they are operated by the Homebrew project and the respective cask publishers under their own privacy terms.

### 4.2 Cask catalog and icon resolution

- `formulae.brew.sh/api/cask.json` — anonymous fetch of the public cask catalog
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — anonymous fetch of 365-day install statistics
- `itunes.apple.com/search` — anonymous lookup of macOS app icons by display name
- `icon.horse` — fallback favicon lookup based on the cask's `homepage` URL

### 4.3 Auto-update check

Sparkle periodically contacts the AutoBrew appcast URL on GitHub to check for new AutoBrew releases. The request contains your macOS version and the AutoBrew version (standard `User-Agent`), no further identifiers.

---

## 5. THIRD-PARTY SERVICES (NOT SUB-PROCESSORS)

We do not engage sub-processors because we do not process your data. The third-party services AutoBrew talks to act independently and on their own terms:

| Service | Purpose | Operator |
|---|---|---|
| Homebrew + formulae.brew.sh | Package management and catalog | Homebrew project |
| Apple iTunes Search API | App icon lookup | Apple Inc. |
| icon.horse | Favicon fallback | icon.horse |
| GitHub (appcast, releases) | Distribution + update channel | GitHub, Inc. |

When you click a Sponsor link inside AutoBrew, you leave the app and your browser hits GitHub Sponsors — that interaction is governed by GitHub's privacy policy.

---

## 6. YOUR RIGHTS

Because we do not store personal data on our servers, the access / rectification / erasure / portability / objection / restriction rights under GDPR Articles 15–22 and equivalent local laws are effectively satisfied by deleting AutoBrew from your Mac.

You may still contact us at **data-protection@digitalfreedom.co.za** if you have questions about this policy.

You may complain to your competent data-protection authority. In Germany this is the Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). The EU lists national authorities at https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. CHILDREN

AutoBrew is a developer utility for macOS. It is not directed at children under 16. We do not collect personal data, so we do not process children's data either.

---

## 8. SECURITY

- The application binary is signed with the Apple Developer ID certificate and notarized by Apple.
- Auto-updates are verified against an EdDSA Ed25519 signature before they are applied.
- AutoBrew runs under Hardened Runtime; direct-distribution apps that talk to system tools cannot use full App Sandbox without breaking the use case, so we ship the minimum entitlements required.
- Source code is publicly auditable at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. INTERNATIONAL TRANSFERS

We do not transfer personal data because we do not collect it. The third-party services you reach through AutoBrew (Homebrew project servers, Apple, icon.horse, GitHub) may operate outside the EU; transfers to those services are between you and them, not us.

---

## 10. CHANGES TO THIS POLICY

We may update this Privacy Policy to reflect changes to AutoBrew's architecture or to applicable law. The "Last Updated" date at the top reflects the most recent revision. Material changes are communicated in the AutoBrew release notes.

### 10.1 Future paid features

AutoBrew is currently free of charge and operates without any backend (see Section 2). The Publisher reserves the right to introduce optional **paid features**, **paid editions**, or **paid add-on services** in future versions, which may require limited data processing (for example payment handling via a third-party provider, or a licence-key check). Any such change will be:

- Announced in advance in the AutoBrew release notes and in this Privacy Policy
- Strictly opt-in — the free, zero-data version remains usable
- Documented in a dedicated section of this Privacy Policy before any new data flow is enabled

The current "zero data collection" statement applies to the present version of AutoBrew. It is not a perpetual guarantee for every future release; we will keep this Policy current so it always describes the actual behaviour.

---

## 11. CONTACT

For data-protection inquiries:
**data-protection@digitalfreedom.co.za**

For everything else:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (trading as DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germany
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
