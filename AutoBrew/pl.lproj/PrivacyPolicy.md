# POLITYKA PRYWATNOŚCI

## AutoBrew

**Data wejścia w życie:** maj 2026
**Ostatnia aktualizacja:** maj 2026

**Usługa prowadzona przez:** DigitalFreedom — marka Berger & Rosenstock GbR

**Administrator danych (podmiot prawny):**
Berger & Rosenstock GbR (działająca jako DigitalFreedom)
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

Niniejsza Polityka Prywatności wyjaśnia, w jaki sposób DigitalFreedom (marka Berger & Rosenstock GbR — „my", „nas", „nasz") postępuje z danymi w związku z aplikacją AutoBrew („AutoBrew", „Oprogramowanie").

AutoBrew jest **open source na licencji MIT**, **całkowicie bezpłatny** i dystrybuowany bezpośrednio jako notaryzowany plik DMG oraz poprzez tap Homebrew — nie poprzez Apple App Store ani Google Play Store. Nie prowadzimy backendu, nie hostujemy kont użytkowników i nie zbieramy, nie przesyłamy, nie przechowujemy ani nie przetwarzamy żadnych danych osobowych na naszych serwerach.

Przyjmujemy ogólne rozporządzenie UE o ochronie danych (RODO) jako najbardziej rygorystyczny punkt odniesienia i stosujemy je jako globalny minimalny standard — ochrona poniżej dotyczy każdego użytkownika, niezależnie od kraju.

---

## 2. ZASADA ZEROWEGO ZBIERANIA DANYCH

**Nie zbieramy żadnych danych osobowych.**

AutoBrew działa w całości na Państwa Macu. Nie istnieje konto AutoBrew, brak telemetrii, brak analityki, brak raportowania awarii, brak zdalnej konfiguracji. Ponieważ nie przetwarzamy danych osobowych pod naszą kontrolą, większość obowiązków RODO po stronie operatora (dokumentacja transferów międzynarodowych, umowy z podmiotami przetwarzającymi, zgłaszanie naruszeń po naszej stronie) nie ma do nas zastosowania jako wydawcy Oprogramowania. Sekcja 6 mimo to opisuje prawa, które przysługują Państwu na mocy obowiązującego prawa.

---

## 3. DANE PRZECHOWYWANE LOKALNIE NA PAŃSTWA URZĄDZENIU

AutoBrew przechowuje następujące dane lokalnie. **Żadne z tych danych nie opuszczają Państwa Maca, chyba że zdecydują się Państwo je udostępnić.**

### 3.1 Ustawienia (UserDefaults)

- Tryb wyzwalania (bezczynność / harmonogram)
- Próg bezczynności (minuty) i zaplanowana godzina
- Znacznik czasu ostatniego uruchomienia
- Preferencja uruchamiania przy logowaniu
- Preferencja powiadomień
- Ustawienia retencji migawek
- Domyślne polityki aktualizacji (patch/minor/major × cask/formula) i nadpisania dla poszczególnych pakietów
- Stan onboardingu

### 3.2 Stan polityki aktualizacji (Application Support)

- `UpdateLedger.json` — kiedy każdy `(kind, token, version)` po raz pierwszy pojawił się jako nieaktualny, aby można było zmierzyć okno karencji. Tokeny to nazwy pakietów Homebrew; brak identyfikatorów użytkownika.
- `PendingUpdates.json` — wpisy aktualizacji typu major oczekujące na Państwa decyzję (zatwierdzenie / odrzucenie).

### 3.3 Pamięć podręczna ikon (Application Support)

- Pliki PNG ikon cask buforowane przez API iTunes Search (anonimowe wyszukiwanie po nazwie aplikacji) oraz icon.horse jako rozwiązanie zapasowe. Przechowywane w `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 Migawki aplikacji (Application Support)

- Spakowane w ZIP kopie `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers` itp. dla aplikacji, dla których wyraźnie utworzono migawkę. Przechowywane w `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Dzienniki (os.Logger)

- Zdarzenia diagnostyczne zapisywane przez ujednolicony system logowania Apple. Widoczne w Console.app. Nigdzie nie przesyłane.

Mogą Państwo usunąć wszystkie lokalnie przechowywane dane, usuwając AutoBrew, jego folder wsparcia (`~/Library/Application Support/AutoBrew/`) oraz jego plik plist UserDefaults (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. AKTYWNOŚĆ SIECIOWA

AutoBrew wykonuje żądania wychodzące w trzech sytuacjach. Żadna z nich nie przesyła danych osobowych.

### 4.1 Operacje na pakietach Homebrew

AutoBrew uruchamia lokalnie zainstalowany plik wykonywalny `brew`. Projekt Homebrew kontaktuje się następnie z `formulae.brew.sh`, GitHub, mirrorami CDN oraz indywidualnymi adresami URL pobierania cask. Nie mamy żadnej relacji z tymi punktami końcowymi — są one obsługiwane przez projekt Homebrew oraz odpowiednich wydawców cask na podstawie ich własnych warunków prywatności.

### 4.2 Katalog cask i rozpoznawanie ikon

- `formulae.brew.sh/api/cask.json` — anonimowe pobieranie publicznego katalogu cask
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — anonimowe pobieranie 365-dniowych statystyk instalacji
- `itunes.apple.com/search` — anonimowe wyszukiwanie ikon aplikacji macOS po nazwie wyświetlanej
- `icon.horse` — zapasowe wyszukiwanie favicon na podstawie URL `homepage` cask

### 4.3 Sprawdzanie automatycznych aktualizacji

Sparkle okresowo kontaktuje się z adresem URL appcast AutoBrew na GitHub w celu sprawdzenia nowych wydań AutoBrew. Żądanie zawiera Państwa wersję macOS oraz wersję AutoBrew (standardowy `User-Agent`), bez dalszych identyfikatorów.

---

## 5. USŁUGI STRON TRZECICH (NIE PODMIOTY PODPRZETWARZAJĄCE)

Nie angażujemy podmiotów podprzetwarzających, ponieważ nie przetwarzamy Państwa danych. Usługi stron trzecich, z którymi komunikuje się AutoBrew, działają niezależnie i na własnych warunkach:

| Usługa | Cel | Operator |
|---|---|---|
| Homebrew + formulae.brew.sh | Zarządzanie pakietami i katalog | Projekt Homebrew |
| Apple iTunes Search API | Wyszukiwanie ikon aplikacji | Apple Inc. |
| icon.horse | Zapasowy favicon | icon.horse |
| GitHub (appcast, releases) | Kanał dystrybucji + aktualizacji | GitHub, Inc. |

Po kliknięciu linku Sponsor wewnątrz AutoBrew opuszczają Państwo aplikację, a Państwa przeglądarka łączy się z GitHub Sponsors — ta interakcja podlega polityce prywatności GitHub.

---

## 6. PAŃSTWA PRAWA

Ponieważ nie przechowujemy danych osobowych na naszych serwerach, prawa do dostępu / sprostowania / usunięcia / przenoszenia / sprzeciwu / ograniczenia z art. 15–22 RODO oraz równoważne przepisy lokalne są praktycznie spełnione poprzez usunięcie AutoBrew z Państwa Maca.

Nadal mogą Państwo skontaktować się z nami pod adresem **data-protection@digitalfreedom.co.za** w przypadku pytań dotyczących niniejszej polityki.

Mogą Państwo złożyć skargę do właściwego organu ochrony danych. W Niemczech jest to Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). W Polsce właściwym organem nadzorczym jest Urząd Ochrony Danych Osobowych (UODO, https://uodo.gov.pl). UE wymienia organy krajowe pod adresem https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. DZIECI

AutoBrew jest narzędziem deweloperskim dla systemu macOS. Nie jest skierowany do dzieci poniżej 16. roku życia. Nie zbieramy danych osobowych, więc nie przetwarzamy też danych dzieci.

---

## 8. BEZPIECZEŃSTWO

- Plik binarny aplikacji jest podpisany certyfikatem Apple Developer ID i notaryzowany przez Apple.
- Automatyczne aktualizacje są weryfikowane względem podpisu EdDSA Ed25519 przed ich zastosowaniem.
- AutoBrew działa w ramach Hardened Runtime; aplikacje dystrybuowane bezpośrednio, które komunikują się z narzędziami systemowymi, nie mogą używać pełnego App Sandbox bez utraty funkcjonalności, dlatego dostarczamy minimalne wymagane uprawnienia.
- Kod źródłowy jest publicznie audytowalny pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. TRANSFERY MIĘDZYNARODOWE

Nie przekazujemy danych osobowych, ponieważ ich nie zbieramy. Usługi stron trzecich, z którymi łączą się Państwo za pośrednictwem AutoBrew (serwery projektu Homebrew, Apple, icon.horse, GitHub), mogą działać poza UE; transfery do tych usług odbywają się między Państwem a nimi, nie z nami.

---

## 10. ZMIANY NINIEJSZEJ POLITYKI

Możemy aktualizować niniejszą Politykę Prywatności w celu odzwierciedlenia zmian w architekturze AutoBrew lub w obowiązującym prawie. Data „Ostatniej aktualizacji" na górze odzwierciedla najnowszą wersję. Istotne zmiany są komunikowane w informacjach o wydaniu AutoBrew.

### 10.1 Przyszłe funkcje płatne

AutoBrew jest obecnie bezpłatny i działa bez jakiegokolwiek backendu (patrz sekcja 2). Wydawca zastrzega sobie prawo do wprowadzenia opcjonalnych **funkcji płatnych**, **edycji płatnych** lub **płatnych usług dodatkowych** w przyszłych wersjach, co może wymagać ograniczonego przetwarzania danych (np. obsługa płatności przez dostawcę zewnętrznego lub weryfikacja klucza licencyjnego). Każda taka zmiana będzie:

- Zapowiadana z wyprzedzeniem w informacjach o wydaniu AutoBrew oraz w niniejszej Polityce Prywatności
- Wyłącznie opcjonalna — bezpłatna wersja z zerowym zbieraniem danych pozostanie używalna
- Udokumentowana w dedykowanej sekcji niniejszej Polityki Prywatności przed włączeniem nowego przepływu danych

Obecne oświadczenie „zerowego zbierania danych" dotyczy aktualnej wersji AutoBrew. Nie stanowi ono wieczystej gwarancji dla każdej przyszłej wersji; będziemy aktualizować niniejszą Politykę, aby zawsze opisywała rzeczywiste zachowanie.

---

## 11. KONTAKT

W sprawach dotyczących ochrony danych:
**data-protection@digitalfreedom.co.za**

We wszystkich pozostałych sprawach:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (działająca jako DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Niemcy
Strona internetowa: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
