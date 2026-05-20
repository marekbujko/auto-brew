# NUTZUNGSBEDINGUNGEN

## AutoBrew

**Gültig ab:** Mai 2026
**Zuletzt aktualisiert:** Mai 2026

Diese Nutzungsbedingungen („Bedingungen") regeln die Nutzung von AutoBrew (die „Software"). Bitte sorgfältig lesen. Mit der Installation oder Nutzung von AutoBrew erklärt sich der Nutzer mit diesen Bedingungen einverstanden.

---

## 1. ANBIETER

Die Software wird unter der Marke **DigitalFreedom** veröffentlicht. Die dahinterstehende juristische Einheit ist:

Berger & Rosenstock GbR (handelnd unter der Marke DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Deutschland
Vertretungsberechtigte Gesellschafter: Marcel R. G. Berger, Jasmin Rosenstock
E-Mail: hello@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

Diese Bedingungen gelten weltweit. Zwingende Verbraucherschutzrechte sowie sonstige gesetzliche Rechte, die dem Nutzer nach dem Recht seines Aufenthaltslandes zustehen, bleiben unberührt und gehen vor, soweit sie weitergehenden Schutz bieten.

---

## 2. DIE SOFTWARE

AutoBrew ist ein Menüleisten-Werkzeug für macOS, das Homebrew-Updates automatisiert, den Homebrew-Cask-Katalog durchsucht und App-Snapshots für die Migration zwischen Macs verwaltet. Die Software ist:

- **Open Source** unter der MIT-Lizenz — vollständiger Quellcode unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Kostenfrei** — keine In-App-Käufe, keine Abonnements, keine kostenpflichtige Stufe, keine Testperiode
- **Direkt vertrieben** — notarisiertes DMG über GitHub Releases sowie über einen Homebrew-Tap; nicht über den Apple App Store oder den Google Play Store
- **Ausschließlich lokal** — läuft vollständig auf dem Mac des Nutzers, kein AutoBrew-Konto und kein Backend-Dienst erforderlich (siehe [Datenschutzerklärung](PrivacyPolicy.md))

Diese Bedingungen gelten für die AutoBrew-Binärdatei. Die MIT-Lizenz (wiedergegeben im [EULA](EULA.md) und in den [Open-Source-Lizenzen](OpenSourceLicenses.md)) regelt den Quellcode sowie etwaige Forks oder abgeleitete Werke.

---

## 3. NUTZUNGSLIZENZ

Vorbehaltlich der Einhaltung dieser Bedingungen und der MIT-Lizenz darf der Nutzer:

- AutoBrew auf einer beliebigen Anzahl von Macs, über die er die Verfügungsgewalt hat, installieren, ausführen, verändern und weitergeben
- Den Quellcode forken und unter den Bedingungen der MIT-Lizenz abgeleitete Werke erstellen

Der Nutzer darf nicht:

- Die Herkunft der Software falsch darstellen (die MIT-Lizenz verlangt, dass der ursprüngliche Urheberrechtsvermerk erhalten bleibt)
- Die eingebetteten Lizenzhinweise von Sparkle, bsdiff, sais-lite oder pdqsort bei der Weitergabe entfernen
- Den Namen **AutoBrew** oder die Marke **DigitalFreedom** auf abgeleiteten Werken ohne unsere schriftliche Zustimmung verwenden (Markenrecht, siehe Dokument [Markenhinweis](Trademark.md))

---

## 4. KEIN KONTO, KEINE ZAHLUNG (DERZEITIGER STAND)

AutoBrew erfordert derzeit weder eine Registrierung noch eine Anmeldung oder Zahlung. Der **Sponsor**-Link innerhalb der App führt zu GitHub Sponsors und ist **vollständig freiwillig** — jeder Beitrag wird als Spende behandelt und begründet keinerlei Anspruch auf Funktionen oder Support.

### 4.1 Vorbehalt hinsichtlich künftiger kostenpflichtiger Funktionen

Der Anbieter behält sich vor, in zukünftigen Versionen von AutoBrew optionale **kostenpflichtige Funktionen**, **kostenpflichtige Editionen** oder **kostenpflichtige Zusatzdienste** einzuführen. Für jedes solche künftige kostenpflichtige Angebot gilt:

- Es wird vorab in der Anwendungsoberfläche sowie in den offiziellen Release-Notes angekündigt
- Es wirkt ausschließlich zukunftsgerichtet — das Recht des Nutzers, die derzeitige kostenfreie Version weiterhin zu nutzen, bleibt unberührt
- Der Open-Source-Kern bleibt unangetastet: Der Quellcode unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) bleibt weiterhin unter der MIT-Lizenz verfügbar

Das derzeitige Fehlen kostenpflichtiger Funktionen begründet keine Garantie, dass AutoBrew in jeder zukünftigen Version frei von kostenpflichtigen Funktionen bleiben wird.

---

## 5. ABHÄNGIGKEIT VON HOMEBREW

AutoBrew benötigt für seinen Zweck eine funktionsfähige Homebrew-Installation. AutoBrew ruft die `brew`-Binärdatei auf und liest bzw. schreibt Daten unter Verwendung der Befehle und Konventionen des Homebrew-Projekts. Wir sind nicht mit dem Homebrew-Projekt verbunden; wir haben keinen Einfluss darauf, welche Pakete verfügbar sind, wann Versionen veröffentlicht werden oder was die einzelnen Cask-Herausgeber mit ihren Installern tun.

