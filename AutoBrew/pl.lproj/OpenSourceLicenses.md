# LICENCJE OPEN-SOURCE

## Oprogramowanie stron trzecich używane w AutoBrew

**Ostatnia aktualizacja:** maj 2026

Sam AutoBrew jest open source na licencji MIT (patrz [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Niniejszy dokument wymienia każdy komponent stron trzecich, który jest dostarczany wewnątrz pakietu aplikacji AutoBrew, oraz zależności środowiska uruchomieniowego, na których AutoBrew polega w działaniu.

Każdy komponent podlega własnej licencji, powtórzonej lub przywołanej poniżej. Tam, gdzie komponent sam dołącza dalszy kod stron trzecich (np. Sparkle), wymienione są również zagnieżdżone atrybucje.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.1.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

Pełny tekst licencji MIT jest powtórzony w sekcji 5 — obowiązuje on dla AutoBrew oraz dla komponentów stron trzecich oznaczonych jako „MIT".

---

## 2. Dołączone zależności

Komponenty te są linkowane do pakietu aplikacji AutoBrew i dostarczane wraz z aplikacją.

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

Sparkle sam zawiera następujące komponenty stron trzecich:

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

#### 2.1.4 SUDistributedUpdaterArguments (pomocnik Sparkle)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

Pełny tekst licencji Sparkle oraz jego dołączonych licencji zewnętrznych jest dostarczany wewnątrz frameworku pod adresem `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Zależności środowiska uruchomieniowego (zewnętrzne)

Komponenty te **nie są** dostarczane wewnątrz pakietu AutoBrew. AutoBrew wywołuje je w czasie wykonywania poprzez uruchomienie procesu, więc muszą zostać zainstalowane oddzielnie przez użytkownika. AutoBrew przeprowadza przez instalację Homebrew przy pierwszym uruchomieniu.

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

Katalog pakietów, który AutoBrew wyświetla w BrewStore, jest serwowany przez `formulae.brew.sh`, prowadzony przez projekt Homebrew.

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

## 4. Frameworki systemowe Apple

AutoBrew linkuje się z następującymi frameworkami Apple. Stanowią one część macOS i nie podlegają odrębnej atrybucji zgodnie z umową Apple SDK; są wymienione tutaj dla kompletności:

- **SwiftUI** — framework UI
- **Foundation** — typy bazowe, I/O plików, JSON
- **AppKit** — integracja z paskiem menu, `NSApp`, `NSWorkspace`
- **UserNotifications** — bannery ukończenia i oczekującego zatwierdzenia
- **ServiceManagement** (`SMAppService`) — okablowanie uruchamiania przy logowaniu
- **IOKit** — wykrywanie czasu bezczynności poprzez `IOHIDSystem`
- **os.Logger** — ujednolicone logowanie
- **CryptoKit** — hashowanie SHA-256 dla integralności migawek

---

## 5. Licencja MIT (dosłownie)

Poniższa licencja MIT obowiązuje dla AutoBrew oraz dla każdego z powyższych komponentów oznaczonego jako „MIT". Posiadacze praw autorskich różnią się w zależności od komponentu (patrz sekcje 1 i 2 dla odpowiednich not).

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

## 6. Licencja BSD-2-Clause (dosłownie)

Poniższa licencja BSD-2-Clause obowiązuje dla `bsdiff` (dołączonego wewnątrz Sparkle) oraz dla Homebrew.

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

## 7. Licencja zlib (dosłownie)

Poniższa licencja zlib obowiązuje dla `pdqsort` (dołączonego wewnątrz Sparkle).

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

## 8. Dostępność kodu źródłowego

AutoBrew jest open source — pełny kod źródłowy znajduje się pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). Kod źródłowy dla dołączonych zależności jest dostępny pod adresami URL repozytoriów wymienionych powyżej.

Dla komponentów typu copyleft — żaden obecnie nie ma zastosowania do AutoBrew, ale co do zasady — żądania kodu źródłowego można wysyłać na hello@digitalfreedom.co.za i zostaną zrealizowane w ciągu 30 dni.

---

## 9. Państwa obowiązki przy redystrybucji

Jeśli redystrybuują Państwo AutoBrew lub którykolwiek z jego dołączonych komponentów, muszą Państwo:

- Zachować noty copyright i teksty licencji w sekcjach od 1 do 7
- Powielić teksty licencji MIT, BSD-2-Clause i zlib obok pliku binarnego
- Nie usuwać pliku `LICENSE` Sparkle dostarczanego wewnątrz `Sparkle.framework`
- Przestrzegać wymogu atrybucji BSD-2-Clause dla `bsdiff` (jego nota copyright musi towarzyszyć redystrybucji binarnej)

---

## 10. Zgłaszanie problemów

Jeśli zauważą Państwo brakującą atrybucję, błędne odniesienie do licencji lub wymieniony komponent, którego AutoBrew już nie używa, prosimy o otwarcie zgłoszenia pod adresem [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) lub wysłanie wiadomości na hello@digitalfreedom.co.za.

---

## 11. Kontakt

Berger & Rosenstock GbR (działająca jako DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Niemcy
E-mail: hello@digitalfreedom.co.za
Strona internetowa: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Uwaga: Niniejsza nota copyright obejmuje sam ten dokument; wymienione komponenty open-source podlegają swoim odpowiednim licencjom.*
