# EINDGEBRUIKERSLICENTIEOVEREENKOMST (EULA)

## AutoBrew

**Ingangsdatum:** mei 2026
**Laatst bijgewerkt:** mei 2026

Deze Eindgebruikerslicentieovereenkomst ("EULA", "Overeenkomst") is een juridisch contract tussen u ("Gebruiker", "u") en de uitgever van AutoBrew, **Berger & Rosenstock GbR**, handelend onder de naam **DigitalFreedom** ("Uitgever", "wij", "ons", "onze").

Door AutoBrew (de "Software") te installeren, te kopiëren of anderszins te gebruiken, verbindt u zich aan de voorwaarden van deze EULA.

---

## 1. DE SOFTWARE

AutoBrew is een macOS-menubalkhulpprogramma dat Homebrew-updates automatiseert, door de Homebrew-cask-catalogus bladert en app-snapshots beheert. De Software wordt uitgegeven onder het merk DigitalFreedom en aan u in licentie gegeven onder onderstaande voorwaarden.

### 1.1 Licentiemodel

AutoBrew wordt uitgebracht als **gratis open-source-software** onder de MIT-licentie. De volledige tekst van de MIT-licentie is overgenomen in paragraaf 6 en in het document [Open-source-licenties](OpenSourceLicenses.md). De MIT-licentie regelt de broncode; deze EULA regelt de binaire distributie en uw verplichtingen als gebruiker van het binair.

### 1.2 Voorbehoud ten aanzien van toekomstige betaalde functies

De Uitgever behoudt zich het recht voor om op elk moment optionele **betaalde functies**, **betaalde edities** of **betaalde aanvullende diensten** te introduceren. Dergelijke toekomstige wijzigingen zullen:

- Vooraf worden aangekondigd via de applicatie-UI en de officiële releasenotes
- Uitsluitend voorwaarts werken (d.w.z. bestaande gratis functionaliteit van een versie die u al heeft geïnstalleerd, blijft gratis te gebruiken)
- De open-source-kern onder de MIT-licentie intact laten — de broncode op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) blijft beschikbaar onder dezelfde licentie, ongeacht eventuele betaalde toevoegingen

Het huidige ontbreken van enige betaalde functie vormt geen garantie dat AutoBrew voor altijd vrij blijft van betaalde functies.

### 1.3 Open-source-omvang versus betaalde functies

De MIT-licentie is van toepassing op de AutoBrew-broncode zoals gepubliceerd in de officiële repository op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Forks en afgeleide werken van die codebasis zijn uitdrukkelijk toegestaan** onder de voorwaarden van de MIT-licentie — wij verwelkomen het dat de community op AutoBrew voortbouwt.

Eventuele **toekomstige betaalde functies**, **betaalde edities** of **betaalde aanvullende diensten** (zie paragraaf 1.2) zullen worden uitgebracht onder een **afzonderlijke proprietary licentie** en zullen **geen** deel uitmaken van de codebasis onder de MIT-licentie. In het bijzonder:

- De broncode van betaalde functies wordt niet in de MIT-repository gepubliceerd
- Het kopiëren, decompileren, reverse-engineeren of anderszins reproduceren van de implementatie van enige door AutoBrew uitgebrachte proprietary betaalde functie is niet toegestaan, behoudens voor zover uitdrukkelijk toegestaan door dwingend toepasselijk recht (bijvoorbeeld § 69e UrhG / artikel 6 van EU-richtlijn 2009/24/EG voor interoperabiliteit)
- Deze beperking ziet specifiek op de implementatie van de betaalde functie — zij beperkt niet het recht van derden om vergelijkbare functionaliteit zelfstandig en vanaf nul te ontwikkelen

De handelsmerken **"AutoBrew"** en **"DigitalFreedom"** mogen niet worden gebruikt door forks of afgeleide werken die concurrerende betaalde functies aanbieden — zie paragraaf 3 van deze EULA en de [Handelsmerk](Trademark.md)-disclaimer.

### 1.4 Distributiekanalen

Het officiële AutoBrew-binair wordt uitsluitend verspreid via:

