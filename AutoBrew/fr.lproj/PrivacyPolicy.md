# POLITIQUE DE CONFIDENTIALITÉ

## AutoBrew

**Date d'entrée en vigueur :** mai 2026
**Dernière mise à jour :** mai 2026

**Service exploité par :** DigitalFreedom — une marque de Berger & Rosenstock GbR

**Responsable du traitement (entité juridique) :**
Berger & Rosenstock GbR (sous le nom commercial DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Allemagne

Représentants autorisés : Marcel R. G. Berger, Jasmin Rosenstock
Numéro de TVA : DE455096022

Contact (général) : hello@digitalfreedom.co.za
Contact (protection des données) : data-protection@digitalfreedom.co.za
Site web : https://digitalfreedom.co.za

---

## 1. INTRODUCTION

La présente politique de confidentialité explique la manière dont DigitalFreedom (une marque de Berger & Rosenstock GbR — « nous », « notre ») traite les données en lien avec l'application AutoBrew (« AutoBrew », « le Logiciel »).

AutoBrew est un **logiciel open source sous licence MIT**, **entièrement gratuit**, distribué directement sous la forme d'un DMG notarié et via un tap Homebrew — non via l'Apple App Store ni le Google Play Store. Nous n'exploitons aucun service dorsal, n'hébergeons aucun compte utilisateur et ne collectons, ne transmettons, ne stockons ni ne traitons aucune donnée personnelle sur nos serveurs.

Nous adoptons le règlement général sur la protection des données de l'Union européenne (RGPD) comme socle le plus exigeant et l'appliquons comme un seuil mondial — les protections décrites ci-dessous s'appliquent à chaque utilisateur, quel que soit son pays.

---

## 2. AUCUNE COLLECTE DE DONNÉES

**Nous ne collectons aucune donnée personnelle.**

AutoBrew s'exécute entièrement sur votre Mac. Il n'existe ni compte AutoBrew, ni télémétrie, ni analyses, ni rapport d'erreurs, ni configuration à distance. Étant donné que nous ne traitons aucune donnée personnelle sous notre contrôle, la plupart des obligations RGPD pesant sur l'exploitant (formalités de transfert international, contrats de sous-traitance, notification de violation de notre côté) ne s'appliquent pas à nous en tant qu'éditeur du Logiciel. La section 6 décrit néanmoins les droits dont vous disposez en vertu du droit applicable.

---

## 3. DONNÉES STOCKÉES LOCALEMENT SUR VOTRE APPAREIL

AutoBrew stocke localement les données suivantes. **Aucune de ces données ne quitte votre Mac à moins que vous ne choisissiez de les partager.**

### 3.1 Réglages (UserDefaults)

- Mode de déclenchement (inactivité / planifié)
- Seuil d'inactivité (en minutes) et heure planifiée
- Horodatage de la dernière exécution
- Préférence de lancement à l'ouverture de session
- Préférence de notification
- Réglages de conservation des snapshots
- Politique de mise à jour par défaut (patch/mineure/majeure × cask/formula) et exceptions par paquet
- État de l'intégration (onboarding)

### 3.2 État de la politique de mise à jour (Application Support)

- `UpdateLedger.json` — moment où chaque `(kind, token, version)` est apparu comme obsolète pour la première fois, afin de mesurer la fenêtre de temporisation. Les tokens sont les noms de paquets Homebrew ; aucun identifiant utilisateur.
- `PendingUpdates.json` — entrées de mises à jour majeures en attente de votre décision (approbation / rejet).

### 3.3 Cache d'icônes (Application Support)

- PNG mis en cache des icônes de casks récupérées via l'API iTunes Search (recherche anonyme par nom d'application) et icon.horse en repli. Stockés sous `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 Snapshots d'applications (Application Support)

- Copies au format ZIP de `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers`, etc. pour les applications dont vous demandez explicitement un snapshot. Stockées sous `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Journaux (os.Logger)

- Événements de diagnostic écrits via le système de journalisation unifié d'Apple. Visibles dans Console.app. Non transmis ailleurs.

Vous pouvez supprimer l'ensemble des données stockées localement en supprimant AutoBrew, son dossier de support (`~/Library/Application Support/AutoBrew/`) et son plist UserDefaults (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. ACTIVITÉ RÉSEAU

AutoBrew émet des requêtes sortantes dans trois situations. Aucune ne transmet de données personnelles.

### 4.1 Opérations sur les paquets Homebrew

AutoBrew délègue au binaire `brew` que vous avez installé localement. Le projet Homebrew contacte alors `formulae.brew.sh`, GitHub, des miroirs CDN et les URL de téléchargement des casks. Nous n'avons aucune relation avec ces points de terminaison — ils sont exploités par le projet Homebrew et les éditeurs de casks respectifs, sous leurs propres conditions de confidentialité.

### 4.2 Catalogue de casks et résolution d'icônes

