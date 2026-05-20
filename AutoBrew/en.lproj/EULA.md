# END USER LICENCE AGREEMENT (EULA)

## AutoBrew

**Effective Date:** May 2026
**Last Updated:** May 2026

This End User Licence Agreement ("EULA", "Agreement") is a legal contract between you ("User", "you") and the publisher of AutoBrew, **Berger & Rosenstock GbR** trading as **DigitalFreedom** ("Publisher", "we", "us", "our").

By installing, copying, or otherwise using AutoBrew (the "Software") you agree to be bound by the terms of this EULA.

---

## 1. THE SOFTWARE

AutoBrew is a macOS menu-bar utility that automates Homebrew updates, browses the Homebrew cask catalog, and manages app snapshots. It is published under the DigitalFreedom brand and licensed to you under the terms below.

### 1.1 Licence model

AutoBrew is released as **free open-source software** under the MIT Licence. The full text of the MIT Licence is reproduced in Section 6 and in the [Open-Source Licenses](OpenSourceLicenses.md) document. The MIT Licence governs the source code; this EULA covers binary distribution and your obligations as a user of the binary.

### 1.2 Reservation regarding future paid features

The Publisher reserves the right to introduce optional **paid features**, **paid editions**, or **paid add-on services** at any time. Any such future changes will:

- Be announced in advance via the application UI and the official release notes
- Apply only on a forward-looking basis (i.e. existing free functionality of a version you have already installed remains free to use)
- Leave the open-source core under the MIT Licence — the source code at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) stays available under the same licence regardless of any paid additions

The current absence of any paid feature does not constitute a guarantee that AutoBrew will remain free of paid features forever.

### 1.3 Open-source scope vs. paid features

The MIT Licence applies to the AutoBrew source code as published in the official repository at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Forks and derivatives of that codebase are explicitly permitted** under the MIT Licence terms — we welcome the community building on top of AutoBrew.

Any **future paid features**, **paid editions**, or **paid add-on services** (see Section 1.2) will be released under a **separate proprietary licence** and will **not** form part of the MIT-licensed codebase. In particular:

- The source code of paid features will not be published in the MIT repository
- Copying, decompiling, reverse-engineering, or otherwise reproducing the implementation of any proprietary paid feature shipped by AutoBrew is not permitted, except as expressly allowed by applicable mandatory law (e.g. § 69e UrhG / Art. 6 of EU Directive 2009/24/EC for interoperability)
- This restriction applies to the paid-feature implementation specifically — it does not restrict the right of any third party to develop comparable functionality independently and from scratch

The trademarks **"AutoBrew"** and **"DigitalFreedom"** may not be used by forks or derivatives that offer competing paid features — see Section 3 of this EULA and the [Trademark](Trademark.md) disclaimer.

### 1.2 Distribution channels

The official AutoBrew binary is distributed exclusively through:

- **GitHub Releases** at [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — notarized DMG files signed with the Apple Developer ID certificate
- The **Homebrew tap** at [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew is **not** distributed through the Apple App Store, the Google Play Store, or any third-party download portal. If you obtained AutoBrew from anywhere else, the binary is unverified and not covered by this EULA.

---

## 2. GRANT OF LICENCE

Subject to your compliance with this EULA and the MIT Licence, the Publisher grants you a worldwide, royalty-free, non-exclusive licence to:

- Install and run AutoBrew on any number of Macs you own or control
- Modify the source code and create derivative works
- Redistribute the Software in source or binary form

---

## 3. RESTRICTIONS

You may not:

- Remove, alter, or obscure the copyright notices, the MIT licence text, or the embedded Sparkle / bsdiff / sais-lite / pdqsort licence notices when redistributing
- Use the trademarks **"AutoBrew"** and **"DigitalFreedom"** in the name of a fork or derivative without our prior written consent (see the [Trademark](Trademark.md) document)
- Misrepresent your fork as the official AutoBrew distribution

---

## 4. THIRD-PARTY COMPONENTS

AutoBrew bundles the following open-source components, each governed by its own licence (see the [Open-Source Licenses](OpenSourceLicenses.md) document for the full list and the verbatim licence texts):

- **Sparkle** (MIT) — in-app auto-updates
- **bsdiff / bspatch** (BSD-2-Clause) — bundled inside Sparkle for binary deltas
- **sais-lite** (MIT) — bundled inside Sparkle
- **pdqsort** (zlib) — bundled inside Sparkle

AutoBrew also relies at runtime on **Homebrew** (BSD-2-Clause) — invoked via process spawning, not embedded. Homebrew must be installed separately; AutoBrew will guide you through its installation on first launch.

The MIT, BSD-2-Clause, and zlib licences applicable to these components remain in force independently of this EULA. In the event of conflict between this EULA and an open-source licence, the open-source licence prevails for the affected component.

---

## 5. NO PAYMENT, NO ACCOUNT (CURRENT STATE)

AutoBrew is currently free of charge. The Software does not require registration, sign-up, or any payment, and at the time of this EULA there are no in-app purchases, no subscriptions, no paid features, and no trial mechanics.

The **Sponsor** link inside AutoBrew routes to GitHub Sponsors and is **entirely voluntary**. Any contribution is treated as a donation and confers no additional entitlements.

**Reservation:** See Section 1.2 — the Publisher reserves the right to introduce optional paid features, paid editions, or paid add-on services in the future. Any such future paid offerings will only apply to users who explicitly opt in; the current free functionality you have installed will not be retroactively gated.

---

## 6. MIT LICENCE (verbatim)

```
Copyright (c) 2026 Marcel R. G. Berger

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

---

## 7. DISCLAIMER OF WARRANTY

The Software is provided **"AS IS"** without warranty of any kind, express or implied. The Publisher does not warrant that the Software will be uninterrupted or error-free, that AutoBrew's interaction with Homebrew or with individual casks will always succeed, or that snapshots will perfectly capture every aspect of an application's state.

Statutory warranty rights that cannot be excluded by contract under your local consumer-protection law (e.g. the German Mängelhaftung under §§ 434 ff. BGB, where applicable) remain unaffected.

---

## 8. LIMITATION OF LIABILITY

To the maximum extent permitted by applicable law, the Publisher is not liable for any indirect, incidental, consequential, exemplary, or punitive damages — including data loss, lost profits, or damage arising from third-party software (Homebrew, individual casks) invoked through AutoBrew.

For users habitually resident in Germany or the EU, our liability for damage caused by **gross negligence or intentional misconduct**, for **injury to life, body or health**, and under the **German Product Liability Act (ProdHaftG)** remains unaffected.

---

## 9. EXPORT CONTROL

The Software contains no cryptography beyond what Apple's macOS and the Sparkle framework provide by default. The export of macOS itself is governed by Apple's terms; you remain responsible for compliance with export-control laws applicable to your jurisdiction.

---

## 10. TERMINATION

This EULA is effective until terminated. It terminates automatically without notice if you fail to comply with any of its terms. You may also terminate it at any time by uninstalling AutoBrew. Upon termination you must cease all use of the Software and remove all copies in your control.

---

## 11. GOVERNING LAW AND JURISDICTION

This EULA is governed by the laws of the Federal Republic of Germany, excluding the UN Convention on Contracts for the International Sale of Goods (CISG). Mandatory consumer-protection law of the user's country of residence applies in addition.

The non-exclusive place of jurisdiction is Bad Nauheim, Germany. Consumers may sue at their domicile where local law allows it.

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
