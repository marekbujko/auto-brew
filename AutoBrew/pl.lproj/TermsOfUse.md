# WARUNKI UŻYTKOWANIA

## AutoBrew

**Data wejścia w życie:** maj 2026
**Ostatnia aktualizacja:** maj 2026

Niniejsze Warunki Użytkowania („Warunki") regulują korzystanie przez Państwa z AutoBrew („Oprogramowanie"). Prosimy o ich uważne przeczytanie. Instalując lub używając AutoBrew, zgadzają się Państwo na związanie niniejszymi Warunkami.

---

## 1. DOSTAWCA

Oprogramowanie jest publikowane pod marką **DigitalFreedom**. Stojącym za nim podmiotem prawnym jest:

Berger & Rosenstock GbR (działająca jako DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Niemcy
Uprawnieni przedstawiciele: Marcel R. G. Berger, Jasmin Rosenstock
E-mail: hello@digitalfreedom.co.za
Strona internetowa: https://digitalfreedom.co.za

Niniejsze Warunki obowiązują globalnie. Bezwzględnie obowiązujące prawa konsumenta oraz inne ustawowe prawa przyznane przez kraj zamieszkania użytkownika pozostają nienaruszone i mają pierwszeństwo wszędzie tam, gdzie zapewniają wyższą ochronę.

---

## 2. OPROGRAMOWANIE

AutoBrew jest narzędziem paska menu dla systemu macOS, które automatyzuje aktualizacje Homebrew, przegląda katalog cask Homebrew oraz zarządza migawkami aplikacji do migracji między Macami. Jest:

- **Open source** na licencji MIT — pełny kod źródłowy pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Bezpłatny** — bez zakupów w aplikacji, bez subskrypcji, bez wariantu płatnego, bez okresu próbnego
- **Dystrybuowany bezpośrednio** — notaryzowany plik DMG z GitHub Releases oraz tap Homebrew; nie poprzez Apple App Store ani Google Play Store
- **Wyłącznie lokalny** — działa w całości na Państwa Macu, nie wymaga konta AutoBrew ani usługi backend (patrz [Polityka Prywatności](PrivacyPolicy.md))

Niniejsze Warunki dotyczą pliku binarnego AutoBrew. Licencja MIT (powtórzona w [EULA](EULA.md) oraz [Licencje Open Source](OpenSourceLicenses.md)) reguluje kod źródłowy oraz wszelkie forki lub utwory pochodne.

---

## 3. LICENCJA UŻYTKOWA

Z zastrzeżeniem przestrzegania niniejszych Warunków oraz licencji MIT mogą Państwo:

- Instalować, uruchamiać, modyfikować i redystrybuować AutoBrew na dowolnej liczbie Maców, które Państwo kontrolują
- Forkować kod źródłowy i tworzyć utwory pochodne na warunkach licencji MIT

Nie mogą Państwo:

- Wprowadzać w błąd co do pochodzenia Oprogramowania (licencja MIT wymaga zachowania oryginalnej noty copyright)
- Usuwać osadzonych not licencyjnych Sparkle, bsdiff, sais-lite ani pdqsort podczas redystrybucji
- Używać nazwy **AutoBrew** ani marki **DigitalFreedom** w utworach pochodnych bez naszej pisemnej zgody (znak towarowy, patrz dokument [Znaki towarowe](Trademark.md))

---

## 4. BEZ KONTA, BEZ PŁATNOŚCI (STAN AKTUALNY)

AutoBrew obecnie nie wymaga rejestracji, zapisu ani jakiejkolwiek płatności. Link **Sponsor** wewnątrz aplikacji prowadzi do GitHub Sponsors i jest **całkowicie dobrowolny** — każdy wkład traktowany jest jako darowizna i nie tworzy uprawnień do funkcji ani wsparcia.

### 4.1 Zastrzeżenie dotyczące przyszłych funkcji płatnych

Dostawca zastrzega sobie prawo do wprowadzenia opcjonalnych **funkcji płatnych**, **edycji płatnych** lub **płatnych usług dodatkowych** w przyszłych wersjach AutoBrew. Każda taka przyszła płatna oferta:

- Zostanie zapowiedziana z wyprzedzeniem za pośrednictwem interfejsu aplikacji oraz oficjalnych informacji o wydaniu
- Będzie obowiązywać wyłącznie na przyszłość — Państwa prawo do dalszego korzystania z aktualnej bezpłatnej wersji pozostaje nienaruszone
- Pozostawi nienaruszony rdzeń open-source: kod źródłowy pod adresem [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) pozostanie dostępny na licencji MIT

Aktualny brak funkcji płatnych nie stanowi gwarancji, że AutoBrew pozostanie wolny od funkcji płatnych w każdej przyszłej wersji.

---

## 5. ZALEŻNOŚĆ OD HOMEBREW

AutoBrew opiera się na działającej instalacji Homebrew, aby spełniać swój cel. AutoBrew uruchamia plik binarny `brew` oraz odczytuje i zapisuje dane przy użyciu własnych komend i konwencji projektu Homebrew. Nie jesteśmy powiązani z projektem Homebrew; nie kontrolujemy, które pakiety są dostępne, kiedy wydawane są wersje ani co poszczególni wydawcy cask robią ze swoimi instalatorami.

Jeśli instalacja cask nie powiedzie się, zachowa się nieoczekiwanie lub spowoduje szkodę, dotyczy to relacji między Państwem a wydawcą cask i/lub projektem Homebrew — patrz sekcja 7 (Wyłączenie gwarancji) oraz sekcja 8 (Ograniczenie odpowiedzialności).

---

## 6. AKTUALIZACJE

AutoBrew korzysta z frameworku Sparkle do dostarczania aktualizacji w aplikacji z oficjalnego appcast AutoBrew na GitHub. Aktualizacje są podpisywane kluczem EdDSA Ed25519 i weryfikowane przed zastosowaniem. Automatyczne aktualizacje można wyłączyć w Ustawieniach.

Mogą Państwo zignorować aktualizacje w aplikacji i aktualizować plik binarny za pośrednictwem swojego tap Homebrew lub ręcznie pobierając nowszy DMG.

---

## 7. WYŁĄCZENIE GWARANCJI

Oprogramowanie jest dostarczane **„TAK JAK JEST"** i **„W MIARĘ DOSTĘPNOŚCI"** bez jakichkolwiek gwarancji, wyraźnych lub dorozumianych, w tym m.in. dorozumianych gwarancji przydatności handlowej, przydatności do określonego celu i nienaruszania praw.

Bez ograniczania powyższego nie gwarantujemy, że:

- Oprogramowanie będzie działać nieprzerwanie lub bezbłędnie
- Współdziałanie AutoBrew z Homebrew, z poszczególnymi cask lub z samym macOS zawsze przyniesie pożądany rezultat
- Migawki tworzone przez AutoBrew idealnie uchwycą każdy aspekt stanu aplikacji — aplikacje, które przechowują dane poza standardowymi podkatalogami Library, mogą nie zostać w pełni uchwycone

Ustawowe prawa gwarancyjne, których nie można wyłączyć w drodze umowy na podstawie lokalnego prawa ochrony konsumentów (np. niemiecka Mängelhaftung zgodnie z §§ 434 i nast. BGB, gdy ma zastosowanie), pozostają nienaruszone.

---

## 8. OGRANICZENIE ODPOWIEDZIALNOŚCI

W maksymalnym zakresie dozwolonym przez obowiązujące prawo:

- Nie ponosimy odpowiedzialności za jakiekolwiek pośrednie, przypadkowe, wynikowe, przykładowe lub karne szkody
- Nie ponosimy odpowiedzialności za utratę danych, utracone zyski, przerwę w działalności ani jakiekolwiek szkody wynikające z oprogramowania stron trzecich (Homebrew, poszczególne cask) wywoływanego za pośrednictwem AutoBrew

W odniesieniu do użytkowników mających zwykłe miejsce pobytu w Niemczech lub UE, nasza odpowiedzialność za szkody spowodowane **rażącym niedbalstwem lub umyślnym niewłaściwym postępowaniem**, za **naruszenie życia, zdrowia lub ciała** oraz na podstawie **bezwzględnie obowiązujących przepisów niemieckiej ustawy o odpowiedzialności za produkt (ProdHaftG)** pozostaje nienaruszona.

---

## 9. ROZWIĄZANIE

Mogą Państwo w każdej chwili przestać korzystać z AutoBrew, odinstalowując go. Usunięcie AutoBrew oraz jego folderu wsparcia (`~/Library/Application Support/AutoBrew/`) przywraca Państwa Maca do stanu, w którym nie pozostają żadne artefakty AutoBrew.

Możemy w każdej chwili zaprzestać dystrybucji AutoBrew. Ponieważ Oprogramowanie jest open source na licencji MIT, Państwo i społeczność pozostają wolni, aby je forkować, budować i niezależnie uruchamiać.

---

## 10. ZMIANY NINIEJSZYCH WARUNKÓW

Możemy aktualizować niniejsze Warunki w celu odzwierciedlenia zmian w Oprogramowaniu lub w obowiązującym prawie. Istotne zmiany są komunikowane w informacjach o wydaniu AutoBrew. Data „Ostatniej aktualizacji" na górze odzwierciedla najnowszą wersję.

---

## 11. PRAWO WŁAŚCIWE I JURYSDYKCJA

Niniejsze Warunki podlegają prawu Republiki Federalnej Niemiec, z wyłączeniem Konwencji Narodów Zjednoczonych o umowach międzynarodowej sprzedaży towarów (CISG).

Dla konsumentów mających zwykłe miejsce pobytu poza Niemcami dodatkowo stosuje się bezwzględnie obowiązujące prawo ochrony konsumentów ich kraju zamieszkania. Niewyłącznym miejscem jurysdykcji dla sporów jest Bad Nauheim, Niemcy; konsumenci mogą nadal pozywać w miejscu swojego zamieszkania, jeżeli pozwala na to prawo lokalne.

W przypadku sporów konsumenckich powstałych na gruncie prawa UE dostępna jest platforma internetowego rozstrzygania sporów Komisji Europejskiej pod adresem https://ec.europa.eu/consumers/odr. Nie jesteśmy zobowiązani ani skłonni do udziału w alternatywnych postępowaniach rozstrzygania sporów przed komisją arbitrażową konsumentów (Verbraucherschlichtungsstelle) zgodnie z § 36 VSBG.

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
