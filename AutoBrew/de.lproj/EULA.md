# ENDBENUTZER-LIZENZVERTRAG (EULA)

## AutoBrew

**Gültig ab:** Mai 2026
**Zuletzt aktualisiert:** Mai 2026

Dieser Endbenutzer-Lizenzvertrag („EULA", „Vertrag") ist eine rechtsverbindliche Vereinbarung zwischen dem Nutzer („Nutzer", „Sie") und dem Herausgeber von AutoBrew, der **Berger & Rosenstock GbR**, handelnd unter der Marke **DigitalFreedom** („Anbieter", „wir", „uns", „unser").

Mit der Installation, dem Kopieren oder einer sonstigen Nutzung von AutoBrew (der „Software") erklärt sich der Nutzer mit den Bedingungen dieses EULA einverstanden.

---

## 1. DIE SOFTWARE

AutoBrew ist ein Menüleisten-Werkzeug für macOS, das Homebrew-Updates automatisiert, den Homebrew-Cask-Katalog durchsucht und App-Snapshots verwaltet. Die Software wird unter der Marke DigitalFreedom veröffentlicht und dem Nutzer zu den nachfolgenden Bedingungen lizenziert.

### 1.1 Lizenzmodell

AutoBrew wird als **kostenfreie Open-Source-Software** unter der MIT-Lizenz veröffentlicht. Der vollständige Text der MIT-Lizenz ist in Abschnitt 6 sowie im Dokument [Open-Source-Lizenzen](OpenSourceLicenses.md) wiedergegeben. Die MIT-Lizenz regelt den Quellcode; dieser EULA regelt die Verbreitung der Binärdatei und die Pflichten des Nutzers im Umgang mit der Binärdatei.

### 1.2 Vorbehalt hinsichtlich künftiger kostenpflichtiger Funktionen

Der Anbieter behält sich vor, jederzeit optionale **kostenpflichtige Funktionen**, **kostenpflichtige Editionen** oder **kostenpflichtige Zusatzdienste** einzuführen. Für jede solche künftige Änderung gilt:

- Sie wird vorab in der Anwendungsoberfläche sowie in den offiziellen Release-Notes angekündigt
- Sie wirkt ausschließlich zukunftsgerichtet (d. h. die bestehenden kostenfreien Funktionen einer bereits installierten Version bleiben kostenfrei nutzbar)
- Der Open-Source-Kern bleibt unter der MIT-Lizenz — der Quellcode unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) bleibt unabhängig von etwaigen kostenpflichtigen Ergänzungen unter derselben Lizenz verfügbar

Das derzeitige Fehlen jeglicher kostenpflichtiger Funktionen begründet keine Garantie, dass AutoBrew dauerhaft frei von kostenpflichtigen Funktionen bleiben wird.

### 1.3 Open-Source-Umfang vs. kostenpflichtige Funktionen

Die MIT-Lizenz gilt für den AutoBrew-Quellcode in der Form, in der er im offiziellen Repository unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) veröffentlicht ist. **Forks und abgeleitete Werke dieses Codebestands sind ausdrücklich gestattet** unter den Bedingungen der MIT-Lizenz — wir begrüßen es, wenn die Community auf AutoBrew aufbaut.

Etwaige **künftige kostenpflichtige Funktionen**, **kostenpflichtige Editionen** oder **kostenpflichtige Zusatzdienste** (siehe Abschnitt 1.2) werden unter einer **gesonderten proprietären Lizenz** veröffentlicht und sind **nicht** Bestandteil des unter MIT lizenzierten Codebestands. Insbesondere gilt:

- Der Quellcode kostenpflichtiger Funktionen wird nicht im MIT-Repository veröffentlicht
- Das Kopieren, Dekompilieren, Reverse Engineering oder sonstige Reproduzieren der Implementierung einer von AutoBrew ausgelieferten kostenpflichtigen Funktion ist nicht gestattet, ausgenommen in dem nach zwingendem Recht ausdrücklich zulässigen Umfang (z. B. § 69e UrhG bzw. Art. 6 der EU-Richtlinie 2009/24/EG zur Herstellung von Interoperabilität)
- Diese Beschränkung bezieht sich gezielt auf die Implementierung der kostenpflichtigen Funktion — sie schränkt das Recht eines Dritten, vergleichbare Funktionalität unabhängig und von Grund auf neu zu entwickeln, nicht ein

