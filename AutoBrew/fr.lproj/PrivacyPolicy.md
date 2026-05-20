# POLITIQUE DE CONFIDENTIALITÉ

## Avis mondial de protection des données et de la vie privée

**Date d'entrée en vigueur :** Mai 2026

**Service exploité par :** DigitalFreedom — une marque de Berger & Rosenstock GbR

**Responsable du traitement (entité juridique) :**
Berger & Rosenstock GbR (sous la marque DigitalFreedom)
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

La présente politique de confidentialité explique la manière dont DigitalFreedom (une marque de Berger & Rosenstock GbR, collectivement « nous », « notre ») collecte, utilise, stocke et protège vos données personnelles lorsque vous utilisez nos applications, logiciels, sites web et services associés (« les Services »).

### 1.1 Portée mondiale

AutoBrew est distribué directement (et non via l'App Store) en tant que logiciel libre sous licence MIT, et est donc accessible aux utilisateurs du monde entier. La présente politique de confidentialité s'applique à l'échelle mondiale à tous les utilisateurs des Services, quel que soit le pays dans lequel le Service est téléchargé, consulté ou utilisé.

### 1.2 Le RGPD comme socle mondial

Nous adoptons le **Règlement général sur la protection des données de l'Union européenne (RGPD)** et le droit européen connexe en matière de protection des données comme socle le plus strict et nous l'appliquons comme un **standard mondial minimal** — chaque utilisateur, dans chaque pays, bénéficie au minimum des protections de niveau RGPD énoncées dans la présente politique. Nous respectons en outre toute loi locale applicable de protection des données dans la juridiction de l'utilisateur, et lorsque cette loi locale est plus protectrice pour l'utilisateur, le standard le plus protecteur s'applique.

Nous nous engageons à protéger votre vie privée et à respecter les lois applicables en matière de protection des données, y compris, mais sans s'y limiter :

- Règlement général sur la protection des données de l'UE (RGPD) — appliqué comme socle mondial
- Loi fédérale allemande sur la protection des données (BDSG)
- Règlement général sur la protection des données du Royaume-Uni (UK GDPR) et Data Protection Act 2018
- Loi fédérale suisse sur la protection des données (LPD)
- California Consumer Privacy Act (CCPA) / California Privacy Rights Act (CPRA) et autres lois des États américains
- Loi canadienne sur la protection des renseignements personnels et les documents électroniques (LPRPDE / PIPEDA)
- Australian Privacy Act 1988
- Loi générale brésilienne sur la protection des données (LGPD)
- Loi japonaise sur la protection des informations personnelles (APPI)
- Loi sud-coréenne sur la protection des informations personnelles (PIPA)
- Digital Personal Data Protection Act (DPDP Act) de l'Inde et IT Act
- Loi sud-africaine sur la protection des informations personnelles (POPIA)
- Tous les autres régimes nationaux applicables de protection des données dans les juridictions où les Services sont disponibles

---

## 2. RESPONSABLE DU TRAITEMENT

Les Services sont proposés sous la marque **DigitalFreedom**. L'entité juridique responsable du traitement de vos données personnelles (le « responsable du traitement » au sens de l'art. 4(7) RGPD) est :

