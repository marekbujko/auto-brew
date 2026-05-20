# CONDITIONS D'UTILISATION

## AutoBrew

**Date d'entrée en vigueur :** mai 2026
**Dernière mise à jour :** mai 2026

Les présentes conditions d'utilisation (« Conditions ») régissent votre utilisation d'AutoBrew (le « Logiciel »). Veuillez les lire attentivement. En installant ou en utilisant AutoBrew, vous acceptez d'être lié par les présentes Conditions.

---

## 1. FOURNISSEUR

Le Logiciel est publié sous la marque **DigitalFreedom**. L'entité juridique qui l'exploite est :

Berger & Rosenstock GbR (sous le nom commercial DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Allemagne
Représentants autorisés : Marcel R. G. Berger, Jasmin Rosenstock
Courriel : hello@digitalfreedom.co.za
Site web : https://digitalfreedom.co.za

Les présentes Conditions s'appliquent à l'échelle mondiale. Les droits impératifs de protection des consommateurs et les autres droits légaux accordés par le pays de résidence de l'utilisateur demeurent inchangés et prévalent partout où ils sont plus protecteurs.

---

## 2. LE LOGICIEL

AutoBrew est un utilitaire pour la barre de menus macOS qui automatise les mises à jour Homebrew, parcourt le catalogue de casks Homebrew et gère des snapshots d'applications pour la migration entre Mac. Il est :

- **Open source** sous licence MIT — code source complet sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Gratuit** — pas d'achats intégrés, pas d'abonnements, pas d'édition payante, pas de période d'essai
- **Distribué directement** — DMG notarié depuis GitHub Releases et un tap Homebrew ; non via l'Apple App Store ni le Google Play Store
- **Strictement local** — il s'exécute entièrement sur votre Mac, aucun compte AutoBrew ni service dorsal n'est requis (voir la [Politique de confidentialité](PrivacyPolicy.md))

Les présentes Conditions s'appliquent au binaire AutoBrew. La licence MIT (reproduite dans l'[EULA](EULA.md) et dans les [Licences open source](OpenSourceLicenses.md)) régit le code source ainsi que tout fork ou œuvre dérivée.

---

## 3. LICENCE D'UTILISATION

Sous réserve de votre respect des présentes Conditions et de la licence MIT, vous pouvez :

- Installer, exécuter, modifier et redistribuer AutoBrew sur autant de Mac que vous contrôlez
- Forker le code source et créer des œuvres dérivées dans les conditions de la licence MIT

Vous ne pouvez pas :

- Dénaturer l'origine du Logiciel (la licence MIT exige la conservation de la mention de copyright d'origine)
- Retirer les mentions de licence intégrées de Sparkle, bsdiff, sais-lite ou pdqsort lors de la redistribution
- Utiliser le nom **AutoBrew** ou la marque **DigitalFreedom** dans des œuvres dérivées sans notre autorisation écrite (voir le document [Marques](Trademark.md))

---

## 4. AUCUN COMPTE, AUCUN PAIEMENT (ÉTAT ACTUEL)

AutoBrew ne nécessite actuellement aucune inscription, aucune création de compte, ni aucun paiement. Le lien **Sponsor** dans l'application renvoie vers GitHub Sponsors et est **entièrement volontaire** — toute contribution est traitée comme un don et ne crée aucun droit à des fonctionnalités ou à un support.

### 4.1 Réserve concernant les futures fonctionnalités payantes

Le Fournisseur se réserve le droit d'introduire des **fonctionnalités payantes**, **éditions payantes** ou **services additionnels payants** optionnels dans les versions futures d'AutoBrew. Toute offre payante future :

- Sera annoncée à l'avance via l'interface de l'application et les notes de version officielles
- Ne s'appliquera que pour l'avenir — votre droit de continuer à utiliser la version gratuite actuelle reste inchangé
- N'affectera pas le noyau open source : le code source sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) continuera d'être disponible sous licence MIT

L'absence actuelle de fonctionnalités payantes ne constitue pas une garantie qu'AutoBrew demeurera exempt de fonctionnalités payantes dans toutes les versions futures.

---

## 5. DÉPENDANCE À HOMEBREW

AutoBrew repose sur une installation Homebrew fonctionnelle pour remplir son objet. AutoBrew délègue au binaire `brew` et lit / écrit des données via les commandes et conventions du projet Homebrew. Nous ne sommes pas affiliés au projet Homebrew ; nous ne contrôlons ni les paquets disponibles, ni leur cadence de publication, ni ce que font les éditeurs de casks de leurs installateurs.