Die Marken **„AutoBrew"** und **„DigitalFreedom"** dürfen von Forks oder abgeleiteten Werken, die konkurrierende kostenpflichtige Funktionen anbieten, nicht verwendet werden — siehe Abschnitt 3 dieses EULA sowie das Dokument [Markenhinweis](Trademark.md).

### 1.4 Vertriebskanäle

Die offizielle AutoBrew-Binärdatei wird ausschließlich über folgende Kanäle vertrieben:

- **GitHub Releases** unter [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — notarisierte DMG-Dateien, signiert mit dem Apple-Developer-ID-Zertifikat
- Den **Homebrew-Tap** unter [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew wird **nicht** über den Apple App Store, den Google Play Store oder ein sonstiges Download-Portal Dritter vertrieben. Wurde AutoBrew aus einer anderen Quelle bezogen, ist die Binärdatei nicht verifiziert und nicht von diesem EULA erfasst.

---

## 2. LIZENZGEWÄHRUNG

Vorbehaltlich der Einhaltung dieses EULA und der MIT-Lizenz gewährt der Anbieter dem Nutzer eine weltweite, gebührenfreie, nicht-ausschließliche Lizenz zu folgenden Zwecken:

- Installation und Ausführung von AutoBrew auf einer beliebigen Anzahl von Macs, die der Nutzer besitzt oder über die er die Verfügungsgewalt hat
- Veränderung des Quellcodes und Erstellung abgeleiteter Werke
- Weitergabe der Software in Quell- oder Binärform

---

## 3. BESCHRÄNKUNGEN

Der Nutzer darf nicht:

- Bei der Weitergabe die Urheberrechtsvermerke, den MIT-Lizenztext oder die eingebetteten Lizenzhinweise von Sparkle / bsdiff / sais-lite / pdqsort entfernen, verändern oder verschleiern
- Die Marken **„AutoBrew"** und **„DigitalFreedom"** im Namen eines Forks oder abgeleiteten Werks ohne unsere vorherige schriftliche Zustimmung verwenden (siehe Dokument [Markenhinweis](Trademark.md))
- Den eigenen Fork als offizielle AutoBrew-Distribution ausgeben

---

## 4. DRITTKOMPONENTEN

AutoBrew bündelt die folgenden Open-Source-Komponenten, die jeweils ihrer eigenen Lizenz unterliegen (vollständige Liste und wortgetreue Lizenztexte siehe Dokument [Open-Source-Lizenzen](OpenSourceLicenses.md)):

- **Sparkle** (MIT) — in-app Auto-Updates
- **bsdiff / bspatch** (BSD-2-Clause) — in Sparkle gebündelt für Binär-Deltas
- **sais-lite** (MIT) — in Sparkle gebündelt
- **pdqsort** (zlib) — in Sparkle gebündelt

AutoBrew nutzt zur Laufzeit zusätzlich **Homebrew** (BSD-2-Clause) — aufgerufen über Prozessstart, nicht eingebettet. Homebrew muss separat installiert sein; AutoBrew führt den Nutzer beim ersten Start durch die Installation.

Die MIT-, BSD-2-Clause- und zlib-Lizenzen, die auf diese Komponenten anwendbar sind, bleiben unabhängig von diesem EULA in Kraft. Im Falle eines Konflikts zwischen diesem EULA und einer Open-Source-Lizenz geht die Open-Source-Lizenz für die betroffene Komponente vor.

---

## 5. KEINE ZAHLUNG, KEIN KONTO (DERZEITIGER STAND)

AutoBrew ist derzeit kostenfrei. Die Software erfordert weder Registrierung noch Anmeldung oder Zahlung, und zum Zeitpunkt dieses EULA gibt es keine In-App-Käufe, keine Abonnements, keine kostenpflichtigen Funktionen und keine Testperioden-Mechanik.

Der **Sponsor**-Link innerhalb von AutoBrew führt zu GitHub Sponsors und ist **vollständig freiwillig**. Jeder Beitrag wird als Spende behandelt und begründet keine weiteren Ansprüche.

**Vorbehalt:** Siehe Abschnitt 1.2 — der Anbieter behält sich vor, in Zukunft optionale kostenpflichtige Funktionen, kostenpflichtige Editionen oder kostenpflichtige Zusatzdienste einzuführen. Etwaige künftige kostenpflichtige Angebote gelten nur für Nutzer, die ausdrücklich opt-in zustimmen; die derzeit installierten kostenfreien Funktionen werden nicht rückwirkend hinter einer Bezahlschranke verborgen.

---

## 6. MIT-LIZENZ (wortgetreu)

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

## 7. GEWÄHRLEISTUNGSAUSSCHLUSS

Die Software wird **„wie besehen"** ohne jegliche ausdrückliche oder konkludente Gewährleistung bereitgestellt. Der Anbieter gewährleistet nicht, dass die Software unterbrechungs- oder fehlerfrei läuft, dass das Zusammenwirken von AutoBrew mit Homebrew oder mit einzelnen Casks stets gelingt oder dass Snapshots jeden Aspekt des Anwendungszustands vollständig erfassen.

Gesetzliche Gewährleistungsrechte, die nach dem örtlichen Verbraucherschutzrecht nicht vertraglich ausgeschlossen werden können (z. B. die deutsche Mängelhaftung gemäß §§ 434 ff. BGB, soweit anwendbar), bleiben unberührt.

---

## 8. HAFTUNGSBESCHRÄNKUNG

Soweit nach geltendem Recht zulässig, haftet der Anbieter nicht für indirekte, beiläufige, Folge-, exemplarische oder Strafschäden — einschließlich Datenverlust, entgangener Gewinne oder Schäden aus Drittsoftware (Homebrew, einzelne Casks), die über AutoBrew aufgerufen wird.

Für Nutzer mit gewöhnlichem Aufenthalt in Deutschland oder der EU bleibt unsere Haftung für Schäden aus **grober Fahrlässigkeit oder Vorsatz**, für **Verletzungen des Lebens, des Körpers oder der Gesundheit** sowie nach dem **deutschen Produkthaftungsgesetz (ProdHaftG)** unberührt.

---

## 9. EXPORTKONTROLLE

Die Software enthält keine Kryptographie über das hinaus, was Apples macOS und das Sparkle-Framework standardmäßig bereitstellen. Der Export von macOS selbst unterliegt den Bedingungen von Apple; der Nutzer bleibt verantwortlich für die Einhaltung der für seine Rechtsordnung anwendbaren Exportkontrollvorschriften.

---

## 10. BEENDIGUNG

Dieser EULA gilt bis zur Beendigung. Er endet automatisch ohne Vorankündigung, wenn der Nutzer eine seiner Bestimmungen verletzt. Der Nutzer kann ihn zudem jederzeit durch Deinstallation von AutoBrew beenden. Nach Beendigung hat der Nutzer jede Nutzung der Software einzustellen und alle in seiner Verfügungsgewalt befindlichen Kopien zu entfernen.

---

## 11. ANWENDBARES RECHT UND GERICHTSSTAND

Dieser EULA unterliegt dem Recht der Bundesrepublik Deutschland unter Ausschluss des UN-Kaufrechts (CISG). Zwingendes Verbraucherschutzrecht des Aufenthaltslandes des Nutzers gilt ergänzend.

Der nicht-ausschließliche Gerichtsstand ist Bad Nauheim, Deutschland. Verbrauchern bleibt es unbenommen, an ihrem Wohnsitzgericht zu klagen, soweit das örtliche Recht dies zulässt.

---

## 12. KONTAKT

Berger & Rosenstock GbR (handelnd unter der Marke DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Deutschland
E-Mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
