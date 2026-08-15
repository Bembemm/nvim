<div align="center">

# ✨ Neovim

**Uma configuração moderna, pequena e direta ao ponto.**

Lua · C++ · Neovim 0.12+ · `vim.pack` · Blink v2 · Snacks · Overseer · LLDB · Monokai Remastered

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-LuaJIT-2C2D72?logo=lua&logoColor=white)
![C++](https://img.shields.io/badge/C%2B%2B-clangd-00599C?logo=cplusplus&logoColor=white)
![Plugins](https://img.shields.io/badge/plugins-vim.pack-6E56CF)
![Build](https://img.shields.io/badge/build-Overseer-F7D51D)
![Debug](https://img.shields.io/badge/debug-LLDB-6E56CF)
![Theme](https://img.shields.io/badge/theme-Monokai%20Remastered-F4005F)
[![CI](https://github.com/Bembemm/nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/Bembemm/nvim/actions/workflows/ci.yml)

</div>

---

## Visão geral

Esta configuração segue uma regra simples: **usar o máximo possível das APIs nativas do Neovim e adicionar plugins apenas quando eles resolvem um problema real**.

As linguagens configuradas atualmente são **Lua** e **C++**. Cada camada continua independente: LSP cuida da inteligência de código, Treesitter do parsing, Conform da formatação, Overseer de build/run e DAP do debugging.

### Stack

- **Neovim 0.12+**
- plugins com **`vim.pack`**
- completion com **Blink.cmp v2**
- LSP nativo com **`vim.lsp.config()`** e **`vim.lsp.enable()`**
- Lua com **lua-language-server + StyLua**
- C++ com **clangd + clang-format + Treesitter cpp**
- build e execução de C++ com **Overseer + clang++**
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
    ├── overseer.lua
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
| **clang++** | build automático de C++ pelo Overseer |
| **lldb-dap** | debugging de C++ |
| **ripgrep (`rg`)** | grep e busca de TODOs |
| **Nerd Font** | ícones da interface |

As ferramentas externas devem estar disponíveis no `PATH`. Quando `lua-language-server`, `clangd` ou `lldb-dap`/`lldb-vscode` não são encontrados, a configuração continua iniciando e mostra uma notificação com o recurso que foi desativado. O build C++ do Overseer requer `clang++`.

A GUI usa, quando disponível:

```text
Iosevka Nerd Font 14
```

---

## Plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`. A configuração evita sobreposição desnecessária: cada plugin tem uma responsabilidade específica e, quando possível, integra-se às APIs nativas do Neovim.

### Visão rápida

| Categoria | Plugins |
|---|---|
| **Completion e código** | Blink.cmp, blink.lib, nvim-treesitter, conform.nvim |
| **Build / Run** | overseer.nvim |
| **Debug** | nvim-dap, nvim-dap-view |
| **Navegação** | snacks.nvim, oil.nvim, Harpoon 2 |
| **Git** | gitsigns.nvim |
| **Edição** | mini.pairs, nvim-surround, todo-comments.nvim |
| **Interface** | Which-Key, indent-blankline, Lualine, nvim-web-devicons, Smear Cursor |
| **Tema** | Monokai Remastered |
| **Bibliotecas** | plenary.nvim |

### Completion e código

#### Blink.cmp

É o motor de completion da configuração. Ele reúne em uma única interface sugestões vindas de LSP, caminhos de arquivos, snippets e conteúdo do buffer.

A configuração também habilita signature help, documentação automática e ícones/tipos no menu de completion. Quando `clangd` ou `lua-language-server` estão conectados pelo LSP nativo, suas sugestões entram no Blink pela source `lsp`.

#### blink.lib

Biblioteca usada pelo Blink.cmp v2. Ela faz parte da infraestrutura do sistema de completion e não possui configuração separada neste repositório.

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

A configuração inicia o Treesitter através da API nativa `vim.treesitter.start()` quando um desses filetypes é aberto e usa o `indentexpr` fornecido pelo próprio nvim-treesitter.

#### conform.nvim

Centraliza a formatação automática dos arquivos.

```text
Lua     → StyLua
C / C++ → clang-format
```

A formatação acontece ao salvar. Caso o formatter externo não esteja disponível e o servidor LSP ofereça formatação, o Conform pode usar o LSP como fallback.

### Build e execução

#### overseer.nvim

O Overseer é o task runner da configuração. Para exercícios C++ de arquivo único ele usa o `.cpp` aberto no buffer atual, salva o arquivo se houver alterações, chama `clang++` e gera o executável na mesma pasta com o mesmo nome sem a extensão.

Exemplos:

```text
/home/user/teste/main.cpp   → /home/user/teste/main
/tmp/learncpp/hello.cpp     → /tmp/learncpp/hello
```

Flags usadas no build:

```text
-std=c++20
-Wall
-Wextra
-Wpedantic
-g
-O0
```

O fluxo de execução é:

```text
arquivo.cpp
    ↓
Overseer: C++ Build
    ↓
clang++
    ↓
    ├── falhou → Quickfix / diagnostics e para
    └── sucesso
           ↓
      Overseer: C++ Run
           ↓
       executável
```

Atalhos:

```text
<leader>rb  build do C++ atual
<leader>rr  build + run
<leader>rt  escolher/executar uma task
<leader>ru  abrir/fechar a lista de tasks
<leader>rl  repetir a task mais recente
```

`<leader>rr` abre a saída do programa em um terminal horizontal dentro do Neovim. O terminal entra em Insert mode para permitir entrada com `std::cin`.

A task registrada como **C++ Build** também é usada pelo DAP como `preLaunchTask`, permitindo build automático antes de iniciar uma nova sessão de debug.

### Debug

#### nvim-dap

Implementa o cliente Debug Adapter Protocol usado para debugging de C++.

A configuração procura `lldb-dap` e usa `lldb-vscode` como fallback. O fluxo principal de launch é **Build e depurar C++**:

```text
<leader>dc
    ↓
Overseer: C++ Build
    ↓
clang++
    ↓
    ├── falhou → debugger não inicia
    └── sucesso
           ↓
        lldb-dap
           ↓
          DAP
```

O executável é resolvido automaticamente a partir do arquivo aberto:

```text
${fileDirname}/${fileBasenameNoExtension}
```

Assim não é necessário informar manualmente o caminho do executável a cada sessão.

Também existe a configuração **Anexar a processo C++** para attach em um processo já em execução.

O DAP fornece breakpoints, breakpoints condicionais, step into, step over, step out, continue, terminate e REPL. Os comandos ficam agrupados em `<leader>d`.

#### nvim-dap-view

É a interface visual sobre o `nvim-dap`. Exibe informações da sessão de debug como scopes, variáveis, breakpoints, threads e REPL.

A interface abre e fecha automaticamente junto da sessão, possui controles no winbar e mostra valores através de virtual text inline.

### Navegação

#### snacks.nvim

É o principal conjunto de ferramentas de interface e navegação da configuração. Atualmente fornece dashboard, picker de arquivos, grep, arquivos recentes, lista de buffers, comandos, projetos, status Git, notificações e visualização de imagens.

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

Substitui o explorador de arquivos padrão por uma interface baseada em buffers. Arquivos ocultos são exibidos por padrão.

```text
<leader>o  → abrir Oil
```

#### Harpoon 2

Mantém uma pequena lista de arquivos escolhidos para acesso rápido durante o trabalho atual.

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

Integra informações do Git diretamente aos buffers e fornece preview do hunk atual:

```text
<leader>gp  → preview do hunk
```

### Edição

#### mini.nvim / mini.pairs

O repositório `mini.nvim` é usado somente através do módulo `mini.pairs`. Ele insere pares automaticamente durante a digitação em Insert mode.

#### nvim-surround

Permite adicionar, trocar ou remover delimitadores ao redor de texto já existente.

#### todo-comments.nvim

Destaca comentários especiais como `TODO`, `FIX`, `HACK` e similares. A busca é integrada ao picker do Snacks:

```text
<leader>ft  → buscar TODOs
```

### Interface

#### which-key.nvim

Organiza e apresenta os grupos de keymaps associados ao Leader.

```text
<leader>b  Buffers
<leader>d  Debug
<leader>f  Find
<leader>g  Git
<leader>h  Harpoon
<leader>l  LSP
<leader>p  Plugins
<leader>r  Run
```

A interface usa o preset `modern`, bordas arredondadas e delay de 200 ms.

#### indent-blankline.nvim

Exibe guias visuais de indentação e do escopo atual reutilizando highlights do colorscheme.

#### lualine.nvim

Fornece a statusline, com ícones habilitados e tema integrado à paleta Monokai.

#### nvim-web-devicons

Fornece ícones para arquivos e elementos da interface. A configuração pressupõe o uso de uma Nerd Font.

#### smear-cursor.nvim

Adiciona animação visual ao movimento do cursor. Pode ser alternado com:

```vim
:SmearCursorToggle
```

### Tema

#### monokai_remastered.nvim

Fornece o colorscheme **Monokai Remastered** com a paleta `classic`, itálicos e pequenas customizações de cor.

### Bibliotecas

#### plenary.nvim

Biblioteca usada como infraestrutura pela stack do Harpoon 2.

---

## Dashboard

O dashboard do Snacks usa `lua/core/dashboard.lua` como fonte única para informações do sistema. O rodapé mostra quantos plugins gerenciados pelo `vim.pack` estão ativos e o tempo gasto desde o início da configuração.

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
<leader>r  Run
```

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

## Janelas e terminal

A configuração usa os keymaps nativos do Neovim para navegar entre splits:

| Keymap | Ação |
|---|---|
| `<C-w>h` | Ir para a janela à esquerda |
| `<C-w>j` | Ir para a janela abaixo |
| `<C-w>k` | Ir para a janela acima |
| `<C-w>l` | Ir para a janela à direita |
| `<C-w>w` | Alternar para a próxima janela |
| `<Esc>` no terminal | Voltar ao Normal mode |

Quando o terminal do Overseer estiver em Insert mode, pressione `<Esc>` primeiro e depois use `<C-w>h/j/k/l` para trocar de janela.

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

## Run — `<leader>r`

| Keymap | Ação |
|---|---|
| `<leader>rb` | Build do arquivo C++ atual |
| `<leader>rr` | Build e executar o arquivo C++ atual |
| `<leader>rt` | Escolher e executar uma task do Overseer |
| `<leader>ru` | Abrir / fechar a lista de tasks do Overseer |
| `<leader>rl` | Repetir a task mais recente |

Para o uso diário em exercícios C++:

```text
<leader>rr  → quero compilar e rodar
<leader>dc  → quero compilar e debugar
```

## Debug — `<leader>d`

| Keymap | Ação |
|---|---|
| `<leader>db` | Alternar breakpoint |
| `<leader>dB` | Breakpoint condicional |
| `<leader>dc` | Iniciar com Build automático / continuar sessão |
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

---

## C++

O suporte C++ é dividido em cinco partes independentes:

```text
clangd        → LSP / diagnósticos / completion / navegação
Treesitter    → parsing / highlight / indentação
clang-format  → formatação
Overseer      → build / run / tasks
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

O filetype `c` também é aceito porque headers `.h` são detectados dessa forma pelo Neovim. Não são forçados standard, includes ou defines globais no LSP; essas opções pertencem ao projeto e devem vir da compilação real.

Para projetos C++ maiores, prefira um `compile_commands.json`. O clangd usa essa base para entender includes, defines, standard da linguagem e demais flags do compilador.

### Completion

Não existe configuração especial de completion para C++. O Blink já usa a source `lsp`; quando o clangd se conecta, completion, signatures e sugestões C++ entram automaticamente no mesmo pipeline.

### Inlay hints

```text
<leader>li  → ligar/desligar hints
```

### Source / header

```text
<leader>lh  → alternar entre implementação e header correspondente
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

### Formatação

```text
Lua     → StyLua
C / C++ → clang-format
```

O Conform executa `clang-format` ao salvar arquivos `c` ou `cpp`. Um `.clang-format` existente no projeto é respeitado.

Para inspecionar o formatter ativo:

```vim
:ConformInfo
```

### Build / Run

Para exercícios C++ de arquivo único, o Overseer compila diretamente o buffer atual:

```text
main.cpp
   ↓
clang++ -std=c++20 -Wall -Wextra -Wpedantic -g -O0
   ↓
main
```

O executável fica na mesma pasta do source. O fluxo atual é propositalmente simples e adequado para exercícios de arquivo único. Projetos com múltiplos `.cpp` devem usar uma task de projeto/build system em vez de compilar somente o buffer atual.

### Debug

```text
Overseer: C++ Build
        ↓
     clang++
        ↓
     lldb-dap
        ↓
     nvim-dap
        ↓
  nvim-dap-view
```

Ao iniciar uma nova sessão com `<leader>dc`, o DAP usa `preLaunchTask = "C++ Build"`. O Overseer salva e compila o `.cpp` atual; se o build falhar, o debugger não inicia. Se o build terminar com sucesso, o LLDB recebe automaticamente o executável correspondente ao arquivo aberto.

Depois que a sessão já está ativa, `<leader>dc` volta ao comportamento normal de **Continue**.

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

A configuração global de diagnósticos usa virtual text, signs, underline, ordenação por severidade, float com borda arredondada e atualização desativada durante Insert mode.

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

A numeração permanece absoluta em qualquer posição do cursor. A cor do gutter acompanha o modo atual usando a paleta Monokai.

---

## Tema

O colorscheme é **Monokai Remastered** com `termguicolors`, background escuro e itálicos habilitados.

---

## Atualização de plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`.

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
clang++
lldb-dap
rg
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

---

## Filosofia

> **Uma base pequena, compreensível e fácil de evoluir conforme novas necessidades aparecem.**

Cada camada tem uma responsabilidade:

```text
Blink       → completion
LSP         → inteligência de código
Treesitter  → parsing / highlight / indentação
Conform     → formatação
Overseer    → build / run / tasks
DAP         → debugging
```

Adicionar uma linguagem não significa instalar uma distribuição inteira de plugins. A configuração adiciona apenas as ferramentas necessárias para aquela linguagem.

---

<div align="center">

**Neovim · Lua · C++ · clangd · Overseer · LLDB · vim.pack · Blink · Snacks · Which-Key · Monokai Remastered**

</div>