- `formulae.brew.sh/api/cask.json` — récupération anonyme du catalogue public de casks
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — récupération anonyme des statistiques d'installation sur 365 jours
- `itunes.apple.com/search` — recherche anonyme des icônes d'applications macOS par nom d'affichage
- `icon.horse` — recherche de favicon en repli, basée sur l'URL `homepage` du cask

### 4.3 Vérification des mises à jour automatiques

Sparkle contacte périodiquement l'URL de l'appcast AutoBrew sur GitHub afin de vérifier la disponibilité de nouvelles versions d'AutoBrew. La requête contient votre version de macOS et la version d'AutoBrew (`User-Agent` standard), sans autre identifiant.

---

## 5. SERVICES TIERS (PAS DES SOUS-TRAITANTS)

Nous ne mobilisons pas de sous-traitants, car nous ne traitons pas vos données. Les services tiers avec lesquels AutoBrew communique agissent de manière indépendante et sous leurs propres conditions :

| Service | Finalité | Exploitant |
|---|---|---|
| Homebrew + formulae.brew.sh | Gestion de paquets et catalogue | Projet Homebrew |
| API iTunes Search d'Apple | Recherche d'icônes d'applications | Apple Inc. |
| icon.horse | Repli pour favicon | icon.horse |
| GitHub (appcast, releases) | Distribution + canal de mise à jour | GitHub, Inc. |

Lorsque vous cliquez sur un lien Sponsor dans AutoBrew, vous quittez l'application et votre navigateur ouvre GitHub Sponsors — cette interaction est régie par la politique de confidentialité de GitHub.

---

## 6. VOS DROITS

Étant donné que nous ne stockons aucune donnée personnelle sur nos serveurs, les droits d'accès / rectification / effacement / portabilité / opposition / limitation prévus par les articles 15 à 22 du RGPD et par les législations locales équivalentes sont, en pratique, satisfaits par la suppression d'AutoBrew de votre Mac.

Vous pouvez néanmoins nous contacter à **data-protection@digitalfreedom.co.za** pour toute question relative à la présente politique.

Vous pouvez introduire une réclamation auprès de votre autorité compétente de protection des données. En Allemagne, il s'agit du Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). L'UE recense les autorités nationales à l'adresse https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. ENFANTS

AutoBrew est un utilitaire de développeur pour macOS. Il n'est pas destiné aux enfants de moins de 16 ans. Nous ne collectons aucune donnée personnelle ; nous ne traitons donc pas non plus de données d'enfants.

---

## 8. SÉCURITÉ

- Le binaire de l'application est signé avec le certificat Apple Developer ID et notarisé par Apple.
- Les mises à jour automatiques sont vérifiées contre une signature EdDSA Ed25519 avant d'être appliquées.
- AutoBrew s'exécute sous Hardened Runtime ; les applications en distribution directe qui dialoguent avec des outils système ne peuvent utiliser le sandbox d'application complet sans casser le cas d'usage : nous livrons donc les entitlements minimaux requis.
- Le code source est librement auditable sur [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. TRANSFERTS INTERNATIONAUX

Nous ne transférons pas de données personnelles, puisque nous n'en collectons pas. Les services tiers que vous joignez via AutoBrew (serveurs du projet Homebrew, Apple, icon.horse, GitHub) peuvent être exploités hors UE ; les transferts vers ces services interviennent entre vous et eux, non avec nous.

---

## 10. MODIFICATIONS DE LA PRÉSENTE POLITIQUE

Nous pouvons mettre à jour la présente politique de confidentialité pour refléter des changements de l'architecture d'AutoBrew ou du droit applicable. La date « Dernière mise à jour » en haut du document indique la révision la plus récente. Les modifications substantielles sont communiquées dans les notes de version d'AutoBrew.

### 10.1 Futures fonctionnalités payantes

AutoBrew est actuellement gratuit et fonctionne sans aucun service dorsal (voir section 2). L'Éditeur se réserve le droit d'introduire, dans de futures versions, des **fonctionnalités payantes**, **éditions payantes** ou **services additionnels payants** optionnels, susceptibles de nécessiter un traitement limité de données (par exemple le traitement d'un paiement via un prestataire tiers, ou la vérification d'une clé de licence). Toute évolution de ce type sera :

- Annoncée à l'avance dans les notes de version d'AutoBrew et dans la présente politique de confidentialité
- Strictement opt-in — la version gratuite à zéro donnée reste utilisable
- Documentée dans une section dédiée de la présente politique avant l'activation de tout nouveau flux de données

La mention « aucune collecte de données » s'applique à la version actuelle d'AutoBrew. Elle ne constitue pas une garantie perpétuelle pour toutes les versions futures ; nous maintiendrons la présente politique à jour de sorte qu'elle décrive toujours le comportement effectif.

---

## 11. CONTACT

Pour les demandes relatives à la protection des données :
**data-protection@digitalfreedom.co.za**

Pour tout le reste :
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (sous le nom commercial DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Allemagne
Site web : https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
