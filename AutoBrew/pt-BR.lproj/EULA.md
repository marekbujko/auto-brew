# CONTRATO DE LICENÇA DE USUÁRIO FINAL (EULA)

## AutoBrew

**Data de Vigência:** Maio de 2026
**Última Atualização:** Maio de 2026

Este Contrato de Licença de Usuário Final ("EULA", "Contrato") é um contrato jurídico entre você ("Usuário", "você") e o editor do AutoBrew, **Berger & Rosenstock GbR** atuando como **DigitalFreedom** ("Editor", "nós", "nosso").

Ao instalar, copiar ou de qualquer forma usar o AutoBrew (o "Software"), você concorda em vincular-se aos termos deste EULA.

---

## 1. O SOFTWARE

O AutoBrew é um utilitário de barra de menus para macOS que automatiza atualizações do Homebrew, permite navegar no catálogo de casks do Homebrew e gerencia snapshots de aplicativos. Ele é publicado sob a marca DigitalFreedom e licenciado a você nos termos abaixo.

### 1.1 Modelo de licenciamento

O AutoBrew é disponibilizado como **software livre e de código aberto** sob a Licença MIT. O texto integral da Licença MIT está reproduzido na Seção 6 e no documento [Licenças de Código Aberto](OpenSourceLicenses.md). A Licença MIT rege o código-fonte; este EULA rege a distribuição do binário e as suas obrigações como usuário do binário.

### 1.2 Reserva quanto a funcionalidades pagas futuras

O Editor reserva-se o direito de introduzir, a qualquer momento, **funcionalidades pagas**, **edições pagas** ou **serviços complementares pagos** opcionais. Quaisquer alterações futuras desse tipo:

- Serão anunciadas com antecedência por meio da interface do aplicativo e das notas de versão oficiais
- Aplicar-se-ão apenas para o futuro (isto é, a funcionalidade gratuita existente em uma versão já instalada permanece de uso gratuito)
- Deixarão intacto o núcleo de código aberto sob a Licença MIT — o código-fonte em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew) permanece disponível sob a mesma licença, independentemente de quaisquer adições pagas

A ausência atual de qualquer funcionalidade paga não constitui garantia de que o AutoBrew permanecerá livre de funcionalidades pagas para sempre.

### 1.3 Escopo do código aberto vs. funcionalidades pagas

