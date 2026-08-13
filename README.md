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
    ├── oil.lua
    ├── snacks.lua
    ├── surround.lua
    ├── todo.lua
    ├── treesitter.lua
    └── which-key.lua
```

`init.lua` permanece pequeno de propósito. A declaração dos plugins fica centralizada em `lua/core/plugins.lua`, enquanto os arquivos em `plugin/` cuidam apenas da configuração de cada plugin.

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

As ferramentas externas devem estar disponíveis no `PATH`.

A GUI usa, quando disponível:

```text
Iosevka Nerd Font 14
```

---

## Plugins

| Plugin | Função |
|---|---|
| **blink.cmp + blink.lib** | completion, snippets, path, buffer e LSP |
| **nvim-treesitter** | parsing, highlight e indentação |
| **conform.nvim** | formatação automática |
| **nvim-dap** | cliente Debug Adapter Protocol |
| **nvim-dap-view** | interface visual de debugging |
| **snacks.nvim** | picker, grep, recentes, comandos, notificações e imagens |
| **oil.nvim** | explorer baseado em buffers |
| **harpoon** | acesso rápido a arquivos frequentes |
| **gitsigns.nvim** | sinais e preview de alterações Git |
| **todo-comments.nvim** | TODO/FIX/HACK/etc. |
| **which-key.nvim** | organização e descoberta dos keymaps |
| **indent-blankline.nvim** | guias de indentação |
| **lualine.nvim** | statusline |
| **nvim-web-devicons** | ícones de arquivos |
| **mini.nvim** | `mini.pairs` |
| **nvim-surround** | manipulação de delimitadores |
| **monokai_remastered.nvim** | colorscheme |
| **plenary.nvim** | dependência do Harpoon 2 |

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
| `gi` | Implementação |
| `gr` | Referências |
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
filetype: cpp
flags:
  --background-index
  --clang-tidy
  --completion-style=detailed
```

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
cpp
vim
vimdoc
query
```

Somente `cpp` foi adicionado; não foi habilitado suporte separado para C.

### Formatação

```text
Lua → StyLua
C++ → clang-format
```

O Conform executa `clang-format` ao salvar arquivos `cpp`. O nome do arquivo é repassado ao formatter, portanto um `.clang-format` existente no projeto é respeitado.

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
line numbers        absolute + relative
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

---

## Tema

O colorscheme é **Monokai Remastered** com `termguicolors`, background escuro e itálicos habilitados. A Lualine usa `theme = "auto"`, herdando a paleta ativa.

---

## Plugins

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
