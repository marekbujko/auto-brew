# TERMS OF USE

## AutoBrew

**Effective Date:** May 2026
**Last Updated:** May 2026

These Terms of Use ("Terms") govern your use of AutoBrew (the "Software"). Please read them carefully. By installing or using AutoBrew you agree to be bound by these Terms.

---

## 1. PROVIDER

The Software is published under the **DigitalFreedom** brand. The legal entity behind it is:

Berger & Rosenstock GbR (trading as DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Germany
Authorized Representatives: Marcel R. G. Berger, Jasmin Rosenstock
Email: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

These Terms apply globally. Mandatory consumer-protection and other statutory rights granted by the user's country of residence remain unaffected and prevail wherever they are more protective.

---

## 2. THE SOFTWARE

AutoBrew is a macOS menu-bar utility that automates Homebrew updates, browses the Homebrew cask catalog, and manages app snapshots for cross-Mac migration. It is:

- **Open source** under the MIT License — full source at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Free of charge** — no in-app purchases, no subscriptions, no paid tier, no trial period
- **Distributed directly** — notarized DMG from GitHub Releases and a Homebrew tap; not via the Apple App Store or the Google Play Store
- **Local-only** — runs entirely on your Mac, no AutoBrew account or backend service required (see the [Privacy Policy](PrivacyPolicy.md))

These Terms apply to the AutoBrew binary. The MIT licence (reproduced in the [EULA](EULA.md) and [Open-Source Licenses](OpenSourceLicenses.md)) governs the source code and any forks or derivatives.

---

## 3. LICENCE TO USE

Subject to your compliance with these Terms and the MIT licence, you may:

- Install, run, modify, and redistribute AutoBrew on any number of Macs you control
- Fork the source code and create derivative works under the MIT licence terms

You may not:

- Misrepresent the origin of the Software (the MIT licence requires the original copyright notice to be retained)
- Strip out the embedded Sparkle, bsdiff, sais-lite, or pdqsort licence notices when redistributing
- Use the **AutoBrew** name or the **DigitalFreedom** brand on derivative works without our written permission (trademark, see the [Trademark](Trademark.md) document)

---

## 4. NO ACCOUNT, NO PAYMENT (CURRENT STATE)

AutoBrew currently does not require registration, sign-up, or any payment. The **Sponsor** link inside the app routes to GitHub Sponsors and is **entirely voluntary** — any contribution is treated as a donation and creates no entitlement to features or support.

### 4.1 Reservation regarding future paid features

The Provider reserves the right to introduce optional **paid features**, **paid editions**, or **paid add-on services** in future versions of AutoBrew. Any such future paid offerings will:

- Be announced in advance via the application UI and the official release notes
- Apply only on a forward-looking basis — your right to keep using the current free version remains unaffected
- Leave the open-source core untouched: the source code at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) will continue to be available under the MIT Licence

The current absence of paid features does not constitute a guarantee that AutoBrew will remain free of paid features in every future release.

---

## 5. HOMEBREW DEPENDENCY

AutoBrew relies on a working Homebrew installation to fulfil its purpose. AutoBrew shells out to the `brew` binary and reads / writes data using the Homebrew project's own commands and conventions. We are not affiliated with the Homebrew project; we do not control which packages are available, when versions are released, or which cask publishers do what with their installers.

If a cask installation fails, behaves unexpectedly, or causes harm, that is between you and the cask publisher and/or the Homebrew project — see Section 7 (Disclaimer of Warranty) and Section 8 (Limitation of Liability).

---

## 6. UPDATES

AutoBrew uses the Sparkle framework to deliver in-app updates from the official AutoBrew appcast on GitHub. Updates are signed with an EdDSA Ed25519 key and verified before they are applied. Auto-updates can be disabled from Settings.

You are free to ignore in-app updates and update the binary via your Homebrew tap or by downloading a newer DMG manually.

---

## 7. DISCLAIMER OF WARRANTY

The Software is provided **"AS IS"** and **"AS AVAILABLE"** without warranty of any kind, express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement.

Without limiting the foregoing, we do not warrant that:

- The Software will be uninterrupted or error-free
- AutoBrew's interaction with Homebrew, with individual casks, or with macOS itself will always produce the desired result
- Snapshots created by AutoBrew will perfectly capture every aspect of an app's state — apps that store data outside the standard Library subdirectories may not be fully captured

Statutory warranty rights that cannot be excluded by contract under your local consumer-protection law (e.g. the German Mängelhaftung under §§ 434 ff. BGB, where applicable) remain unaffected.

---

## 8. LIMITATION OF LIABILITY

To the maximum extent permitted by applicable law:

- We are not liable for any indirect, incidental, consequential, exemplary, or punitive damages
- We are not liable for data loss, lost profits, business interruption, or any damage arising from third-party software (Homebrew, individual casks) invoked through AutoBrew

For users habitually resident in Germany or the EU, our liability for damage caused by **gross negligence or intentional misconduct**, for **injury to life, body or health**, and under **mandatory provisions of the German Product Liability Act (ProdHaftG)** remains unaffected.

---

## 9. TERMINATION

You may stop using AutoBrew at any time by uninstalling it. Removing AutoBrew and its support folder (`~/Library/Application Support/AutoBrew/`) returns your Mac to a state where no AutoBrew artefacts remain.

We may discontinue distributing AutoBrew at any time. Because the Software is open source under MIT, you and the community remain free to fork, build, and run it independently.

---

## 10. CHANGES TO THESE TERMS

We may update these Terms to reflect changes to the Software or applicable law. Material changes are communicated in the AutoBrew release notes. The "Last Updated" date at the top reflects the most recent revision.

---

## 11. GOVERNING LAW AND JURISDICTION

These Terms are governed by the laws of the Federal Republic of Germany, excluding the UN Convention on Contracts for the International Sale of Goods (CISG).

For consumers habitually resident outside Germany, the mandatory consumer-protection law of your country of residence applies in addition. The non-exclusive place of jurisdiction for disputes is Bad Nauheim, Germany; consumers may still sue at their domicile where local law allows it.

For consumer disputes arising under EU law, the European Commission's Online Dispute Resolution platform is available at https://ec.europa.eu/consumers/odr. We are not obliged and not willing to participate in alternative dispute-resolution proceedings before a Verbraucherschlichtungsstelle (consumer arbitration board) under § 36 VSBG.

---

## 12. CONTACT

Berger & Rosenstock GbR (trading as DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germany
Email: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