- **GitHub Releases** op [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — genotariseerde DMG-bestanden ondertekend met het Apple Developer ID-certificaat
- De **Homebrew-tap** op [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew wordt **niet** verspreid via de Apple App Store, de Google Play Store of enig downloadportaal van derden. Indien u AutoBrew elders heeft verkregen, is het binair niet geverifieerd en valt het niet onder deze EULA.

---

## 2. VERLENING VAN LICENTIE

Onder voorbehoud van uw naleving van deze EULA en de MIT-licentie verleent de Uitgever u een wereldwijde, royaltyvrije, niet-exclusieve licentie om:

- AutoBrew te installeren en uit te voeren op een willekeurig aantal Macs waarvan u eigenaar of beheerder bent
- De broncode te wijzigen en afgeleide werken te maken
- De Software in broncode- of binaire vorm te herdistribueren

---

## 3. BEPERKINGEN

U mag niet:

- De auteursrechtmeldingen, de tekst van de MIT-licentie of de gebundelde Sparkle-/bsdiff-/sais-lite-/pdqsort-licentievermeldingen verwijderen, wijzigen of onleesbaar maken bij herdistributie
- De handelsmerken **"AutoBrew"** en **"DigitalFreedom"** gebruiken in de naam van een fork of afgeleid werk zonder onze voorafgaande schriftelijke toestemming (zie het document [Handelsmerk](Trademark.md))
- Uw fork verkeerd voorstellen als de officiële AutoBrew-distributie

---

## 4. COMPONENTEN VAN DERDEN

AutoBrew bundelt de volgende open-source-componenten, elk geregeld door een eigen licentie (zie het document [Open-source-licenties](OpenSourceLicenses.md) voor de volledige lijst en de letterlijke licentieteksten):

- **Sparkle** (MIT) — automatische in-app-updates
- **bsdiff / bspatch** (BSD-2-Clause) — gebundeld in Sparkle voor binaire delta's
- **sais-lite** (MIT) — gebundeld in Sparkle
- **pdqsort** (zlib) — gebundeld in Sparkle

AutoBrew vertrouwt tijdens runtime ook op **Homebrew** (BSD-2-Clause) — aangeroepen via process spawning, niet ingebed. Homebrew moet apart worden geïnstalleerd; AutoBrew begeleidt u bij de installatie ervan tijdens het eerste gebruik.

De op deze componenten toepasselijke MIT-, BSD-2-Clause- en zlib-licenties blijven onafhankelijk van deze EULA van kracht. Bij strijdigheid tussen deze EULA en een open-source-licentie prevaleert de open-source-licentie voor het betreffende component.

---

## 5. GEEN BETALING, GEEN ACCOUNT (HUIDIGE TOESTAND)

AutoBrew is momenteel gratis. De Software vereist geen registratie, geen aanmelding en geen enkele betaling, en op het moment van deze EULA zijn er geen in-app-aankopen, geen abonnementen, geen betaalde functies en geen proefmechanismen.

De **Sponsor**-link in AutoBrew verwijst naar GitHub Sponsors en is **volledig vrijwillig**. Elke bijdrage wordt behandeld als een donatie en verleent geen extra rechten.

**Voorbehoud:** zie paragraaf 1.2 — de Uitgever behoudt zich het recht voor om in de toekomst optionele betaalde functies, betaalde edities of betaalde aanvullende diensten te introduceren. Dergelijke toekomstige betaalde aanbiedingen zullen uitsluitend gelden voor gebruikers die uitdrukkelijk opt-in geven; de huidige gratis functionaliteit die u heeft geïnstalleerd, wordt niet met terugwerkende kracht achter een betaalmuur geplaatst.

---

## 6. MIT-LICENTIE (letterlijk)

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

## 7. GARANTIEVRIJWARING

De Software wordt geleverd **"AS IS"**, zonder garantie van welke aard dan ook, uitdrukkelijk of impliciet. De Uitgever garandeert niet dat de Software ononderbroken of foutloos zal werken, dat de interactie van AutoBrew met Homebrew of met individuele casks altijd zal slagen, of dat snapshots elk aspect van de toestand van een applicatie perfect zullen vastleggen.

Wettelijke garantierechten die niet bij overeenkomst kunnen worden uitgesloten op grond van het op u toepasselijke consumentenrecht (bijvoorbeeld de Duitse Mängelhaftung op grond van §§ 434 e.v. BGB, voor zover van toepassing) blijven onverlet.

---

## 8. BEPERKING VAN AANSPRAKELIJKHEID

Voor zover wettelijk toegestaan, is de Uitgever niet aansprakelijk voor indirecte, incidentele, gevolg-, exemplarische of punitieve schade — met inbegrip van gegevensverlies, gederfde winst of schade die voortvloeit uit software van derden (Homebrew, individuele casks) die via AutoBrew wordt aangeroepen.

Voor gebruikers met gewone verblijfplaats in Duitsland of de EU blijft onze aansprakelijkheid voor schade door **grove nalatigheid of opzet**, voor **letsel aan leven, lichaam of gezondheid** en op grond van de **Duitse Productaansprakelijkheidswet (ProdHaftG)** onverlet.

---

## 9. EXPORTCONTROLE

De Software bevat geen cryptografie buiten wat macOS van Apple en het Sparkle-framework standaard leveren. De export van macOS zelf is onderworpen aan de voorwaarden van Apple; u blijft zelf verantwoordelijk voor de naleving van de in uw rechtsgebied toepasselijke exportcontrolewetgeving.

---

## 10. BEËINDIGING

Deze EULA is van kracht totdat zij wordt beëindigd. Zij eindigt automatisch en zonder kennisgeving indien u een van de bepalingen niet naleeft. U kunt deze ook op elk moment beëindigen door AutoBrew te de-installeren. Na beëindiging dient u elk gebruik van de Software te staken en alle kopieën in uw beheer te verwijderen.

---

## 11. TOEPASSELIJK RECHT EN BEVOEGDE RECHTER

Op deze EULA is het recht van de Bondsrepubliek Duitsland van toepassing, met uitsluiting van het Weens Koopverdrag (CISG). Daarnaast is het dwingende consumentenrecht van het land van verblijf van de gebruiker van toepassing.

Niet-uitsluitend bevoegd is Bad Nauheim, Duitsland. Consumenten kunnen een procedure aanhangig maken bij hun woonplaats wanneer het lokale recht dit toestaat.

---

## 12. CONTACT

Berger & Rosenstock GbR (handelend onder de naam DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Duitsland
E-mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
