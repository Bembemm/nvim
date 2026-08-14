<div align="center">

# ✨ Neovim

**Uma configuração moderna, pequena e direta ao ponto.**

Lua · C++ · Neovim 0.12+ · `vim.pack` · Blink v2 · Snacks · LLDB · Monokai Remastered

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-LuaJIT-2C2D72?logo=lua&logoColor=white)
![C++](https://img.shields.io/badge/C%2B%2B-clangd-00599C?logo=cplusplus&logoColor=white)
![Plugins](https://img.shields.io/badge/plugins-vim.pack-6E56CF)
![Debug](https://img.shields.io/badge/debug-LLDB-6E56CF)
![Theme](https://img.shields.io/badge/theme-Monokai%20Remastered-F4005F)
[![CI](https://github.com/Bembemm/nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/Bembemm/nvim/actions/workflows/ci.yml)

</div>

---

## Visão geral

Esta configuração segue uma regra simples: **usar o máximo possível das APIs nativas do Neovim e adicionar plugins apenas quando eles resolvem um problema real**.

As linguagens configuradas atualmente são **Lua** e **C++**. Cada camada continua independente: LSP cuida da inteligência de código, Treesitter do parsing, Conform da formatação e DAP do debugging.

### Stack

- **Neovim 0.12+**
- plugins com **`vim.pack`**
- completion com **Blink.cmp v2**
- LSP nativo com **`vim.lsp.config()`** e **`vim.lsp.enable()`**
- Lua com **lua-language-server + StyLua**
- C++ com **clangd + clang-format + Treesitter cpp**
- debugging C++ com **nvim-dap + lldb-dap**
- UI de debug com **nvim-dap-view**
- busca e navegação com **Snacks**
- explorer com **Oil**
- navegação rápida com **Harpoon 2**
- atalhos organizados com **Which-Key v3**
- animação do cursor com **Smear Cursor**
- tema **Monokai Remastered**

---

## Estrutura

```text
.
├── .stylua.toml
├── init.lua
├── README.md
├── lua/
│   └── core/
│       ├── dashboard.lua
│       ├── keymaps.lua
│       ├── options.lua
│       └── plugins.lua
│
└── plugin/
    ├── blink.lua
    ├── colorscheme.lua
    ├── conform.lua
    ├── dap.lua
    ├── devicons.lua
    ├── gitsigns.lua
    ├── harpoon.lua
    ├── indent.lua
    ├── lsp.lua
    ├── lualine.lua
    ├── mini.lua
    ├── mode-line-numbers.lua
    ├── oil.lua
    ├── smear-cursor.lua
    ├── snacks.lua
    ├── surround.lua
    ├── todo.lua
    ├── treesitter.lua
    └── which-key.lua
```

`init.lua` permanece pequeno de propósito. A declaração dos plugins fica centralizada em `lua/core/plugins.lua`, enquanto os arquivos em `plugin/` cuidam apenas da configuração de cada plugin. `lua/core/dashboard.lua` concentra a coleta e a formatação das informações do sistema usadas pelo dashboard do Snacks.

---

## Requisitos

| Dependência | Uso |
|---|---|
| **Neovim 0.12+** | APIs modernas da configuração |
| **Git** | instalação e atualização de plugins |
| **curl** | download de parsers do Treesitter |
| **tar** | extração dos parsers do Treesitter |
| **tree-sitter-cli >= 0.26.1** | geração e compilação dos parsers |
| **Rust toolchain (`cargo` + `rustc`)** | compilação do fuzzy matcher do Blink v2 a partir do source |
| **lua-language-server** | LSP para Lua |
| **StyLua** | formatação de Lua |
| **clangd** | LSP para C++ |
| **clang-format** | formatação de C++ |
| **lldb-dap** | debugging de C++ |
| **clang++ ou g++** | compilação de programas C++ |
| **ripgrep (`rg`)** | grep e busca de TODOs |
| **Nerd Font** | ícones da interface |

As ferramentas externas devem estar disponíveis no `PATH`. Quando `lua-language-server`, `clangd` ou
`lldb-dap`/`lldb-vscode` não são encontrados, a configuração continua iniciando e mostra uma notificação com o
recurso que foi desativado.

A GUI usa, quando disponível:

```text
Iosevka Nerd Font 14
```

---

## Plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`. A configuração evita sobreposição
desnecessária: cada plugin tem uma responsabilidade específica e, quando possível, integra-se às APIs nativas do
Neovim.

### Visão rápida

| Categoria | Plugins |
|---|---|
| **Completion e código** | Blink.cmp, blink.lib, nvim-treesitter, conform.nvim |
| **Debug** | nvim-dap, nvim-dap-view |
| **Navegação** | snacks.nvim, oil.nvim, Harpoon 2 |
| **Git** | gitsigns.nvim |
| **Edição** | mini.pairs, nvim-surround, todo-comments.nvim |
| **Interface** | Which-Key, indent-blankline, Lualine, nvim-web-devicons, Smear Cursor |
| **Tema** | Monokai Remastered |
| **Bibliotecas** | plenary.nvim |

### Completion e código

#### Blink.cmp

É o motor de completion da configuração. Ele reúne em uma única interface sugestões vindas de:

- LSP;
- caminhos de arquivos;
- snippets;
- conteúdo do buffer.

A configuração também habilita signature help, documentação automática e ícones/tipos no menu de completion.
Quando `clangd` ou `lua-language-server` estão conectados pelo LSP nativo, suas sugestões entram no Blink pela
source `lsp`.

#### blink.lib

Biblioteca usada pelo Blink.cmp v2. Ela faz parte da infraestrutura do sistema de completion e não possui
configuração separada neste repositório.

#### nvim-treesitter

Fornece parsing baseado em árvores sintáticas para highlight e indentação.

Os parsers instalados atualmente são:

```text
lua
c
cpp
vim
vimdoc
query
```

A configuração inicia o Treesitter através da API nativa `vim.treesitter.start()` quando um desses filetypes é
aberto e usa o `indentexpr` fornecido pelo próprio nvim-treesitter.

#### conform.nvim

Centraliza a formatação automática dos arquivos.

Nesta configuração:

```text
Lua     → StyLua
C / C++ → clang-format
```

A formatação acontece ao salvar. Caso o formatter externo não esteja disponível e o servidor LSP ofereça
formatação, o Conform pode usar o LSP como fallback.

### Debug

#### nvim-dap

Implementa o cliente Debug Adapter Protocol usado para debugging de C++.

A configuração procura `lldb-dap` e usa `lldb-vscode` como fallback. Quando um adapter está disponível, existem
fluxos para:

- executar um programa C++;
- anexar a um processo;
- criar breakpoints;
- criar breakpoints condicionais;
- step into, step over e step out;
- continuar ou encerrar a execução;
- abrir o REPL.

Os comandos ficam agrupados em `<leader>d`.

#### nvim-dap-view

É a interface visual sobre o `nvim-dap`. Exibe informações da sessão de debug como scopes, variáveis,
breakpoints, threads e REPL.

Na configuração atual a interface abre e fecha automaticamente junto da sessão, possui controles no winbar e
mostra valores através de virtual text inline.

### Navegação

#### snacks.nvim

É o principal conjunto de ferramentas de interface e navegação da configuração.

Atualmente o Snacks fornece:

- dashboard;
- picker de arquivos;
- grep;
- arquivos recentes;
- lista de buffers;
- busca de comandos;
- lista de projetos;
- status Git no dashboard;
- notificações;
- visualização de imagens.

O dashboard usa `lua/core/dashboard.lua` para obter informações do sistema e mantém a parte visual separada da
coleta das métricas.

Principais atalhos:

```text
<leader>.d  dashboard
<leader>ff  arquivos
<leader>fg  grep
<leader>fr  recentes
<leader>fc  comandos
<leader>fp  todos os pickers
<leader>bb  buffers
<leader>i   visualizar imagem
```

#### oil.nvim

Substitui o explorador de arquivos padrão por uma interface baseada em buffers.

Diretórios podem ser navegados como buffers normais do Neovim, mantendo a experiência próxima da edição de
texto. Arquivos ocultos são exibidos por padrão.

```text
<leader>o  → abrir Oil
```

#### Harpoon 2

Mantém uma pequena lista de arquivos escolhidos para acesso rápido durante o trabalho atual.

Ele complementa o picker do Snacks: o Snacks serve para **encontrar** arquivos, enquanto o Harpoon serve para
**voltar imediatamente** aos arquivos que já foram escolhidos como importantes.

```text
<leader>ha      adicionar arquivo
<leader>hm      abrir menu
<leader>hn      próximo
<leader>hp      anterior
<C-e>           menu rápido
<C-1>…<C-4>     abrir itens 1 a 4
```

O menu também permite abrir um item em split horizontal ou vertical.

### Git

#### gitsigns.nvim

Integra informações do Git diretamente aos buffers.

Mostra sinais no gutter indicando linhas adicionadas, modificadas ou removidas e fornece preview do hunk atual:

```text
<leader>gp  → preview do hunk
```

O plugin trabalha no nível do buffer e complementa o status Git exibido pelo dashboard do Snacks.

### Edição

#### mini.nvim / mini.pairs

O repositório `mini.nvim` é usado somente através do módulo `mini.pairs`.

Ele insere pares automaticamente durante a digitação em Insert mode, como parênteses, colchetes e aspas. O
recurso fica desabilitado em Command mode e Terminal mode.

#### nvim-surround

Trabalha com delimitadores ao redor de texto já existente.

Ele permite adicionar, trocar ou remover surrounds como:

- `(...)`;
- `[...]`;
- `{...}`;
- aspas;
- outros delimitadores e estruturas suportadas pelo plugin.

Ele complementa o `mini.pairs`: o `mini.pairs` cria pares enquanto o texto é digitado, enquanto o
`nvim-surround` modifica os delimitadores de texto que já existe.

#### todo-comments.nvim

Destaca comentários especiais como `TODO`, `FIX`, `HACK` e similares.

A busca desses comentários é integrada ao picker do Snacks:

```text
<leader>ft  → buscar TODOs
```

Assim, o plugin cuida da identificação dos comentários e o Snacks cuida da interface de busca.

### Interface

#### which-key.nvim

Organiza e apresenta os grupos de keymaps associados ao Leader.

Os principais grupos são:

```text
<leader>b  Buffers
<leader>d  Debug
<leader>f  Find
<leader>g  Git
<leader>h  Harpoon
<leader>l  LSP
<leader>p  Plugins
```

A interface usa o preset `modern`, bordas arredondadas e delay de 200 ms.

#### indent-blankline.nvim

Exibe guias visuais de indentação e do escopo atual.

As cores dos níveis não são fixadas diretamente em HEX; os highlights são ligados a grupos do colorscheme
ativo, como `DiagnosticError`, `Type`, `String`, `Function` e `Statement`. Isso mantém as guias coerentes com a
paleta do tema.

#### lualine.nvim

Fornece a statusline.

A configuração é propositalmente pequena: ícones ficam habilitados e `theme = "auto"` faz a Lualine acompanhar o
colorscheme ativo.

#### nvim-web-devicons

Fornece ícones para arquivos e elementos da interface usados por outros componentes da configuração.

A variante escura e os ícones coloridos ficam habilitados. A configuração pressupõe o uso de uma Nerd Font.

#### smear-cursor.nvim

Adiciona uma animação visual ao movimento do cursor entre posições, buffers e janelas.

Ele inicia com a configuração padrão e não interfere nas funcionalidades de edição. Pode ser alternado com:

```vim
:SmearCursorToggle
```

### Tema

#### monokai_remastered.nvim

Fornece o colorscheme **Monokai Remastered**.

A configuração usa a paleta `classic`, habilita itálicos e faz uma pequena alteração na cor `brown`. Outros
elementos, como a Lualine e os números de linha dependentes do modo, reutilizam essa identidade visual.

### Bibliotecas

#### plenary.nvim

Biblioteca Lua utilizada como dependência na stack do Harpoon 2.

Ela não possui configuração própria neste repositório: fica disponível apenas como infraestrutura para plugins
que precisem dela.

### Código nativo relacionado

Dois arquivos em `plugin/` não correspondem a plugins externos:

- `plugin/lsp.lua` configura diretamente o LSP nativo do Neovim para Lua e C/C++;
- `plugin/mode-line-numbers.lua` muda a cor dos números de linha conforme o modo atual do Neovim.

Isso mantém funcionalidades que já existem no Neovim fora de dependências adicionais.

---

## Dashboard

O dashboard do Snacks usa `lua/core/dashboard.lua` como fonte única para as informações do sistema. Ele detecta a distribuição Linux, versão do Neovim, CPU, RAM, swap, disco, uptime, bateria quando disponível, quantidade de processos e IP local.

O rodapé mostra quantos plugins gerenciados pelo `vim.pack` estão ativos em relação ao total conhecido e o tempo gasto desde o início da configuração:

```text
⚡ Config loaded · ativos/total plugins · tempo
```

Esse tempo mede o carregamento da configuração a partir da primeira linha de `init.lua`; não pretende representar o startup completo do processo do Neovim.

O dashboard também inclui atalhos, arquivos recentes, projetos, status Git, previsão do tempo e fallback para `rmatrix` quando disponível.

```text
<leader>.d  → abrir dashboard
```

---

## Which-Key

A tecla **Leader é `Space`**.

```text
<leader>b  Buffers
<leader>d  Debug
<leader>f  Find
<leader>g  Git
<leader>h  Harpoon
<leader>l  LSP
<leader>p  Plugins
```

O Which-Key usa o preset `modern`, borda arredondada e delay de 200 ms.

Para exibir apenas os keymaps locais do buffer:

```text
<leader>?
```

---

# ⌨️ Keymaps

## Básicos

| Keymap | Ação |
|---|---|
| `<leader>w` | Salvar arquivo |
| `<leader>q` | Sair |
| `<Esc>` | Limpar highlight da busca |
| `<leader>?` | Keymaps locais do buffer |

## Find — `<leader>f`

| Keymap | Ação |
|---|---|
| `<leader>ff` | Buscar arquivos |
| `<leader>fg` | Buscar texto com grep |
| `<leader>fr` | Arquivos recentes |
| `<leader>fc` | Comandos do Neovim |
| `<leader>fp` | Todos os pickers |
| `<leader>ft` | Buscar TODOs |

## Buffers — `<leader>b`

| Keymap | Ação |
|---|---|
| `<leader>bb` | Listar buffers |
| `<leader>bd` | Fechar buffer atual |
| `<leader>bo` | Fechar outros buffers não modificados |

## Git — `<leader>g`

| Keymap | Ação |
|---|---|
| `<leader>gp` | Preview do hunk atual |

## Harpoon — `<leader>h`

| Keymap | Ação |
|---|---|
| `<leader>ha` | Adicionar arquivo |
| `<leader>hm` | Abrir menu |
| `<leader>hn` | Próximo arquivo |
| `<leader>hp` | Arquivo anterior |
| `<C-e>` | Menu rápido |
| `<C-1>` … `<C-4>` | Abrir itens 1 a 4 |

Dentro do menu:

| Keymap | Ação |
|---|---|
| `<C-v>` | Abrir em split vertical |
| `<C-x>` | Abrir em split horizontal |

## LSP — `<leader>l`

| Keymap | Ação |
|---|---|
| `<leader>la` | Code action |
| `<leader>ld` | Diagnóstico da linha |
| `<leader>li` | Alternar inlay hints, quando suportado |
| `<leader>lr` | Renomear símbolo |
| `<leader>ls` | Signature help |
| `<leader>lh` | C++: alternar source/header com clangd |
| `gd` | Definição |
| `gD` | Declaração |
| `K` | Hover / documentação |
| `gri` | Implementação (nativo do Neovim) |
| `grr` | Referências (nativo do Neovim) |
| `]d` | Próximo diagnóstico |
| `[d` | Diagnóstico anterior |

Em C++, os inlay hints do clangd são habilitados automaticamente e podem ser desligados com `<leader>li`.

## Debug — `<leader>d`

| Keymap | Ação |
|---|---|
| `<leader>db` | Alternar breakpoint |
| `<leader>dB` | Breakpoint condicional |
| `<leader>dc` | Iniciar / continuar |
| `<leader>de` | Avaliar expressão sob o cursor ou seleção |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dl` | Repetir última sessão |
| `<leader>dr` | Abrir / fechar REPL |
| `<leader>dt` | Encerrar debug |
| `<leader>du` | Abrir / fechar DAP View |

## Plugins — `<leader>p`

| Keymap | Ação |
|---|---|
| `<leader>pu` | Atualizar plugins |

## Outros

| Keymap | Ação |
|---|---|
| `<leader>.d` | Abrir dashboard |
| `<leader>o` | Abrir Oil |
| `<leader>i` | Visualizar imagem |
| `J` / `K` em visual | Mover seleção |
| `<` / `>` em visual | Indentar mantendo seleção |
| `D` em visual | Duplicar seleção |
| `<Esc>` no terminal | Voltar ao Normal mode |

---

## C++

O suporte C++ é dividido em quatro partes independentes:

```text
clangd        → LSP / diagnósticos / completion / navegação
Treesitter    → parsing / highlight / indentação
clang-format  → formatação
lldb-dap      → debugging
```

### clangd

O servidor é configurado diretamente pela API nativa do Neovim:

```text
filetypes: c, cpp
flags:
  --background-index
  --clang-tidy
  --completion-style=detailed
```

O filetype `c` também é aceito porque headers `.h` são detectados dessa forma pelo Neovim. Assim, esses headers
continuam com clangd mesmo quando fazem parte de um projeto C++.

Não são forçados `-std=c++17`, `-std=c++20`, includes ou defines globais. Essas opções pertencem ao projeto e devem vir da compilação real.

Para projetos C++ reais, prefira um `compile_commands.json`. O clangd usa essa base para entender includes, defines, standard da linguagem e demais flags do compilador.

Com CMake:

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build
```

O clangd procura `compile_commands.json` nos diretórios ancestrais do arquivo e também em diretórios `build/`.

Projetos simples também podem usar `compile_flags.txt`. Para customizações compartilhadas específicas do clangd, use um arquivo `.clangd` no projeto.

### Completion

Não existe configuração especial de completion para C++. O Blink já usa a source `lsp`; quando o clangd se conecta, completion, signatures e sugestões C++ entram automaticamente no mesmo pipeline.

### Inlay hints

O clangd fornece hints como nomes de parâmetros e tipos deduzidos. Para C++, eles são ativados automaticamente pelo cliente nativo do Neovim.

```text
<leader>li  → ligar/desligar hints
```

### Source / header

O clangd possui uma extensão própria para alternar entre implementação e header correspondente:

```text
<leader>lh
```

### Treesitter

Parsers instalados:

```text
lua
c
cpp
vim
vimdoc
query
```

Os parsers `c` e `cpp` são instalados para que headers `.h`, normalmente detectados como `c`, também tenham
highlight e indentação via Treesitter.

### Formatação

```text
Lua     → StyLua
C / C++ → clang-format
```

O Conform executa `clang-format` ao salvar arquivos `c` ou `cpp`. O nome do arquivo é repassado ao formatter,
portanto um `.clang-format` existente no projeto é respeitado.

Se o formatter externo não estiver disponível, `lsp_format = "fallback"` permite usar a capacidade de formatação do LSP quando disponível.

Para inspecionar o formatter ativo:

```vim
:ConformInfo
```

### Debug

```text
nvim-dap
   ↓
lldb-dap
   ↓
executável C++

nvim-dap-view
   ↓
watches · scopes · breakpoints · threads · REPL
```

Há duas configurações:

- **Executar programa C++**;
- **Anexar a processo C++**.

Para gerar um executável adequado a debugging:

```bash
clang++ -g -O0 main.cpp -o main
```

ou:

```bash
g++ -g -O0 main.cpp -o main
```

O DAP View abre e fecha automaticamente com a sessão, exibe controles no winbar e mostra variáveis com virtual text inline.

---

## Lua

Lua continua usando:

```text
lua-language-server → LSP
StyLua              → formatter
Treesitter lua      → parsing
```

O LuaLS conhece o runtime LuaJIT e a biblioteca da API do Neovim. A formatação interna do servidor fica desativada para evitar conflito com StyLua.

`.stylua.toml`:

```toml
syntax = "LuaJIT"
column_width = 120
indent_type = "Spaces"
indent_width = 4
quote_style = "AutoPreferDouble"
```

---

## Diagnósticos

A configuração global de diagnósticos usa:

- virtual text;
- signs;
- underline;
- ordenação por severidade;
- float com borda arredondada;
- atualização desativada durante Insert mode.

---

## Opções importantes

```text
line numbers        absolute
indent              4 espaços
expandtab           ligado
wrap                desligado
scrolloff           8 linhas
clipboard           unnamedplus
undo persistente    ligado
swapfile            desligado
search              ignorecase + smartcase
updatetime          200 ms
timeoutlen           500 ms
floating borders    rounded
```

A numeração permanece absoluta (`1`, `2`, `3`...) em qualquer posição do cursor. A cor do gutter acompanha o
modo atual usando a paleta Monokai:

| Modo | Cor |
|---|---|
| Normal | aqua |
| Insert | verde |
| Visual / Select | roxo |
| Replace | vermelho |
| Command | laranja |
| Terminal | amarelo |

---

## Tema

O colorscheme é **Monokai Remastered** com `termguicolors`, background escuro e itálicos habilitados. A Lualine usa `theme = "auto"`, herdando a paleta ativa.

---

## Atualização de plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`.

Para atualizar:

```vim
:packupdate
```

ou:

```text
<leader>pu
```

---

## Instalação

```bash
git clone https://github.com/Bembemm/nvim ~/.config/nvim
```

Ferramentas externas esperadas:

```text
git
curl
tar
tree-sitter >= 0.26.1
cargo
rustc
lua-language-server
stylua
clangd
clang-format
lldb-dap
rg
clang++ ou g++
```

Verificações úteis:

```vim
:checkhealth
:checkhealth vim.lsp
:checkhealth which-key
:ConformInfo
```

---

## CI

O workflow de CI executa três níveis de validação:

1. `stylua --check .` para garantir a formatação Lua;
2. carregamento de todos os arquivos `.lua` com `loadfile()` para detectar erros de sintaxe;
3. um smoke test headless que inicia a configuração real com Neovim 0.12, instala os plugins via `vim.pack` e carrega um arquivo comum.

O smoke test usa diretórios XDG temporários, portanto não depende de estado pré-existente do runner.

---

## Filosofia

> **Uma base pequena, compreensível e fácil de evoluir conforme novas necessidades aparecem.**

Cada camada tem uma responsabilidade:

```text
Blink       → completion
LSP         → inteligência de código
Treesitter  → parsing / highlight / indentação
Conform     → formatação
DAP         → debugging
```

Adicionar uma linguagem não significa instalar uma distribuição inteira de plugins. A configuração adiciona apenas as ferramentas necessárias para aquela linguagem.

---

<div align="center">

**Neovim · Lua · C++ · clangd · LLDB · vim.pack · Blink · Snacks · Which-Key · Monokai Remastered**

</div>