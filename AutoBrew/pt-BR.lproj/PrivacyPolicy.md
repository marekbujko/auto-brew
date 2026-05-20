# POLÍTICA DE PRIVACIDADE

## AutoBrew

**Data de Vigência:** Maio de 2026
**Última Atualização:** Maio de 2026

**Serviço operado por:** DigitalFreedom — uma marca da Berger & Rosenstock GbR

**Controlador (pessoa jurídica):**
Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha

Representantes Autorizados: Marcel R. G. Berger, Jasmin Rosenstock
Número de IVA: DE455096022

Contato (geral): hello@digitalfreedom.co.za
Contato (proteção de dados): data-protection@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

---

## 1. INTRODUÇÃO

Esta Política de Privacidade explica como a DigitalFreedom (uma marca da Berger & Rosenstock GbR — "nós", "nosso") trata informações em conexão com o aplicativo AutoBrew ("AutoBrew", "o Software").

O AutoBrew é **código aberto sob a Licença MIT**, **totalmente gratuito** e distribuído diretamente como DMG notarizado e por meio de um tap do Homebrew — não pela Apple App Store nem pela Google Play Store. Não operamos um backend, não hospedamos contas de usuários e não coletamos, transmitimos, armazenamos ou tratamos quaisquer dados pessoais em nossos servidores.

Adotamos o Regulamento Geral de Proteção de Dados da União Europeia (GDPR) como o padrão mais rigoroso de referência e o aplicamos como piso global — as proteções abaixo se aplicam a todos os usuários, independentemente do país. Os usuários no Brasil também estão protegidos pela Lei Geral de Proteção de Dados Pessoais (LGPD, Lei nº 13.709/2018) e podem dirigir-se à Autoridade Nacional de Proteção de Dados (ANPD).

---

## 2. COLETA ZERO DE DADOS

**Não coletamos quaisquer dados pessoais.**

O AutoBrew é executado inteiramente no seu Mac. Não há conta AutoBrew, telemetria, análises, relatório de falhas ou configuração remota. Como não realizamos tratamento de dados pessoais sob nosso controle, a maioria das obrigações do controlador previstas no GDPR e na LGPD (documentação de transferência internacional, contratos com operadores, notificação de incidentes do nosso lado) não se aplica a nós como editor do Software. A Seção 6, ainda assim, descreve os direitos disponíveis ao titular nos termos da legislação aplicável.

---

## 3. DADOS ARMAZENADOS LOCALMENTE NO SEU DISPOSITIVO

O AutoBrew armazena os seguintes dados localmente. **Nenhum deles sai do seu Mac, salvo se você optar por compartilhar.**

### 3.1 Configurações (UserDefaults)

- Modo de acionamento (ocioso / agendado)
- Limite de ociosidade (minutos) e horário agendado
- Horário da última execução
- Preferência de inicialização ao fazer login
- Preferência de notificações
- Configurações de retenção de snapshots
- Padrões de política de atualização (patch/menor/maior × cask/formula) e exceções por pacote
- Estado de onboarding

### 3.2 Estado da Política de Atualização (Application Support)

- `UpdateLedger.json` — registro de quando cada `(kind, token, version)` apareceu como desatualizado pela primeira vez, para que a janela de espera possa ser medida. Os tokens são nomes de pacotes do Homebrew; não há identificadores do usuário.
- `PendingUpdates.json` — entradas de atualização principal aguardando sua decisão (aprovar / rejeitar).

### 3.3 Cache de Ícones (Application Support)

- PNGs em cache de ícones de casks obtidos pela API iTunes Search (consulta anônima pelo nome do aplicativo) e por icon.horse como alternativa. Armazenados em `~/Library/Application Support/AutoBrew/IconCache/`.

### 3.4 Snapshots de Aplicativos (Application Support)

- Cópias compactadas em ZIP de `~/Library/Preferences`, `~/Library/Application Support`, `~/Library/Containers` etc. para os aplicativos dos quais você explicitamente cria snapshot. Armazenadas em `~/Library/Application Support/AutoBrew/Snapshots/`.

### 3.5 Registros (os.Logger)

- Eventos de diagnóstico gravados pelo sistema unificado de registro da Apple. Visíveis no Console.app. Não transmitidos a lugar algum.

Você pode excluir todos os dados armazenados localmente removendo o AutoBrew, a sua pasta de suporte (`~/Library/Application Support/AutoBrew/`) e o seu arquivo plist de UserDefaults (`~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist`).

---

## 4. ATIVIDADE DE REDE

O AutoBrew realiza requisições de saída em três situações. Nenhuma delas transmite dados pessoais.

### 4.1 Operações de pacotes do Homebrew

O AutoBrew invoca o binário `brew` instalado localmente. O projeto Homebrew, por sua vez, contata `formulae.brew.sh`, GitHub, espelhos de CDN e URLs de download de casks individuais. Não temos relação com esses endpoints — eles são operados pelo projeto Homebrew e pelos respectivos publicadores de casks sob seus próprios termos de privacidade.

### 4.2 Catálogo de casks e resolução de ícones

