# TERMOS DE USO

## AutoBrew

**Data de Vigência:** Maio de 2026
**Última Atualização:** Maio de 2026

Estes Termos de Uso ("Termos") regem o seu uso do AutoBrew (o "Software"). Leia-os com atenção. Ao instalar ou usar o AutoBrew, você concorda em vincular-se a estes Termos.

---

## 1. PRESTADOR

O Software é publicado sob a marca **DigitalFreedom**. A pessoa jurídica responsável é:

Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e, 61231 Bad Nauheim, Alemanha
Representantes Autorizados: Marcel R. G. Berger, Jasmin Rosenstock
E-mail: hello@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

Estes Termos têm aplicação global. Direitos imperativos de proteção do consumidor e demais direitos legais do país de residência do usuário permanecem inalterados e prevalecem sempre que forem mais protetivos.

---

## 2. O SOFTWARE

O AutoBrew é um utilitário de barra de menus para macOS que automatiza atualizações do Homebrew, permite navegar no catálogo de casks do Homebrew e gerencia snapshots de aplicativos para migração entre Macs. Ele é:

- **Código aberto** sob a Licença MIT — código-fonte completo em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew)
- **Gratuito** — sem compras dentro do aplicativo, sem assinaturas, sem nível pago, sem período de avaliação
- **Distribuído diretamente** — DMG notarizado a partir das GitHub Releases e de um tap do Homebrew; não pela Apple App Store nem pela Google Play Store
- **Apenas local** — é executado inteiramente no seu Mac, sem necessidade de conta AutoBrew ou serviço de backend (consulte a [Política de Privacidade](PrivacyPolicy.md))

Estes Termos aplicam-se ao binário do AutoBrew. A Licença MIT (reproduzida no [EULA](EULA.md) e em [Licenças de Código Aberto](OpenSourceLicenses.md)) rege o código-fonte e quaisquer forks ou derivados.

---

## 3. LICENÇA DE USO

Sujeito ao cumprimento destes Termos e da Licença MIT, você pode:

- Instalar, executar, modificar e redistribuir o AutoBrew em quantos Macs controlar
- Fazer fork do código-fonte e criar trabalhos derivados nos termos da Licença MIT

Você não pode:

- Falsear a origem do Software (a Licença MIT exige a manutenção do aviso de copyright original)
- Remover os avisos de licença incorporados do Sparkle, bsdiff, sais-lite ou pdqsort ao redistribuir
- Utilizar o nome **AutoBrew** ou a marca **DigitalFreedom** em trabalhos derivados sem nosso consentimento por escrito (marca registrada, consulte o documento [Marca](Trademark.md))

---

## 4. SEM CONTA, SEM PAGAMENTO (ESTADO ATUAL)

O AutoBrew atualmente não exige cadastro, registro ou qualquer pagamento. O link **Sponsor** dentro do aplicativo direciona ao GitHub Sponsors e é **totalmente voluntário** — qualquer contribuição é tratada como doação e não gera direito a recursos ou suporte.

### 4.1 Reserva quanto a funcionalidades pagas futuras

O Prestador reserva-se o direito de introduzir, em versões futuras do AutoBrew, **funcionalidades pagas**, **edições pagas** ou **serviços complementares pagos** opcionais. Quaisquer ofertas pagas futuras desse tipo:

- Serão anunciadas com antecedência por meio da interface do aplicativo e das notas de versão oficiais
- Aplicar-se-ão apenas para o futuro — seu direito de continuar usando a versão gratuita atual permanece inalterado
- Não afetarão o núcleo de código aberto: o código-fonte em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) continuará disponível sob a Licença MIT

A ausência atual de funcionalidades pagas não constitui garantia de que o AutoBrew permanecerá livre de funcionalidades pagas em toda versão futura.

---

## 5. DEPENDÊNCIA DO HOMEBREW

O AutoBrew depende de uma instalação funcional do Homebrew para cumprir sua finalidade. O AutoBrew invoca o binário `brew` e lê / grava dados utilizando os próprios comandos e convenções do projeto Homebrew. Não somos afiliados ao projeto Homebrew; não controlamos quais pacotes estão disponíveis, quando as versões são lançadas ou o que os publicadores de casks fazem com seus instaladores.

Se a instalação de um cask falhar, se comportar de maneira inesperada ou causar dano, esse é um assunto entre você e o publicador do cask e/ou o projeto Homebrew — consulte a Seção 7 (Isenção de Garantia) e a Seção 8 (Limitação de Responsabilidade).