Si l'installation d'un cask échoue, se comporte de manière inattendue ou cause un préjudice, cela relève de votre relation avec l'éditeur du cask et/ou le projet Homebrew — voir la section 7 (Exclusion de garantie) et la section 8 (Limitation de responsabilité).

---

## 6. MISES À JOUR

AutoBrew utilise le framework Sparkle pour livrer des mises à jour intégrées depuis l'appcast officiel AutoBrew hébergé sur GitHub. Les mises à jour sont signées avec une clé EdDSA Ed25519 et vérifiées avant d'être appliquées. Les mises à jour automatiques peuvent être désactivées dans les Réglages.

Vous êtes libre d'ignorer les mises à jour intégrées et de mettre à jour le binaire via votre tap Homebrew ou en téléchargeant manuellement un DMG plus récent.

---

## 7. EXCLUSION DE GARANTIE

Le Logiciel est fourni **« EN L'ÉTAT »** et **« SELON DISPONIBILITÉ »**, sans aucune garantie d'aucune sorte, expresse ou implicite, y compris, sans s'y limiter, les garanties implicites de qualité marchande, d'adéquation à un usage particulier et de non-contrefaçon.

Sans limiter ce qui précède, nous ne garantissons pas que :

- Le Logiciel sera ininterrompu ou exempt d'erreurs
- L'interaction d'AutoBrew avec Homebrew, avec des casks individuels ou avec macOS lui-même produira toujours le résultat souhaité
- Les snapshots créés par AutoBrew capturent parfaitement chaque aspect de l'état d'une application — les applications qui stockent des données en dehors des sous-dossiers Library standard peuvent ne pas être intégralement capturées

Les droits légaux de garantie qui ne peuvent être exclus par contrat selon votre droit local de protection des consommateurs (par exemple la Mängelhaftung allemande au sens des §§ 434 et suivants du BGB, le cas échéant) demeurent inchangés.

---

## 8. LIMITATION DE RESPONSABILITÉ

Dans toute la mesure permise par le droit applicable :

- Nous ne sommes pas responsables des dommages indirects, accessoires, consécutifs, exemplaires ou punitifs
- Nous ne sommes pas responsables des pertes de données, pertes de bénéfices, interruptions d'activité ou de tout dommage provenant de logiciels tiers (Homebrew, casks individuels) invoqués via AutoBrew

Pour les utilisateurs résidant habituellement en Allemagne ou dans l'UE, notre responsabilité pour les dommages causés par **négligence grave ou faute intentionnelle**, pour les **atteintes à la vie, à l'intégrité physique ou à la santé**, ainsi que celle prévue par les **dispositions impératives de la loi allemande sur la responsabilité du fait des produits (ProdHaftG)** demeure inchangée.

---

## 9. RÉSILIATION

Vous pouvez cesser d'utiliser AutoBrew à tout moment en le désinstallant. La suppression d'AutoBrew et de son dossier de support (`~/Library/Application Support/AutoBrew/`) ramène votre Mac à un état exempt de tout artefact AutoBrew.

Nous pouvons cesser à tout moment de distribuer AutoBrew. Le Logiciel étant open source sous licence MIT, vous et la communauté restez libres de le forker, de le compiler et de l'exécuter de manière indépendante.

---

## 10. MODIFICATIONS DES PRÉSENTES CONDITIONS

Nous pouvons mettre à jour les présentes Conditions pour refléter des changements du Logiciel ou du droit applicable. Les modifications substantielles sont communiquées dans les notes de version d'AutoBrew. La date « Dernière mise à jour » en haut du document indique la révision la plus récente.

---

## 11. DROIT APPLICABLE ET JURIDICTION

Les présentes Conditions sont régies par le droit de la République fédérale d'Allemagne, à l'exclusion de la Convention des Nations unies sur les contrats de vente internationale de marchandises (CVIM).

Pour les consommateurs résidant habituellement hors d'Allemagne, le droit impératif de protection des consommateurs de leur pays de résidence s'applique en outre. Le lieu de juridiction non exclusif pour les litiges est Bad Nauheim, Allemagne ; les consommateurs peuvent néanmoins agir au lieu de leur domicile lorsque le droit local le permet.

Pour les litiges de consommation relevant du droit de l'UE, la plateforme de règlement en ligne des litiges de la Commission européenne est accessible à l'adresse https://ec.europa.eu/consumers/odr. Nous ne sommes ni tenus ni disposés à participer à des procédures alternatives de règlement des litiges devant un organisme d'arbitrage consommateur (Verbraucherschlichtungsstelle) au sens du § 36 VSBG.

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
