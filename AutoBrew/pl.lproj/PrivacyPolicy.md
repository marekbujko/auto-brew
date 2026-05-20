# POLITYKA PRYWATNOŚCI

## Globalna informacja o ochronie danych i prywatności

**Data wejścia w życie:** maj 2026

**Usługa prowadzona przez:** DigitalFreedom — marka Berger & Rosenstock GbR

**Administrator danych (podmiot prawny):**
Berger & Rosenstock GbR (działający pod marką DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Niemcy

Uprawnieni przedstawiciele: Marcel R. G. Berger, Jasmin Rosenstock
Numer VAT: DE455096022

Kontakt (ogólny): hello@digitalfreedom.co.za
Kontakt (ochrona danych): data-protection@digitalfreedom.co.za
Strona internetowa: https://digitalfreedom.co.za

---

## 1. WPROWADZENIE

Niniejsza Polityka Prywatności wyjaśnia, w jaki sposób DigitalFreedom (marka Berger & Rosenstock GbR, zbiorczo „my", „nas", „nasz") zbiera, wykorzystuje, przechowuje i chroni Państwa dane osobowe podczas korzystania z naszych aplikacji, oprogramowania, stron internetowych i powiązanych usług („Usługi").

### 1.1 Zakres globalny

AutoBrew jest dystrybuowany bezpośrednio jako natywna aplikacja macOS o otwartym kodzie źródłowym (licencja MIT) i jest udostępniany użytkownikom na całym świecie. Niniejsza Polityka Prywatności ma zastosowanie globalnie do wszystkich użytkowników Usług, niezależnie od kraju, w którym Usługa jest pobierana, używana lub do której uzyskuje się dostęp.

### 1.2 RODO jako globalny standard bazowy

Przyjmujemy **Ogólne rozporządzenie UE o ochronie danych (RODO)** oraz powiązane unijne prawo o ochronie danych jako najsurowszy standard bazowy i stosujemy je jako **globalny minimalny poziom** — każdy użytkownik w każdym kraju korzysta z co najmniej takiej ochrony, jaką przewiduje RODO i niniejsza Polityka. Dodatkowo respektujemy i przestrzegamy wszelkich obowiązujących lokalnych przepisów o ochronie danych w jurysdykcji użytkownika, a w sytuacjach, gdy prawo lokalne zapewnia użytkownikowi większą ochronę, zastosowanie ma standard bardziej chroniący.

Zobowiązujemy się do ochrony Państwa prywatności i przestrzegania obowiązujących przepisów o ochronie danych, w tym między innymi:

- Ogólnego rozporządzenia UE o ochronie danych (RODO) — stosowanego jako globalny standard bazowy
- Niemieckiej federalnej ustawy o ochronie danych (BDSG)
- Brytyjskiego ogólnego rozporządzenia o ochronie danych (UK GDPR) oraz Data Protection Act 2018
- Szwajcarskiej federalnej ustawy o ochronie danych (FADP)
- California Consumer Privacy Act (CCPA) / California Privacy Rights Act (CPRA) oraz innych stanowych ustaw o prywatności w USA
- Kanadyjskiej ustawy Personal Information Protection and Electronic Documents Act (PIPEDA)
- Australijskiej ustawy Privacy Act 1988
- Brazylijskiej ogólnej ustawy o ochronie danych (LGPD)
- Japońskiej ustawy o ochronie danych osobowych (APPI)
- Południowokoreańskiej ustawy Personal Information Protection Act (PIPA)
- Indyjskiej ustawy Digital Personal Data Protection Act (DPDP Act) oraz IT Act
- Południowoafrykańskiej ustawy Protection of Personal Information Act (POPIA)
- Wszelkich innych obowiązujących krajowych reżimów ochrony danych w jurysdykcjach, w których Usługi są dostępne

---

## 2. ADMINISTRATOR DANYCH

Usługi są oferowane pod marką **DigitalFreedom**. Podmiotem prawnym odpowiedzialnym za przetwarzanie Państwa danych osobowych („administrator danych" w rozumieniu art. 4 pkt 7 RODO) jest:

Berger & Rosenstock GbR (działający pod marką DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Niemcy

Uprawnieni przedstawiciele: Marcel R. G. Berger, Jasmin Rosenstock
Numer VAT: DE455096022

W sprawach związanych z ochroną danych (art. 13/14 RODO, żądania dostępu, sprostowania, usunięcia, przenoszenia, sprzeciwu):
E-mail: data-protection@digitalfreedom.co.za

W sprawach ogólnych:
E-mail: hello@digitalfreedom.co.za

Strona internetowa: https://digitalfreedom.co.za

---

## 3. ZASADA ZEROWEGO ZBIERANIA DANYCH

**Nie zbieramy, nie przechowujemy, nie przesyłamy ani nie przetwarzamy żadnych danych osobowych na naszych serwerach.**

AutoBrew jest open source na licencji MIT i jest całkowicie bezpłatny (bez zakupów w aplikacji, bez planu płatnego, bez analityki, bez serwerowego zbierania danych). Aplikacja działa w całości na Państwa komputerze Mac. Cała konfiguracja, preferencje oraz historia operacji Homebrew są przechowywane lokalnie. Nie posiadamy serwerów, które odbierałyby Państwa dane. Nie prowadzimy żadnej infrastruktury backend służącej do zbierania danych, analityki, raportowania awarii ani telemetrii.

Ponieważ nie przetwarzamy danych osobowych pod naszą kontrolą, większość obowiązków wynikających z przepisów o ochronie danych (obowiązki administratora, obowiązki dotyczące transferów międzynarodowych, powiadomienia o naruszeniach itp.) nie ma do nas zastosowania jako wydawcy AutoBrew. Sekcja 10 mimo to opisuje prawa, które przysługują Państwu na mocy obowiązującego prawa.

---

## 4. DANE PRZECHOWYWANE NA PAŃSTWA URZĄDZENIU

AutoBrew przechowuje następujące dane lokalnie na Państwa komputerze macOS. Żadne z tych danych nie są przesyłane na nasze serwery.

### 4.1 Preferencje aplikacji

- **Harmonogram aktualizacji** (UserDefaults) — preferowane przedziały czasu dla automatycznych aktualizacji Homebrew
- **Wybrane formuły i casks** (UserDefaults / lokalna baza JSON) — pakiety zarządzane przez AutoBrew
- **Katalog BrewStore** (lokalna pamięć podręczna) — buforowane metadane pakietów Homebrew
- **AppSnapshot** (lokalne dane) — migawki stanu zainstalowanych aplikacji wykonywane lokalnie
- **Uruchamianie przy logowaniu** (UserDefaults) — preferencja automatycznego startu
- **Stan onboardingu** (UserDefaults) — flaga ukończenia konfiguracji

### 4.2 Dane runtime

- **Wyniki operacji Homebrew** — przechowywane w pamięci podczas sesji
- **Logi diagnostyczne** — przechowywane lokalnie z `privacy: .private` przy użyciu `os.Logger`, nigdy nie eksportowane

### 4.3 Aktualizacje (Sparkle)

AutoBrew korzysta z frameworku Sparkle do automatycznych aktualizacji aplikacji. Sparkle pobiera kanał appcast oraz pakiety aktualizacji bezpośrednio z naszego repozytorium dystrybucji. Standardowe metadane żądań HTTPS (adres IP, ciąg User-Agent) są widoczne dla serwera hostującego kanał aktualizacji, ale nie są przez nas przechowywane ani powiązywane z tożsamością użytkownika.

### 4.4 Dane NIE zbierane

AutoBrew nie zbiera:

- żadnej telemetrii, analityki ani statystyk użytkowania
- raportów awarii ani raportów diagnostycznych
- identyfikatorów reklamowych
- lokalizacji, kontaktów, kalendarza, zdrowia, fotografii
- danych logowania ani danych konta (nie ma konta DigitalFreedom)
- danych płatności (aplikacja jest bezpłatna)

---

## 5. PODSTAWA PRAWNA PRZETWARZANIA (RODO)

Ponieważ nie działamy jako administrator ani podmiot przetwarzający dane osobowe zbierane poprzez AutoBrew, podstawy przetwarzania z art. 6 RODO nie mają do nas zastosowania. W zakresie, w jakim działanie AutoBrew obejmuje lokalne przetwarzanie na Państwa urządzeniu, odbywa się ono w oparciu o:

- **Wykonanie umowy** (art. 6 ust. 1 lit. b RODO) — zapewnienie funkcjonalności, dla której zainstalowali Państwo aplikację
- **Uzasadniony interes** (art. 6 ust. 1 lit. f RODO) — bezpieczne dostarczanie aktualizacji aplikacji za pośrednictwem Sparkle

Żadne przetwarzanie nie odbywa się na infrastrukturze prowadzonej przez nas.

---

## 6. SPOSÓB WYKORZYSTANIA DANYCH

Dane na Państwa urządzeniu wykorzystywane są wyłącznie w celu:

- Automatyzacji aktualizacji Homebrew zgodnie z Państwa harmonogramem
- Wyświetlania katalogu BrewStore i zarządzania zainstalowanymi pakietami
- Tworzenia lokalnych migawek AppSnapshot dla zainstalowanych aplikacji
- Lokalnego wyświetlania statusu operacji i logów aktywności
- Sprawdzania i pobierania aktualizacji samej aplikacji AutoBrew za pośrednictwem Sparkle

Dane nigdy nie są przez nas udostępniane, sprzedawane, wypożyczane ani w inny sposób ujawniane osobom trzecim.

---

## 7. USŁUGI STRON TRZECICH

AutoBrew komunikuje się z następującymi usługami stron trzecich. Nie jesteśmy stroną tej komunikacji.

### 7.1 Homebrew

- **Cel:** Pobieranie, instalowanie i aktualizowanie pakietów (formuły i casks)
- **Wysyłane dane:** Standardowe żądania HTTPS do oficjalnych serwerów Homebrew i serwerów lustrzanych
- **Operator:** Homebrew (projekt open source)
- **Polityka prywatności:** https://docs.brew.sh

### 7.2 GitHub (Sparkle appcast i kod źródłowy)

- **Cel:** Hostowanie kanału aktualizacji Sparkle, pakietów aktualizacji oraz kodu źródłowego aplikacji
- **Wysyłane dane:** Standardowe metadane żądania HTTPS
- **Operator:** GitHub, Inc.
- **Polityka prywatności:** https://docs.github.com/en/site-policy/privacy-policies/github-general-privacy-statement

### 7.3 GitHub Sponsors (opcjonalnie)

- **Cel:** Dobrowolne dotacje dla projektu open source — wyłącznie wtedy, gdy użytkownik klika link GitHub Sponsors
- **Wysyłane dane:** Zarządzane w całości przez GitHub; aplikacja jedynie otwiera adres URL w przeglądarce
- **Operator:** GitHub, Inc.

### 7.4 Niewykorzystywane SDK

**Nie** integrujemy żadnego z następujących rozwiązań:

- SDK analityczne (Google Analytics, Firebase Analytics, Mixpanel, Amplitude, PostHog itp.)
- SDK raportowania awarii (Crashlytics, Sentry, Bugsnag itp.)
- SDK reklamowe (AdMob, Meta Audience Network, AppLovin itp.)
- SDK atrybucji (AppsFlyer, Adjust, Branch, Kochava itp.)
- Frameworki do testów A/B
- SDK mediów społecznościowych
- Dostawcy uwierzytelniania strony trzeciej

---

## 8. MIĘDZYNARODOWE TRANSFERY DANYCH

Nie przekazujemy danych osobowych międzynarodowo, ponieważ nie zbieramy ani nie przetwarzamy danych osobowych.

Przepływy danych inicjowane przez Państwa (operacje Homebrew, sprawdzanie aktualizacji Sparkle, otwieranie linków GitHub) mogą obejmować transmisję transgraniczną. Takie transfery podlegają politykom prywatności i mechanizmom transferu danych poszczególnych operatorów stron trzecich.

---

## 9. RETENCJA DANYCH

Nie przechowujemy żadnych danych. Wszystkie dane AutoBrew są przechowywane lokalnie na Państwa urządzeniu i znajdują się pod Państwa wyłączną kontrolą.

- **Odinstalowanie aplikacji** usuwa preferencje zapisane w UserDefaults oraz lokalne dane aplikacji
- **Logi diagnostyczne** są utrzymywane lokalnie do momentu odinstalowania aplikacji

---

## 10. BEZPIECZEŃSTWO DANYCH

Chociaż nie zbieramy Państwa danych, wdrażamy następujące środki bezpieczeństwa w AutoBrew:

- **Komunikacja sieciowa:** HTTPS/TLS dla całej komunikacji z Homebrew, GitHub i Sparkle
- **Podpisy Sparkle:** Aktualizacje aplikacji są weryfikowane przez podpisy kryptograficzne EdDSA przed instalacją
- **App Sandbox / Hardened Runtime:** Aplikacja działa z odpowiednimi zabezpieczeniami uruchomieniowymi macOS
- **Otwarty kod źródłowy:** Kompletny kod źródłowy jest publicznie dostępny pod licencją MIT do niezależnego audytu
- **Brak telemetrii:** Żadne dane użytkowania, analityczne ani raporty awarii nie są nigdzie przesyłane
- **Brak trwałego logowania:** Logi używają `os.Logger` z `privacy: .private` i nie są eksportowane

Żaden system nie jest w pełni bezpieczny.

---

## 11. PAŃSTWA PRAWA

### 11.1 Prawa na mocy RODO (UE / EOG / Zjednoczone Królestwo)

Przysługuje Państwu prawo do:

- **Dostępu** do swoich danych osobowych (art. 15 RODO) — nie dotyczy, nie przechowujemy żadnych Państwa danych
- **Sprostowania** nieprawidłowych danych (art. 16 RODO) — nie dotyczy
- **Usunięcia** / prawa do bycia zapomnianym (art. 17 RODO) — nie dotyczy; mogą Państwo usunąć dane lokalne poprzez odinstalowanie
- **Ograniczenia** przetwarzania (art. 18 RODO) — nie dotyczy
- **Przenoszenia danych** (art. 20 RODO) — nie dotyczy
- **Sprzeciwu** wobec przetwarzania (art. 21 RODO) — nie dotyczy
- **Wycofania zgody** w dowolnym momencie (art. 7 ust. 3 RODO) — mogą Państwo przestać korzystać z aplikacji w każdej chwili
- **Złożenia skargi** do organu nadzorczego

Prawa te są spełnione przez naszą politykę zerowego zbierania danych.

### 11.2 Prawa na mocy CCPA / CPRA (Kalifornia)

Mieszkańcy Kalifornii mają prawo do:

- Uzyskania informacji o tym, jakie dane osobowe są zbierane
- Żądania usunięcia danych osobowych
- Rezygnacji ze sprzedaży lub udostępniania danych osobowych
- Niedyskryminacji za korzystanie z praw prywatności
- Sprostowania nieprawidłowych danych osobowych
- Ograniczenia wykorzystania wrażliwych danych osobowych

Nie sprzedajemy danych osobowych. Nie zbieramy danych osobowych w rozumieniu CCPA/CPRA.

### 11.3 Prawa na mocy PIPEDA (Kanada)

Mieszkańcy Kanady mają prawo do:

- Dostępu do swoich danych osobowych
- Kwestionowania prawidłowości swoich danych
- Wycofania zgody (z zastrzeżeniem ograniczeń prawnych lub umownych)

### 11.4 Prawa na mocy Australian Privacy Act

Mieszkańcy Australii mają prawo do:

- Dostępu do swoich danych osobowych
- Żądania sprostowania nieprawidłowych danych
- Skargi do Biura Australijskiego Komisarza ds. Informacji (OAIC)

### 11.5 Prawa na mocy LGPD (Brazylia)

Mieszkańcy Brazylii mają prawo do:

- Potwierdzenia przetwarzania danych
- Dostępu do danych
- Sprostowania niekompletnych lub nieprawidłowych danych
- Anonimizacji, zablokowania lub usunięcia danych zbędnych
- Przenoszenia danych
- Informacji o udostępnionych danych
- Cofnięcia zgody

---

## 12. PRYWATNOŚĆ DZIECI

Nasze Usługi nie są skierowane do dzieci poniżej 16 roku życia (lub odpowiedniego wieku zgody w Państwa jurysdykcji).

Nie zbieramy świadomie danych osobowych od dzieci. Ponieważ AutoBrew wdraża ścisłą politykę zerowego zbierania danych, żadne dane osobowe żadnego użytkownika — niezależnie od wieku — nie są zbierane ani przesyłane.

---

## 13. PLIKI COOKIE I ŚLEDZENIE

AutoBrew jest natywną aplikacją macOS i nie używa plików cookie, web beaconów, znaczników pikselowych, fingerprintingu ani podobnych technologii śledzących. Aplikacja nie zawiera żadnych osadzonych widoków webowych, które ładowałyby treści stron trzecich.

---

## 14. ZAUTOMATYZOWANE PODEJMOWANIE DECYZJI I AI

Nie podejmujemy zautomatyzowanych decyzji ani profilowania, które wywołują skutki prawne lub w podobny sposób istotnie na Państwa wpływają.

AutoBrew nie zawiera funkcji AI ani zewnętrznych usług inferencji modeli.

---

## 15. LINKI I USŁUGI STRON TRZECICH

Aplikacja może zawierać linki do stron internetowych stron trzecich (np. dokumentacja Homebrew, repozytorium GitHub, GitHub Sponsors). Nie ponosimy odpowiedzialności za praktyki prywatności ani treści usług stron trzecich.

---

## 16. ZMIANY NINIEJSZEJ POLITYKI

Możemy od czasu do czasu aktualizować niniejszą Politykę Prywatności.

- Istotne zmiany będą komunikowane poprzez Aplikację lub repozytorium projektu
- Dalsze korzystanie po zmianach stanowi ich akceptację
- „Data wejścia w życie" na górze odzwierciedla najnowszą wersję

---

## 17. KONTAKT

W sprawach związanych z prywatnością lub w celu skorzystania ze swoich praw:

DigitalFreedom
Marka Berger & Rosenstock GbR
Dieselstr. 22e
61231 Bad Nauheim
Niemcy

Ochrona danych: data-protection@digitalfreedom.co.za
Zapytania ogólne: hello@digitalfreedom.co.za
Wsparcie: https://support.digitalfreedom.co.za/help/767340152
Strona internetowa: https://digitalfreedom.co.za

Mieszkańcy UE mogą również skontaktować się z właściwym organem nadzorczym w swoim państwie członkowskim.

---

## 18. POSTANOWIENIA REGIONALNE

### 18.1 Unia Europejska / EOG

- Przetwarzanie jest zgodne z wymogami RODO
- Wiodącym organem nadzorczym jest właściwy niemiecki organ ochrony danych
- Oceny skutków dla ochrony danych (DPIA) są przeprowadzane, gdy są wymagane

### 18.2 Polska

- Zgodność z RODO i Ustawą o ochronie danych osobowych
- Organ nadzorczy: Urząd Ochrony Danych Osobowych (UODO)

### 18.3 Zjednoczone Królestwo

- Przetwarzanie jest zgodne z UK GDPR i Data Protection Act 2018
- Organ nadzorczy: Information Commissioner's Office (ICO)

### 18.4 Stany Zjednoczone

- Przetwarzanie jest zgodne z obowiązującymi stanowymi ustawami o prywatności (CCPA/CPRA, VCDPA, CPA itp.)
- Sygnały „Do Not Track" są respektowane tam, gdzie jest to technicznie wykonalne

### 18.5 Kanada

- Przetwarzanie jest zgodne z PIPEDA i obowiązującym prowincjonalnym ustawodawstwem o prywatności
- Skargi można kierować do Biura Komisarza ds. Prywatności Kanady

### 18.6 Australia

- Przetwarzanie jest zgodne z Privacy Act 1988 oraz Australian Privacy Principles (APPs)

### 18.7 Brazylia

- Przetwarzanie jest zgodne z Lei Geral de Proteção de Dados (LGPD)
- Właściwym organem jest Autoridade Nacional de Proteção de Dados (ANPD)

---

(c) 2025-2026 DigitalFreedom — Berger & Rosenstock GbR. Wszelkie prawa zastrzeżone.
