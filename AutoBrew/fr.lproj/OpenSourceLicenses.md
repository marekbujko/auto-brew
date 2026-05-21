# LICENCES OPEN SOURCE

## Logiciels tiers utilisés dans AutoBrew

**Dernière mise à jour :** mai 2026

AutoBrew est lui-même open source sous licence MIT (voir [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)). Le présent document liste chaque composant tiers livré dans le bundle de l'application AutoBrew, ainsi que les dépendances à l'exécution sur lesquelles AutoBrew s'appuie pour fonctionner.

Chaque composant est régi par sa propre licence, reproduite ou référencée ci-dessous. Lorsqu'un composant intègre lui-même d'autres codes tiers (par exemple Sparkle), les attributions imbriquées sont également listées.

---

## 1. AutoBrew

```
Composant :  AutoBrew
Version :    2.2.0
Licence :    MIT
Copyright :  Copyright (c) 2026 Marcel R. G. Berger
Dépôt :      https://github.com/marcelrgberger/auto-brew
```

Le texte intégral de la licence MIT est reproduit à la section 5 — il s'applique à AutoBrew ainsi qu'aux composants tiers étiquetés « MIT ».

---

## 2. Dépendances intégrées

Ces composants sont liés au bundle de l'application AutoBrew et livrés avec elle.

### 2.1 Sparkle

```
Composant :  Sparkle
Version :    2.9.0
Licence :    MIT
Copyright :  Copyright (c) 2006-2013 Andy Matuschak
             Copyright (c) 2009-2013 Elgato Systems GmbH
             Copyright (c) 2011-2014 Kornel Lesiński
             Copyright (c) 2015-2017 Mayur Pawashe
             Copyright (c) 2014 C.W. Betts
             Copyright (c) 2014 Petroules Corporation
             Copyright (c) 2014 Big Nerd Ranch
Dépôt :      https://github.com/sparkle-project/Sparkle
Utilisation : Mises à jour automatiques intégrées pour la build de
              distribution directe (appcast signé EdDSA servi depuis
              le dépôt GitHub).
```

Sparkle inclut lui-même les composants tiers suivants :

#### 2.1.1 bsdiff / bspatch

```
Composant :  bsdiff 4.3
Licence :    BSD-2-Clause
Copyright :  Copyright 2003-2005 Colin Percival
Source :     http://www.daemonology.net/bsdiff/
Utilisation dans Sparkle : mises à jour delta binaires.
```

#### 2.1.2 sais-lite

```
Composant :  sais-lite (2010-08-07)
Licence :    MIT
Copyright :  Copyright (c) 2008-2010 Yuta Mori
Source :     https://sites.google.com/site/yuta256/sais
Utilisation dans Sparkle : construction de tableaux de suffixes pendant bsdiff.
```

#### 2.1.3 pdqsort

```
Composant :  pdqsort
Licence :    zlib
Copyright :  Copyright (c) 2015 Orson Peters
Source :     https://github.com/orlp/pdqsort
Utilisation dans Sparkle : utilitaires de tri dans le pipeline delta.
```

#### 2.1.4 SUDistributedUpdaterArguments (auxiliaire Sparkle)

```
Composant :  SUDistributedUpdaterArguments
Licence :    MIT
Copyright :  Copyright (c) 2011 Mark Hamlin
Utilisation dans Sparkle : transmission d'arguments auxiliaires.
```

Le texte intégral de la licence Sparkle et de ses licences externes intégrées est livré dans le framework à l'emplacement `AutoBrew.app/Contents/Frameworks/Sparkle.framework/Resources/LICENSE`.

---

## 3. Dépendances à l'exécution (externes)

Ces composants **ne sont pas** livrés dans le bundle d'AutoBrew. AutoBrew les invoque à l'exécution par création de processus ; ils doivent donc être installés séparément par l'utilisateur. AutoBrew guide l'installation de Homebrew au premier démarrage.

### 3.1 Homebrew

