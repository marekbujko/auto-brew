# CONTRAT DE LICENCE UTILISATEUR FINAL (EULA)

## AutoBrew

**Date d'entrée en vigueur :** mai 2026
**Dernière mise à jour :** mai 2026

Le présent contrat de licence utilisateur final (« EULA », « Contrat ») est un contrat à caractère juridique entre vous (« Utilisateur », « vous ») et l'éditeur d'AutoBrew, **Berger & Rosenstock GbR** sous le nom commercial **DigitalFreedom** (« Éditeur », « nous », « notre »).

En installant, copiant ou utilisant AutoBrew (le « Logiciel »), vous acceptez d'être lié par les termes du présent EULA.

---

## 1. LE LOGICIEL

AutoBrew est un utilitaire pour la barre de menus macOS qui automatise les mises à jour Homebrew, parcourt le catalogue de casks Homebrew et gère des snapshots d'applications. Il est publié sous la marque DigitalFreedom et vous est concédé sous les termes ci-dessous.

### 1.1 Modèle de licence

AutoBrew est publié comme **logiciel libre et gratuit open source** sous licence MIT. Le texte intégral de la licence MIT est reproduit à la section 6 et dans le document [Licences open source](OpenSourceLicenses.md). La licence MIT régit le code source ; le présent EULA couvre la distribution binaire et vos obligations en tant qu'utilisateur du binaire.

### 1.2 Réserve concernant les futures fonctionnalités payantes

L'Éditeur se réserve le droit d'introduire à tout moment des **fonctionnalités payantes**, **éditions payantes** ou **services additionnels payants** optionnels. Toute évolution future de ce type :

- Sera annoncée à l'avance via l'interface de l'application et les notes de version officielles
- Ne s'appliquera que pour l'avenir (c'est-à-dire que les fonctionnalités gratuites existantes d'une version que vous avez déjà installée restent gratuites)
- N'affectera pas le noyau open source sous licence MIT — le code source sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) reste disponible sous la même licence, quels que soient les ajouts payants

L'absence actuelle de fonctionnalités payantes ne constitue pas une garantie qu'AutoBrew demeurera exempt de fonctionnalités payantes à jamais.

### 1.3 Champ open source vs. fonctionnalités payantes

La licence MIT s'applique au code source d'AutoBrew tel que publié dans le dépôt officiel sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Les forks et œuvres dérivées de ce code sont explicitement autorisés** sous les termes de la licence MIT — nous accueillons favorablement la communauté qui construit sur AutoBrew.

Toute **future fonctionnalité payante**, **édition payante** ou **service additionnel payant** (voir section 1.2) sera publié sous une **licence propriétaire distincte** et **ne fera pas** partie du code source sous licence MIT. En particulier :

- Le code source des fonctionnalités payantes ne sera pas publié dans le dépôt MIT
- La copie, la décompilation, la rétro-ingénierie ou toute autre reproduction de l'implémentation d'une fonctionnalité payante propriétaire livrée par AutoBrew n'est pas autorisée, sauf dans la mesure expressément permise par le droit impératif applicable (par exemple le § 69e UrhG / l'art. 6 de la directive 2009/24/CE pour l'interopérabilité)
- Cette restriction vise spécifiquement l'implémentation de la fonctionnalité payante — elle ne restreint pas le droit d'un tiers de développer indépendamment et de zéro une fonctionnalité comparable

Les marques **« AutoBrew »** et **« DigitalFreedom »** ne peuvent pas être utilisées par des forks ou œuvres dérivées qui proposent des fonctionnalités payantes concurrentes — voir la section 3 du présent EULA et l'avis [Marques](Trademark.md).

### 1.4 Canaux de distribution

Le binaire officiel AutoBrew est distribué exclusivement via :

- **GitHub Releases** à l'adresse [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — fichiers DMG notariés et signés avec le certificat Apple Developer ID
- Le **tap Homebrew** à l'adresse [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew **n'est pas** distribué via l'Apple App Store, le Google Play Store ni aucun portail de téléchargement tiers. Si vous avez obtenu AutoBrew ailleurs, le binaire n'est pas vérifié et n'est pas couvert par le présent EULA.

---

## 2. OCTROI DE LICENCE

Sous réserve de votre respect du présent EULA et de la licence MIT, l'Éditeur vous concède une licence mondiale, libre de redevances, non exclusive vous permettant :

- D'installer et d'exécuter AutoBrew sur autant de Mac que vous possédez ou contrôlez
- De modifier le code source et de créer des œuvres dérivées
- De redistribuer le Logiciel sous forme de code source ou de binaire

---

## 3. RESTRICTIONS

Vous ne pouvez pas :

- Retirer, modifier ou masquer les mentions de copyright, le texte de la licence MIT, ni les mentions de licence intégrées de Sparkle / bsdiff / sais-lite / pdqsort lors de la redistribution
- Utiliser les marques **« AutoBrew »** et **« DigitalFreedom »** dans le nom d'un fork ou d'une œuvre dérivée sans notre consentement écrit préalable (voir le document [Marques](Trademark.md))
- Présenter votre fork de manière trompeuse comme la distribution officielle d'AutoBrew

