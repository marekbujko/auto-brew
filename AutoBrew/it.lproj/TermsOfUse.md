# CONDIZIONI D'USO

## AutoBrew

**Data di entrata in vigore:** Maggio 2026
**Ultimo aggiornamento:** Maggio 2026

Le presenti Condizioni d'Uso ("Condizioni") disciplinano l'utilizzo di AutoBrew (il "Software"). Si prega di leggerle attentamente. Installando o utilizzando AutoBrew, l'utente accetta di essere vincolato dalle presenti Condizioni.

---

## 1. FORNITORE

Il Software è pubblicato sotto il marchio **DigitalFreedom**. La persona giuridica responsabile è:

Berger & Rosenstock GbR (operante come DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Germania
Rappresentanti autorizzati: Marcel R. G. Berger, Jasmin Rosenstock
Email: hello@digitalfreedom.co.za
Sito web: https://digitalfreedom.co.za

Le presenti Condizioni si applicano a livello globale. I diritti inderogabili di tutela del consumatore e altri diritti previsti dalla legge del paese di residenza dell'utente restano impregiudicati e prevalgono ove siano più tutelanti.

---

## 2. IL SOFTWARE

AutoBrew è un'utility per la barra dei menu di macOS che automatizza gli aggiornamenti di Homebrew, consente di sfogliare il catalogo dei cask di Homebrew e gestisce snapshot delle app per la migrazione tra Mac. È:

- **Open source** con licenza MIT — codice sorgente completo su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Gratuito** — nessun acquisto in-app, nessun abbonamento, nessun piano a pagamento, nessun periodo di prova
- **Distribuito direttamente** — DMG notarizzato tramite GitHub Releases e un tap di Homebrew; non tramite l'Apple App Store o il Google Play Store
- **Esclusivamente locale** — viene eseguito interamente sul Mac dell'utente, senza necessità di un account AutoBrew o di un servizio di backend (vedere l'[Informativa sulla Privacy](PrivacyPolicy.md))

Le presenti Condizioni si applicano al binario di AutoBrew. La licenza MIT (riprodotta nell'[EULA](EULA.md) e nelle [Licenze Open Source](OpenSourceLicenses.md)) disciplina il codice sorgente e qualsiasi fork o opera derivata.

---

## 3. LICENZA D'USO

A condizione che l'utente rispetti le presenti Condizioni e la licenza MIT, è consentito:

- Installare, eseguire, modificare e ridistribuire AutoBrew su un numero qualsiasi di Mac controllati dall'utente
- Creare un fork del codice sorgente e realizzare opere derivate ai sensi della licenza MIT

Non è consentito:

- Rappresentare in modo ingannevole l'origine del Software (la licenza MIT richiede che venga conservato l'avviso di copyright originale)
- Rimuovere gli avvisi di licenza incorporati di Sparkle, bsdiff, sais-lite o pdqsort in fase di ridistribuzione
- Utilizzare il nome **AutoBrew** o il marchio **DigitalFreedom** in opere derivate senza il nostro consenso scritto (vedere il documento [Marchi](Trademark.md))

---

## 4. NESSUN ACCOUNT, NESSUN PAGAMENTO (STATO ATTUALE)

AutoBrew attualmente non richiede registrazione, iscrizione né alcun pagamento. Il link **Sponsor** all'interno dell'app rinvia a GitHub Sponsors ed è **del tutto facoltativo** — qualsiasi contributo è trattato come donazione e non genera alcun diritto a funzionalità o supporto.

### 4.1 Riserva sulle funzionalità a pagamento future

Il Fornitore si riserva il diritto di introdurre, in versioni future di AutoBrew, **funzionalità a pagamento** opzionali, **edizioni a pagamento** o **servizi aggiuntivi a pagamento**. Eventuali offerte a pagamento future:

- Saranno annunciate in anticipo tramite l'interfaccia dell'applicazione e le note di rilascio ufficiali
- Si applicheranno solo per il futuro — il diritto di continuare a utilizzare l'attuale versione gratuita resta impregiudicato
- Lasceranno intatto il nucleo open source: il codice sorgente su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) continuerà a essere disponibile con licenza MIT

L'attuale assenza di funzionalità a pagamento non costituisce garanzia che AutoBrew rimarrà privo di funzionalità a pagamento in ogni versione futura.

---

## 5. DIPENDENZA DA HOMEBREW

AutoBrew si basa su un'installazione funzionante di Homebrew per assolvere alla propria funzione. AutoBrew si appoggia al binario `brew` e legge / scrive dati utilizzando i comandi e le convenzioni del progetto Homebrew. Non siamo affiliati al progetto Homebrew; non controlliamo quali pacchetti siano disponibili, quando vengano rilasciate le versioni o cosa facciano i singoli editori dei cask con i loro installer.

