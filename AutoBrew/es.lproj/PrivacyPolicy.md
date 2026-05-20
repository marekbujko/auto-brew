# POLÍTICA DE PRIVACIDAD

## AutoBrew

**Fecha de entrada en vigor:** Mayo de 2026
**Última actualización:** Mayo de 2026

**Servicio operado por:** DigitalFreedom — una marca de Berger & Rosenstock GbR

**Responsable del tratamiento (entidad jurídica):**
Berger & Rosenstock GbR (operando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemania

Representantes autorizados: Marcel R. G. Berger, Jasmin Rosenstock
NIF-IVA: DE455096022

Contacto (general): hello@digitalfreedom.co.za
Contacto (protección de datos): data-protection@digitalfreedom.co.za
Sitio web: https://digitalfreedom.co.za

---

## 1. INTRODUCCIÓN

La presente Política de Privacidad explica cómo DigitalFreedom (una marca de Berger & Rosenstock GbR — «nosotros», «nos», «nuestro») trata los datos en relación con la aplicación AutoBrew («AutoBrew», «el Software»).

AutoBrew es **software de código abierto bajo la Licencia MIT**, **totalmente gratuito** y se distribuye directamente como un DMG notarizado y a través de un tap de Homebrew — no a través de la Apple App Store ni de la Google Play Store. No operamos ningún backend, no alojamos cuentas de usuario y no recopilamos, transmitimos, almacenamos ni tratamos datos personales en nuestros servidores.

Adoptamos el Reglamento General de Protección de Datos de la Unión Europea (RGPD) como referencia más estricta y lo aplicamos como mínimo global — las protecciones descritas a continuación se aplican a todos los usuarios, con independencia de su país.

---

## 2. RECOPILACIÓN CERO DE DATOS

**No recopilamos ningún dato personal.**

AutoBrew se ejecuta íntegramente en su Mac. No existe ninguna cuenta de AutoBrew, ni telemetría, ni analítica, ni informes de fallos, ni configuración remota. Dado que no tratamos datos personales bajo nuestro control, la mayoría de las obligaciones del operador conforme al RGPD (documentación de transferencias internacionales, contratos con encargados del tratamiento, notificación de brechas por nuestra parte) no se aplican a nosotros como editor del Software. No obstante, la Sección 6 describe los derechos que le asisten conforme a la legislación aplicable.

---

## 3. DATOS ALMACENADOS LOCALMENTE EN SU DISPOSITIVO

AutoBrew almacena los siguientes datos de forma local. **Ninguno de ellos sale de su Mac salvo que usted decida compartirlo.**

### 3.1 Ajustes (UserDefaults)

- Modo de activación (inactividad / programado)
- Umbral de inactividad (minutos) y hora programada
- Marca de tiempo de la última ejecución
- Preferencia de inicio automático al iniciar sesión
- Preferencia de notificaciones
- Ajustes de retención de snapshots
- Valores por defecto de política de actualización (patch/minor/major × cask/formula) y anulaciones por paquete
- Estado de onboarding

### 3.2 Estado de la política de actualización (Application Support)

- `UpdateLedger.json` — cuándo apareció por primera vez cada `(kind, token, version)` como desactualizada, para poder medir la ventana de espera. Los tokens son nombres de paquetes de Homebrew; no contienen identificadores de usuario.
- `PendingUpdates.json` — entradas de actualizaciones mayores pendientes de su decisión (aprobar / rechazar).

### 3.3 Caché de iconos (Application Support)

- PNG en caché de iconos de casks obtenidos mediante la iTunes Search API (búsqueda anónima por nombre de aplicación) y icon.horse como alternativa. Almacenados en `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 Snapshots de aplicaciones (Application Support)

- Copias empaquetadas en ZIP de `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers`, etc., para las aplicaciones de las que usted realice explícitamente un snapshot. Almacenadas en `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Registros (os.Logger)

- Eventos de diagnóstico escritos mediante el sistema unificado de registro de Apple. Visibles en Consola.app. No se transmiten a ningún lugar.

Puede eliminar todos los datos almacenados localmente eliminando AutoBrew, su carpeta de soporte (`~/Library/Application Support/AutoBrew/`) y su plist de UserDefaults (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. ACTIVIDAD DE RED

AutoBrew realiza solicitudes salientes en tres situaciones. Ninguna de ellas transmite datos personales.

### 4.1 Operaciones de paquetes Homebrew

AutoBrew invoca el binario `brew` que usted ha instalado localmente. El proyecto Homebrew se pone entonces en contacto con `formulae.brew.sh`, GitHub, mirrors CDN y URL de descarga de casks individuales. No mantenemos relación con esos endpoints — están operados por el proyecto Homebrew y por los respectivos editores de casks bajo sus propias condiciones de privacidad.

### 4.2 Catálogo de casks y resolución de iconos

- `formulae.brew.sh/api/cask.json` — descarga anónima del catálogo público de casks
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — descarga anónima de estadísticas de instalación de 365 días
- `itunes.apple.com/search` — búsqueda anónima de iconos de aplicaciones macOS por nombre visible
- `icon.horse` — búsqueda alternativa de favicon basada en la URL `homepage` del cask

### 4.3 Comprobación de actualizaciones automáticas

Sparkle contacta periódicamente con la URL del appcast oficial de AutoBrew en GitHub para comprobar si hay nuevas versiones de AutoBrew. La solicitud contiene su versión de macOS y la versión de AutoBrew (`User-Agent` estándar), sin identificadores adicionales.

---

## 5. SERVICIOS DE TERCEROS (NO SUBENCARGADOS)

No recurrimos a subencargados del tratamiento porque no tratamos sus datos. Los servicios de terceros con los que AutoBrew se comunica actúan de forma independiente y conforme a sus propias condiciones:

| Servicio | Finalidad | Operador |
|---|---|---|
| Homebrew + formulae.brew.sh | Gestión de paquetes y catálogo | Proyecto Homebrew |
| Apple iTunes Search API | Búsqueda de iconos de aplicaciones | Apple Inc. |
| icon.horse | Favicon de respaldo | icon.horse |
| GitHub (appcast, releases) | Canal de distribución y actualizaciones | GitHub, Inc. |

Cuando hace clic en un enlace de Sponsor dentro de AutoBrew, abandona la aplicación y su navegador accede a GitHub Sponsors — esa interacción se rige por la política de privacidad de GitHub.

---

## 6. SUS DERECHOS

Dado que no almacenamos datos personales en nuestros servidores, los derechos de acceso / rectificación / supresión / portabilidad / oposición / limitación previstos en los artículos 15 a 22 del RGPD y en las leyes locales equivalentes quedan efectivamente satisfechos eliminando AutoBrew de su Mac.

No obstante, puede ponerse en contacto con nosotros en **data-protection@digitalfreedom.co.za** si tiene preguntas sobre esta política.

Puede presentar una reclamación ante su autoridad de protección de datos competente. En Alemania, esta es el Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). La UE publica el listado de autoridades nacionales en https://edpb.europa.eu/about-edpb/about-edpb/members_en.

---

## 7. MENORES

AutoBrew es una utilidad para desarrolladores en macOS. No está dirigida a menores de 16 años. No recopilamos datos personales, por lo que tampoco tratamos datos de menores.

---

## 8. SEGURIDAD

- El binario de la aplicación está firmado con el certificado Apple Developer ID y notarizado por Apple.
- Las actualizaciones automáticas se verifican frente a una firma EdDSA Ed25519 antes de aplicarse.
- AutoBrew se ejecuta bajo Hardened Runtime; las aplicaciones de distribución directa que se comunican con herramientas del sistema no pueden utilizar App Sandbox completo sin romper el caso de uso, por lo que enviamos los entitlements mínimos necesarios.
- El código fuente puede auditarse públicamente en [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. TRANSFERENCIAS INTERNACIONALES

No realizamos transferencias de datos personales porque no los recopilamos. Los servicios de terceros a los que accede a través de AutoBrew (servidores del proyecto Homebrew, Apple, icon.horse, GitHub) pueden operar fuera de la UE; dichas transferencias se producen entre usted y ellos, no con nosotros.

---

## 10. CAMBIOS EN ESTA POLÍTICA

Podemos actualizar esta Política de Privacidad para reflejar cambios en la arquitectura de AutoBrew o en la legislación aplicable. La fecha de «Última actualización» que figura al principio refleja la revisión más reciente. Los cambios sustanciales se comunican en las notas de versión de AutoBrew.

### 10.1 Futuras funciones de pago

Actualmente AutoBrew es gratuito y opera sin ningún backend (véase la Sección 2). El Editor se reserva el derecho a introducir **funciones de pago**, **ediciones de pago** o **servicios complementarios de pago** opcionales en versiones futuras, que podrían requerir un tratamiento limitado de datos (por ejemplo, gestión de pagos a través de un tercero o comprobación de una clave de licencia). Cualquier cambio de este tipo será:

- Anunciado con antelación en las notas de versión de AutoBrew y en esta Política de Privacidad
- Estrictamente opt-in — la versión gratuita y sin recopilación de datos seguirá siendo utilizable
- Documentado en una sección específica de esta Política de Privacidad antes de habilitar cualquier nuevo flujo de datos

La declaración actual de «recopilación cero de datos» se aplica a la versión presente de AutoBrew. No constituye una garantía perpetua para cada versión futura; mantendremos esta Política actualizada para que siempre describa el comportamiento real.

---

## 11. CONTACTO

Para consultas en materia de protección de datos:
**data-protection@digitalfreedom.co.za**

Para todo lo demás:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (operando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemania
Sitio web: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
