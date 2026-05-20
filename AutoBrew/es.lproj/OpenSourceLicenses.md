# AVISOS DE CÓDIGO ABIERTO

## Atribución del software de código abierto de terceros

**Última actualización:** Abril de 2026

**Editor:**
DigitalFreedom
Una marca de Berger & Rosenstock GbR
Dieselstr. 22e
61231 Bad Nauheim
Alemania
Contacto: hello@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

---

## 1. INTRODUCCIÓN

Este documento recoge los componentes de software de código abierto utilizados en AutoBrew (el «Software»). Cada componente está sujeto a sus propios términos de licencia, que se reproducen o referencian a continuación.

**AutoBrew en sí mismo se publica bajo la licencia MIT.** El código fuente completo está disponible públicamente en el repositorio de GitHub.

Este aviso se proporciona en cumplimiento de los requisitos de atribución y notificación de las licencias de código abierto aplicables y conforme a nuestro [EULA](EULA.md).

### 1.1 Alcance global

AutoBrew se distribuye directamente para macOS y, por tanto, está disponible en todo país y territorio. Estos avisos de código abierto se aplican globalmente — los avisos de copyright, los textos de las licencias y los requisitos de atribución se presentan según lo exigido por la licencia de cada componente y según sean exigibles conforme al derecho de autor de la UE (tomado como referencia) y al derecho de autor de toda otra jurisdicción en la que se distribuya el Software.

---

## 2. CONDICIONES GENERALES

### 2.1 Jerarquía de licencias

Cuando el Software incluya componentes de código abierto:

- Los términos de la licencia de código abierto rigen dichos componentes
- Nuestro EULA no anula ni restringe los derechos concedidos por las licencias de código abierto
- En caso de conflicto entre el EULA y una licencia de código abierto, prevalece la licencia de código abierto respecto del componente afectado

### 2.2 Disponibilidad del código fuente

Dado que AutoBrew se publica bajo la licencia MIT, el código fuente completo está disponible públicamente en el repositorio de GitHub de DigitalFreedom.

Para los componentes con licencia bajo licencias copyleft (por ejemplo, GPL, LGPL, MPL) que requieran disponibilidad del código fuente:

- El código fuente está disponible a petición en: hello@digitalfreedom.co.za
- Las solicitudes se atenderán en un plazo de 30 días
- Las ofertas de código fuente permanecen vigentes durante 3 años desde la última fecha de distribución, o conforme exija la respectiva licencia

### 2.3 Sus obligaciones

Si redistribuye el Software o componentes del mismo, es responsable del cumplimiento de los términos de las licencias de código abierto aplicables, incluyendo:

- Conservar los avisos de copyright y los textos de las licencias
- Proporcionar el código fuente cuando sea exigido
- Mantener los avisos de atribución

---

## 3. COMPONENTES DE CÓDIGO ABIERTO

### 3.1 Sparkle

```
Componente: Sparkle
Licencia: MIT
Copyright: Copyright (c) 2006-2024 Andy Matuschak y otros
Repositorio: https://github.com/sparkle-project/Sparkle
```

Sparkle es el framework de actualización de software utilizado por AutoBrew para entregar actualizaciones firmadas.

### 3.2 Homebrew (referenciado, no incluido)

Homebrew se invoca por AutoBrew como un programa externo y no se distribuye con la aplicación. Homebrew se publica bajo la licencia BSD 2-Clause y debe instalarse por separado desde https://brew.sh.

### 3.3 AutoBrew (este Software)

```
Componente: AutoBrew
Licencia: MIT
Copyright: Copyright (c) 2025-2026 Marcel R. G. Berger / Berger & Rosenstock GbR
Repositorio: https://github.com/marcelrgberger/auto-brew
```

**MIT License:**

> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.

---

## 4. TEXTOS DE LICENCIAS COMUNES

### 4.1 MIT License

Véase el texto íntegro arriba.