```
Composant :  Homebrew
Licence :    BSD-2-Clause
Copyright :  Copyright (c) 2009-présent Homebrew contributors
Dépôt :      https://github.com/Homebrew/brew
Utilisation par AutoBrew :
             - `brew update` pour rafraîchir l'index des paquets
             - `brew upgrade` et `brew upgrade --cask` pour les installations
             - `brew outdated --json=v2` pour détecter les mises à jour disponibles
             - `brew install --cask <token>` pour les demandes d'installation directe
             - `brew search` pour retrouver les casks renommés lors d'une restauration
             - `brew cleanup --prune=7` pour la maintenance périodique
```

Le catalogue de paquets affiché par AutoBrew dans le BrewStore est servi par `formulae.brew.sh`, exploité par le projet Homebrew.

### 3.2 API iTunes Search (Apple)

```
Service :    API iTunes Search
Exploitant : Apple Inc.
Utilisation par AutoBrew :
             Recherche au mieux des icônes d'applications macOS par
             nom d'affichage, servies sous forme de PNG mis en cache
             dans le BrewStore. Anonyme — aucun identifiant utilisateur
             n'est transmis.
```

### 3.3 icon.horse

```
Service :    icon.horse
Utilisation par AutoBrew :
             Résolution de favicon en repli pour les casks dont l'URL
             `homepage` est définie, après une recherche iTunes Search
             infructueuse. Anonyme.
Point de terminaison : https://icon.horse
```

---

## 4. Frameworks système Apple

AutoBrew est lié aux frameworks Apple suivants. Ils font partie de macOS et ne sont pas soumis à une attribution distincte au titre de l'Apple SDK Agreement ; ils sont listés ici par souci d'exhaustivité :

- **SwiftUI** — framework d'interface
- **Foundation** — types de base, E/S fichiers, JSON
- **AppKit** — intégration à la barre de menus, `NSApp`, `NSWorkspace`
- **UserNotifications** — bannières d'achèvement et d'approbation en attente
- **ServiceManagement** (`SMAppService`) — câblage du lancement à l'ouverture de session
- **IOKit** — détection du temps d'inactivité via `IOHIDSystem`
- **os.Logger** — journalisation unifiée
- **CryptoKit** — hachage SHA-256 pour l'intégrité des snapshots

---

## 5. Licence MIT (verbatim)

La licence MIT ci-dessous s'applique à AutoBrew lui-même et à chacun des composants ci-dessus étiquetés « MIT ». Les détenteurs de copyright diffèrent selon le composant (voir sections 1 et 2 pour les mentions concernées).

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

## 6. Licence BSD-2-Clause (verbatim)

La licence BSD-2-Clause ci-dessous s'applique à `bsdiff` (intégré à Sparkle) et à Homebrew.

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

## 7. Licence zlib (verbatim)

La licence zlib ci-dessous s'applique à `pdqsort` (intégré à Sparkle).

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

## 8. Disponibilité du code source

AutoBrew est open source — le code source complet réside sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). Le code source des dépendances intégrées est disponible aux URL des dépôts listés ci-dessus.

Pour les composants copyleft — aucun ne s'applique actuellement à AutoBrew, mais en principe — les demandes de code source peuvent être adressées à hello@digitalfreedom.co.za et seront satisfaites sous 30 jours.

---

## 9. Vos obligations en cas de redistribution

Si vous redistribuez AutoBrew ou l'un de ses composants intégrés, vous devez :

- Conserver les mentions de copyright et les textes de licence des sections 1 à 7
- Reproduire les textes des licences MIT, BSD-2-Clause et zlib aux côtés du binaire
- Ne pas retirer le fichier `LICENSE` de Sparkle livré dans `Sparkle.framework`
- Respecter l'exigence d'attribution BSD-2-Clause pour `bsdiff` (sa mention de copyright doit accompagner les redistributions binaires)

---

## 10. Signalement de problèmes

Si vous identifiez une attribution manquante, une référence de licence incorrecte ou un composant listé qu'AutoBrew n'utilise plus, veuillez ouvrir un ticket sur [github.com/marcelrgberger/auto-brew/issues](https://github.com/marcelrgberger/auto-brew/issues) ou écrire à hello@digitalfreedom.co.za.

---

## 11. Contact

Berger & Rosenstock GbR (sous le nom commercial DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Allemagne
Courriel : hello@digitalfreedom.co.za
Site web : https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.

*Note : la présente mention de copyright couvre le présent document lui-même ; les composants open source listés sont soumis à leurs licences respectives.*