---

## 6. ATUALIZAÇÕES

O AutoBrew utiliza o framework Sparkle para entregar atualizações dentro do aplicativo a partir do appcast oficial do AutoBrew no GitHub. As atualizações são assinadas com uma chave EdDSA Ed25519 e verificadas antes de serem aplicadas. As atualizações automáticas podem ser desativadas nas Configurações.

Você é livre para ignorar as atualizações no aplicativo e atualizar o binário pelo seu tap do Homebrew ou baixando manualmente um DMG mais recente.

---

## 7. ISENÇÃO DE GARANTIA

O Software é fornecido **"COMO ESTÁ"** e **"CONFORME DISPONÍVEL"**, sem garantia de qualquer tipo, expressa ou implícita, incluindo, entre outras, as garantias implícitas de comercialização, adequação a uma finalidade específica e não violação.

Sem limitar o que precede, não garantimos que:

- O Software será ininterrupto ou livre de erros
- A interação do AutoBrew com o Homebrew, com casks individuais ou com o próprio macOS produzirá sempre o resultado desejado
- Os snapshots criados pelo AutoBrew capturarão perfeitamente todos os aspectos do estado de um aplicativo — aplicativos que armazenam dados fora dos subdiretórios padrão de Library podem não ser totalmente capturados

Direitos legais de garantia que não possam ser excluídos por contrato segundo a legislação local de proteção do consumidor (por exemplo, a Mängelhaftung alemã nos §§ 434 e seguintes do BGB, quando aplicável, ou os direitos do consumidor previstos no Código de Defesa do Consumidor brasileiro) permanecem inalterados.

---

## 8. LIMITAÇÃO DE RESPONSABILIDADE

Na máxima extensão permitida pela lei aplicável:

- Não somos responsáveis por danos indiretos, incidentais, consequenciais, exemplares ou punitivos
- Não somos responsáveis por perda de dados, lucros cessantes, interrupção de negócios ou qualquer dano decorrente de software de terceiros (Homebrew, casks individuais) invocado pelo AutoBrew

Para usuários habitualmente residentes na Alemanha ou na UE, nossa responsabilidade por danos causados por **culpa grave ou dolo**, por **lesão à vida, ao corpo ou à saúde** e nos termos das **disposições imperativas da Lei Alemã de Responsabilidade pelo Produto (ProdHaftG)** permanece inalterada.

---

## 9. RESCISÃO

Você pode parar de usar o AutoBrew a qualquer momento desinstalando-o. A remoção do AutoBrew e da sua pasta de suporte (`~/Library/Application Support/AutoBrew/`) devolve seu Mac a um estado em que não restam artefatos do AutoBrew.

Podemos descontinuar a distribuição do AutoBrew a qualquer momento. Como o Software é código aberto sob MIT, você e a comunidade permanecem livres para criar fork, compilar e executá-lo de forma independente.

---

## 10. ALTERAÇÕES NESTES TERMOS

Podemos atualizar estes Termos para refletir alterações no Software ou na legislação aplicável. Alterações relevantes são comunicadas nas notas de versão do AutoBrew. A data de "Última Atualização" no topo reflete a revisão mais recente.

---

## 11. LEI APLICÁVEL E FORO

Estes Termos são regidos pelas leis da República Federal da Alemanha, com exclusão da Convenção das Nações Unidas sobre Contratos de Compra e Venda Internacional de Mercadorias (CISG).

Para consumidores habitualmente residentes fora da Alemanha, a lei imperativa de proteção do consumidor do país de residência aplica-se adicionalmente. O foro não exclusivo para litígios é Bad Nauheim, Alemanha; consumidores ainda podem demandar no seu domicílio quando a lei local permitir.

Para litígios de consumo originados sob a legislação da UE, a plataforma de Resolução de Litígios Online da Comissão Europeia está disponível em https://ec.europa.eu/consumers/odr. Não somos obrigados nem estamos dispostos a participar de procedimentos alternativos de resolução de litígios perante uma Verbraucherschlichtungsstelle (órgão de arbitragem do consumidor) nos termos do § 36 VSBG.

---

## 12. CONTATO

Berger & Rosenstock GbR (atuando como DigitalFreedom)
Dieselstr. 22e
61231 Bad Nauheim
Alemanha
E-mail: hello@digitalfreedom.co.za
Site: https://digitalfreedom.co.za

---

(c) 2026 DigitalFreedom — Berger & Rosenstock GbR.