- `formulae.brew.sh/api/cask.json` — busca anônima do catálogo público de casks
- `formulae.brew.sh/api/analytics/cask-install/365d.json` — busca anônima das estatísticas de instalação dos últimos 365 dias
- `itunes.apple.com/search` — consulta anônima de ícones de aplicativos macOS pelo nome de exibição
- `icon.horse` — consulta alternativa de favicon a partir da URL `homepage` do cask

### 4.3 Verificação de atualização automática

O Sparkle contata periodicamente a URL do appcast do AutoBrew no GitHub para verificar novas versões do AutoBrew. A requisição contém a sua versão do macOS e a versão do AutoBrew (`User-Agent` padrão), sem outros identificadores.

---

## 5. SERVIÇOS DE TERCEIROS (NÃO SUBOPERADORES)

Não contratamos suboperadores porque não tratamos seus dados. Os serviços de terceiros com os quais o AutoBrew se comunica atuam de forma independente e sob seus próprios termos:

| Serviço | Finalidade | Operador |
|---|---|---|
| Homebrew + formulae.brew.sh | Gerenciamento de pacotes e catálogo | Projeto Homebrew |
| API iTunes Search da Apple | Consulta de ícones de aplicativos | Apple Inc. |
| icon.horse | Favicon alternativo | icon.horse |
| GitHub (appcast, releases) | Canal de distribuição e atualização | GitHub, Inc. |

Ao clicar em um link Sponsor dentro do AutoBrew, você sai do aplicativo e seu navegador acessa o GitHub Sponsors — essa interação é regida pela política de privacidade do GitHub.

---

## 6. SEUS DIREITOS

Como não armazenamos dados pessoais em nossos servidores, os direitos de acesso / retificação / exclusão / portabilidade / oposição / restrição previstos nos artigos 15 a 22 do GDPR, no art. 18 da LGPD e em leis locais equivalentes são efetivamente atendidos com a exclusão do AutoBrew do seu Mac.

Você ainda pode entrar em contato pelo **data-protection@digitalfreedom.co.za** caso tenha dúvidas sobre esta política.

Você pode apresentar reclamação à autoridade de proteção de dados competente. Na Alemanha, é o Hessischer Beauftragter für Datenschutz und Informationsfreiheit (https://datenschutz.hessen.de). A UE lista as autoridades nacionais em https://edpb.europa.eu/about-edpb/about-edpb/members_en. No Brasil, o titular pode dirigir-se à Autoridade Nacional de Proteção de Dados (ANPD, https://www.gov.br/anpd).

---

## 7. CRIANÇAS

O AutoBrew é um utilitário para desenvolvedores no macOS. Não se destina a crianças menores de 16 anos. Como não coletamos dados pessoais, também não tratamos dados de crianças.

---

## 8. SEGURANÇA

- O binário do aplicativo é assinado com o certificado Apple Developer ID e notarizado pela Apple.
- As atualizações automáticas são verificadas contra uma assinatura EdDSA Ed25519 antes de serem aplicadas.
- O AutoBrew é executado sob Hardened Runtime; aplicativos de distribuição direta que se comunicam com ferramentas do sistema não conseguem usar o App Sandbox completo sem comprometer o caso de uso, portanto adotamos as autorizações mínimas necessárias.
- O código-fonte é publicamente auditável em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew).

---

## 9. TRANSFERÊNCIAS INTERNACIONAIS

Não transferimos dados pessoais porque não os coletamos. Os serviços de terceiros que você acessa por meio do AutoBrew (servidores do projeto Homebrew, Apple, icon.horse, GitHub) podem operar fora da UE; as transferências para esses serviços ocorrem entre você e eles, não envolvendo a nós.

---

## 10. ALTERAÇÕES NESTA POLÍTICA

Podemos atualizar esta Política de Privacidade para refletir alterações na arquitetura do AutoBrew ou na legislação aplicável. A data de "Última Atualização" no topo reflete a revisão mais recente. Alterações relevantes são comunicadas nas notas de versão do AutoBrew.

### 10.1 Funcionalidades pagas futuras

O AutoBrew é atualmente gratuito e opera sem qualquer backend (consulte a Seção 2). O Editor reserva-se o direito de introduzir, em versões futuras, **funcionalidades pagas**, **edições pagas** ou **serviços complementares pagos** opcionais, que podem exigir tratamento limitado de dados (por exemplo, processamento de pagamentos por meio de um prestador terceiro ou verificação de chave de licença). Qualquer alteração nesse sentido será:

- Anunciada com antecedência nas notas de versão do AutoBrew e nesta Política de Privacidade
- Estritamente opt-in — a versão gratuita e sem coleta de dados permanece utilizável
- Documentada em uma seção dedicada desta Política de Privacidade antes que qualquer novo fluxo de dados seja habilitado

A declaração atual de "coleta zero de dados" aplica-se à versão presente do AutoBrew. Não constitui garantia perpétua para toda versão futura; manteremos esta Política sempre atualizada de modo a refletir o comportamento real.

---

## 11. CONTATO

Para consultas sobre proteção de dados:
**data-protection@digitalfreedom.co.za**

Para os demais assuntos:
**hello@digitalfreedom.co.za**

Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha
Site: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