Se l'installazione di un cask fallisce, si comporta in modo inatteso o provoca danni, la questione riguarda l'utente e l'editore del cask e/o il progetto Homebrew — vedere Sezione 7 (Esclusione di Garanzie) e Sezione 8 (Limitazione di Responsabilità).

---

## 6. AGGIORNAMENTI

AutoBrew utilizza il framework Sparkle per distribuire aggiornamenti in-app a partire dall'appcast ufficiale di AutoBrew su GitHub. Gli aggiornamenti sono firmati con una chiave EdDSA Ed25519 e verificati prima di essere applicati. Gli aggiornamenti automatici possono essere disattivati dalle Impostazioni.

L'utente è libero di ignorare gli aggiornamenti in-app e di aggiornare il binario tramite il proprio tap di Homebrew o scaricando manualmente un DMG più recente.

---

## 7. ESCLUSIONE DI GARANZIE

Il Software è fornito **"COSÌ COM'È"** e **"COME DISPONIBILE"**, senza alcuna garanzia, espressa o implicita, comprese, a titolo esemplificativo ma non limitativo, le garanzie implicite di commerciabilità, idoneità per uno scopo particolare e non violazione di diritti altrui.

Fermo restando quanto sopra, non garantiamo che:

- Il Software sarà ininterrotto o privo di errori
- L'interazione di AutoBrew con Homebrew, con singoli cask o con macOS stesso produrrà sempre il risultato desiderato
- Gli snapshot creati da AutoBrew cattureranno perfettamente ogni aspetto dello stato di un'app — le app che memorizzano dati al di fuori delle sottodirectory standard di Library potrebbero non essere acquisite per intero

I diritti di garanzia di legge non escludibili contrattualmente in base alla legge locale di tutela del consumatore (ad esempio la Mängelhaftung tedesca ai sensi dei §§ 434 e segg. BGB, ove applicabile) restano impregiudicati.

---

## 8. LIMITAZIONE DI RESPONSABILITÀ

Nella massima misura consentita dalla legge applicabile:

- Non siamo responsabili per alcun danno indiretto, incidentale, consequenziale, esemplare o punitivo
- Non siamo responsabili per perdita di dati, mancato guadagno, interruzione di attività o danni derivanti da software di terze parti (Homebrew, singoli cask) richiamati tramite AutoBrew

Per gli utenti abitualmente residenti in Germania o nell'UE, la nostra responsabilità per danni causati da **colpa grave o dolo**, per **lesioni alla vita, al corpo o alla salute** e ai sensi di **disposizioni inderogabili della Legge tedesca sulla responsabilità per danno da prodotti (ProdHaftG)** rimane impregiudicata.

---

## 9. RISOLUZIONE

L'utente può smettere di utilizzare AutoBrew in qualsiasi momento disinstallandolo. La rimozione di AutoBrew e della relativa cartella di supporto (`~/Library/Application Support/AutoBrew/`) riporta il Mac a uno stato in cui non resta alcun artefatto di AutoBrew.

Possiamo interrompere la distribuzione di AutoBrew in qualsiasi momento. Poiché il Software è open source con licenza MIT, l'utente e la community restano liberi di crearne fork, compilarlo ed eseguirlo in modo indipendente.

---

## 10. MODIFICHE ALLE PRESENTI CONDIZIONI

Possiamo aggiornare le presenti Condizioni per riflettere modifiche al Software o alla legge applicabile. Le modifiche sostanziali vengono comunicate nelle note di rilascio di AutoBrew. La data di "Ultimo aggiornamento" in alto indica la revisione più recente.

---

## 11. LEGGE APPLICABILE E FORO COMPETENTE

Le presenti Condizioni sono disciplinate dalla legge della Repubblica federale di Germania, con esclusione della Convenzione delle Nazioni Unite sui contratti di vendita internazionale di merci (CISG).

Per i consumatori abitualmente residenti al di fuori della Germania, si applica in aggiunta la legge inderogabile di tutela del consumatore del paese di residenza. Il foro competente non esclusivo per le controversie è Bad Nauheim, Germania; i consumatori possono comunque agire presso il proprio domicilio ove la legge locale lo consenta.

Per le controversie tra consumatori derivanti dal diritto dell'UE, è disponibile la piattaforma di risoluzione delle controversie online della Commissione Europea all'indirizzo https://ec.europa.eu/consumers/odr. Non siamo obbligati né disposti a partecipare a procedimenti alternativi di risoluzione delle controversie dinanzi a un organismo di composizione per i consumatori (Verbraucherschlichtungsstelle) ai sensi del § 36 VSBG.

---

## 12. CONTATTI

Berger & Rosenstock GbR (operante come DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Germania
Email: hello@digitalfreedom.co.za
Sito web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
