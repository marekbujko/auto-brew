# GEBRUIKSVOORWAARDEN

## AutoBrew

**Ingangsdatum:** mei 2026
**Laatst bijgewerkt:** mei 2026

Deze Gebruiksvoorwaarden ("Voorwaarden") zijn van toepassing op uw gebruik van AutoBrew (de "Software"). Lees ze zorgvuldig door. Door AutoBrew te installeren of te gebruiken, verbindt u zich aan deze Voorwaarden.

---

## 1. AANBIEDER

De Software wordt uitgegeven onder het merk **DigitalFreedom**. De rechtspersoon erachter is:

Berger & Rosenstock GbR (handelend onder de naam DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Duitsland
Bevoegde vertegenwoordigers: Marcel R. G. Berger, Jasmin Rosenstock
E-mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

Deze Voorwaarden gelden wereldwijd. Dwingende rechten inzake consumentenbescherming en andere wettelijke rechten die de gebruiker in het land van verblijf toekomen, blijven onverlet en gaan voor wanneer zij meer bescherming bieden.

---

## 2. DE SOFTWARE

AutoBrew is een macOS-menubalkhulpprogramma dat Homebrew-updates automatiseert, door de Homebrew-cask-catalogus bladert en app-snapshots beheert voor migratie tussen Macs. De Software is:

- **Open source** onder de MIT-licentie — volledige broncode op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Gratis** — geen in-app-aankopen, geen abonnementen, geen betaalde laag, geen proefperiode
- **Direct verspreid** — genotariseerd DMG via GitHub Releases en een Homebrew-tap; niet via de Apple App Store of de Google Play Store
- **Uitsluitend lokaal** — draait volledig op uw Mac, geen AutoBrew-account of back-enddienst vereist (zie het [Privacybeleid](PrivacyPolicy.md))

Deze Voorwaarden zijn van toepassing op het AutoBrew-binair. De MIT-licentie (overgenomen in de [EULA](EULA.md) en in de [Open-source-licenties](OpenSourceLicenses.md)) regelt de broncode en eventuele forks of afgeleide werken.

---

## 3. GEBRUIKSLICENTIE

Onder voorbehoud van uw naleving van deze Voorwaarden en de MIT-licentie mag u:

- AutoBrew installeren, uitvoeren, wijzigen en herdistribueren op een willekeurig aantal Macs waarover u beschikt
- De broncode forken en afgeleide werken maken onder de voorwaarden van de MIT-licentie

U mag niet:

- De herkomst van de Software verkeerd voorstellen (de MIT-licentie vereist dat de oorspronkelijke auteursrechtmelding behouden blijft)
- De gebundelde Sparkle-, bsdiff-, sais-lite- of pdqsort-licentievermeldingen verwijderen bij herdistributie
- De naam **AutoBrew** of het merk **DigitalFreedom** op afgeleide werken gebruiken zonder onze schriftelijke toestemming (handelsmerk, zie het document [Handelsmerk](Trademark.md))

---

## 4. GEEN ACCOUNT, GEEN BETALING (HUIDIGE TOESTAND)

AutoBrew vereist op dit moment geen registratie, geen aanmelding en geen enkele betaling. De **Sponsor**-link in de app verwijst naar GitHub Sponsors en is **volledig vrijwillig** — elke bijdrage wordt behandeld als een donatie en geeft geen recht op functies of ondersteuning.

### 4.1 Voorbehoud ten aanzien van toekomstige betaalde functies

De Aanbieder behoudt zich het recht voor om in toekomstige versies van AutoBrew optionele **betaalde functies**, **betaalde edities** of **betaalde aanvullende diensten** te introduceren. Dergelijke toekomstige betaalde aanbiedingen zullen:

- Vooraf worden aangekondigd via de applicatie-UI en de officiële releasenotes
- Uitsluitend voorwaarts werken — uw recht om de huidige gratis versie te blijven gebruiken blijft onverlet
- De open-source-kern intact laten: de broncode op [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) blijft beschikbaar onder de MIT-licentie

Het huidige ontbreken van betaalde functies vormt geen garantie dat AutoBrew in elke toekomstige uitgave gratis blijft.

---

## 5. AFHANKELIJKHEID VAN HOMEBREW

AutoBrew is afhankelijk van een werkende Homebrew-installatie om zijn doel te vervullen. AutoBrew roept het `brew`-binair aan en leest en schrijft gegevens met behulp van de eigen commando's en conventies van het Homebrew-project. Wij zijn niet gelieerd aan het Homebrew-project; wij hebben geen invloed op welke pakketten beschikbaar zijn, wanneer versies worden uitgebracht, of wat de individuele cask-uitgevers met hun installers doen.

Indien de installatie van een cask mislukt, zich onverwacht gedraagt of schade veroorzaakt, is dat een aangelegenheid tussen u en de cask-uitgever en/of het Homebrew-project — zie paragraaf 7 (Garantievrijwaring) en paragraaf 8 (Beperking van aansprakelijkheid).

---

## 6. UPDATES

AutoBrew gebruikt het Sparkle-framework om in-app-updates uit te leveren vanaf de officiële AutoBrew-appcast op GitHub. Updates worden ondertekend met een EdDSA Ed25519-sleutel en geverifieerd voordat ze worden toegepast. Automatische updates kunnen in de instellingen worden uitgeschakeld.

Het staat u vrij om in-app-updates te negeren en het binair via uw Homebrew-tap te updaten of handmatig een nieuwere DMG te downloaden.

---

## 7. GARANTIEVRIJWARING

De Software wordt geleverd **"AS IS"** en **"AS AVAILABLE"**, zonder garantie van welke aard dan ook, uitdrukkelijk of impliciet, met inbegrip van maar niet beperkt tot de impliciete garanties van verkoopbaarheid, geschiktheid voor een bepaald doel en niet-inbreuk.

Onverminderd het voorgaande garanderen wij niet dat:

- De Software ononderbroken of foutloos zal werken
- De interactie van AutoBrew met Homebrew, met individuele casks of met macOS zelf altijd het gewenste resultaat zal opleveren
- Snapshots die door AutoBrew worden gemaakt elk aspect van de toestand van een app perfect vastleggen — apps die gegevens buiten de standaard Library-submappen opslaan, worden mogelijk niet volledig vastgelegd

Wettelijke garantierechten die niet bij overeenkomst kunnen worden uitgesloten op grond van het op u toepasselijke consumentenrecht (bijvoorbeeld de Duitse Mängelhaftung op grond van §§ 434 e.v. BGB, voor zover van toepassing) blijven onverlet.

---

## 8. BEPERKING VAN AANSPRAKELIJKHEID

Voor zover wettelijk toegestaan:

- Zijn wij niet aansprakelijk voor indirecte, incidentele, gevolg-, exemplarische of punitieve schade
- Zijn wij niet aansprakelijk voor gegevensverlies, gederfde winst, bedrijfsonderbreking of enige schade die voortvloeit uit software van derden (Homebrew, individuele casks) die via AutoBrew wordt aangeroepen

Voor gebruikers met gewone verblijfplaats in Duitsland of de EU blijft onze aansprakelijkheid voor schade door **grove nalatigheid of opzet**, voor **letsel aan leven, lichaam of gezondheid** en op grond van **dwingende bepalingen van de Duitse Productaansprakelijkheidswet (ProdHaftG)** onverlet.

---

## 9. BEËINDIGING

U kunt het gebruik van AutoBrew op elk moment beëindigen door de app te de-installeren. Door AutoBrew en de supportmap (`~/Library/Application Support/AutoBrew/`) te verwijderen, brengt u uw Mac terug in een toestand waarin geen AutoBrew-artefacten meer aanwezig zijn.

Wij kunnen de verspreiding van AutoBrew op elk moment staken. Aangezien de Software open source onder MIT is, blijft het u en de community vrij staan deze te forken, te bouwen en zelfstandig uit te voeren.

---

## 10. WIJZIGINGEN IN DEZE VOORWAARDEN

Wij kunnen deze Voorwaarden bijwerken om wijzigingen in de Software of in het toepasselijk recht weer te geven. Wezenlijke wijzigingen worden in de releasenotes van AutoBrew gecommuniceerd. De datum "Laatst bijgewerkt" bovenaan geeft de meest recente revisie weer.

---

## 11. TOEPASSELIJK RECHT EN BEVOEGDE RECHTER

Op deze Voorwaarden is het recht van de Bondsrepubliek Duitsland van toepassing, met uitsluiting van het Weens Koopverdrag (CISG).

Voor consumenten met gewone verblijfplaats buiten Duitsland is daarnaast het dwingende consumentenrecht van het land van verblijf van toepassing. Niet-uitsluitend bevoegd voor geschillen is Bad Nauheim, Duitsland; consumenten kunnen nog steeds een procedure aanhangig maken bij hun woonplaats wanneer het lokale recht dit toestaat.

Voor consumentengeschillen die voortvloeien uit EU-recht is het platform voor onlinegeschillenbeslechting van de Europese Commissie beschikbaar op https://ec.europa.eu/consumers/odr. Wij zijn niet verplicht en niet bereid om deel te nemen aan alternatieve geschillenbeslechtingsprocedures voor een Verbraucherschlichtungsstelle (consumentenarbitragecommissie) op grond van § 36 VSBG.

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
