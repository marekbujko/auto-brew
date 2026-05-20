# CONDICIONES DE USO

## AutoBrew

**Fecha de entrada en vigor:** Mayo de 2026
**Última actualización:** Mayo de 2026

Las presentes Condiciones de Uso («Condiciones») regulan el uso que usted hace de AutoBrew (el «Software»). Léalas detenidamente. Al instalar o utilizar AutoBrew, acepta quedar vinculado por estas Condiciones.

---

## 1. PRESTADOR

El Software se publica bajo la marca **DigitalFreedom**. La entidad jurídica responsable es:

Berger & Rosenstock GbR (operando como DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Alemania
Representantes autorizados: Marcel R. G. Berger, Jasmin Rosenstock
Correo electrónico: hello@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

Estas Condiciones se aplican a escala global. Los derechos imperativos de protección del consumidor y demás derechos legales otorgados por el país de residencia del usuario permanecen inalterados y prevalecen donde sean más protectores.

---

## 2. EL SOFTWARE

AutoBrew es una utilidad para la barra de menús de macOS que automatiza las actualizaciones de Homebrew, navega por el catálogo público de casks de Homebrew y gestiona snapshots de aplicaciones para la migración entre Macs. Es:

- **Código abierto** bajo la Licencia MIT — código fuente completo en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Gratuito** — sin compras dentro de la aplicación, sin suscripciones, sin niveles de pago, sin periodo de prueba
- **Distribuido directamente** — DMG notarizado desde GitHub Releases y un tap de Homebrew; no a través de la Apple App Store ni de la Google Play Store
- **Solo local** — se ejecuta íntegramente en su Mac, sin necesidad de una cuenta de AutoBrew ni de un servicio backend (véase la [Política de Privacidad](PrivacyPolicy.md))

Estas Condiciones se aplican al binario de AutoBrew. La Licencia MIT (reproducida en el [EULA](EULA.md) y en las [Licencias de código abierto](OpenSourceLicenses.md)) rige el código fuente y cualquier fork o derivado.

---

## 3. LICENCIA DE USO

Sujeto al cumplimiento de estas Condiciones y de la Licencia MIT, puede:

- Instalar, ejecutar, modificar y redistribuir AutoBrew en cualquier número de Macs bajo su control
- Hacer fork del código fuente y crear obras derivadas bajo los términos de la Licencia MIT

No puede:

- Tergiversar el origen del Software (la Licencia MIT exige conservar el aviso de copyright original)
- Eliminar los avisos de licencia incrustados de Sparkle, bsdiff, sais-lite o pdqsort al redistribuir
- Utilizar el nombre **AutoBrew** ni la marca **DigitalFreedom** en obras derivadas sin nuestro consentimiento por escrito (marca, véase el documento [Marca](Trademark.md))

---

## 4. SIN CUENTA, SIN PAGO (ESTADO ACTUAL)

Actualmente AutoBrew no requiere registro, alta ni pago alguno. El enlace **Sponsor** dentro de la aplicación dirige a GitHub Sponsors y es **totalmente voluntario** — cualquier contribución se considera una donación y no genera ningún derecho a funcionalidades ni a soporte.

### 4.1 Reserva sobre futuras funciones de pago

El Prestador se reserva el derecho a introducir **funciones de pago**, **ediciones de pago** o **servicios complementarios de pago** opcionales en versiones futuras de AutoBrew. Cualquier oferta de pago futura de este tipo:

- Se anunciará con antelación a través de la interfaz de la aplicación y de las notas de versión oficiales
- Se aplicará únicamente con efecto prospectivo — su derecho a seguir utilizando la versión gratuita actual permanece inalterado
- Dejará intacto el núcleo de código abierto: el código fuente en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) seguirá disponible bajo la Licencia MIT

La ausencia actual de funciones de pago no constituye una garantía de que AutoBrew vaya a permanecer libre de funciones de pago en cualquier versión futura.

---

## 5. DEPENDENCIA DE HOMEBREW

AutoBrew depende de una instalación de Homebrew operativa para cumplir su propósito. AutoBrew invoca el binario `brew` y lee / escribe datos utilizando los comandos y convenciones del propio proyecto Homebrew. No estamos afiliados al proyecto Homebrew; no controlamos qué paquetes están disponibles, cuándo se publican versiones, ni qué hacen los editores de casks con sus instaladores.

