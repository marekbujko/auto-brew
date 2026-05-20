# UMOWA LICENCYJNA UŻYTKOWNIKA KOŃCOWEGO (EULA)

## AutoBrew

**Data wejścia w życie:** maj 2026
**Ostatnia aktualizacja:** maj 2026

Niniejsza Umowa Licencyjna Użytkownika Końcowego („EULA", „Umowa") jest umową prawną pomiędzy Państwem („Użytkownik", „Państwo") a wydawcą AutoBrew, **Berger & Rosenstock GbR** działającym jako **DigitalFreedom** („Wydawca", „my", „nas", „nasz").

Instalując, kopiując lub w inny sposób korzystając z AutoBrew („Oprogramowanie"), zgadzają się Państwo na związanie warunkami niniejszej EULA.

---

## 1. OPROGRAMOWANIE

AutoBrew jest narzędziem paska menu dla systemu macOS, które automatyzuje aktualizacje Homebrew, przegląda katalog cask Homebrew oraz zarządza migawkami aplikacji. Jest publikowany pod marką DigitalFreedom i licencjonowany Państwu na poniższych warunkach.

### 1.1 Model licencyjny

AutoBrew jest wydany jako **bezpłatne oprogramowanie open source** na licencji MIT. Pełny tekst licencji MIT znajduje się w sekcji 6 oraz w dokumencie [Licencje Open Source](OpenSourceLicenses.md). Licencja MIT reguluje kod źródłowy; niniejsza EULA obejmuje dystrybucję plików binarnych oraz Państwa obowiązki jako użytkownika pliku binarnego.

### 1.2 Zastrzeżenie dotyczące przyszłych funkcji płatnych

Wydawca zastrzega sobie prawo do wprowadzenia opcjonalnych **funkcji płatnych**, **edycji płatnych** lub **płatnych usług dodatkowych** w dowolnym momencie. Każda taka przyszła zmiana:

- Zostanie zapowiedziana z wyprzedzeniem za pośrednictwem interfejsu aplikacji oraz oficjalnych informacji o wydaniu
- Będzie obowiązywać wyłącznie na przyszłość (tj. istniejąca bezpłatna funkcjonalność wersji, którą już Państwo zainstalowali, pozostanie bezpłatna w użyciu)
- Pozostawi rdzeń open-source na licencji MIT — kod źródłowy pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) pozostanie dostępny na tej samej licencji, niezależnie od jakichkolwiek dodatków płatnych

Aktualny brak jakiejkolwiek funkcji płatnej nie stanowi gwarancji, że AutoBrew pozostanie wolny od funkcji płatnych na zawsze.

### 1.3 Zakres open-source a funkcje płatne

Licencja MIT obowiązuje dla kodu źródłowego AutoBrew opublikowanego w oficjalnym repozytorium pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Forki i utwory pochodne tej bazy kodu są wyraźnie dozwolone** zgodnie z warunkami licencji MIT — z zadowoleniem przyjmujemy budowanie przez społeczność na bazie AutoBrew.

Wszelkie **przyszłe funkcje płatne**, **edycje płatne** lub **płatne usługi dodatkowe** (patrz sekcja 1.2) będą wydawane na podstawie **odrębnej licencji własnościowej** i **nie** będą stanowić części bazy kodu na licencji MIT. W szczególności:

- Kod źródłowy funkcji płatnych nie będzie publikowany w repozytorium MIT
- Kopiowanie, dekompilacja, inżynieria wsteczna lub w inny sposób reprodukowanie implementacji jakiejkolwiek własnościowej funkcji płatnej dostarczanej przez AutoBrew nie jest dozwolone, z wyjątkiem przypadków wyraźnie dopuszczonych przez bezwzględnie obowiązujące prawo (np. § 69e UrhG / art. 6 dyrektywy UE 2009/24/WE w celu interoperacyjności)
- Niniejsze ograniczenie dotyczy konkretnie implementacji funkcji płatnych — nie ogranicza ono prawa żadnej strony trzeciej do niezależnego opracowania porównywalnej funkcjonalności od podstaw