### 4.2 Apache License 2.0

Los componentes con licencia Apache License 2.0 están sujetos a los términos disponibles en:
https://www.apache.org/licenses/LICENSE-2.0

### 4.3 BSD 2-Clause License («Simplified»)

Los componentes con licencia BSD 2-Clause están sujetos a los términos disponibles en:
https://opensource.org/licenses/BSD-2-Clause

### 4.4 BSD 3-Clause License («New» o «Revised»)

Los componentes con licencia BSD 3-Clause están sujetos a los términos disponibles en:
https://opensource.org/licenses/BSD-3-Clause

### 4.5 GNU General Public License v3.0 (GPL-3.0)

Los componentes con licencia GPL-3.0 están sujetos a los términos disponibles en:
https://www.gnu.org/licenses/gpl-3.0.html

### 4.6 GNU Lesser General Public License v3.0 (LGPL-3.0)

Los componentes con licencia LGPL-3.0 están sujetos a los términos disponibles en:
https://www.gnu.org/licenses/lgpl-3.0.html

### 4.7 Mozilla Public License 2.0 (MPL-2.0)

Los componentes con licencia MPL-2.0 están sujetos a los términos disponibles en:
https://www.mozilla.org/en-US/MPL/2.0/

### 4.8 ISC License

Los componentes con licencia ISC están sujetos a los términos disponibles en:
https://opensource.org/licenses/ISC

---

## 5. CONSIDERACIONES LEGALES POR JURISDICCIÓN

### 5.1 Unión Europea

- El cumplimiento de las licencias de código abierto es exigible conforme al derecho de autor de la UE (Directiva 2001/29/CE)
- La Directiva sobre programas de ordenador (2009/24/CE) permite la descompilación con fines de interoperabilidad
- El Cyber Resilience Act (Reglamento (UE) 2024/2847) puede imponer obligaciones adicionales al software comercial que incorpore componentes de código abierto

### 5.2 Alemania

- La UrhG (Urheberrechtsgesetz) regula los derechos de autor sobre el software
- Las licencias de código abierto son generalmente exigibles conforme al derecho contractual alemán
- Los tribunales alemanes han hecho cumplir la GPL y otras licencias de código abierto (por ejemplo, LG München I, LG Hamburg)

### 5.3 Estados Unidos

- La Copyright Act (17 U.S.C.) regula los derechos de autor sobre el software
- Las licencias de código abierto son exigibles como licencias de derechos de autor
- Pueden aplicarse las disposiciones de puerto seguro de la DMCA

### 5.4 Reino Unido

- La Copyright, Designs and Patents Act 1988 regula los derechos de autor sobre el software
- Las licencias de código abierto son exigibles conforme al derecho inglés contractual y de derechos de autor

### 5.5 Japón

- La Copyright Act (著作権法) regula los derechos de autor sobre el software
- Las licencias de código abierto son reconocidas y exigibles

### 5.6 Otras jurisdicciones

- La exigibilidad de las licencias de código abierto puede variar según la jurisdicción
- El derecho local de autor regula los derechos y obligaciones de los licenciatarios

---

## 6. ACTUALIZACIONES

Este documento se actualiza cuando se añaden nuevos componentes de código abierto o cuando se actualizan los componentes existentes. La fecha de «Última actualización» en la parte superior refleja la revisión más reciente.

---

## 7. CONTACTO

Para consultas sobre componentes de código abierto, cumplimiento de licencias o solicitudes de código fuente:

DigitalFreedom
Una marca de Berger & Rosenstock GbR
Dieselstr. 22e
61231 Bad Nauheim
Alemania
Correo electrónico: hello@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

---

(c) 2025-2026 DigitalFreedom — Berger & Rosenstock GbR. Todos los derechos reservados.

*Nota: El aviso de copyright anterior se aplica a este documento en sí, no a los componentes de código abierto enumerados, que están sujetos a sus respectivas licencias.*
