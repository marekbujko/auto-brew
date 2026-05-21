# LICENZE OPEN SOURCE

## Software di Terze Parti Utilizzato in AutoBrew

**Ultimo aggiornamento:** Maggio 2026

AutoBrew è esso stesso open source con licenza MIT (vedere [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Il presente documento elenca ogni componente di terze parti distribuito all'interno del bundle dell'applicazione AutoBrew, oltre alle dipendenze runtime su cui AutoBrew si basa per funzionare.

Ciascun componente è disciplinato dalla propria licenza, riprodotta o richiamata di seguito. Laddove un componente includa a sua volta ulteriore codice di terze parti (ad esempio Sparkle), sono elencate anche le attribuzioni nidificate.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.2.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

Il testo integrale della licenza MIT è riprodotto nella sezione 5 — si applica ad AutoBrew nonché ai componenti di terze parti contrassegnati come "MIT".

---

## 2. Dipendenze Incluse

Questi componenti sono collegati al bundle dell'applicazione AutoBrew e vengono distribuiti con l'app.

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

Sparkle include a sua volta i seguenti componenti di terze parti:

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

#### 2.1.4 SUDistributedUpdaterArguments (helper di Sparkle)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

Il testo integrale della licenza di Sparkle e delle licenze esterne incluse è distribuito all'interno del framework in `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Dipendenze Runtime (Esterne)

Questi componenti **non** vengono distribuiti all'interno del bundle di AutoBrew. AutoBrew li invoca a runtime tramite spawn di processi, quindi devono essere installati separatamente dall'utente. AutoBrew guida nell'installazione di Homebrew al primo avvio.

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

Il catalogo dei pacchetti che AutoBrew visualizza nel BrewStore è servito da `formulae.brew.sh`, gestito dal progetto Homebrew.

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

## 4. Framework di Sistema Apple

AutoBrew si collega ai seguenti framework Apple. Essi fanno parte di macOS e non sono soggetti a un'attribuzione separata ai sensi dell'Apple SDK Agreement; sono elencati qui per completezza:

- **SwiftUI** — framework UI
- **Foundation** — tipi base, I/O su file, JSON
- **AppKit** — integrazione nella barra dei menu, `NSApp`, `NSWorkspace`
- **UserNotifications** — banner di completamento e di richieste in attesa
- **ServiceManagement** (`SMAppService`) — integrazione dell'Avvio al Login
- **IOKit** — rilevamento del tempo di inattività tramite `IOHIDSystem`
- **os.Logger** — logging unificato
- **CryptoKit** — hashing SHA-256 per l'integrità degli snapshot

---

## 5. Licenza MIT (testo integrale)

La licenza MIT riportata di seguito si applica ad AutoBrew stesso e a ogni componente sopra contrassegnato come "MIT". I titolari del copyright variano per ciascun componente (vedere le sezioni 1 e 2 per i relativi avvisi).

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

## 6. Licenza BSD-2-Clause (testo integrale)

La licenza BSD-2-Clause riportata di seguito si applica a `bsdiff` (incluso in Sparkle) e a Homebrew.

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

## 7. Licenza zlib (testo integrale)

La licenza zlib riportata di seguito si applica a `pdqsort` (incluso in Sparkle).

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

## 8. Disponibilità del Codice Sorgente

AutoBrew è open source — il codice sorgente completo è disponibile su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). Il codice sorgente delle dipendenze incluse è disponibile agli URL dei repository elencati sopra.

Per i componenti copyleft — al momento nessuno si applica ad AutoBrew, ma in linea di principio — le richieste di codice sorgente possono essere inviate a hello@digitalfreedom.co.za e saranno evase entro 30 giorni.

---

## 9. Obblighi in Caso di Ridistribuzione

Chi ridistribuisce AutoBrew o uno qualsiasi dei suoi componenti inclusi deve:

- Conservare gli avvisi di copyright e i testi delle licenze nelle sezioni da 1 a 7
- Riprodurre i testi delle licenze MIT, BSD-2-Clause e zlib insieme al binario
- Non rimuovere il file `LICENSE` di Sparkle distribuito all'interno di `Sparkle.framework`
- Rispettare l'obbligo di attribuzione BSD-2-Clause per `bsdiff` (il suo avviso di copyright deve accompagnare le ridistribuzioni binarie)

---

## 10. Segnalazione di Problemi

Qualora venga rilevata un'attribuzione mancante, un riferimento di licenza errato o un componente elencato che AutoBrew non utilizza più, La preghiamo di aprire una segnalazione su [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) o di scrivere a hello@digitalfreedom.co.za.

---

## 11. Contatti

Berger & Rosenstock GbR (operante come DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germania
Email: hello@digitalfreedom.co.za
Sito web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Nota: il presente avviso di copyright si riferisce al documento stesso; i componenti open source elencati sono soggetti alle rispettive licenze.*