Wenn die Installation eines Casks fehlschlägt, sich unerwartet verhält oder einen Schaden verursacht, ist dies eine Angelegenheit zwischen dem Nutzer und dem jeweiligen Cask-Herausgeber bzw. dem Homebrew-Projekt — siehe Abschnitt 7 (Gewährleistungsausschluss) und Abschnitt 8 (Haftungsbeschränkung).

---

## 6. UPDATES

AutoBrew nutzt das Sparkle-Framework, um in-app Updates über den offiziellen AutoBrew-Appcast auf GitHub auszuliefern. Updates werden mit einem EdDSA-Ed25519-Schlüssel signiert und vor der Anwendung geprüft. Auto-Updates lassen sich in den Einstellungen deaktivieren.

Der Nutzer kann in-app Updates ignorieren und die Binärdatei stattdessen über seinen Homebrew-Tap oder durch manuellen Download eines neueren DMG aktualisieren.

---

## 7. GEWÄHRLEISTUNGSAUSSCHLUSS

Die Software wird **„wie besehen"** und **„wie verfügbar"** ohne jegliche ausdrückliche oder konkludente Gewährleistung bereitgestellt, einschließlich, aber nicht beschränkt auf konkludente Gewährleistungen der Marktgängigkeit, der Eignung für einen bestimmten Zweck und der Nichtverletzung von Rechten Dritter.

Ohne Einschränkung des Vorstehenden gewährleisten wir nicht, dass:

- Die Software unterbrechungs- oder fehlerfrei läuft
- Das Zusammenwirken von AutoBrew mit Homebrew, mit einzelnen Casks oder mit macOS selbst stets das gewünschte Ergebnis liefert
- Von AutoBrew erstellte Snapshots jeden Aspekt des Anwendungszustands vollständig erfassen — Apps, die Daten außerhalb der üblichen Library-Unterverzeichnisse speichern, werden möglicherweise nicht vollständig erfasst

Gesetzliche Gewährleistungsrechte, die nach dem örtlichen Verbraucherschutzrecht nicht vertraglich ausgeschlossen werden können (z. B. die deutsche Mängelhaftung gemäß §§ 434 ff. BGB, soweit anwendbar), bleiben unberührt.

---

## 8. HAFTUNGSBESCHRÄNKUNG

Soweit nach geltendem Recht zulässig:

- Haften wir nicht für indirekte, beiläufige, Folge-, exemplarische oder Strafschäden
- Haften wir nicht für Datenverlust, entgangenen Gewinn, Betriebsunterbrechung oder Schäden, die aus Drittsoftware (Homebrew, einzelne Casks) entstehen, die über AutoBrew aufgerufen wird

Für Nutzer mit gewöhnlichem Aufenthalt in Deutschland oder der EU bleibt unsere Haftung für Schäden aus **grober Fahrlässigkeit oder Vorsatz**, für **Verletzungen des Lebens, des Körpers oder der Gesundheit** sowie nach den **zwingenden Vorschriften des Produkthaftungsgesetzes (ProdHaftG)** unberührt.

---

## 9. BEENDIGUNG

Der Nutzer kann die Nutzung von AutoBrew jederzeit beenden, indem er die Software deinstalliert. Durch das Entfernen von AutoBrew und des zugehörigen Support-Ordners (`~/Library/Application Support/AutoBrew/`) wird der Mac in einen Zustand zurückversetzt, in dem keine AutoBrew-Artefakte zurückbleiben.

Wir können den Vertrieb von AutoBrew jederzeit einstellen. Da die Software Open Source unter MIT ist, bleibt es dem Nutzer und der Community unbenommen, AutoBrew eigenständig zu forken, zu bauen und auszuführen.

---

## 10. ÄNDERUNGEN DIESER BEDINGUNGEN

Wir können diese Bedingungen ändern, um Änderungen an der Software oder am geltenden Recht abzubilden. Wesentliche Änderungen werden in den AutoBrew-Release-Notes kommuniziert. Das Datum „Zuletzt aktualisiert" am Anfang gibt die jeweils aktuellste Überarbeitung an.

---

## 11. ANWENDBARES RECHT UND GERICHTSSTAND

Diese Bedingungen unterliegen dem Recht der Bundesrepublik Deutschland unter Ausschluss des UN-Kaufrechts (CISG).

Für Verbraucher mit gewöhnlichem Aufenthalt außerhalb Deutschlands gilt ergänzend das zwingende Verbraucherschutzrecht ihres Aufenthaltslandes. Der nicht-ausschließliche Gerichtsstand für Streitigkeiten ist Bad Nauheim, Deutschland; Verbrauchern bleibt es unbenommen, an ihrem Wohnsitzgericht zu klagen, soweit das örtliche Recht dies zulässt.

Für Verbraucherstreitigkeiten nach EU-Recht steht die Plattform der Europäischen Kommission zur Online-Streitbeilegung unter https://ec.europa.eu/consumers/odr zur Verfügung. Wir sind weder verpflichtet noch bereit, an alternativen Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle gemäß § 36 VSBG teilzunehmen.

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
