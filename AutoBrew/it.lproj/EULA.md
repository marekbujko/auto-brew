# CONTRATTO DI LICENZA CON L'UTENTE FINALE (EULA)

## AutoBrew

**Data di entrata in vigore:** Maggio 2026
**Ultimo aggiornamento:** Maggio 2026

Il presente Contratto di Licenza con l'Utente Finale ("EULA", "Contratto") è un contratto legale tra l'utente ("Utente", "Lei") e l'editore di AutoBrew, **Berger & Rosenstock GbR**, operante come **DigitalFreedom** ("Editore", "noi", "nostro").

Installando, copiando o utilizzando in altro modo AutoBrew (il "Software"), l'utente accetta di essere vincolato dai termini del presente EULA.

---

## 1. IL SOFTWARE

AutoBrew è un'utility per la barra dei menu di macOS che automatizza gli aggiornamenti di Homebrew, consente di sfogliare il catalogo dei cask di Homebrew e gestisce snapshot delle app. È pubblicato sotto il marchio DigitalFreedom e concesso in licenza all'utente secondo i termini di seguito.

### 1.1 Modello di licenza

AutoBrew è rilasciato come **software open source gratuito** con licenza MIT. Il testo integrale della licenza MIT è riprodotto nella Sezione 6 e nel documento [Licenze Open Source](OpenSourceLicenses.md). La licenza MIT disciplina il codice sorgente; il presente EULA disciplina la distribuzione binaria e gli obblighi dell'utente quale utente del binario.

### 1.2 Riserva sulle funzionalità a pagamento future

L'Editore si riserva il diritto di introdurre, in qualsiasi momento, **funzionalità a pagamento** opzionali, **edizioni a pagamento** o **servizi aggiuntivi a pagamento**. Eventuali modifiche di questo tipo:

- Saranno annunciate in anticipo tramite l'interfaccia dell'applicazione e le note di rilascio ufficiali
- Si applicheranno solo per il futuro (le funzionalità gratuite di una versione già installata resteranno gratuite)
- Lasceranno intatto il nucleo open source con licenza MIT — il codice sorgente su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) rimarrà disponibile con la medesima licenza indipendentemente da eventuali aggiunte a pagamento

L'attuale assenza di qualsiasi funzionalità a pagamento non costituisce garanzia che AutoBrew rimarrà privo di funzionalità a pagamento per sempre.

### 1.3 Ambito open source vs. funzionalità a pagamento

La licenza MIT si applica al codice sorgente di AutoBrew così come pubblicato nel repository ufficiale su [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **I fork e le opere derivate da tale codice sono espressamente consentiti** ai sensi della licenza MIT — accogliamo con favore la community che costruisce a partire da AutoBrew.

Eventuali **funzionalità a pagamento future**, **edizioni a pagamento** o **servizi aggiuntivi a pagamento** (vedere Sezione 1.2) saranno rilasciati con **licenza proprietaria separata** e **non** faranno parte della base di codice con licenza MIT. In particolare:

- Il codice sorgente delle funzionalità a pagamento non sarà pubblicato nel repository MIT
- La copia, il decompilare, il reverse engineering o la riproduzione in altro modo dell'implementazione di qualsiasi funzionalità a pagamento proprietaria distribuita da AutoBrew non è consentito, salvo quanto espressamente autorizzato dalla legge inderogabile applicabile (ad esempio § 69e UrhG / Art. 6 della Direttiva UE 2009/24/CE per l'interoperabilità)
- Tale restrizione si applica specificamente all'implementazione della funzionalità a pagamento — non limita il diritto di terzi di sviluppare in modo indipendente e da zero una funzionalità comparabile

I marchi **"AutoBrew"** e **"DigitalFreedom"** non possono essere utilizzati da fork o opere derivate che offrano funzionalità a pagamento concorrenti — vedere Sezione 3 del presente EULA e il documento [Marchi](Trademark.md).

### 1.4 Canali di distribuzione

Il binario ufficiale di AutoBrew è distribuito esclusivamente tramite:

