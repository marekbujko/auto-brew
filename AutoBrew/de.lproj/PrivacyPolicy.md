# DATENSCHUTZERKLÄRUNG

## AutoBrew

**Gültig ab:** Mai 2026
**Zuletzt aktualisiert:** Mai 2026

**Dienst betrieben von:** DigitalFreedom — eine Marke der Berger & Rosenstock GbR

**Verantwortlicher (juristische Einheit):**
Berger & Rosenstock GbR (handelnd unter der Marke DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Deutschland

Vertretungsberechtigte Gesellschafter: Marcel R. G. Berger, Jasmin Rosenstock
USt-IdNr.: DE455096022

Kontakt (allgemein): hello@digitalfreedom.co.za
Kontakt (Datenschutz): data-protection@digitalfreedom.co.za
Website: https://digitalfreedom.co.za

---

## 1. EINLEITUNG

Diese Datenschutzerklärung beschreibt, wie DigitalFreedom (eine Marke der Berger & Rosenstock GbR — „wir", „uns", „unser") im Zusammenhang mit der Anwendung AutoBrew („AutoBrew", „die Software") mit Daten umgeht.

AutoBrew ist **Open Source unter der MIT-Lizenz**, **vollständig kostenfrei** und wird direkt als notarisiertes DMG sowie über einen Homebrew-Tap vertrieben — nicht über den Apple App Store oder den Google Play Store. Wir betreiben kein Backend, hosten keine Nutzerkonten und erheben, übermitteln, speichern oder verarbeiten keine personenbezogenen Daten auf unseren Servern.

Wir orientieren uns an der Datenschutz-Grundverordnung (DSGVO) als strengstem Maßstab und wenden diese als globalen Mindeststandard an — die nachfolgenden Schutzregelungen gelten für jeden Nutzer, unabhängig vom Land.

---

## 2. NULL DATENERHEBUNG

**Wir erheben keinerlei personenbezogene Daten.**

AutoBrew läuft vollständig auf dem Mac des Nutzers. Es gibt kein AutoBrew-Konto, keine Telemetrie, keine Analytik, keinen Absturzberichterstatter und keine Fernkonfiguration. Da wir keine personenbezogenen Daten unter unserer Kontrolle verarbeiten, finden die meisten anbieterseitigen Pflichten nach der DSGVO (Drittlandtransfer-Dokumentation, Auftragsverarbeitungsverträge, Meldung von Datenpannen auf unserer Seite) auf uns als Herausgeber der Software keine Anwendung. Abschnitt 6 beschreibt dennoch die Rechte, die dem Nutzer nach geltendem Recht zustehen.

---

## 3. LOKAL AUF DEM GERÄT GESPEICHERTE DATEN

AutoBrew speichert die folgenden Daten lokal. **Keine dieser Daten verlässt den Mac, sofern der Nutzer sie nicht selbst teilt.**

### 3.1 Einstellungen (UserDefaults)

- Auslösemodus (idle / geplant)
- Idle-Schwellwert (Minuten) und geplante Uhrzeit
- Zeitstempel des letzten Laufs
- Einstellung „Beim Anmelden starten"
- Benachrichtigungseinstellung
- Aufbewahrungseinstellungen für Snapshots
- Standardrichtlinien für Updates (patch/minor/major × cask/formula) sowie paketspezifische Überschreibungen
- Onboarding-Status

### 3.2 Update-Richtlinienzustand (Application Support)

- `UpdateLedger.json` — wann jedes `(kind, token, version)` erstmals als veraltet erschien, damit das Cool-off-Fenster gemessen werden kann. Tokens sind Homebrew-Paketnamen; keine Nutzerkennungen.
- `PendingUpdates.json` — Major-Update-Einträge, die auf eine Entscheidung des Nutzers warten (Genehmigung / Ablehnung).

### 3.3 Icon-Cache (Application Support)

- Zwischengespeicherte PNGs der Cask-Icons, abgerufen über die iTunes Search API (anonyme Suche anhand des App-Namens) sowie über icon.horse als Fallback. Abgelegt unter `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 App-Snapshots (Application Support)

- ZIP-gebündelte Kopien von `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers` usw. für Apps, von denen der Nutzer ausdrücklich einen Snapshot anlegt. Abgelegt unter `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Logs (os.Logger)

- Diagnoseereignisse, geschrieben über das einheitliche Apple-Logging-System. Sichtbar in Console.app. Werden nirgendwohin übertragen.

Der Nutzer kann sämtliche lokal gespeicherten Daten löschen, indem er AutoBrew, den zugehörigen Support-Ordner (`~/Library/Application Support/AutoBrew/`) sowie die UserDefaults-Plist (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`) entfernt.

---

## 4. NETZWERKAKTIVITÄT

AutoBrew sendet in drei Situationen ausgehende Anfragen. Keine davon überträgt personenbezogene Daten.

### 4.1 Homebrew-Paketoperationen

AutoBrew ruft die lokal installierte `brew`-Binärdatei auf. Das Homebrew-Projekt kontaktiert daraufhin `formulae.brew.sh`, GitHub, CDN-Mirrors sowie die einzelnen Cask-Download-URLs. Zu diesen Endpunkten haben wir keine Beziehung — sie werden vom Homebrew-Projekt und den jeweiligen Cask-Herausgebern unter deren eigenen Datenschutzbedingungen betrieben.

### 4.2 Cask-Katalog und Icon-Auflösung

- `formulae.brew.sh/api/cask.json` — anonymer Abruf des öffentlichen Cask-Katalogs
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — anonymer Abruf der 365-Tage-Installationsstatistik
- `itunes.apple.com/search` — anonyme Suche nach macOS-App-Icons anhand des Anzeigenamens
- `icon.horse` — Fallback-Favicon-Auflösung anhand der `homepage`-URL des Casks

### 4.3 Prüfung auf Programmupdates

Sparkle kontaktiert in regelmäßigen Abständen die offizielle AutoBrew-Appcast-URL auf GitHub, um nach neuen AutoBrew-Versionen zu suchen. Die Anfrage enthält die macOS-Version sowie die AutoBrew-Version (Standard-`User-Agent`), darüber hinaus keine weiteren Kennungen.

---

## 5. DRITTANBIETERDIENSTE (KEINE AUFTRAGSVERARBEITER)

Wir setzen keine Auftragsverarbeiter ein, da wir keine Daten des Nutzers verarbeiten. Die von AutoBrew angesprochenen Drittanbieterdienste handeln eigenständig und unter ihren eigenen Bedingungen:

| Dienst | Zweck | Betreiber |
|---|---|---|
| Homebrew + formulae.brew.sh | Paketverwaltung und Katalog | Homebrew-Projekt |
| Apple iTunes Search API | App-Icon-Suche | Apple Inc. |
| icon.horse | Favicon-Fallback | icon.horse |
| GitHub (Appcast, Releases) | Vertriebs- und Update-Kanal | GitHub, Inc. |

Wenn der Nutzer einen Sponsor-Link innerhalb von AutoBrew anklickt, verlässt er die Anwendung; der Browser ruft GitHub Sponsors auf — diese Interaktion unterliegt der Datenschutzerklärung von GitHub.

---

## 6. RECHTE DES NUTZERS

Da wir keine personenbezogenen Daten auf unseren Servern speichern, sind die Rechte auf Auskunft, Berichtigung, Löschung, Datenübertragbarkeit, Widerspruch und Einschränkung nach Art. 15–22 DSGVO sowie nach gleichwertigen lokalen Gesetzen faktisch dadurch erfüllt, dass der Nutzer AutoBrew vom Mac entfernt.

Bei Fragen zu dieser Erklärung kann sich der Nutzer dennoch an uns wenden unter **data-protection@digitalfreedom.co.za**.

Der Nutzer kann sich bei der zuständigen Datenschutzaufsichtsbehörde beschweren. In Deutschland ist dies der Hessische Beauftragte für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). Die EU listet die nationalen Aufsichtsbehörden unter https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. KINDER

AutoBrew ist ein Entwicklerwerkzeug für macOS. Es richtet sich nicht an Kinder unter 16 Jahren. Wir erheben keine personenbezogenen Daten und verarbeiten somit auch keine Daten von Kindern.

---

## 8. SICHERHEIT

- Die Anwendungs-Binärdatei ist mit dem Apple-Developer-ID-Zertifikat signiert und von Apple notarisiert.
- Automatische Updates werden vor der Anwendung gegen eine EdDSA-Ed25519-Signatur geprüft.
- AutoBrew läuft unter Hardened Runtime; Direktvertriebs-Apps, die mit Systemwerkzeugen kommunizieren, können das vollständige App-Sandbox nicht ohne Funktionsverlust nutzen — daher liefern wir die minimal erforderlichen Entitlements aus.
- Der Quellcode ist öffentlich auditierbar unter [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. INTERNATIONALE ÜBERMITTLUNGEN

Wir übermitteln keine personenbezogenen Daten, da wir keine erheben. Die Drittanbieterdienste, die der Nutzer über AutoBrew erreicht (Server des Homebrew-Projekts, Apple, icon.horse, GitHub), können außerhalb der EU betrieben werden; Übermittlungen an diese Dienste finden zwischen dem Nutzer und dem jeweiligen Anbieter statt, nicht über uns.

---

## 10. ÄNDERUNGEN DIESER ERKLÄRUNG

Wir können diese Datenschutzerklärung aktualisieren, um Änderungen an der Architektur von AutoBrew oder am geltenden Recht abzubilden. Das Datum „Zuletzt aktualisiert" am Anfang gibt die jeweils aktuellste Überarbeitung an. Wesentliche Änderungen werden in den AutoBrew-Release-Notes kommuniziert.

### 10.1 Künftige kostenpflichtige Funktionen

AutoBrew ist derzeit kostenfrei und arbeitet ohne Backend (siehe Abschnitt 2). Der Anbieter behält sich vor, in zukünftigen Versionen optionale **kostenpflichtige Funktionen**, **kostenpflichtige Editionen** oder **kostenpflichtige Zusatzdienste** einzuführen, die eine begrenzte Datenverarbeitung erfordern können (z. B. Zahlungsabwicklung über einen externen Anbieter oder eine Lizenzschlüsselprüfung). Jede solche Änderung wird:

- Vorab in den AutoBrew-Release-Notes und in dieser Datenschutzerklärung angekündigt
- Ausschließlich opt-in ausgestaltet — die kostenfreie, datenfreie Version bleibt nutzbar
- In einem eigenen Abschnitt dieser Datenschutzerklärung dokumentiert, bevor ein neuer Datenfluss aktiviert wird

Die derzeitige Aussage zur „Null Datenerhebung" gilt für die aktuelle Version von AutoBrew. Sie stellt keine dauerhafte Garantie für jede zukünftige Version dar; wir halten diese Erklärung aktuell, sodass sie stets das tatsächliche Verhalten beschreibt.

---

## 11. KONTAKT

Für datenschutzbezogene Anfragen:
**data-protection@digitalfreedom.co.za**

Für alle übrigen Anliegen:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (handelnd unter der Marke DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Deutschland
Website: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
