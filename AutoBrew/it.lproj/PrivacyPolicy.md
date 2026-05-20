# INFORMATIVA SULLA PRIVACY

## AutoBrew

**Data di entrata in vigore:** Maggio 2026
**Ultimo aggiornamento:** Maggio 2026

**Servizio gestito da:** DigitalFreedom — un marchio di Berger & Rosenstock GbR

**Titolare del trattamento (persona giuridica):**
Berger & Rosenstock GbR (operante come DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germania

Rappresentanti autorizzati: Marcel R. G. Berger, Jasmin Rosenstock
Partita IVA: DE455096022

Contatto (generale): hello@digitalfreedom.co.za
Contatto (protezione dei dati): data-protection@digitalfreedom.co.za
Sito web: https://digitalfreedom.co.za

---

## 1. INTRODUZIONE

La presente Informativa sulla Privacy descrive in che modo DigitalFreedom (un marchio di Berger & Rosenstock GbR — "noi", "nostro") tratta i dati in relazione all'applicazione AutoBrew ("AutoBrew", "il Software").

AutoBrew è **open source con licenza MIT**, **completamente gratuito** e distribuito direttamente come DMG notarizzato e tramite un tap di Homebrew — non attraverso l'Apple App Store o il Google Play Store. Non gestiamo un backend, non ospitiamo account utente e non raccogliamo, trasmettiamo, memorizziamo o trattiamo dati personali sui nostri server.

Adottiamo il Regolamento Generale sulla Protezione dei Dati dell'Unione Europea (RGPD) come standard di riferimento più rigoroso e lo applichiamo come livello minimo globale — le tutele descritte di seguito si applicano a ogni utente, indipendentemente dal paese.

---

## 2. NESSUNA RACCOLTA DI DATI

**Non raccogliamo alcun dato personale.**

AutoBrew viene eseguito interamente sul Mac dell'utente. Non esiste alcun account AutoBrew, nessuna telemetria, nessuna analitica, nessun crash reporter, nessuna configurazione remota. Poiché non trattiamo dati personali sotto il nostro controllo, la maggior parte degli obblighi RGPD a carico del titolare (documentazione sui trasferimenti internazionali, contratti con i responsabili del trattamento, notifica delle violazioni da parte nostra) non si applica a noi in quanto editore del Software. La Sezione 6 descrive comunque i diritti di cui l'utente dispone ai sensi della legge applicabile.

---

## 3. DATI MEMORIZZATI LOCALMENTE SUL DISPOSITIVO

AutoBrew memorizza i seguenti dati in locale. **Nessuno di questi dati lascia il Mac, salvo che l'utente scelga di condividerli.**

### 3.1 Impostazioni (UserDefaults)

- Modalità di attivazione (inattività / pianificata)
- Soglia di inattività (minuti) e orario pianificato
- Timestamp dell'ultima esecuzione
- Preferenza di avvio al login
- Preferenza per le notifiche
- Impostazioni di conservazione degli snapshot
- Valori predefiniti per la policy di aggiornamento (patch/minor/major × cask/formula) e override per pacchetto
- Stato dell'onboarding

### 3.2 Stato della policy di aggiornamento (Application Support)

- `UpdateLedger.json` — momento in cui ciascuna tripla `(kind, token, version)` è apparsa per la prima volta come obsoleta, in modo da poter misurare la finestra di cool-off. I token sono nomi di pacchetti Homebrew; nessun identificativo utente.
- `PendingUpdates.json` — voci di aggiornamento maggiore in attesa della decisione dell'utente (approvazione / rifiuto).

### 3.3 Cache delle icone (Application Support)

- PNG memorizzati in cache delle icone dei cask recuperate tramite l'API iTunes Search (ricerca anonima per nome dell'app) e icon.horse come fallback. Memorizzati in `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 Snapshot delle app (Application Support)

- Copie raggruppate in ZIP di `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers` e simili, relative alle app di cui l'utente esegue esplicitamente uno snapshot. Memorizzate in `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Log (os.Logger)

- Eventi diagnostici scritti tramite il sistema di logging unificato di Apple. Visibili in Console.app. Non vengono trasmessi da nessuna parte.

