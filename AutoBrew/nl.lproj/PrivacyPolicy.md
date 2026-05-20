# PRIVACYBELEID

## AutoBrew

**Ingangsdatum:** mei 2026
**Laatst bijgewerkt:** mei 2026

**Dienst geëxploiteerd door:** DigitalFreedom — een merk van Berger & Rosenstock GbR

**Verwerkingsverantwoordelijke (rechtspersoon):**
Berger & Rosenstock GbR (handelend onder de naam DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Duitsland

Bevoegde vertegenwoordigers: Marcel R. G. Berger, Jasmin Rosenstock
Btw-id: DE455096022

Contact (algemeen): hello@digitalfreedom.co.za
Contact (gegevensbescherming): data-protection@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

## 1. INLEIDING

Dit Privacybeleid beschrijft hoe DigitalFreedom (een merk van Berger & Rosenstock GbR — "wij", "ons", "onze") omgaat met gegevens in verband met de applicatie AutoBrew ("AutoBrew", "de Software").

AutoBrew is **open source onder de MIT-licentie**, **volledig gratis** en wordt rechtstreeks verspreid als genotariseerd DMG en via een Homebrew-tap — niet via de Apple App Store of de Google Play Store. Wij exploiteren geen back-end, hosten geen gebruikersaccounts en verzamelen, verzenden, bewaren of verwerken geen persoonsgegevens op onze servers.

Wij hanteren de Algemene Verordening Gegevensbescherming van de Europese Unie (AVG) als de strengste basisnorm en passen die toe als wereldwijde ondergrens — de hieronder beschreven bescherming geldt voor iedere gebruiker, ongeacht het land.

---

## 2. NULVERZAMELING VAN GEGEVENS

**Wij verzamelen geen persoonsgegevens.**

AutoBrew draait volledig op uw Mac. Er is geen AutoBrew-account, geen telemetrie, geen analyse, geen crashrapportage, geen configuratie op afstand. Aangezien wij geen persoonsgegevens onder onze controle verwerken, zijn de meeste exploitantverplichtingen uit de AVG (papierwerk voor internationale doorgifte, verwerkersovereenkomsten, meldingsplicht bij datalekken aan onze zijde) niet op ons als uitgever van de Software van toepassing. In paragraaf 6 worden niettemin de rechten beschreven die u op grond van het toepasselijk recht toekomen.

---

## 3. GEGEVENS DIE LOKAAL OP UW APPARAAT WORDEN OPGESLAGEN

AutoBrew slaat de volgende gegevens lokaal op. **Geen daarvan verlaat uw Mac, tenzij u die zelf besluit te delen.**

### 3.1 Instellingen (UserDefaults)

- Triggermodus (inactief / gepland)
- Drempel voor inactiviteit (minuten) en geplande tijd
- Tijdstip van de laatste run
- Voorkeur voor starten bij inloggen
- Voorkeur voor meldingen
- Bewaarinstellingen voor snapshots
- Standaardupdatebeleid (patch/minor/major × cask/formula) en uitzonderingen per pakket
- Onboardingstatus

### 3.2 Updatebeleidsstatus (Application Support)

- `UpdateLedger.json` — wanneer elke `(kind, token, version)` voor het eerst als verouderd verscheen, zodat het cool-off-venster kan worden gemeten. Tokens zijn Homebrew-pakketnamen; geen gebruikersidentifiers.
- `PendingUpdates.json` — vermeldingen van major-updates die in afwachting zijn van uw beslissing (goedkeuren / afwijzen).

### 3.3 Icooncache (Application Support)

- Gecachte PNG's van cask-iconen die zijn opgehaald via de iTunes Search API (anonieme opzoeking op app-naam) en icon.horse als fallback. Opgeslagen in `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 App-snapshots (Application Support)

- ZIP-gebundelde kopieën van `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers` enz. voor apps waarvan u expliciet een snapshot maakt. Opgeslagen in `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Logs (os.Logger)

- Diagnostische gebeurtenissen die via het unified logging-systeem van Apple worden weggeschreven. Zichtbaar in Console.app. Worden nergens naartoe verzonden.

U kunt alle lokaal opgeslagen gegevens verwijderen door AutoBrew te de-installeren, de supportmap (`~/Library/Application Support/AutoBrew/`) te verwijderen en het UserDefaults-plist (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`) te wissen.

---

## 4. NETWERKACTIVITEIT

AutoBrew doet in drie situaties uitgaande verzoeken. Geen daarvan verzendt persoonsgegevens.

### 4.1 Homebrew-pakketbewerkingen

AutoBrew roept het lokaal geïnstalleerde `brew`-binair aan. Het Homebrew-project neemt vervolgens contact op met `formulae.brew.sh`, GitHub, CDN-mirrors en de individuele download-URL's van casks. Wij hebben geen relatie met deze endpoints — zij worden geëxploiteerd door het Homebrew-project en de respectieve cask-uitgevers onder hun eigen privacyvoorwaarden.

### 4.2 Cask-catalogus en icoonresolutie

