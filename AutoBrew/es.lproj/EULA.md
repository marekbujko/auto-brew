# CONTRATO DE LICENCIA DE USUARIO FINAL (EULA)

## AutoBrew

**Fecha de entrada en vigor:** Mayo de 2026
**Última actualización:** Mayo de 2026

El presente Contrato de Licencia de Usuario Final («EULA», «Contrato») es un contrato legal entre usted («Usuario», «usted») y el editor de AutoBrew, **Berger & Rosenstock GbR** operando como **DigitalFreedom** («Editor», «nosotros», «nos», «nuestro»).

Al instalar, copiar o utilizar de cualquier otro modo AutoBrew (el «Software»), acepta quedar vinculado por los términos del presente EULA.

---

## 1. EL SOFTWARE

AutoBrew es una utilidad para la barra de menús de macOS que automatiza las actualizaciones de Homebrew, navega por el catálogo de casks de Homebrew y gestiona snapshots de aplicaciones. Se publica bajo la marca DigitalFreedom y se le licencia bajo los términos siguientes.

### 1.1 Modelo de licencia

AutoBrew se publica como **software libre y de código abierto** bajo la Licencia MIT. El texto completo de la Licencia MIT se reproduce en la Sección 6 y en el documento [Licencias de código abierto](OpenSourceLicenses.md). La Licencia MIT rige el código fuente; este EULA cubre la distribución binaria y sus obligaciones como usuario del binario.

### 1.2 Reserva sobre futuras funciones de pago

El Editor se reserva el derecho a introducir **funciones de pago**, **ediciones de pago** o **servicios complementarios de pago** opcionales en cualquier momento. Cualquier cambio futuro de este tipo:

- Se anunciará con antelación a través de la interfaz de la aplicación y de las notas de versión oficiales
- Se aplicará únicamente con efecto prospectivo (es decir, la funcionalidad gratuita existente de una versión que usted ya tenga instalada seguirá siendo gratuita)
- Dejará intacto el núcleo de código abierto bajo la Licencia MIT — el código fuente en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) permanece disponible bajo la misma licencia con independencia de cualquier añadido de pago

La ausencia actual de funciones de pago no constituye una garantía de que AutoBrew vaya a permanecer libre de funciones de pago indefinidamente.

### 1.3 Alcance del código abierto frente a funciones de pago

La Licencia MIT se aplica al código fuente de AutoBrew tal y como se publica en el repositorio oficial en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Se permiten expresamente los forks y los derivados de ese código** conforme a los términos de la Licencia MIT — agradecemos que la comunidad construya sobre AutoBrew.

Cualquier **futura función de pago**, **edición de pago** o **servicio complementario de pago** (véase la Sección 1.2) se publicará bajo una **licencia propietaria independiente** y **no** formará parte del código bajo licencia MIT. En particular:

- El código fuente de las funciones de pago no se publicará en el repositorio MIT
- No está permitido copiar, descompilar, realizar ingeniería inversa ni reproducir de cualquier otra forma la implementación de cualquier función propietaria de pago distribuida por AutoBrew, salvo en la medida expresamente permitida por la legislación imperativa aplicable (por ejemplo, el § 69e UrhG / el art. 6 de la Directiva 2009/24/CE de la UE para la interoperabilidad)
- Esta restricción se aplica específicamente a la implementación de la función de pago — no restringe el derecho de terceros a desarrollar funcionalidades comparables de forma independiente y desde cero

Las marcas **«AutoBrew»** y **«DigitalFreedom»** no podrán ser utilizadas por forks o derivados que ofrezcan funciones de pago competidoras — véase la Sección 3 del presente EULA y el [Aviso sobre la marca](Trademark.md).

### 1.4 Canales de distribución

El binario oficial de AutoBrew se distribuye exclusivamente a través de:

