# OPEN-SOURCE-LIZENZEN

## In AutoBrew verwendete Drittsoftware

**Zuletzt aktualisiert:** Mai 2026

AutoBrew selbst ist Open Source unter der MIT-Lizenz (siehe [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Dieses Dokument listet jede Drittkomponente auf, die innerhalb des AutoBrew-Anwendungsbundles ausgeliefert wird, sowie die Laufzeit-Abhängigkeiten, auf die AutoBrew zum Betrieb angewiesen ist.

Jede Komponente unterliegt ihrer eigenen Lizenz, die nachfolgend wiedergegeben oder referenziert ist. Wo eine Komponente selbst weiteren Drittcode bündelt (z. B. Sparkle), sind auch die verschachtelten Zuordnungen aufgeführt.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.1.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

Der vollständige Text der MIT-Lizenz ist in Abschnitt 5 wiedergegeben — er gilt sowohl für AutoBrew selbst als auch für die nachfolgend mit „MIT" gekennzeichneten Drittkomponenten.

---

## 2. Gebündelte Abhängigkeiten

Diese Komponenten werden in das AutoBrew-Anwendungsbundle eingebunden und mit der App ausgeliefert.

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

Sparkle selbst enthält die folgenden Drittkomponenten:

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

#### 2.1.4 SUDistributedUpdaterArguments (Sparkle-Helfer)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

Der vollständige Text der Sparkle-Lizenz sowie der von Sparkle gebündelten externen Lizenzen wird innerhalb des Frameworks unter `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE` ausgeliefert.

---

## 3. Laufzeit-Abhängigkeiten (extern)

Diese Komponenten werden **nicht** im AutoBrew-Bundle ausgeliefert. AutoBrew ruft sie zur Laufzeit über Prozessstart auf, sodass sie vom Nutzer separat installiert werden müssen. AutoBrew führt beim ersten Start durch die Installation von Homebrew.

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

Der Paketkatalog, den AutoBrew im BrewStore darstellt, wird von `formulae.brew.sh` ausgeliefert und vom Homebrew-Projekt betrieben.

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

## 4. Apple-Systemframeworks

AutoBrew bindet die folgenden Apple-Frameworks ein. Sie sind Bestandteil von macOS und unterliegen nach dem Apple SDK Agreement keiner gesonderten Attribution; sie sind hier vollständigkeitshalber aufgeführt:

- **SwiftUI** — UI-Framework
- **Foundation** — Basistypen, Datei-I/O, JSON
- **AppKit** — Menüleisten-Integration, `NSApp`, `NSWorkspace`
- **UserNotifications** — Banner für Abschluss- und Genehmigungshinweise
- **ServiceManagement** (`SMAppService`) — Anbindung „Beim Anmelden starten"
- **IOKit** — Idle-Zeit-Erkennung via `IOHIDSystem`
- **os.Logger** — einheitliches Logging
- **CryptoKit** — SHA-256-Hashing zur Integritätsprüfung von Snapshots

---

## 5. MIT-Lizenz (wortgetreu)

Die folgende MIT-Lizenz gilt für AutoBrew selbst sowie für jede oben mit „MIT" gekennzeichnete Komponente. Die Rechteinhaber unterscheiden sich je Komponente (vgl. Abschnitte 1 und 2 für die jeweiligen Vermerke).

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

## 6. BSD-2-Clause-Lizenz (wortgetreu)

Die folgende BSD-2-Clause-Lizenz gilt für `bsdiff` (in Sparkle gebündelt) und für Homebrew.

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

## 7. zlib-Lizenz (wortgetreu)

Die folgende zlib-Lizenz gilt für `pdqsort` (in Sparkle gebündelt).

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

## 8. Verfügbarkeit des Quellcodes

AutoBrew ist Open Source — der vollständige Quellcode befindet sich unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). Der Quellcode der gebündelten Abhängigkeiten ist unter den oben angegebenen Repository-URLs verfügbar.

Für Copyleft-Komponenten — derzeit für AutoBrew nicht einschlägig, aber grundsätzlich — können Quellcode-Anfragen an hello@digitalfreedom.co.za gerichtet werden und werden innerhalb von 30 Tagen erfüllt.

---

## 9. Pflichten des Nutzers bei Weitergabe

Bei einer Weitergabe von AutoBrew oder einer seiner gebündelten Komponenten muss der Nutzer:

- Die Urheberrechtsvermerke und Lizenztexte in den Abschnitten 1 bis 7 erhalten
- Die Texte der MIT-, BSD-2-Clause- und zlib-Lizenz zusammen mit der Binärdatei wiedergeben
- Die in `Sparkle.framework` ausgelieferte Sparkle-`LICENSE`-Datei nicht entfernen
- Die Attributionspflicht der BSD-2-Clause-Lizenz für `bsdiff` einhalten (sein Urheberrechtsvermerk muss Binärweitergaben beigefügt werden)

---

## 10. Meldung von Problemen

Sollten eine fehlende Attribution, ein unzutreffender Lizenzverweis oder eine aufgeführte Komponente, die AutoBrew nicht mehr nutzt, auffallen, kann unter [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) ein Issue eröffnet oder eine Nachricht an hello@digitalfreedom.co.za gesendet werden.

---

## 11. Kontakt

Berger & Rosenstock GbR (handelnd unter der Marke DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Deutschland
E-Mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Hinweis: Dieser Urheberrechtsvermerk bezieht sich auf dieses Dokument selbst; die aufgeführten Open-Source-Komponenten unterliegen ihren jeweiligen Lizenzen.*
