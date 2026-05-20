# POLÍTICA DE PRIVACIDADE

## Aviso Global sobre Proteção de Dados e Privacidade

**Data de Vigência:** Maio de 2026

**Serviço operado por:** DigitalFreedom — uma marca da Berger & Rosenstock GbR

**Controlador de Dados (pessoa jurídica):**
Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha

Representantes Autorizados: Marcel R. G. Berger, Jasmin Rosenstock
IVA: DE455096022

Contato (geral): hello@digitalfreedom.co.za
Contato (proteção de dados): data-protection@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

---

## 1. INTRODUÇÃO

Esta Política de Privacidade explica como a DigitalFreedom (uma marca da Berger & Rosenstock GbR, coletivamente "nós", "nosso") coleta, utiliza, armazena e protege seus dados pessoais quando você usa nossos aplicativos, software, sites e serviços relacionados ("os Serviços").

### 1.1 Escopo global

O AutoBrew é distribuído diretamente pela DigitalFreedom para macOS (com atualizações automáticas via Sparkle) e está disponível para usuários em todo o mundo. Esta Política de Privacidade aplica-se globalmente a todos os usuários dos Serviços, independentemente do país em que o Serviço é baixado, acessado ou utilizado.

### 1.2 GDPR como linha de base global

Adotamos o **Regulamento Geral de Proteção de Dados da União Europeia (GDPR)** e a legislação europeia de proteção de dados relacionada como a referência mínima mais rigorosa e a aplicamos como um **piso global** — todo usuário, em qualquer país, beneficia-se ao menos do nível de proteção do GDPR descrito nesta Política. Adicionalmente, respeitamos e cumprimos qualquer legislação local de proteção de dados aplicável à jurisdição do usuário e, sempre que essa legislação local for mais protetiva, prevalece o padrão mais protetivo.

Temos o compromisso de proteger sua privacidade e cumprir as leis de proteção de dados aplicáveis, incluindo, entre outras:

- Regulamento Geral de Proteção de Dados da UE (GDPR) — aplicado como linha de base global
- Lei Federal Alemã de Proteção de Dados (BDSG)
- Regulamento Geral de Proteção de Dados do Reino Unido (UK GDPR) e Data Protection Act 2018
- Lei Federal Suíça de Proteção de Dados (FADP)
- California Consumer Privacy Act (CCPA) / California Privacy Rights Act (CPRA) e outras leis estaduais de privacidade dos EUA
- Personal Information Protection and Electronic Documents Act do Canadá (PIPEDA)
- Australian Privacy Act 1988
- Lei Geral de Proteção de Dados Pessoais do Brasil (LGPD, Lei nº 13.709/2018)
- Lei Japonesa de Proteção de Informações Pessoais (APPI)
- Lei Sul-Coreana de Proteção de Informações Pessoais (PIPA)
- Indian Digital Personal Data Protection Act (DPDP Act) e IT Act
- Protection of Personal Information Act da África do Sul (POPIA)
- Todos os demais regimes nacionais de proteção de dados aplicáveis nas jurisdições em que os Serviços são disponibilizados

---

## 2. CONTROLADOR DE DADOS

Os Serviços são oferecidos sob a marca **DigitalFreedom**. A pessoa jurídica responsável pelo tratamento de seus dados pessoais (o "controlador de dados" nos termos do Art. 4(7) do GDPR) é:

Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha

Representantes Autorizados: Marcel R. G. Berger, Jasmin Rosenstock
IVA: DE455096022

Para consultas sobre proteção de dados (GDPR Art. 13/14, pedidos de acesso, retificação, eliminação, portabilidade, oposição):
E-mail: data-protection@digitalfreedom.co.za

Para consultas gerais:
E-mail: hello@digitalfreedom.co.za

Site: https://digitalfreedom.co.za

---

## 3. PRINCÍPIO DE COLETA ZERO DE DADOS DO AUTOBREW

**O AutoBrew não coleta, armazena, transmite ou processa quaisquer dados pessoais em nossos servidores.**