- **GitHub Releases** su [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — file DMG notarizzati e firmati con il certificato Apple Developer ID
- Il **tap di Homebrew** su [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew **non** è distribuito tramite l'Apple App Store, il Google Play Store o qualsiasi portale di download di terze parti. Se l'utente ha ottenuto AutoBrew da una fonte diversa, il binario non è verificato e non è coperto dal presente EULA.

---

## 2. CONCESSIONE DI LICENZA

Subordinatamente al rispetto del presente EULA e della licenza MIT, l'Editore concede all'utente una licenza mondiale, esente da royalty e non esclusiva per:

- Installare ed eseguire AutoBrew su un numero qualsiasi di Mac di proprietà o sotto il controllo dell'utente
- Modificare il codice sorgente e creare opere derivate
- Ridistribuire il Software in forma sorgente o binaria

---

## 3. RESTRIZIONI

Non è consentito:

- Rimuovere, alterare od occultare gli avvisi di copyright, il testo della licenza MIT o gli avvisi di licenza incorporati di Sparkle / bsdiff / sais-lite / pdqsort in fase di ridistribuzione
- Utilizzare i marchi **"AutoBrew"** e **"DigitalFreedom"** nel nome di un fork o di un'opera derivata senza il nostro previo consenso scritto (vedere il documento [Marchi](Trademark.md))
- Rappresentare il proprio fork come distribuzione ufficiale di AutoBrew

---

## 4. COMPONENTI DI TERZE PARTI

AutoBrew include i seguenti componenti open source, ciascuno disciplinato dalla propria licenza (vedere il documento [Licenze Open Source](OpenSourceLicenses.md) per l'elenco completo e i testi integrali delle licenze):

- **Sparkle** (MIT) — aggiornamenti automatici in-app
- **bsdiff / bspatch** (BSD-2-Clause) — incluso in Sparkle per i delta binari
- **sais-lite** (MIT) — incluso in Sparkle
- **pdqsort** (zlib) — incluso in Sparkle

AutoBrew si appoggia inoltre a runtime su **Homebrew** (BSD-2-Clause) — invocato tramite spawn di processi, non incorporato. Homebrew deve essere installato separatamente; AutoBrew guida l'utente nella sua installazione al primo avvio.

Le licenze MIT, BSD-2-Clause e zlib applicabili a tali componenti restano in vigore indipendentemente dal presente EULA. In caso di conflitto tra il presente EULA e una licenza open source, prevale la licenza open source per il componente interessato.

---

## 5. NESSUN PAGAMENTO, NESSUN ACCOUNT (STATO ATTUALE)

AutoBrew è attualmente gratuito. Il Software non richiede registrazione, iscrizione o alcun pagamento e, alla data del presente EULA, non vi sono acquisti in-app, abbonamenti, funzionalità a pagamento o meccanismi di prova.

Il link **Sponsor** all'interno di AutoBrew rinvia a GitHub Sponsors ed è **del tutto facoltativo**. Qualsiasi contributo è trattato come donazione e non conferisce ulteriori diritti.

**Riserva:** vedere Sezione 1.2 — l'Editore si riserva il diritto di introdurre in futuro funzionalità a pagamento opzionali, edizioni a pagamento o servizi aggiuntivi a pagamento. Eventuali offerte a pagamento future si applicheranno solo agli utenti che vi aderiranno esplicitamente; le funzionalità gratuite attualmente installate non saranno limitate retroattivamente.

---

## 6. LICENZA MIT (testo integrale)

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

## 7. ESCLUSIONE DI GARANZIE

Il Software è fornito **"COSÌ COM'È"**, senza alcuna garanzia, espressa o implicita. L'Editore non garantisce che il Software sarà ininterrotto o privo di errori, che l'interazione di AutoBrew con Homebrew o con singoli cask avrà sempre esito positivo, né che gli snapshot cattureranno perfettamente ogni aspetto dello stato di un'applicazione.

I diritti di garanzia di legge non escludibili contrattualmente in base alla legge locale di tutela del consumatore (ad esempio la Mängelhaftung tedesca ai sensi dei §§ 434 e segg. BGB, ove applicabile) restano impregiudicati.

---

## 8. LIMITAZIONE DI RESPONSABILITÀ

Nella massima misura consentita dalla legge applicabile, l'Editore non è responsabile per alcun danno indiretto, incidentale, consequenziale, esemplare o punitivo — inclusi perdita di dati, mancato guadagno o danni derivanti da software di terze parti (Homebrew, singoli cask) richiamati tramite AutoBrew.

Per gli utenti abitualmente residenti in Germania o nell'UE, la nostra responsabilità per danni causati da **colpa grave o dolo**, per **lesioni alla vita, al corpo o alla salute** e ai sensi della **Legge tedesca sulla responsabilità per danno da prodotti (ProdHaftG)** rimane impregiudicata.

---

## 9. CONTROLLO DELLE ESPORTAZIONI

Il Software non contiene crittografia oltre a quella fornita di default da macOS di Apple e dal framework Sparkle. L'esportazione di macOS stesso è disciplinata dai termini di Apple; l'utente resta responsabile del rispetto delle leggi sul controllo delle esportazioni applicabili alla propria giurisdizione.

---

## 10. RISOLUZIONE

Il presente EULA è efficace fino alla risoluzione. Si risolve automaticamente, senza preavviso, in caso di inadempimento di uno qualsiasi dei suoi termini. L'utente può inoltre risolverlo in qualsiasi momento disinstallando AutoBrew. Alla risoluzione, l'utente deve cessare ogni utilizzo del Software e rimuovere tutte le copie sotto il proprio controllo.

---

## 11. LEGGE APPLICABILE E FORO COMPETENTE

Il presente EULA è disciplinato dalla legge della Repubblica federale di Germania, con esclusione della Convenzione delle Nazioni Unite sui contratti di vendita internazionale di merci (CISG). Si applica in aggiunta la legge inderogabile di tutela del consumatore del paese di residenza dell'utente.

Il foro competente non esclusivo è Bad Nauheim, Germania. I consumatori possono agire presso il proprio domicilio ove la legge locale lo consenta.

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