- `formulae.brew.sh/api/cask.json` — anonieme ophaling van de openbare cask-catalogus
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — anonieme ophaling van installatiestatistieken over 365 dagen
- `itunes.apple.com/search` — anonieme opzoeking van macOS-app-iconen op weergavenaam
- `icon.horse` — fallback-favicon-opzoeking op basis van de `homepage`-URL van de cask

### 4.3 Controle op automatische updates

Sparkle neemt periodiek contact op met de AutoBrew-appcast-URL op GitHub om te controleren op nieuwe AutoBrew-releases. Het verzoek bevat uw macOS-versie en de AutoBrew-versie (standaard `User-Agent`), zonder verdere identifiers.

---

## 5. DIENSTEN VAN DERDEN (GEEN SUBVERWERKERS)

Wij schakelen geen subverwerkers in, omdat wij uw gegevens niet verwerken. De diensten van derden waarmee AutoBrew communiceert, handelen zelfstandig en onder hun eigen voorwaarden:

| Dienst | Doel | Exploitant |
|---|---|---|
| Homebrew + formulae.brew.sh | Pakketbeheer en catalogus | Homebrew-project |
| Apple iTunes Search API | Opzoeking van app-iconen | Apple Inc. |
| icon.horse | Favicon-fallback | icon.horse |
| GitHub (appcast, releases) | Distributie- en updatekanaal | GitHub, Inc. |

Wanneer u in AutoBrew op een Sponsor-link klikt, verlaat u de app en gaat uw browser naar GitHub Sponsors — die interactie wordt beheerst door het privacybeleid van GitHub.

---

## 6. UW RECHTEN

Aangezien wij geen persoonsgegevens op onze servers bewaren, kunt u de rechten op inzage, rectificatie, verwijdering, overdraagbaarheid, bezwaar en beperking op grond van de artikelen 15–22 AVG en gelijkwaardige nationale wetgeving in feite uitoefenen door AutoBrew van uw Mac te verwijderen.

U kunt nog steeds contact met ons opnemen via **data-protection@digitalfreedom.co.za** voor vragen over dit beleid.

U kunt een klacht indienen bij de voor u bevoegde gegevensbeschermingsautoriteit. In Duitsland is dat de Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). De EU vermeldt de nationale autoriteiten op https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. KINDEREN

AutoBrew is een ontwikkelaarshulpprogramma voor macOS. Het is niet gericht op kinderen jonger dan 16 jaar. Wij verzamelen geen persoonsgegevens en verwerken dus ook geen gegevens van kinderen.

---

## 8. BEVEILIGING

- Het applicatiebinair is ondertekend met het Apple Developer ID-certificaat en genotariseerd door Apple.
- Automatische updates worden geverifieerd aan de hand van een EdDSA Ed25519-handtekening voordat ze worden toegepast.
- AutoBrew draait onder Hardened Runtime; direct gedistribueerde apps die met systeemtools communiceren, kunnen geen volledige App Sandbox gebruiken zonder de use case te breken, dus verschepen wij de minimale entitlements die nodig zijn.
- De broncode is openbaar controleerbaar op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. INTERNATIONALE DOORGIFTE

Wij geven geen persoonsgegevens door, omdat wij ze niet verzamelen. De diensten van derden die u via AutoBrew bereikt (servers van het Homebrew-project, Apple, icon.horse, GitHub) opereren mogelijk buiten de EU; doorgiften aan die diensten vinden plaats tussen u en hen, niet tussen u en ons.

---

## 10. WIJZIGINGEN IN DIT BELEID

Wij kunnen dit Privacybeleid bijwerken om wijzigingen in de architectuur van AutoBrew of in het toepasselijk recht weer te geven. De datum "Laatst bijgewerkt" bovenaan geeft de meest recente revisie weer. Wezenlijke wijzigingen worden in de releasenotes van AutoBrew gecommuniceerd.

### 10.1 Toekomstige betaalde functies

AutoBrew is momenteel gratis en werkt zonder enige back-end (zie paragraaf 2). De Uitgever behoudt zich het recht voor om in toekomstige versies optionele **betaalde functies**, **betaalde edities** of **betaalde aanvullende diensten** te introduceren, waarvoor beperkte gegevensverwerking nodig kan zijn (bijvoorbeeld betalingsverwerking via een externe aanbieder of een licentiesleutelcontrole). Een dergelijke wijziging zal:

- Vooraf worden aangekondigd in de releasenotes van AutoBrew en in dit Privacybeleid
- Strikt opt-in zijn — de gratis, gegevensloze versie blijft bruikbaar
- Worden gedocumenteerd in een specifieke paragraaf van dit Privacybeleid voordat enige nieuwe gegevensstroom wordt geactiveerd

De huidige verklaring "nulverzameling van gegevens" geldt voor de huidige versie van AutoBrew. Het is geen eeuwigdurende garantie voor elke toekomstige uitgave; wij houden dit beleid actueel zodat het steeds het werkelijke gedrag beschrijft.

---

## 11. CONTACT

Voor vragen over gegevensbescherming:
**data-protection@digitalfreedom.co.za**

Voor al het overige:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (handelend onder de naam DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Duitsland
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