O AutoBrew é um aplicativo de menu bar para macOS de código aberto sob a licença MIT que opera inteiramente no seu Mac. Não operamos qualquer infraestrutura de backend para coleta de dados, análises, relatórios de falhas ou telemetria. Não existem contas de usuário, não há login no lado do servidor e não há sincronização em nuvem.

### 3.1 Dados armazenados em seu Mac

O AutoBrew armazena os seguintes dados localmente em seu dispositivo. Nenhum destes dados é transmitido aos nossos servidores:

- **Preferências do aplicativo** (UserDefaults) — agendamento de atualizações do Homebrew, opções do BrewStore, configurações do AppSnapshot, preferências de interface
- **AppSnapshots** — registros locais dos seus pacotes Homebrew instalados, gerados sob demanda
- **Logs do Homebrew** — saída das operações `brew update`, `brew upgrade`, `brew cleanup` executadas pelo AutoBrew, exibidas e armazenadas localmente
- **Estado do BrewStore** — catálogo local em cache e estado da última visualização

### 3.2 Conexões de rede iniciadas pelo AutoBrew

O AutoBrew comunica-se diretamente, a partir do seu Mac, com:

- **Homebrew** (https://brew.sh) — para consultar fórmulas/casks e executar operações de atualização
- **Sparkle / appcast da DigitalFreedom** — para verificar atualizações do AutoBrew (Sparkle envia uma requisição HTTPS padrão para obter o appcast)
- **GitHub Sponsors** (somente quando você clica voluntariamente em um link de patrocínio) — para abrir a página de patrocínio no seu navegador
- **URL de suporte** (https://support.digitalfreedom.co.za/help/767340152) — somente quando você abre a página de suporte

Não somos parte de quaisquer dessas comunicações além daquelas relacionadas ao appcast (atualizações automáticas) e à URL de suporte, e o appcast é uma requisição HTTPS padrão que não contém identificadores pessoais.

### 3.3 Dados NÃO coletados

Não coletamos:

- nome, e-mail, endereço ou quaisquer dados de identificação
- localização precisa em segundo plano
- contatos / catálogo de endereços
- conteúdo de SMS / e-mail
- histórico de navegação
- identificadores de publicidade comportamental
- dados de cartão de pagamento (o AutoBrew é gratuito e de código aberto — não existem compras dentro do aplicativo)
- identificadores únicos do dispositivo enviados a nossos servidores
- estatísticas de uso, telemetria ou relatórios de falhas

### 3.4 SDKs Não Utilizados

**Não** integramos nenhum dos seguintes:

- SDKs de análise (Google Analytics, Firebase Analytics, Mixpanel, Amplitude, PostHog, etc.)
- SDKs de relatório de falhas (Crashlytics, Sentry, Bugsnag, etc.)
- SDKs de publicidade (AdMob, Meta Audience Network, AppLovin, etc.)
- SDKs de atribuição (AppsFlyer, Adjust, Branch, Kochava, etc.)
- Frameworks de teste A/B
- SDKs de mídia social
- Provedores de autenticação de terceiros

---

## 4. BASE LEGAL PARA O TRATAMENTO (GDPR)

Como não atuamos como controlador ou operador de dados pessoais coletados por meio do AutoBrew, as bases do Art. 6 do GDPR para tratamento centralizado não se aplicam a nós. Na medida em que a operação do AutoBrew envolve tratamento local em seu dispositivo, este é realizado com base em:

- **Execução de contrato** (Art. 6(1)(b) GDPR) — fornecer a funcionalidade para a qual você instalou o AutoBrew
- **Consentimento** (Art. 6(1)(a) GDPR) — quando você aciona explicitamente ações como executar atualizações do Homebrew ou abrir a página de suporte

Nenhum tratamento ocorre sob os Arts. 6(1)(c), (d), (e) ou (f) do GDPR em infraestrutura operada por nós.

---

## 5. COMO OS DADOS SÃO UTILIZADOS

Os dados em seu Mac são utilizados exclusivamente para:

- Executar operações do Homebrew (update, upgrade, cleanup) conforme você as agenda ou aciona
- Manter o catálogo do BrewStore e o estado do AppSnapshot
- Exibir status de atualização, log e estatísticas localmente
- Verificar a disponibilidade de novas versões do AutoBrew via Sparkle

Os dados nunca são compartilhados, vendidos, alugados ou de outra forma divulgados a terceiros por nós.

---

## 6. COMPARTILHAMENTO E DIVULGAÇÃO DE DADOS

### 6.1 Sem operadores no lado do servidor

Como o AutoBrew não envia dados pessoais a quaisquer servidores operados por nós, não engajamos sub-operadores para o tratamento de dados pessoais relacionados ao uso do AutoBrew.

### 6.2 Serviços de Terceiros sob sua direção

O AutoBrew comunica-se diretamente com os seguintes serviços de terceiros quando você usa o aplicativo. Não somos parte dessas comunicações.

| Parte | Função | Localização |
|---|---|---|
| Homebrew (https://brew.sh) | Catálogo de fórmulas/casks e operações de gerenciador de pacotes | Repositórios públicos (GitHub) |
| Sparkle / appcast da DigitalFreedom | Atualizações automáticas do AutoBrew | Infraestrutura da DigitalFreedom |
| GitHub Sponsors | Patrocínio voluntário pelo usuário (somente quando você clica) | EUA |

### 6.3 Requisitos Legais

Podemos divulgar dados quando exigido por lei, processo legal ou requisição governamental — mas, como não armazenamos dados sobre você, não há dados pessoais a divulgar em conexão com o AutoBrew.

### 6.4 Transferências de Negócios

No caso de uma fusão, aquisição ou venda de ativos, qualquer dado disponível poderá ser transferido. Por padrão, não existem dados de usuários a transferir em relação ao AutoBrew.

### 6.5 Sem Venda de Dados Pessoais

Não vendemos seus dados pessoais a terceiros. Não realizamos publicidade comportamental entre contextos.

---

## 7. TRANSFERÊNCIAS INTERNACIONAIS DE DADOS

Não realizamos transferências internacionais de dados pessoais em conexão com o AutoBrew porque não coletamos ou processamos dados pessoais.

Os fluxos de dados iniciados por você (requisições do Homebrew, verificações de atualização do Sparkle, abertura de URLs externas) podem envolver transmissão transfronteiriça. Essas transferências são regidas pelos avisos de privacidade dos respectivos operadores.

Para qualquer transferência que possa, no futuro, ocorrer sob nosso controle e que não seja coberta por uma decisão de adequação:

- Recorremos às Cláusulas Contratuais Padrão (SCCs) da UE
- Garantimos salvaguardas adequadas nos termos do Capítulo V do GDPR
- Avaliamos a legislação de proteção de dados do país destinatário (Transfer Impact Assessment)

---

## 8. RETENÇÃO DE DADOS

Não retemos dados em nossos servidores. Todos os dados do AutoBrew são armazenados localmente em seu Mac e estão sob seu controle exclusivo.

- **Desinstalar o AutoBrew** remove o aplicativo. Preferências e logs locais podem permanecer em `~/Library` até serem removidos manualmente
- **Você pode remover o AppSnapshot e os caches do BrewStore** a qualquer momento usando os comandos correspondentes do aplicativo ou apagando os arquivos relevantes

Quaisquer dados que você nos enviar voluntariamente por e-mail (por exemplo, mensagens de suporte) serão retidos somente enquanto necessários para responder à sua solicitação e cumprir obrigações legais (por exemplo, períodos de retenção fiscal sob a lei alemã: até 10 anos).

---

## 9. SEGURANÇA DOS DADOS

Embora não coletemos seus dados, implementamos as seguintes medidas de segurança no AutoBrew:

- **Comunicação de rede:** HTTPS/TLS para todas as comunicações com servidores externos (Sparkle appcast, URL de suporte)
- **Sandbox de aplicativo:** O AutoBrew é executado com as autorizações mínimas necessárias para gerenciar o Homebrew
- **Hardened Runtime e assinatura de código:** o aplicativo é assinado e notarizado pela Apple
- **Sem telemetria:** nenhum dado de uso, análise ou relatório de falhas é transmitido a lugar algum
- **Sem registro persistente fora do seu Mac:** os logs permanecem locais

Nenhum sistema é completamente seguro. Não podemos garantir segurança absoluta dos dados.

### 9.1 Notificação de Violações

Como não armazenamos seus dados pessoais em nossos servidores, uma violação que afete dados pessoais relacionados ao AutoBrew é estruturalmente improvável. Se, ainda assim, ocorrer uma violação que provavelmente resulte em alto risco para seus direitos e liberdades (Art. 34 GDPR), faremos uma comunicação pública em https://digitalfreedom.co.za/security.

---

## 10. SEUS DIREITOS

### 10.1 Direitos sob o GDPR (UE/EEE/Reino Unido)

Você tem o direito de:

- **Acesso** aos seus dados pessoais (Art. 15 GDPR) — não aplicável, não mantemos dados sobre você
- **Retificação** de dados imprecisos (Art. 16 GDPR) — não aplicável
- **Apagamento** / direito ao esquecimento (Art. 17 GDPR) — não aplicável; você pode excluir dados locais desinstalando o AutoBrew
- **Limitação** do tratamento (Art. 18 GDPR) — não aplicável
- **Portabilidade dos dados** (Art. 20 GDPR) — não aplicável
- **Oposição** ao tratamento (Art. 21 GDPR) — não aplicável
- **Retirada do consentimento** a qualquer momento (Art. 7(3) GDPR) — você pode parar de usar o AutoBrew a qualquer momento
- **Apresentar uma reclamação** a uma autoridade supervisora

### 10.2 Direitos sob a CCPA/CPRA (Califórnia)

Residentes da Califórnia têm o direito de:

- Saber quais informações pessoais são coletadas
- Solicitar a exclusão de informações pessoais
- Optar por não participar da venda ou compartilhamento de informações pessoais
- Não sofrer discriminação por exercer direitos de privacidade
- Corrigir informações pessoais imprecisas
- Limitar o uso de informações pessoais sensíveis

### 10.3 Direitos sob a PIPEDA (Canadá)

Residentes canadenses têm o direito de:

- Acessar suas informações pessoais
- Contestar a precisão das suas informações
- Retirar o consentimento (sujeito a restrições legais ou contratuais)

### 10.4 Direitos sob o Australian Privacy Act

Residentes australianos têm o direito de:

- Acessar suas informações pessoais
- Solicitar correção de informações imprecisas
- Apresentar reclamação ao Office of the Australian Information Commissioner (OAIC)

### 10.5 Direitos sob a LGPD (Brasil)

Os titulares de dados no Brasil têm os direitos previstos no Art. 18 da LGPD (Lei nº 13.709/2018):

- Confirmação da existência de tratamento
- Acesso aos dados
- Correção de dados incompletos, inexatos ou desatualizados
- Anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com a LGPD
- Portabilidade dos dados a outro fornecedor de serviço ou produto
- Eliminação dos dados pessoais tratados com o consentimento do titular
- Informação sobre as entidades públicas e privadas com as quais o controlador realizou uso compartilhado de dados
- Informação sobre a possibilidade de não fornecer consentimento e sobre as consequências da negativa
- Revogação do consentimento

As reclamações podem ser direcionadas à Autoridade Nacional de Proteção de Dados (ANPD). Como o AutoBrew não coleta dados pessoais sob nosso controle, esses direitos são atendidos por padrão.

---

## 11. PRIVACIDADE INFANTIL

O AutoBrew é uma ferramenta técnica voltada para administradores de sistemas e desenvolvedores que usam o Homebrew em seus Macs. Não é direcionado a crianças menores de 16 anos (ou a idade aplicável de consentimento em sua jurisdição).

Não coletamos intencionalmente dados pessoais de ninguém, incluindo crianças. Se você for pai, mãe ou responsável e acreditar que seu filho forneceu dados pessoais, entre em contato com data-protection@digitalfreedom.co.za. Como o AutoBrew implementa uma política estrita de coleta zero, essa situação não deve ocorrer em conexão com o aplicativo.

---

## 12. COOKIES E RASTREAMENTO

O AutoBrew é um aplicativo nativo do macOS e não usa cookies, web beacons, pixel tags, fingerprinting ou tecnologias de rastreamento similares.

O AutoBrew não contém webviews incorporadas que carreguem conteúdo de terceiros, exceto quando você abre, voluntariamente, um link externo (página de suporte, GitHub Sponsors) em seu navegador.

---

## 13. TOMADA DE DECISÃO AUTOMATIZADA E IA

### 13.1 Decisões automatizadas com efeito jurídico ou similarmente significativo

Não realizamos tomada de decisão automatizada nem criação de perfis que produzam efeitos jurídicos sobre você. O AutoBrew automatiza apenas operações do Homebrew (`update`, `upgrade`, `cleanup`) que você configura ou aciona; nenhuma decisão sobre você é tomada por nossa infraestrutura.

### 13.2 Recursos assistidos por IA

O AutoBrew não inclui recursos assistidos por IA, não envia dados a APIs de modelos de linguagem e não usa modelos de aprendizado de máquina para tratamento de seus dados.

### 13.3 Comunicações de marketing

Não enviamos comunicações de marketing pelo AutoBrew. Não há cadastro, não há newsletter dentro do aplicativo, não há notificações push de marketing.

### 13.4 Exclusão de dados locais

Você pode excluir todos os dados locais do AutoBrew a qualquer momento removendo o aplicativo e seus dados de suporte. Não há nenhuma conta a excluir do nosso lado.

---

## 14. LINKS E SERVIÇOS DE TERCEIROS

Os Serviços podem conter links para sites ou serviços de terceiros (por exemplo, Homebrew, GitHub, página de suporte). Não somos responsáveis pelas práticas de privacidade de terceiros. Consulte as políticas de privacidade deles antes de fornecer quaisquer dados.

---

## 15. ALTERAÇÕES NESTA POLÍTICA

Podemos atualizar esta Política de Privacidade periodicamente.

- Alterações materiais serão comunicadas por meio dos Serviços ou em https://digitalfreedom.co.za
- O uso continuado após as alterações constitui aceitação
- A "Data de Vigência" no topo reflete a revisão mais recente

---

## 16. CONTATO

Para consultas relacionadas à privacidade ou para exercer seus direitos:

DigitalFreedom
Uma marca da Berger & Rosenstock GbR
Dieselstr. 22e
61231 Bad Nauheim
Alemanha

Proteção de dados: data-protection@digitalfreedom.co.za
Consultas gerais: hello@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

Para residentes da UE, você também pode entrar em contato com a autoridade supervisora competente em seu Estado-Membro.

---

## 17. DISPOSIÇÕES REGIONAIS

### 17.1 União Europeia / EEE

- O tratamento está em conformidade com os requisitos do GDPR, na medida aplicável ao tratamento local
- A autoridade supervisora líder é a autoridade alemã de proteção de dados competente
- Avaliações de Impacto sobre a Proteção de Dados (DPIAs) são realizadas quando exigido — não são necessárias para o AutoBrew (sem coleta)

### 17.2 Reino Unido

- Tratamento em conformidade com o UK GDPR e Data Protection Act 2018
- A autoridade supervisora é o Information Commissioner's Office (ICO)

### 17.3 Estados Unidos

- Tratamento em conformidade com as leis estaduais de privacidade aplicáveis (CCPA/CPRA, VCDPA, CPA, etc.)
- Sinais "Do Not Track" são respeitados quando tecnicamente viável (o AutoBrew não rastreia)

### 17.4 Canadá

- Tratamento em conformidade com a PIPEDA e a legislação provincial aplicável
- O Office of the Privacy Commissioner of Canada pode ser contatado para reclamações

### 17.5 Austrália

- Tratamento em conformidade com o Privacy Act 1988 e os Australian Privacy Principles (APPs)

### 17.6 Brasil

- Tratamento em conformidade com a Lei Geral de Proteção de Dados Pessoais (LGPD, Lei nº 13.709/2018)
- A Autoridade Nacional de Proteção de Dados (ANPD) é a autoridade competente

---

(c) 2025-2026 DigitalFreedom — Berger & Rosenstock GbR. Todos os direitos reservados.