Si una instalación de cask falla, se comporta de manera inesperada o causa daños, ese asunto se sustancia entre usted y el editor del cask y/o el proyecto Homebrew — véanse la Sección 7 (Exención de garantías) y la Sección 8 (Limitación de responsabilidad).

---

## 6. ACTUALIZACIONES

AutoBrew utiliza el framework Sparkle para entregar actualizaciones dentro de la aplicación desde el appcast oficial de AutoBrew en GitHub. Las actualizaciones están firmadas con una clave EdDSA Ed25519 y se verifican antes de aplicarse. Las actualizaciones automáticas pueden desactivarse desde Ajustes.

Es libre de ignorar las actualizaciones in-app y actualizar el binario a través de su tap de Homebrew o descargando manualmente un DMG más reciente.

---

## 7. EXENCIÓN DE GARANTÍAS

El Software se proporciona **«TAL CUAL»** y **«SEGÚN DISPONIBILIDAD»**, sin garantías de ningún tipo, expresas o implícitas, incluidas, entre otras, las garantías implícitas de comerciabilidad, idoneidad para un fin determinado y no infracción.

Sin perjuicio de lo anterior, no garantizamos que:

- El Software sea ininterrumpido o esté libre de errores
- La interacción de AutoBrew con Homebrew, con casks individuales o con el propio macOS produzca siempre el resultado deseado
- Los snapshots creados por AutoBrew capturen perfectamente todos los aspectos del estado de una aplicación — las aplicaciones que almacenan datos fuera de los subdirectorios estándar de Library pueden no capturarse en su totalidad

Los derechos legales de garantía que no puedan excluirse contractualmente conforme a la legislación local de protección del consumidor (por ejemplo, la Mängelhaftung alemana conforme a los §§ 434 y ss. del BGB, cuando proceda) permanecen inalterados.

---

## 8. LIMITACIÓN DE RESPONSABILIDAD

En la máxima medida permitida por la legislación aplicable:

- No somos responsables de daños indirectos, incidentales, consecuentes, ejemplares ni punitivos
- No somos responsables de la pérdida de datos, lucro cesante, interrupción de negocio ni de cualquier daño derivado de software de terceros (Homebrew, casks individuales) invocado a través de AutoBrew

Para los usuarios con residencia habitual en Alemania o la UE, nuestra responsabilidad por daños causados por **negligencia grave o dolo**, por **lesión a la vida, integridad física o salud**, y conforme a las **disposiciones imperativas de la Ley Alemana de Responsabilidad por Productos (ProdHaftG)** permanece inalterada.

---

## 9. TERMINACIÓN

Puede dejar de utilizar AutoBrew en cualquier momento desinstalándolo. Eliminar AutoBrew y su carpeta de soporte (`~/Library/Application Support/AutoBrew/`) devuelve su Mac a un estado en el que no permanece ningún artefacto de AutoBrew.

Podemos interrumpir la distribución de AutoBrew en cualquier momento. Dado que el Software es de código abierto bajo MIT, usted y la comunidad siguen siendo libres de bifurcarlo, compilarlo y ejecutarlo de forma independiente.

---

## 10. CAMBIOS EN ESTAS CONDICIONES

Podemos actualizar estas Condiciones para reflejar cambios en el Software o en la legislación aplicable. Los cambios sustanciales se comunican en las notas de versión de AutoBrew. La fecha de «Última actualización» que figura al principio refleja la revisión más reciente.

---

## 11. LEY APLICABLE Y JURISDICCIÓN

Estas Condiciones se rigen por las leyes de la República Federal de Alemania, con exclusión de la Convención de las Naciones Unidas sobre los Contratos de Compraventa Internacional de Mercaderías (CISG).

Para los consumidores con residencia habitual fuera de Alemania, se aplica además la legislación imperativa de protección del consumidor de su país de residencia. El fuero no exclusivo para los litigios es Bad Nauheim, Alemania; los consumidores podrán demandar en su domicilio cuando la ley local lo permita.

Para los litigios de consumo derivados del derecho de la UE, está disponible la plataforma de Resolución de Litigios en Línea de la Comisión Europea en https://ec.europa.eu/consumers/odr. No estamos obligados ni dispuestos a participar en procedimientos alternativos de resolución de litigios ante una Verbraucherschlichtungsstelle (junta de arbitraje de consumidores) conforme al § 36 VSBG.

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