A Licença MIT aplica-se ao código-fonte do AutoBrew tal como publicado no repositório oficial em [github.com/marcelrgberger/auto-brew](https://github.com/marcelrgberger/auto-brew). **Forks e derivados dessa base de código são expressamente permitidos** nos termos da Licença MIT — incentivamos a comunidade a construir sobre o AutoBrew.

Quaisquer **funcionalidades pagas futuras**, **edições pagas** ou **serviços complementares pagos** (consulte a Seção 1.2) serão disponibilizados sob uma **licença proprietária separada** e **não** farão parte da base de código sob a Licença MIT. Em particular:

- O código-fonte das funcionalidades pagas não será publicado no repositório MIT
- Copiar, descompilar, fazer engenharia reversa ou de qualquer outra forma reproduzir a implementação de qualquer funcionalidade paga proprietária distribuída pelo AutoBrew não é permitido, salvo quando expressamente autorizado por lei imperativa aplicável (por exemplo, § 69e UrhG / Art. 6 da Diretiva 2009/24/CE da UE para fins de interoperabilidade)
- Essa restrição aplica-se especificamente à implementação da funcionalidade paga — ela não restringe o direito de qualquer terceiro desenvolver, de forma independente e do zero, funcionalidade comparável

As marcas **"AutoBrew"** e **"DigitalFreedom"** não podem ser utilizadas por forks ou derivados que ofereçam funcionalidades pagas concorrentes — consulte a Seção 3 deste EULA e o aviso [Marca](Trademark.md).

### 1.4 Canais de distribuição

O binário oficial do AutoBrew é distribuído exclusivamente por meio de:

- **GitHub Releases** em [github.com/marcelrgberger/auto-brew/releases](https://github.com/marcelrgberger/auto-brew/releases) — arquivos DMG notarizados e assinados com o certificado Apple Developer ID
- O **tap do Homebrew** em [github.com/marcelrgberger/homebrew-tap](https://github.com/marcelrgberger/homebrew-tap) — `brew install --cask autobrew`

O AutoBrew **não** é distribuído pela Apple App Store, pela Google Play Store ou por qualquer portal de download de terceiros. Se você obteve o AutoBrew por qualquer outro meio, o binário não é verificado e não está coberto por este EULA.

---

## 2. CONCESSÃO DA LICENÇA

Sujeito ao cumprimento deste EULA e da Licença MIT, o Editor concede a você uma licença mundial, isenta de royalties e não exclusiva para:

- Instalar e executar o AutoBrew em quantos Macs você possua ou controle
- Modificar o código-fonte e criar trabalhos derivados
- Redistribuir o Software em código-fonte ou em forma binária

---

## 3. RESTRIÇÕES

Você não pode:

- Remover, alterar ou ocultar os avisos de copyright, o texto da Licença MIT ou os avisos de licença incorporados de Sparkle / bsdiff / sais-lite / pdqsort ao redistribuir
- Utilizar as marcas **"AutoBrew"** e **"DigitalFreedom"** no nome de um fork ou derivado sem nosso consentimento prévio por escrito (consulte o documento [Marca](Trademark.md))
- Apresentar de forma indevida o seu fork como sendo a distribuição oficial do AutoBrew

---

## 4. COMPONENTES DE TERCEIROS

O AutoBrew incorpora os seguintes componentes de código aberto, cada um regido pela sua respectiva licença (consulte o documento [Licenças de Código Aberto](OpenSourceLicenses.md) para a lista completa e os textos integrais das licenças):

- **Sparkle** (MIT) — atualizações automáticas no aplicativo
- **bsdiff / bspatch** (BSD-2-Clause) — incorporado dentro do Sparkle para deltas binários
- **sais-lite** (MIT) — incorporado dentro do Sparkle
- **pdqsort** (zlib) — incorporado dentro do Sparkle

O AutoBrew também depende em tempo de execução do **Homebrew** (BSD-2-Clause) — invocado via spawn de processo, não incorporado. O Homebrew precisa ser instalado separadamente; o AutoBrew o guiará na sua instalação no primeiro lançamento.

As licenças MIT, BSD-2-Clause e zlib aplicáveis a esses componentes permanecem em vigor independentemente deste EULA. Em caso de conflito entre este EULA e uma licença de código aberto, prevalece a licença de código aberto para o componente afetado.

---

## 5. SEM PAGAMENTO, SEM CONTA (ESTADO ATUAL)

O AutoBrew é atualmente gratuito. O Software não exige cadastro, registro ou qualquer pagamento e, na data deste EULA, não há compras dentro do aplicativo, assinaturas, funcionalidades pagas nem mecânicas de avaliação.

O link **Sponsor** dentro do AutoBrew direciona ao GitHub Sponsors e é **totalmente voluntário**. Qualquer contribuição é tratada como doação e não confere direitos adicionais.

**Reserva:** consulte a Seção 1.2 — o Editor reserva-se o direito de introduzir, no futuro, funcionalidades pagas, edições pagas ou serviços complementares pagos opcionais. Quaisquer ofertas pagas futuras desse tipo aplicar-se-ão somente aos usuários que explicitamente optarem por elas; a funcionalidade gratuita atual que você instalou não será restringida retroativamente.

---

## 6. LICENÇA MIT (verbatim)

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

## 7. ISENÇÃO DE GARANTIA

O Software é fornecido **"COMO ESTÁ"**, sem garantia de qualquer tipo, expressa ou implícita. O Editor não garante que o Software será ininterrupto ou livre de erros, que a interação do AutoBrew com o Homebrew ou com casks individuais sempre terá êxito, ou que os snapshots capturarão perfeitamente todos os aspectos do estado de um aplicativo.

Direitos legais de garantia que não possam ser excluídos por contrato segundo a legislação local de proteção do consumidor (por exemplo, a Mängelhaftung alemã nos §§ 434 e seguintes do BGB, quando aplicável, ou os direitos do consumidor previstos no Código de Defesa do Consumidor brasileiro) permanecem inalterados.

---

## 8. LIMITAÇÃO DE RESPONSABILIDADE

Na máxima extensão permitida pela lei aplicável, o Editor não é responsável por danos indiretos, incidentais, consequenciais, exemplares ou punitivos — incluindo perda de dados, lucros cessantes ou danos decorrentes de software de terceiros (Homebrew, casks individuais) invocado pelo AutoBrew.

Para usuários habitualmente residentes na Alemanha ou na UE, nossa responsabilidade por danos causados por **culpa grave ou dolo**, por **lesão à vida, ao corpo ou à saúde** e nos termos da **Lei Alemã de Responsabilidade pelo Produto (ProdHaftG)** permanece inalterada.

---

## 9. CONTROLE DE EXPORTAÇÃO

O Software não contém criptografia além do que o macOS da Apple e o framework Sparkle fornecem por padrão. A exportação do próprio macOS é regida pelos termos da Apple; você continua responsável pelo cumprimento das leis de controle de exportação aplicáveis à sua jurisdição.

---

## 10. RESCISÃO

Este EULA permanece em vigor até ser rescindido. Ele se rescinde automaticamente, sem aviso prévio, se você descumprir qualquer um dos seus termos. Você também pode rescindi-lo a qualquer momento desinstalando o AutoBrew. Após a rescisão, você deve cessar todo uso do Software e remover todas as cópias sob seu controle.

---

## 11. LEI APLICÁVEL E FORO

Este EULA é regido pelas leis da República Federal da Alemanha, com exclusão da Convenção das Nações Unidas sobre Contratos de Compra e Venda Internacional de Mercadorias (CISG). A lei imperativa de proteção do consumidor do país de residência do usuário aplica-se adicionalmente.

O foro não exclusivo é Bad Nauheim, Alemanha. Consumidores podem demandar no seu domicílio quando a lei local permitir.

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
