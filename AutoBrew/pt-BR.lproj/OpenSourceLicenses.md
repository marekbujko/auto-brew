# LICENÇAS DE CÓDIGO ABERTO

## Software de Terceiros Utilizado no AutoBrew

**Última Atualização:** Maio de 2026

O próprio AutoBrew é código aberto sob a Licença MIT (consulte [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Este documento lista todos os componentes de terceiros distribuídos dentro do pacote do aplicativo AutoBrew, além das dependências de tempo de execução das quais o AutoBrew depende para funcionar.

Cada componente é regido por sua própria licença, reproduzida ou referenciada abaixo. Quando um componente, por sua vez, incorpora outro código de terceiros (por exemplo, Sparkle), as atribuições aninhadas também são listadas.

---

## 1. AutoBrew

```
Component:   AutoBrew
Version:     2.2.0
License:     MIT
Copyright:   Copyright (c) 2026 Marcel R. G. Berger
Repository:  https://github.com/marcelrgberger/auto-brew
```

O texto integral da Licença MIT está reproduzido na seção 5 — ele se aplica ao AutoBrew, bem como aos componentes de terceiros rotulados como "MIT".

---

## 2. Dependências Incorporadas

Esses componentes estão vinculados ao pacote do aplicativo AutoBrew e são distribuídos junto com o app.

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

O próprio Sparkle inclui os seguintes componentes de terceiros:

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

#### 2.1.4 SUDistributedUpdaterArguments (auxiliar do Sparkle)

```
Component:   SUDistributedUpdaterArguments
License:     MIT
Copyright:   Copyright (c) 2011 Mark Hamlin
Used in Sparkle for: helper argument plumbing.
```

O texto integral da licença do Sparkle e das suas licenças externas incorporadas é distribuído dentro do framework em `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Dependências de Tempo de Execução (Externas)

Esses componentes **não** são distribuídos dentro do pacote do AutoBrew. O AutoBrew os invoca em tempo de execução via spawn de processo e, portanto, eles precisam ser instalados separadamente pelo usuário. O AutoBrew guia o usuário na instalação do Homebrew no primeiro lançamento.

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

O catálogo de pacotes que o AutoBrew exibe na BrewStore é servido por `formulae.brew.sh`, operado pelo projeto Homebrew.

### 3.2 API iTunes Search (Apple)

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

## 4. Frameworks de Sistema da Apple

O AutoBrew vincula-se aos seguintes frameworks da Apple. Eles fazem parte do macOS e não estão sujeitos a atribuição separada nos termos do Apple SDK Agreement; estão listados aqui para fins de completude:

- **SwiftUI** — framework de interface
- **Foundation** — tipos base, E/S de arquivos, JSON
- **AppKit** — integração com a barra de menus, `NSApp`, `NSWorkspace`
- **UserNotifications** — banners de conclusão e de aprovação pendente
- **ServiceManagement** (`SMAppService`) — configuração de inicialização ao fazer login
- **IOKit** — detecção de tempo ocioso via `IOHIDSystem`
- **os.Logger** — registro unificado
- **CryptoKit** — hashing SHA-256 para integridade dos snapshots

---

## 5. Licença MIT (verbatim)

A licença MIT abaixo aplica-se ao próprio AutoBrew e a todo componente acima rotulado como "MIT". Os titulares dos direitos autorais variam por componente (consulte as seções 1 e 2 para os avisos pertinentes).

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

## 6. Licença BSD-2-Clause (verbatim)

A licença BSD-2-Clause abaixo aplica-se ao `bsdiff` (incorporado dentro do Sparkle) e ao Homebrew.

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

## 7. Licença zlib (verbatim)

A licença zlib abaixo aplica-se ao `pdqsort` (incorporado dentro do Sparkle).

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

## 8. Disponibilidade do Código-Fonte

O AutoBrew é código aberto — o código-fonte completo encontra-se em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). O código-fonte das dependências incorporadas está disponível nas URLs de repositório listadas acima.

Para componentes copyleft — atualmente nenhum se aplica ao AutoBrew, mas, em princípio — as solicitações de código-fonte podem ser enviadas para hello@digitalfreedom.co.za e serão atendidas em até 30 dias.

---

## 9. Suas Obrigações ao Redistribuir

Se você redistribuir o AutoBrew ou qualquer um dos seus componentes incorporados, deve:

- Manter os avisos de copyright e os textos das licenças nas seções 1 a 7
- Reproduzir os textos das licenças MIT, BSD-2-Clause e zlib junto com o binário
- Não remover o arquivo `LICENSE` do Sparkle distribuído dentro do `Sparkle.framework`
- Cumprir o requisito de atribuição da BSD-2-Clause para o `bsdiff` (o aviso de copyright deve acompanhar as redistribuições binárias)

---

## 10. Comunicação de Problemas

Se você identificar uma atribuição ausente, uma referência de licença incorreta ou um componente listado que o AutoBrew não usa mais, abra uma issue em [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) ou envie um e-mail para hello@digitalfreedom.co.za.

---

## 11. Contato

Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha
E-mail: hello@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Nota: este aviso de copyright aplica-se a este próprio documento; os componentes de código aberto listados estão sujeitos às suas respectivas licenças.*