Znaki towarowe **„AutoBrew"** i **„DigitalFreedom"** nie mogą być używane przez forki lub utwory pochodne oferujące konkurencyjne funkcje płatne — patrz sekcja 3 niniejszej EULA oraz dokument [Znaki towarowe](Trademark.md).

### 1.4 Kanały dystrybucji

Oficjalny plik binarny AutoBrew jest dystrybuowany wyłącznie poprzez:

- **GitHub Releases** pod adresem [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — notaryzowane pliki DMG podpisane certyfikatem Apple Developer ID
- **Tap Homebrew** pod adresem [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew **nie jest** dystrybuowany za pośrednictwem Apple App Store, Google Play Store ani żadnego zewnętrznego portalu pobierania. Jeśli pozyskali Państwo AutoBrew z innego miejsca, plik binarny jest niezweryfikowany i nie jest objęty niniejszą EULA.

---

## 2. UDZIELENIE LICENCJI

Z zastrzeżeniem przestrzegania niniejszej EULA oraz licencji MIT Wydawca udziela Państwu ogólnoświatowej, nieodpłatnej, niewyłącznej licencji na:

- Instalację i uruchamianie AutoBrew na dowolnej liczbie Maców, które Państwo posiadają lub kontrolują
- Modyfikację kodu źródłowego i tworzenie utworów pochodnych
- Redystrybucję Oprogramowania w postaci źródłowej lub binarnej

---

## 3. OGRANICZENIA

Nie mogą Państwo:

- Usuwać, zmieniać ani ukrywać not copyright, tekstu licencji MIT ani osadzonych not licencyjnych Sparkle / bsdiff / sais-lite / pdqsort podczas redystrybucji
- Używać znaków towarowych **„AutoBrew"** i **„DigitalFreedom"** w nazwie forka lub utworu pochodnego bez naszej uprzedniej pisemnej zgody (patrz dokument [Znaki towarowe](Trademark.md))
- Wprowadzać w błąd, przedstawiając swój fork jako oficjalną dystrybucję AutoBrew

---

## 4. KOMPONENTY STRON TRZECICH

AutoBrew dołącza następujące komponenty open-source, z których każdy podlega własnej licencji (pełna lista i dosłowne teksty licencji w dokumencie [Licencje Open Source](OpenSourceLicenses.md)):

- **Sparkle** (MIT) — automatyczne aktualizacje w aplikacji
- **bsdiff / bspatch** (BSD-2-Clause) — dołączone wewnątrz Sparkle do delt binarnych
- **sais-lite** (MIT) — dołączony wewnątrz Sparkle
- **pdqsort** (zlib) — dołączony wewnątrz Sparkle

AutoBrew w czasie wykonywania opiera się również na **Homebrew** (BSD-2-Clause) — wywoływanym poprzez uruchomienie procesu, nie osadzonym. Homebrew musi być zainstalowany oddzielnie; AutoBrew przeprowadzi Państwa przez jego instalację przy pierwszym uruchomieniu.

Licencje MIT, BSD-2-Clause oraz zlib mające zastosowanie do tych komponentów pozostają w mocy niezależnie od niniejszej EULA. W przypadku konfliktu między niniejszą EULA a licencją open-source, licencja open-source ma pierwszeństwo dla danego komponentu.

---

## 5. BEZ PŁATNOŚCI, BEZ KONTA (STAN AKTUALNY)

AutoBrew jest obecnie bezpłatny. Oprogramowanie nie wymaga rejestracji, zapisu ani jakiejkolwiek płatności, a w momencie wydania niniejszej EULA nie istnieją zakupy w aplikacji, subskrypcje, funkcje płatne ani mechanika okresu próbnego.

Link **Sponsor** wewnątrz AutoBrew prowadzi do GitHub Sponsors i jest **całkowicie dobrowolny**. Każdy wkład traktowany jest jako darowizna i nie nadaje dodatkowych uprawnień.

**Zastrzeżenie:** Patrz sekcja 1.2 — Wydawca zastrzega sobie prawo do wprowadzenia w przyszłości opcjonalnych funkcji płatnych, edycji płatnych lub płatnych usług dodatkowych. Każda taka przyszła oferta płatna będzie dotyczyć tylko użytkowników, którzy wyraźnie się na nią zdecydują; aktualnie zainstalowana bezpłatna funkcjonalność nie zostanie wstecznie zablokowana.

---

## 6. LICENCJA MIT (dosłownie)

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

## 7. WYŁĄCZENIE GWARANCJI

Oprogramowanie jest dostarczane **„TAK JAK JEST"** bez jakichkolwiek gwarancji, wyraźnych lub dorozumianych. Wydawca nie gwarantuje, że Oprogramowanie będzie działać nieprzerwanie lub bezbłędnie, że współdziałanie AutoBrew z Homebrew lub z poszczególnymi cask zawsze się powiedzie ani że migawki idealnie uchwycą każdy aspekt stanu aplikacji.

Ustawowe prawa gwarancyjne, których nie można wyłączyć w drodze umowy na podstawie lokalnego prawa ochrony konsumentów (np. niemiecka Mängelhaftung zgodnie z §§ 434 i nast. BGB, gdy ma zastosowanie), pozostają nienaruszone.

---

## 8. OGRANICZENIE ODPOWIEDZIALNOŚCI

W maksymalnym zakresie dozwolonym przez obowiązujące prawo Wydawca nie ponosi odpowiedzialności za jakiekolwiek pośrednie, przypadkowe, wynikowe, przykładowe ani karne szkody — w tym za utratę danych, utracone zyski lub szkody wynikające z oprogramowania stron trzecich (Homebrew, poszczególne cask) wywoływanego za pośrednictwem AutoBrew.

W odniesieniu do użytkowników mających zwykłe miejsce pobytu w Niemczech lub UE, nasza odpowiedzialność za szkody spowodowane **rażącym niedbalstwem lub umyślnym niewłaściwym postępowaniem**, za **naruszenie życia, zdrowia lub ciała** oraz na podstawie **niemieckiej ustawy o odpowiedzialności za produkt (ProdHaftG)** pozostaje nienaruszona.

---

## 9. KONTROLA EKSPORTU

Oprogramowanie nie zawiera kryptografii wykraczającej poza to, co domyślnie zapewnia macOS firmy Apple oraz framework Sparkle. Eksport samego macOS jest regulowany warunkami Apple; pozostają Państwo odpowiedzialni za przestrzeganie przepisów kontroli eksportu obowiązujących w Państwa jurysdykcji.

---

## 10. ROZWIĄZANIE

Niniejsza EULA obowiązuje do czasu jej rozwiązania. Wygasa automatycznie bez powiadomienia, jeżeli nie zastosują się Państwo do jej warunków. Mogą Państwo również w każdej chwili ją rozwiązać, odinstalowując AutoBrew. Po rozwiązaniu muszą Państwo zaprzestać wszelkiego użytkowania Oprogramowania i usunąć wszystkie kopie znajdujące się pod Państwa kontrolą.

---

## 11. PRAWO WŁAŚCIWE I JURYSDYKCJA

Niniejsza EULA podlega prawu Republiki Federalnej Niemiec, z wyłączeniem Konwencji Narodów Zjednoczonych o umowach międzynarodowej sprzedaży towarów (CISG). Dodatkowo stosuje się bezwzględnie obowiązujące prawo ochrony konsumentów kraju zamieszkania użytkownika.

Niewyłącznym miejscem jurysdykcji jest Bad Nauheim, Niemcy. Konsumenci mogą pozywać w miejscu swojego zamieszkania, jeżeli pozwala na to prawo lokalne.

---

## 12. KONTAKT

Berger & Rosenstock GbR (działająca jako DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Niemcy
E-mail: hello@digitalfreedom.co.za
Strona internetowa: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