Berger & Rosenstock GbR (sous la marque DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Allemagne

Représentants autorisés : Marcel R. G. Berger, Jasmin Rosenstock
Numéro de TVA : DE455096022

Pour toute demande relative à la protection des données (art. 13/14 RGPD, accès, rectification, effacement, portabilité, opposition) :
Courriel : data-protection@digitalfreedom.co.za

Pour les demandes générales :
Courriel : hello@digitalfreedom.co.za

Site web : https://digitalfreedom.co.za

---

## 3. PRINCIPE DE COLLECTE NULLE

**AutoBrew n'envoie aucune donnée personnelle vers nos serveurs. Tout fonctionne localement sur votre Mac.**

AutoBrew est un logiciel libre sous licence MIT, distribué directement (et non via l'App Store), et entièrement gratuit. Il ne contient aucun achat intégré, aucune offre payante, aucune analyse, aucune télémétrie, aucun rapport d'erreur. Nous n'exploitons aucun serveur dorsal recevant vos données.

### 3.1 Données stockées localement sur votre Mac

- **Préférences AutoBrew** (UserDefaults) — intervalles d'automatisation, paramètres de notification, état de l'intégration, formules suivies dans le catalogue BrewStore
- **Catalogue local BrewStore** — métadonnées sur les formules Homebrew installées et disponibles, récupérées depuis l'API publique de Homebrew
- **AppSnapshot** — instantanés locaux de votre état Homebrew (versions installées, formules), conservés sur votre appareil pour permettre les restaurations et comparaisons
- **Journaux d'opérations Homebrew** — sortie des commandes `brew` exécutées par AutoBrew, conservée localement à des fins de diagnostic

### 3.2 Communications réseau initiées par AutoBrew

AutoBrew communique directement depuis votre Mac avec les services suivants, sans intermédiaire exploité par nos soins :

- **API Homebrew (`formulae.brew.sh`)** — pour récupérer les métadonnées des formules et casks
- **Miroirs Homebrew / GitHub** — pour télécharger les paquets via la commande `brew`
- **Sparkle (notre flux d'appcast hébergé statiquement)** — pour vérifier les mises à jour d'AutoBrew. Sparkle transmet uniquement votre adresse IP (intrinsèquement visible lors de toute requête HTTPS) et un en-tête User-Agent contenant la version d'AutoBrew et la version de macOS
- **GitHub Sponsors** (uniquement si vous choisissez d'ouvrir la page de dons) — soumis à la politique de confidentialité de GitHub
- **Page d'assistance** (`https://support.digitalfreedom.co.za/help/767340152`) — uniquement si vous l'ouvrez explicitement

### 3.3 SDK non utilisés

AutoBrew n'intègre **aucun** des éléments suivants :

- SDK d'analyse (Google Analytics, Firebase Analytics, Mixpanel, Amplitude, PostHog, etc.)
- SDK de rapport d'erreurs (Crashlytics, Sentry, Bugsnag, etc.)
- SDK publicitaires
- SDK d'attribution
- Frameworks de tests A/B
- SDK de réseaux sociaux ou fournisseurs d'authentification tiers

### 3.4 Données NON collectées

AutoBrew ne collecte pas :

- géolocalisation
- contenu de votre carnet d'adresses, calendrier, courriels, SMS
- historique de navigation
- identifiants publicitaires comportementaux
- données de carte de paiement (AutoBrew est gratuit ; les dons éventuels passent par GitHub Sponsors, qui est responsable de son propre traitement)

---

## 4. BASE JURIDIQUE DU TRAITEMENT (RGPD)

AutoBrew mettant en œuvre une politique stricte de collecte nulle, nous n'agissons ni comme responsable du traitement ni comme sous-traitant pour les données personnelles que vous générez en utilisant l'application. Dans la mesure où le fonctionnement d'AutoBrew implique un traitement local sur votre appareil, celui-ci est effectué sur les bases suivantes :

| Base juridique | Finalité |
|---|---|
| **Exécution d'un contrat** (art. 6(1)(b) RGPD) | Fournir la fonctionnalité pour laquelle vous avez installé AutoBrew |
| **Intérêts légitimes** (art. 6(1)(f) RGPD) | Vérification des mises à jour Sparkle, sécurité de fonctionnement |
| **Consentement** (art. 6(1)(a) RGPD) | Actions explicites que vous déclenchez (mise à jour, rétablissement d'un snapshot, ouverture de la page de dons) |
| **Obligation légale** (art. 6(1)(c) RGPD) | Le cas échéant, conservation de registres légaux |

---

## 5. UTILISATION DES DONNÉES

Les données présentes sur votre Mac sont utilisées exclusivement pour :

- Exécuter et orchestrer les commandes Homebrew (`brew update`, `brew upgrade`, etc.) sur votre demande ou selon votre programmation
- Présenter le catalogue BrewStore et les détails des formules installées et disponibles
- Créer et restaurer des AppSnapshots locaux
- Vérifier les mises à jour d'AutoBrew via Sparkle
- Afficher les notifications, journaux et résultats d'opérations en local

Aucune donnée n'est partagée, vendue, louée ou divulguée à des tiers par nos soins.

---

## 6. PARTAGE ET DIVULGATION DES DONNÉES

### 6.1 Prestataires de services

AutoBrew ne fait appel à aucun sous-traitant pour le traitement de données personnelles, car aucune donnée personnelle ne quitte votre Mac vers nos serveurs.

### 6.1.1 Sous-traitants désignés

Aucun. AutoBrew n'exploite aucun service dorsal et n'engage aucun sous-traitant pour traiter vos données personnelles.

### 6.1.2 Canaux de plateforme et de distribution

Les parties suivantes agissent en tant que **responsables indépendants du traitement** pour les opérations de traitement effectuées en lien avec la distribution, le téléchargement de paquets ou les dons — non pas en tant que sous-traitants au titre de l'art. 28 RGPD. Elles sont divulguées ici à des fins de transparence :

| Partie | Rôle | Localisation |
|---|---|---|
| Homebrew (projet communautaire open source) | API de formules, miroirs de téléchargement de paquets | Mondial (CDN) |
| GitHub, Inc. | Hébergement du dépôt source d'AutoBrew, hébergement du flux d'appcast Sparkle, GitHub Sponsors (le cas échéant) | États-Unis (filiale de Microsoft Corporation) |

Pour les données traitées par Homebrew et GitHub sous leur propre responsabilité, leurs politiques de confidentialité respectives s'appliquent :
- Homebrew : <https://docs.brew.sh/Analytics>
- GitHub : <https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement>

### 6.2 Exigences légales

Nous pouvons divulguer des données lorsque la loi, une procédure judiciaire ou une demande gouvernementale l'exige. Dans la pratique, n'ayant aucune donnée vous concernant, il n'y a rien à divulguer.

### 6.3 Transferts d'entreprise

En cas de fusion, d'acquisition ou de cession d'actifs, vos données pourraient être transférées. Dans la pratique, aucune donnée personnelle d'utilisateur n'est conservée par nos soins.

### 6.4 Pas de vente de données personnelles

Nous ne vendons pas vos données personnelles à des tiers.

---

## 7. TRANSFERTS INTERNATIONAUX DE DONNÉES

Nous ne transférons pas de données personnelles à l'international, car nous ne collectons ni ne traitons de données personnelles vous concernant.

Les flux de données que vous initiez (requêtes vers l'API Homebrew, téléchargements depuis les miroirs Homebrew/GitHub, vérification d'appcast Sparkle, ouverture de la page d'assistance ou de GitHub Sponsors) peuvent impliquer une transmission transfrontalière. Ces transferts sont régis par les avis de confidentialité et les mécanismes de transfert des exploitants respectifs.

Pour tout transfert qui ne serait pas couvert par une décision d'adéquation :

- Nous nous appuyons sur les clauses contractuelles types de l'UE (CCT) le cas échéant
- Nous garantissons des garanties adéquates conformément au chapitre V du RGPD
- Nous évaluons le droit de protection des données du pays destinataire (analyse d'impact de transfert)

Pour les transferts depuis d'autres juridictions, nous respectons les exigences applicables de transfert transfrontalier.

---

## 8. CONSERVATION DES DONNÉES

Nous ne conservons aucune donnée personnelle. Toutes les données d'AutoBrew sont stockées localement sur votre appareil et se trouvent sous votre seul contrôle.

Critères de conservation locale :

- Durée de votre utilisation de l'application
- Les préférences et AppSnapshots persistent jusqu'à ce que vous les supprimiez explicitement ou désinstalliez AutoBrew

À l'expiration de la période de conservation, les données sont supprimées avec le conteneur de l'application lors de la désinstallation.

---

## 9. SÉCURITÉ DES DONNÉES

Bien que nous ne collections pas vos données, AutoBrew met en œuvre des mesures techniques et organisationnelles appropriées pour protéger vos données locales, notamment :

- Chiffrement en transit (TLS 1.2+) pour toutes les communications réseau
- Vérification de signature Sparkle EdDSA (Ed25519) pour les mises à jour de l'application
- Sandbox d'application macOS dans la mesure compatible avec l'exécution des commandes Homebrew
- Hardened Runtime activé pour un durcissement de sécurité supplémentaire
- Notarisation Apple pour toutes les versions distribuées
- Aucune télémétrie : aucune donnée d'utilisation, d'analyse ou de rapport d'erreur n'est transmise

Aucun système n'est totalement sécurisé. Nous ne pouvons pas garantir une sécurité absolue des données.

### 9.1 Notification de violation

Étant donné qu'AutoBrew ne traite aucune donnée personnelle sous notre contrôle, le scénario classique de violation de données (art. 33/34 RGPD) ne s'applique pas. Toute compromission de la chaîne de distribution (par exemple, un binaire AutoBrew falsifié) serait annoncée publiquement sur https://digitalfreedom.co.za et sur la page GitHub du projet.

---

## 10. VOS DROITS

### 10.1 Droits au titre du RGPD (UE/EEE/Royaume-Uni)

Vous avez le droit :

- **D'accès** à vos données personnelles (art. 15 RGPD) — non applicable, nous ne détenons aucune donnée vous concernant
- **De rectification** des données inexactes (art. 16 RGPD) — non applicable
- **À l'effacement** de vos données (« droit à l'oubli ») (art. 17 RGPD) — non applicable ; vous pouvez supprimer les données locales en désinstallant AutoBrew
- **À la limitation** du traitement (art. 18 RGPD) — non applicable
- **À la portabilité des données** (art. 20 RGPD) — non applicable
- **D'opposition** au traitement (art. 21 RGPD) — non applicable
- **De retirer votre consentement** à tout moment (art. 7(3) RGPD) — vous pouvez cesser d'utiliser AutoBrew à tout moment
- **D'introduire une réclamation** auprès d'une autorité de contrôle

### 10.2 Droits au titre du CCPA/CPRA (Californie)

Les résidents de Californie ont le droit :

- De savoir quelles informations personnelles sont collectées
- De demander la suppression d'informations personnelles
- De refuser la vente ou le partage d'informations personnelles
- De ne pas faire l'objet de discrimination pour l'exercice de leurs droits
- De corriger des informations personnelles inexactes
- De limiter l'utilisation d'informations personnelles sensibles

### 10.3 Droits au titre de la LPRPDE (Canada)

Les résidents canadiens ont le droit :

- D'accéder à leurs renseignements personnels
- De contester l'exactitude de leurs informations
- De retirer leur consentement (sous réserve de restrictions légales ou contractuelles)

### 10.4 Droits au titre de l'Australian Privacy Act

Les résidents australiens ont le droit :

- D'accéder à leurs informations personnelles
- De demander la correction d'informations inexactes
- De porter plainte auprès de l'Office of the Australian Information Commissioner (OAIC)

### 10.5 Droits au titre de la LGPD (Brésil)

Les résidents brésiliens ont le droit :

- À la confirmation du traitement
- À l'accès aux données
- À la correction de données incomplètes ou inexactes
- À l'anonymisation, au blocage ou à la suppression de données non nécessaires
- À la portabilité des données
- À l'information sur les données partagées
- À la révocation du consentement

---

## 11. VIE PRIVÉE DES ENFANTS

Nos Services ne sont pas destinés aux enfants de moins de 16 ans (ou de l'âge de consentement applicable dans votre juridiction).

Nous ne collectons pas sciemment de données personnelles auprès d'enfants. Si nous prenons connaissance de la collecte de données provenant d'un enfant, nous prendrons des mesures pour les supprimer rapidement.

---

## 12. COOKIES ET TRAÇAGE

AutoBrew est une application macOS native et n'utilise ni cookies, ni balises web, ni pixels espions, ni empreintes numériques, ni technologies de traçage similaires. L'application ne contient aucune vue web intégrée qui chargerait du contenu tiers.

---

## 13. DÉCISIONS AUTOMATISÉES ET IA

### 13.1 Décisions automatisées ayant un effet juridique ou similaire

AutoBrew n'effectue aucune décision automatisée ou profilage produisant des effets juridiques ou vous affectant de manière significative.

### 13.2 Fonctionnalités assistées par IA

AutoBrew ne comporte aucune fonctionnalité d'IA. Aucune donnée n'est envoyée à un fournisseur d'IA.

### 13.3 Application de l'usage équitable

AutoBrew étant un logiciel libre, gratuit et sans serveur, aucune politique d'usage équitable côté serveur ne s'applique.

### 13.4 Communications marketing

AutoBrew n'envoie aucune communication marketing. Aucun courriel d'opt-in n'est demandé.

### 13.5 Suppression du compte

AutoBrew ne nécessite pas de compte. Vous pouvez supprimer toutes les données locales en désinstallant l'application et en supprimant son conteneur (`~/Library/Containers/co.za.digitalfreedom.AutoBrew/` ou un chemin équivalent).

---

## 14. LIENS ET SERVICES TIERS

Les Services peuvent contenir des liens vers des sites ou services tiers (par exemple Homebrew, GitHub, GitHub Sponsors, la page d'assistance). Nous ne sommes pas responsables des pratiques de confidentialité de ces tiers.

---

## 15. MODIFICATIONS DE LA PRÉSENTE POLITIQUE

Nous pouvons mettre à jour la présente politique de confidentialité de temps à autre.

- Les modifications substantielles seront communiquées via les Services ou par courriel
- La poursuite de l'utilisation après les modifications vaut acceptation
- La « Date d'entrée en vigueur » figurant en tête reflète la dernière révision

---

## 16. CONTACT

Pour toute demande relative à la vie privée ou pour exercer vos droits :

DigitalFreedom
Une marque de Berger & Rosenstock GbR
Dieselstr. 22e
61231 Bad Nauheim
Allemagne

Protection des données : data-protection@digitalfreedom.co.za
Demandes générales : hello@digitalfreedom.co.za
Site web : https://digitalfreedom.co.za

Pour les résidents de l'UE, vous pouvez également contacter l'autorité de contrôle compétente de votre État membre.

---

## 17. DISPOSITIONS RÉGIONALES

### 17.1 Union européenne / EEE

- Le traitement est conforme aux exigences du RGPD
- L'autorité de contrôle chef de file est l'autorité allemande compétente de protection des données
- Les analyses d'impact relatives à la protection des données (AIPD) sont menées lorsque cela est requis

### 17.2 Royaume-Uni

- Le traitement est conforme au UK GDPR et au Data Protection Act 2018
- L'autorité de contrôle est l'Information Commissioner's Office (ICO)

### 17.3 États-Unis

- Le traitement est conforme aux lois étatiques applicables en matière de vie privée (CCPA/CPRA, VCDPA, CPA, etc.)
- Les signaux « Do Not Track » sont respectés lorsque cela est techniquement réalisable

### 17.4 Canada

- Le traitement est conforme à la LPRPDE et aux lois provinciales applicables
- Le Commissariat à la protection de la vie privée du Canada peut être contacté pour les plaintes

### 17.5 Australie

- Le traitement est conforme au Privacy Act 1988 et aux Australian Privacy Principles (APPs)

### 17.6 Brésil

- Le traitement est conforme à la Lei Geral de Proteção de Dados (LGPD)
- L'Autoridade Nacional de Proteção de Dados (ANPD) est l'autorité compétente

---

(c) 2025-2026 DigitalFreedom — Berger & Rosenstock GbR. Tous droits réservés.