---

## 4. COMPOSANTS TIERS

AutoBrew intègre les composants open source suivants, chacun régi par sa propre licence (voir le document [Licences open source](OpenSourceLicenses.md) pour la liste complète et les textes de licence verbatim) :

- **Sparkle** (MIT) — mises à jour automatiques intégrées
- **bsdiff / bspatch** (BSD-2-Clause) — intégré à Sparkle pour les deltas binaires
- **sais-lite** (MIT) — intégré à Sparkle
- **pdqsort** (zlib) — intégré à Sparkle

AutoBrew dépend également à l'exécution de **Homebrew** (BSD-2-Clause) — invoqué par création de processus, non embarqué. Homebrew doit être installé séparément ; AutoBrew vous guidera lors de son installation au premier démarrage.

Les licences MIT, BSD-2-Clause et zlib applicables à ces composants restent en vigueur indépendamment du présent EULA. En cas de conflit entre le présent EULA et une licence open source, la licence open source prévaut pour le composant concerné.

---

## 5. AUCUN PAIEMENT, AUCUN COMPTE (ÉTAT ACTUEL)

AutoBrew est actuellement gratuit. Le Logiciel ne requiert ni inscription, ni création de compte, ni paiement, et à la date du présent EULA il n'existe ni achats intégrés, ni abonnements, ni fonctionnalités payantes, ni mécanique d'essai.

Le lien **Sponsor** dans AutoBrew renvoie vers GitHub Sponsors et est **entièrement volontaire**. Toute contribution est traitée comme un don et ne confère aucun droit supplémentaire.

**Réserve :** voir la section 1.2 — l'Éditeur se réserve le droit d'introduire, à l'avenir, des fonctionnalités payantes, éditions payantes ou services additionnels payants optionnels. Toute offre payante future ne s'appliquera qu'aux utilisateurs qui y consentent explicitement ; les fonctionnalités gratuites déjà installées ne seront pas rétroactivement verrouillées.

---

## 6. LICENCE MIT (verbatim)

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

## 7. EXCLUSION DE GARANTIE

Le Logiciel est fourni **« EN L'ÉTAT »** sans aucune garantie d'aucune sorte, expresse ou implicite. L'Éditeur ne garantit pas que le Logiciel sera ininterrompu ou exempt d'erreurs, que l'interaction d'AutoBrew avec Homebrew ou avec des casks individuels aboutira toujours, ni que les snapshots captureront parfaitement tous les aspects de l'état d'une application.

Les droits légaux de garantie qui ne peuvent être exclus par contrat selon votre droit local de protection des consommateurs (par exemple la Mängelhaftung allemande au sens des §§ 434 et suivants du BGB, le cas échéant) demeurent inchangés.

---

## 8. LIMITATION DE RESPONSABILITÉ

Dans toute la mesure permise par le droit applicable, l'Éditeur n'est pas responsable des dommages indirects, accessoires, consécutifs, exemplaires ou punitifs — y compris perte de données, perte de bénéfices ou dommages provenant de logiciels tiers (Homebrew, casks individuels) invoqués via AutoBrew.

Pour les utilisateurs résidant habituellement en Allemagne ou dans l'UE, notre responsabilité pour les dommages causés par **négligence grave ou faute intentionnelle**, pour les **atteintes à la vie, à l'intégrité physique ou à la santé**, ainsi que celle prévue par la **loi allemande sur la responsabilité du fait des produits (ProdHaftG)** demeure inchangée.

---

## 9. CONTRÔLE À L'EXPORTATION

Le Logiciel ne contient pas de cryptographie au-delà de ce que macOS d'Apple et le framework Sparkle fournissent par défaut. L'exportation de macOS lui-même est régie par les conditions d'Apple ; vous restez responsable du respect des lois de contrôle à l'exportation applicables à votre juridiction.

---

## 10. RÉSILIATION

Le présent EULA prend effet jusqu'à sa résiliation. Il prend fin automatiquement et sans préavis si vous ne respectez pas l'un de ses termes. Vous pouvez également y mettre fin à tout moment en désinstallant AutoBrew. À la résiliation, vous devez cesser toute utilisation du Logiciel et supprimer toutes les copies en votre possession.

---

## 11. DROIT APPLICABLE ET JURIDICTION

Le présent EULA est régi par le droit de la République fédérale d'Allemagne, à l'exclusion de la Convention des Nations unies sur les contrats de vente internationale de marchandises (CVIM). Le droit impératif de protection des consommateurs du pays de résidence de l'utilisateur s'applique en outre.

Le lieu de juridiction non exclusif est Bad Nauheim, Allemagne. Les consommateurs peuvent agir au lieu de leur domicile lorsque le droit local le permet.

---

## 12. CONTACT

Berger & Rosenstock GbR (sous le nom commercial DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Allemagne
Courriel : hello@digitalfreedom.co.za
Site web : https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
