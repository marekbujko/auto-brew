# OPEN-SOURCE LICENSES

## Third-Party Software Used in AutoBrew

**Last Updated:** May 2026

AutoBrew itself is open source under the MIT License (see [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). This document lists every third-party component that ships inside the AutoBrew application bundle, plus the runtime dependencies AutoBrew relies on to operate.

Each component is governed by its own licence, reproduced or referenced below. Where a component itself bundles further third-party code (e.g. Sparkle), the nested attributions are listed too.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.2.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

The full MIT licence text is reproduced in section 5 — it applies to AutoBrew as well as to the third-party components labelled "MIT".

---

## 2. Bundled Dependencies

These components are linked into the AutoBrew application bundle and ship with the app.

### 2.1 Sparkle

```
Component:   Sparkle
Version:     2.9.0
License:     MIT
Copyright:   Copyright (c) 2006-2013 Andy Matuschak
             Copyright (c) 2009-2013 Elgato Systems GmbH
             Copyright (c) 2011-2014 Kornel Lesiński
             Copyright (c) 2015-2017 Mayur Pawashe
             Copyright (c) 2014 C.W. Betts
             Copyright (c) 2014 Petroules Corporation
             Copyright (c) 2014 Big Nerd Ranch
Repository:  https://github.com/sparkle-project/Sparkle
Used for:    In-app auto-updates for the direct-distribution build
             (EdDSA-signed appcast served from the GitHub repository).
```

Sparkle itself includes the following third-party components:

#### 2.1.1 bsdiff / bspatch

```
Component:   bsdiff 4.3
License:     BSD-2-Clause
Copyright:   Copyright 2003-2005 Colin Percival
Source:      http://www.daemonology.net/bsdiff/
Used in Sparkle for: binary delta updates.
```

#### 2.1.2 sais-lite

```
Component:   sais-lite (2010-08-07)
License:     MIT
Copyright:   Copyright (c) 2008-2010 Yuta Mori
Source:      https://sites.google.com/site/yuta256/sais
Used in Sparkle for: suffix-array construction during bsdiff.
```

#### 2.1.3 pdqsort

```
Component:   pdqsort
License:     zlib
Copyright:   Copyright (c) 2015 Orson Peters
Source:      https://github.com/orlp/pdqsort
Used in Sparkle for: sorting helpers in the delta pipeline.
```

#### 2.1.4 SUDistributedUpdaterArguments (Sparkle helper)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

The full text of the Sparkle licence and its bundled external licences is shipped inside the framework at `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Runtime Dependencies (External)

These components are **not** shipped inside the AutoBrew bundle. AutoBrew invokes them at runtime via process spawning, so they have to be installed separately by the user. AutoBrew guides through Homebrew installation on first launch.

### 3.1 Homebrew

```
Component:   Homebrew
License:     BSD-2-Clause
Copyright:   Copyright (c) 2009-present Homebrew contributors
Repository:  https://github.com/Homebrew/brew
Used by AutoBrew for:
             - `brew update` to refresh the package index
             - `brew upgrade` and `brew upgrade --cask` for installs
             - `brew outdated --json=v2` to detect available updates
             - `brew install --cask <token>` for direct install requests
             - `brew search` to recover renamed casks during restore
             - `brew cleanup --prune=7` for periodic housekeeping
```

The package catalog AutoBrew renders in the BrewStore is served by `formulae.brew.sh`, run by the Homebrew project.

### 3.2 iTunes Search API (Apple)

```
Service:     iTunes Search API
Operator:    Apple Inc.
Used by AutoBrew for:
             Best-effort lookup of macOS app icons by display name,
             served as cached PNGs in the BrewStore. Anonymous —
             no user identifiers are sent.
```

### 3.3 icon.horse

```
Service:     icon.horse
Used by AutoBrew for:
             Fallback favicon resolution for casks whose `homepage`
             URL is set, after iTunes Search returns no match. Anonymous.
Endpoint:    https://icon.horse
```

---

## 4. Apple System Frameworks

AutoBrew links against the following Apple frameworks. They are part of macOS and not subject to separate attribution under the Apple SDK Agreement; they are listed here for completeness:

- **SwiftUI** — UI framework
- **Foundation** — base types, file I/O, JSON
- **AppKit** — menu-bar integration, `NSApp`, `NSWorkspace`
- **UserNotifications** — completion and pending-approval banners
- **ServiceManagement** (`SMAppService`) — Launch-at-Login wiring
- **IOKit** — idle-time detection via `IOHIDSystem`
- **os.Logger** — unified logging
- **CryptoKit** — SHA-256 hashing for snapshot integrity

---

## 5. MIT Licence (verbatim)

The MIT licence below applies to AutoBrew itself and to every component above that is labelled "MIT". The copyright holders differ per component (see sections 1 and 2 for the relevant notices).

```
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

## 6. BSD-2-Clause Licence (verbatim)

The BSD-2-Clause licence below applies to `bsdiff` (bundled inside Sparkle) and to Homebrew.

```
Redistribution and use in source and binary forms, with or without
modification, are permitted providing that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```

---

## 7. zlib Licence (verbatim)

The zlib licence below applies to `pdqsort` (bundled inside Sparkle).

```
This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not
   be misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
```

---

## 8. Source Code Availability

AutoBrew is open source — the full source code lives at [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). Source code for the bundled dependencies is available at the repository URLs listed above.

For copyleft components — none currently apply to AutoBrew, but in principle — source-code requests can be sent to hello@digitalfreedom.co.za and will be fulfilled within 30 days.

---

## 9. Your Obligations When Redistributing

If you redistribute AutoBrew or any of its bundled components, you must:

- Retain the copyright notices and licence texts in sections 1 through 7
- Reproduce the MIT, BSD-2-Clause, and zlib licence texts alongside the binary
- Not remove the Sparkle `LICENSE` file shipped inside `Sparkle.framework`
- Comply with the BSD-2-Clause attribution requirement for `bsdiff` (its copyright notice must accompany binary redistributions)

---

## 10. Reporting Issues

If you spot a missing attribution, an incorrect licence reference, or a component listed that AutoBrew no longer uses, please open an issue at [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) or email hello@digitalfreedom.co.za.

---

## 11. Contact

Berger & Rosenstock GbR (trading as DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germany
Email: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Note: This copyright notice covers this document itself; the listed open-source components are subject to their respective licences.*