- **GitHub Releases** en [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — archivos DMG notarizados firmados con el certificado Apple Developer ID
- El **tap de Homebrew** en [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

AutoBrew **no** se distribuye a través de la Apple App Store, la Google Play Store ni de ningún portal de descarga de terceros. Si ha obtenido AutoBrew de cualquier otro lugar, el binario no está verificado y no está cubierto por el presente EULA.

---

## 2. CONCESIÓN DE LICENCIA

Sujeto al cumplimiento de este EULA y de la Licencia MIT, el Editor le concede una licencia mundial, libre de regalías y no exclusiva para:

- Instalar y ejecutar AutoBrew en cualquier número de Macs de su propiedad o bajo su control
- Modificar el código fuente y crear obras derivadas
- Redistribuir el Software en forma fuente o binaria

---

## 3. RESTRICCIONES

No podrá:

- Eliminar, alterar u ocultar los avisos de copyright, el texto de la Licencia MIT o los avisos de licencia incrustados de Sparkle / bsdiff / sais-lite / pdqsort al redistribuir
- Utilizar las marcas **«AutoBrew»** y **«DigitalFreedom»** en el nombre de un fork o derivado sin nuestro consentimiento previo por escrito (véase el documento [Marca](Trademark.md))
- Tergiversar su fork como la distribución oficial de AutoBrew

---

## 4. COMPONENTES DE TERCEROS

AutoBrew integra los siguientes componentes de código abierto, cada uno regido por su propia licencia (véase el documento [Licencias de código abierto](OpenSourceLicenses.md) para la lista completa y los textos íntegros de las licencias):

- **Sparkle** (MIT) — actualizaciones automáticas dentro de la aplicación
- **bsdiff / bspatch** (BSD-2-Clause) — integrado en Sparkle para deltas binarios
- **sais-lite** (MIT) — integrado en Sparkle
- **pdqsort** (zlib) — integrado en Sparkle

AutoBrew depende además en tiempo de ejecución de **Homebrew** (BSD-2-Clause) — invocado mediante el lanzamiento de procesos, no integrado. Homebrew debe instalarse por separado; AutoBrew le guiará en su instalación en el primer arranque.

Las licencias MIT, BSD-2-Clause y zlib aplicables a estos componentes permanecen en vigor con independencia del presente EULA. En caso de conflicto entre este EULA y una licencia de código abierto, prevalecerá la licencia de código abierto respecto del componente afectado.

---

## 5. SIN PAGO, SIN CUENTA (ESTADO ACTUAL)

Actualmente AutoBrew es gratuito. El Software no requiere registro, alta ni pago, y en la fecha de este EULA no existen compras dentro de la aplicación, suscripciones, funciones de pago ni mecánicas de prueba.

El enlace **Sponsor** dentro de AutoBrew dirige a GitHub Sponsors y es **totalmente voluntario**. Cualquier contribución se considera una donación y no confiere derechos adicionales.

**Reserva:** Véase la Sección 1.2 — el Editor se reserva el derecho a introducir funciones de pago, ediciones de pago o servicios complementarios de pago opcionales en el futuro. Cualquier oferta de pago futura de este tipo solo se aplicará a los usuarios que opten expresamente por ella; la funcionalidad gratuita actual ya instalada no se restringirá retroactivamente.

---

## 6. LICENCIA MIT (verbatim)

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

## 7. EXENCIÓN DE GARANTÍAS

El Software se proporciona **«TAL CUAL»**, sin garantías de ningún tipo, expresas o implícitas. El Editor no garantiza que el Software sea ininterrumpido o esté libre de errores, que la interacción de AutoBrew con Homebrew o con casks individuales tenga siempre éxito, ni que los snapshots capturen perfectamente todos los aspectos del estado de una aplicación.

Los derechos legales de garantía que no puedan excluirse contractualmente conforme a la legislación local de protección del consumidor (por ejemplo, la Mängelhaftung alemana conforme a los §§ 434 y ss. del BGB, cuando proceda) permanecen inalterados.

---

## 8. LIMITACIÓN DE RESPONSABILIDAD

En la máxima medida permitida por la legislación aplicable, el Editor no será responsable de daños indirectos, incidentales, consecuentes, ejemplares ni punitivos — incluidos la pérdida de datos, el lucro cesante o los daños derivados de software de terceros (Homebrew, casks individuales) invocado a través de AutoBrew.

Para los usuarios con residencia habitual en Alemania o la UE, nuestra responsabilidad por daños causados por **negligencia grave o dolo**, por **lesión a la vida, integridad física o salud**, y conforme a la **Ley Alemana de Responsabilidad por Productos (ProdHaftG)** permanece inalterada.

---

## 9. CONTROL DE EXPORTACIÓN

El Software no contiene criptografía más allá de la que ofrecen por defecto macOS de Apple y el framework Sparkle. La exportación del propio macOS se rige por los términos de Apple; usted sigue siendo responsable del cumplimiento de las leyes de control de exportación aplicables en su jurisdicción.

---

## 10. TERMINACIÓN

El presente EULA tiene vigencia hasta su terminación. Termina automáticamente sin previo aviso si usted incumple cualquiera de sus términos. También puede terminarlo en cualquier momento desinstalando AutoBrew. Tras la terminación, deberá cesar todo uso del Software y eliminar todas las copias bajo su control.

---

## 11. LEY APLICABLE Y JURISDICCIÓN

El presente EULA se rige por las leyes de la República Federal de Alemania, con exclusión de la Convención de las Naciones Unidas sobre los Contratos de Compraventa Internacional de Mercaderías (CISG). Se aplica además la legislación imperativa de protección del consumidor del país de residencia del usuario.

El fuero no exclusivo es Bad Nauheim, Alemania. Los consumidores podrán demandar en su domicilio cuando la ley local lo permita.

---

## 12. CONTACTO

Berger & Rosenstock GbR (operando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemania
Correo electrónico: hello@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
