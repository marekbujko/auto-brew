# OPEN-SOURCE-LICENTIES

## Software van derden gebruikt in AutoBrew

**Laatst bijgewerkt:** mei 2026

AutoBrew is zelf open source onder de MIT-licentie (zie [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Dit document vermeldt elke component van derden die in de AutoBrew-applicatiebundel meekomt, plus de runtime-afhankelijkheden waarop AutoBrew voor zijn werking vertrouwt.

Elke component is onderworpen aan een eigen licentie, hieronder weergegeven of waarnaar wordt verwezen. Wanneer een component zelf nog meer code van derden bundelt (bijvoorbeeld Sparkle), worden de geneste attributies ook vermeld.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.2.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

De volledige tekst van de MIT-licentie is opgenomen in paragraaf 5 — zij is van toepassing op AutoBrew zelf en op iedere component hieronder met het label "MIT".

---

## 2. Gebundelde afhankelijkheden

Deze componenten worden in de AutoBrew-applicatiebundel meegekoppeld en worden met de app meegeleverd.

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

Sparkle bevat zelf de volgende componenten van derden:

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

#### 2.1.4 SUDistributedUpdaterArguments (Sparkle-helper)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

De volledige tekst van de Sparkle-licentie en de bijbehorende externe licenties wordt binnen het framework meegeleverd op `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Runtime-afhankelijkheden (extern)

Deze componenten worden **niet** in de AutoBrew-bundel meegeleverd. AutoBrew roept ze tijdens runtime aan via process spawning, dus moeten ze afzonderlijk door de gebruiker worden geïnstalleerd. AutoBrew begeleidt u bij de installatie van Homebrew tijdens het eerste gebruik.

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

De pakketcatalogus die AutoBrew in de BrewStore weergeeft, wordt aangeboden door `formulae.brew.sh`, geëxploiteerd door het Homebrew-project.

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

## 4. Apple-systeemframeworks

AutoBrew koppelt aan de volgende Apple-frameworks. Zij maken deel uit van macOS en zijn op grond van de Apple SDK Agreement niet aan afzonderlijke attributie onderworpen; ze worden hier voor de volledigheid genoemd:

- **SwiftUI** — UI-framework
- **Foundation** — basistypes, bestands-I/O, JSON
- **AppKit** — integratie van de menubalk, `NSApp`, `NSWorkspace`
- **UserNotifications** — banners voor voltooiing en hangende goedkeuring
- **ServiceManagement** (`SMAppService`) — koppeling voor starten bij inloggen
- **IOKit** — detectie van inactieve tijd via `IOHIDSystem`
- **os.Logger** — unified logging
- **CryptoKit** — SHA-256-hashing voor snapshot-integriteit

---

## 5. MIT-licentie (letterlijk)

De onderstaande MIT-licentie is van toepassing op AutoBrew zelf en op iedere bovenstaande component met het label "MIT". De auteursrechthouders verschillen per component (zie paragrafen 1 en 2 voor de betreffende vermeldingen).

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

## 6. BSD-2-Clause-licentie (letterlijk)

De onderstaande BSD-2-Clause-licentie is van toepassing op `bsdiff` (gebundeld in Sparkle) en op Homebrew.

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

## 7. zlib-licentie (letterlijk)

De onderstaande zlib-licentie is van toepassing op `pdqsort` (gebundeld in Sparkle).

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

## 8. Beschikbaarheid van broncode

AutoBrew is open source — de volledige broncode staat op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). De broncode van de gebundelde afhankelijkheden is beschikbaar op de hierboven vermelde repository-URL's.

Voor copyleft-componenten — momenteel niet van toepassing op AutoBrew, maar in beginsel — kunnen verzoeken om broncode worden gestuurd naar hello@digitalfreedom.co.za en zullen binnen 30 dagen worden ingewilligd.

---

## 9. Uw verplichtingen bij herdistributie

Indien u AutoBrew of een van de gebundelde componenten herdistribueert, dient u:

- De auteursrechtmeldingen en licentieteksten uit de paragrafen 1 tot en met 7 te behouden
- De teksten van de MIT-, BSD-2-Clause- en zlib-licenties bij het binair te reproduceren
- Het Sparkle-`LICENSE`-bestand dat in `Sparkle.framework` wordt meegeleverd niet te verwijderen
- De attributievereiste van BSD-2-Clause voor `bsdiff` na te leven (de bijbehorende auteursrechtmelding moet bij binaire herdistributies meekomen)

---

## 10. Problemen melden

Indien u een ontbrekende attributie, een onjuiste licentieverwijzing of een vermelde component aantreft die AutoBrew niet langer gebruikt, open dan een issue op [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) of stuur een e-mail naar hello@digitalfreedom.co.za.

---

## 11. Contact

Berger & Rosenstock GbR (handelend onder de naam DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Duitsland
E-mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Opmerking: deze auteursrechtmelding heeft betrekking op dit document zelf; de vermelde open-source-componenten zijn onderworpen aan hun respectieve licenties.*
