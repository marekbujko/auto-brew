# LICENCIAS DE CÓDIGO ABIERTO

## Software de terceros utilizado en AutoBrew

**Última actualización:** Mayo de 2026

AutoBrew es a su vez código abierto bajo la Licencia MIT (véase [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). El presente documento enumera todos los componentes de terceros que se incluyen dentro del paquete de la aplicación AutoBrew, además de las dependencias en tiempo de ejecución de las que AutoBrew depende para funcionar.

Cada componente se rige por su propia licencia, reproducida o referenciada a continuación. Cuando un componente integre a su vez código adicional de terceros (por ejemplo, Sparkle), también se enumeran las atribuciones anidadas.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.1.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

El texto completo de la Licencia MIT se reproduce en la sección 5 — se aplica a AutoBrew, así como a los componentes de terceros etiquetados como «MIT».

---

## 2. Dependencias integradas

Estos componentes se enlazan dentro del paquete de la aplicación AutoBrew y se distribuyen con la aplicación.

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

Sparkle incluye a su vez los siguientes componentes de terceros:

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

El texto completo de la licencia de Sparkle y de sus licencias externas integradas se distribuye dentro del framework en `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Dependencias en tiempo de ejecución (externas)

Estos componentes **no** se incluyen dentro del paquete de AutoBrew. AutoBrew los invoca en tiempo de ejecución mediante el lanzamiento de procesos, por lo que el usuario debe instalarlos por separado. AutoBrew guía en la instalación de Homebrew en el primer arranque.

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

El catálogo de paquetes que AutoBrew renderiza en BrewStore es servido por `formulae.brew.sh`, operado por el proyecto Homebrew.

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

## 4. Frameworks del sistema Apple

AutoBrew enlaza con los siguientes frameworks de Apple. Forman parte de macOS y no están sujetos a atribución separada conforme al Apple SDK Agreement; se enumeran aquí por completitud:

- **SwiftUI** — framework de UI
- **Foundation** — tipos base, E/S de archivos, JSON
- **AppKit** — integración con la barra de menús, `NSApp`, `NSWorkspace`
- **UserNotifications** — banners de finalización y de aprobación pendiente
- **ServiceManagement** (`SMAppService`) — cableado del inicio al iniciar sesión
- **IOKit** — detección de inactividad mediante `IOHIDSystem`
- **os.Logger** — registro unificado
- **CryptoKit** — hashing SHA-256 para la integridad de los snapshots

---

## 5. Licencia MIT (verbatim)

La Licencia MIT que figura a continuación se aplica al propio AutoBrew y a todos los componentes anteriores etiquetados como «MIT». Los titulares del copyright difieren por componente (véanse las secciones 1 y 2 para los avisos pertinentes).

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

## 6. Licencia BSD-2-Clause (verbatim)

La licencia BSD-2-Clause que figura a continuación se aplica a `bsdiff` (integrado en Sparkle) y a Homebrew.

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

## 7. Licencia zlib (verbatim)

La licencia zlib que figura a continuación se aplica a `pdqsort` (integrado en Sparkle).

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

## 8. Disponibilidad del código fuente

AutoBrew es código abierto — el código fuente completo se aloja en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). El código fuente de las dependencias integradas está disponible en las URL de repositorio indicadas anteriormente.

Para los componentes copyleft — actualmente ninguno se aplica a AutoBrew, pero, en principio — las solicitudes de código fuente pueden enviarse a hello@digitalfreedom.co.za y se atenderán en un plazo de 30 días.

---

## 9. Sus obligaciones al redistribuir

Si redistribuye AutoBrew o cualquiera de sus componentes integrados, deberá:

- Conservar los avisos de copyright y los textos de licencia de las secciones 1 a 7
- Reproducir los textos de las licencias MIT, BSD-2-Clause y zlib junto con el binario
- No eliminar el archivo `LICENSE` de Sparkle que se distribuye dentro de `Sparkle.framework`
- Cumplir el requisito de atribución BSD-2-Clause para `bsdiff` (su aviso de copyright debe acompañar a las redistribuciones binarias)

---

## 10. Notificación de incidencias

Si detecta una atribución faltante, una referencia de licencia incorrecta o un componente enumerado que AutoBrew ya no utiliza, abra una incidencia en [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) o escriba a hello@digitalfreedom.co.za.

---

## 11. Contacto

Berger & Rosenstock GbR (operando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemania
Correo electrónico: hello@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Nota: este aviso de copyright cubre el presente documento; los componentes de código abierto enumerados están sujetos a sus respectivas licencias.*