È possibile eliminare tutti i dati memorizzati in locale rimuovendo AutoBrew, la sua cartella di supporto (`~/Library/Application Support/AutoBrew/`) e il suo plist UserDefaults (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. ATTIVITÀ DI RETE

AutoBrew effettua richieste in uscita in tre situazioni. Nessuna di esse trasmette dati personali.

### 4.1 Operazioni sui pacchetti Homebrew

AutoBrew si appoggia al binario `brew` installato localmente. Il progetto Homebrew contatta quindi `formulae.brew.sh`, GitHub, mirror CDN e i singoli URL di download dei cask. Non abbiamo alcun rapporto con tali endpoint — sono gestiti dal progetto Homebrew e dai rispettivi editori dei cask in base alle loro condizioni di privacy.

### 4.2 Catalogo dei cask e risoluzione delle icone

- `formulae.brew.sh/api/cask.json` — recupero anonimo del catalogo pubblico dei cask
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — recupero anonimo delle statistiche di installazione a 365 giorni
- `itunes.apple.com/search` — ricerca anonima delle icone delle app macOS per nome visualizzato
- `icon.horse` — ricerca di favicon di fallback basata sull'URL `homepage` del cask

### 4.3 Controllo degli aggiornamenti automatici

Sparkle contatta periodicamente l'URL dell'appcast ufficiale di AutoBrew su GitHub per verificare la disponibilità di nuove versioni di AutoBrew. La richiesta contiene la versione di macOS e la versione di AutoBrew (standard `User-Agent`), nessun ulteriore identificativo.

---

## 5. SERVIZI DI TERZE PARTI (NON RESPONSABILI DEL TRATTAMENTO)

Non ci avvaliamo di responsabili del trattamento perché non trattiamo dati dell'utente. I servizi di terze parti con cui AutoBrew comunica operano in modo indipendente e secondo le proprie condizioni:

| Servizio | Finalità | Operatore |
|---|---|---|
| Homebrew + formulae.brew.sh | Gestione dei pacchetti e catalogo | Progetto Homebrew |
| Apple iTunes Search API | Ricerca delle icone delle app | Apple Inc. |
| icon.horse | Fallback per le favicon | icon.horse |
| GitHub (appcast, releases) | Canale di distribuzione e aggiornamento | GitHub, Inc. |

Quando l'utente fa clic su un link Sponsor all'interno di AutoBrew, esce dall'app e il browser si collega a GitHub Sponsors — tale interazione è disciplinata dall'informativa sulla privacy di GitHub.

---

## 6. DIRITTI DELL'UTENTE

Poiché non memorizziamo dati personali sui nostri server, i diritti di accesso / rettifica / cancellazione / portabilità / opposizione / limitazione previsti dagli Articoli 15–22 RGPD e dalle leggi locali equivalenti sono di fatto soddisfatti eliminando AutoBrew dal Mac.

L'utente può comunque contattarci all'indirizzo **data-protection@digitalfreedom.co.za** per qualsiasi domanda sulla presente informativa.

L'utente può presentare reclamo all'autorità competente in materia di protezione dei dati. In Germania si tratta dell'Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). L'UE elenca le autorità nazionali all'indirizzo https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. MINORI

AutoBrew è un'utility per sviluppatori su macOS. Non è destinato a minori di 16 anni. Non raccogliamo dati personali, dunque non trattiamo neppure dati di minori.

---

## 8. SICUREZZA

- Il binario dell'applicazione è firmato con il certificato Apple Developer ID e notarizzato da Apple.
- Gli aggiornamenti automatici vengono verificati rispetto a una firma EdDSA Ed25519 prima di essere applicati.
- AutoBrew viene eseguito sotto Hardened Runtime; le app a distribuzione diretta che interagiscono con strumenti di sistema non possono utilizzare l'App Sandbox completo senza compromettere il caso d'uso, perciò viene applicato il set minimo di entitlement necessari.
- Il codice sorgente è pubblicamente verificabile su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. TRASFERIMENTI INTERNAZIONALI

Non trasferiamo dati personali perché non li raccogliamo. I servizi di terze parti raggiungibili tramite AutoBrew (server del progetto Homebrew, Apple, icon.horse, GitHub) possono operare al di fuori dell'UE; i trasferimenti verso tali servizi avvengono tra l'utente e i servizi stessi, non con noi.

---

## 10. MODIFICHE ALLA PRESENTE INFORMATIVA

Potremmo aggiornare la presente Informativa sulla Privacy per riflettere modifiche all'architettura di AutoBrew o alla legge applicabile. La data di "Ultimo aggiornamento" in alto indica la revisione più recente. Le modifiche sostanziali vengono comunicate nelle note di rilascio di AutoBrew.

### 10.1 Funzionalità a pagamento future

AutoBrew è attualmente gratuito e funziona senza alcun backend (vedere Sezione 2). L'Editore si riserva il diritto di introdurre, in versioni future, **funzionalità a pagamento** opzionali, **edizioni a pagamento** o **servizi aggiuntivi a pagamento**, che potrebbero richiedere un trattamento limitato di dati (ad esempio gestione dei pagamenti tramite un fornitore terzo o verifica di una chiave di licenza). Eventuali modifiche di questo tipo saranno:

- Annunciate in anticipo nelle note di rilascio di AutoBrew e nella presente Informativa sulla Privacy
- Strettamente opt-in — la versione gratuita a zero raccolta dati rimane utilizzabile
- Documentate in una sezione dedicata della presente Informativa sulla Privacy prima dell'attivazione di qualsiasi nuovo flusso di dati

L'attuale dichiarazione "nessuna raccolta dati" si applica alla versione corrente di AutoBrew. Non costituisce una garanzia perpetua per ogni versione futura; manterremo la presente Informativa aggiornata affinché descriva sempre il comportamento effettivo.

---

## 11. CONTATTI

Per richieste in materia di protezione dei dati:
**data-protection@digitalfreedom.co.za**

Per tutto il resto:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (operante come DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germania
Sito web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
