<div align="center">

# ✨ Neovim

**Uma configuração moderna, poderosa e curada, com plugins especializados e uma UI limpa e coesa.**

Lua · C++ · Neovim 0.12+ · `vim.pack` · Blink v2 · Snacks · Noice · Gitsigns · Trouble · Overseer · LLDB · Monokai Pro

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-LuaJIT-2C2D72?logo=lua&logoColor=white)
![C++](https://img.shields.io/badge/C%2B%2B-clangd-00599C?logo=cplusplus&logoColor=white)
![Plugins](https://img.shields.io/badge/plugins-vim.pack-6E56CF)
![Build](https://img.shields.io/badge/build-Overseer-F7D51D)
![Debug](https://img.shields.io/badge/debug-LLDB-6E56CF)
![Git](https://img.shields.io/badge/git-Gitsigns-F05032?logo=git&logoColor=white)
![Theme](https://img.shields.io/badge/theme-Monokai%20Pro-F4005F)
[![CI](https://github.com/Bembemm/nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/Bembemm/nvim/actions/workflows/ci.yml)

</div>

---

## Visão geral

Esta configuração não busca ser minimalista em quantidade de recursos. A proposta é **escolher ferramentas fortes para cada função, evitar sobreposições desnecessárias e integrar tudo em uma experiência única**.

As APIs nativas do Neovim são usadas sempre que oferecem a base necessária; plugins entram quando adicionam uma experiência claramente melhor ou uma função especializada.

As linguagens configuradas atualmente são **Lua** e **C++**.

### Responsabilidades

```text
Blink          → completion
LSP nativo     → inteligência de código
Treesitter     → parsing / highlight / indentação
Conform        → formatação
nvim-autopairs → pares durante a digitação
nvim-surround  → edição de delimitadores existentes
live-rename    → rename LSP interativo

Snacks         → dashboard / picker / notifier / indent / imagens
Noice          → cmdline / mensagens / UI de LSP
Which-Key      → descoberta e organização de atalhos
Lualine        → status global do editor
Dropbar        → contexto estrutural / breadcrumbs
Trouble        → painéis de diagnósticos / símbolos / quickfix
Scrollview     → visão vertical de sinais pelo arquivo

Gitsigns       → ações Git no buffer / hunks / blame / diff
Harpoon        → working set de arquivos frequentes
Oil            → filesystem como buffer editável
mini.jump2d    → saltos rápidos dentro da interface

CCC            → visualização / edição / conversão de cores
Overseer       → build / run / tasks
DAP            → debugging
DAP View       → interface de debugging
```

### Como as sobreposições são evitadas

Algumas ferramentas atuam sobre o mesmo domínio, mas em **camadas diferentes**:

```text
Git
├── Gitsigns   → ações e contexto por linha/hunk
├── Scrollview → localização das mudanças no arquivo inteiro
└── Lualine    → resumo de additions / changes / deletions

Diagnósticos
├── LSP        → produz os diagnósticos
├── buffer     → virtual text / signs / underline
├── Scrollview → localização vertical
├── Lualine    → resumo
└── Trouble    → exploração em painel

Navegação
├── Dropbar    → contexto estrutural atual
├── Harpoon    → arquivos ativos/frequentes
├── Snacks     → descoberta fuzzy
├── Oil        → filesystem
└── Jump2D     → movimento rápido na tela

Completion / UI
├── Blink      → completion de LSP / path / snippets / buffer
└── Noice      → cmdline, mensagens, hover/signature e apresentação de UI
```

A signature automática do Blink permanece desativada; a apresentação de signature fica com o Noice, evitando duas interfaces concorrentes.

---

## Stack

- **Neovim 0.12+**
- plugins com **`vim.pack`**
- completion com **Blink.cmp v2**
- LSP nativo com **`vim.lsp.config()`** e **`vim.lsp.enable()`**
- Lua com **lua-language-server + StyLua**
- C++ com **clangd + clang-format + Treesitter cpp**
- formatação com **conform.nvim**
- pares automáticos com **nvim-autopairs**
- rename LSP com **live-rename.nvim**
- Git com **gitsigns.nvim**
- busca / dashboard / notifier / indent / imagens com **Snacks**
- cmdline e mensagens com **Noice**
- diagnósticos e símbolos em painel com **Trouble**
- contexto estrutural com **Dropbar**
- overview vertical com **nvim-scrollview**
- build e execução C++ com **Overseer + clang++**
- debugging C++ com **nvim-dap + lldb-dap**
- UI de debug com **nvim-dap-view**
- cores com **ccc.nvim**
- explorer com **Oil**
- arquivos frequentes com **Harpoon 2**
- saltos rápidos com **mini.jump2d**
- atalhos organizados com **Which-Key v3**
- visualização de teclas com **Screenkey**
- animação do cursor com **Smear Cursor**
- tema **Monokai Pro**, filtro `classic`

---

## Estrutura

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── .gitignore
├── .stylua.toml
├── init.lua
├── README.md
├── lua/
│   └── core/
│       ├── dashboard.lua
│       ├── keymaps.lua
│       ├── options.lua
│       └── plugins.lua
├── after/
│   └── plugin/
│       └── noice.lua
└── plugin/
    ├── autopairs.lua
    ├── blink.lua
    ├── ccc.lua
    ├── colorscheme.lua
    ├── conform.lua
    ├── dap.lua
    ├── devicons.lua
    ├── dropbar.lua
    ├── gitsigns.lua
    ├── harpoon.lua
    ├── live-rename.lua
    ├── lsp.lua
    ├── lualine.lua
    ├── mini.lua
    ├── mode-line-numbers.lua
    ├── oil.lua
    ├── overseer.lua
    ├── screenkey.lua
    ├── scrollview.lua
    ├── smear-cursor.lua
    ├── snacks.lua
    ├── surround.lua
    ├── todo.lua
    ├── treesitter.lua
    ├── trouble.lua
    └── which-key.lua
```

`init.lua` permanece pequeno de propósito. A declaração dos plugins fica centralizada em `lua/core/plugins.lua`; os arquivos em `plugin/` configuram cada componente, e o Noice é configurado em `after/plugin/` para carregar depois das dependências de UI.

---

## Requisitos

| Dependência | Uso |
|---|---|
| **Neovim 0.12+** | APIs modernas da configuração |
| **Git** | instalação dos plugins e recursos Git |
| **curl** | download de parsers do Treesitter |
| **tar** | extração dos parsers |
| **tree-sitter-cli >= 0.26.1** | geração/compilação de parsers |
| **Rust toolchain (`cargo` + `rustc`)** | compilação do fuzzy matcher do Blink v2 |
| **lua-language-server** | LSP para Lua |
| **StyLua** | formatação de Lua |
| **clangd** | LSP para C/C++ |
| **clang-format** | formatação de C/C++ |
| **clang++** | build C++ pelo Overseer |
| **lldb-dap** ou **lldb-vscode** | debugging de C++ |
| **ripgrep (`rg`)** | grep e busca de TODOs |
| **Nerd Font** | ícones da interface |

As ferramentas externas devem estar disponíveis no `PATH`. Quando `lua-language-server`, `clangd` ou `lldb-dap`/`lldb-vscode` não são encontrados, a configuração continua iniciando e notifica qual recurso foi desativado.

A GUI usa, quando disponível:

```text
Iosevka Nerd Font 14
```

Quando o Neovim roda em terminal, a fonte é controlada pelo próprio terminal.

---

## Plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`.

| Categoria | Plugins |
|---|---|
| **Completion / código** | Blink.cmp, blink.lib, nvim-treesitter, conform.nvim, live-rename.nvim |
| **Edição** | nvim-autopairs, nvim-surround, todo-comments.nvim |
| **LSP / diagnósticos** | LSP nativo, Trouble |
| **Git** | gitsigns.nvim |
| **Build / Run** | overseer.nvim |
| **Debug** | nvim-dap, nvim-dap-view |
| **Navegação** | mini.jump2d, Snacks, Oil, Harpoon 2, Dropbar |
| **Interface** | Noice, Which-Key, Lualine, nvim-scrollview, Screenkey, nvim-web-devicons, Smear Cursor |
| **Cores** | ccc.nvim |
| **Tema** | monokai-pro.nvim |
| **Bibliotecas / helpers** | plenary.nvim, nui.nvim |

---

## Completion e edição

### Blink.cmp

Blink é o motor de completion e reúne sugestões de:

```text
LSP
paths
snippets
buffer
```

A documentação da completion abre automaticamente com borda arredondada. A signature do Blink está desativada para não duplicar a UI de signature fornecida pelo Noice.

### nvim-autopairs

Cuida da criação de pares durante a digitação. O plugin é desativado em interfaces onde pares automáticos seriam indesejados, como picker/input do Snacks, Noice e DAP REPL.

```text
<leader>pa  ligar/desligar autopairs
```

### nvim-surround

Cuida de adicionar, alterar e remover delimitadores **em texto já existente**. Ele complementa o Autopairs em vez de substituir sua função.

### live-rename.nvim

O rename LSP usa uma interface interativa com destaque das outras ocorrências.

```text
<leader>lr  renomear símbolo
```

---

## Treesitter

Parsers instalados:

```text
lua
c
cpp
vim
vimdoc
query
bash
regex
markdown
markdown_inline
```

Ao abrir um filetype correspondente, Treesitter inicia o parsing e fornece também a expressão de indentação.

Depois da instalação ou atualização do `nvim-treesitter`, o `PackChanged` do `init.lua` executa `TSUpdate` para manter os parsers sincronizados.

---

## Formatação

### conform.nvim

Formatação automática ao salvar:

```text
Lua     → StyLua
C / C++ → clang-format
```

O LSP fica disponível como fallback quando necessário.

---

## Git

### gitsigns.nvim

Gitsigns é a camada de **ações Git dentro do buffer**. O Scrollview continua responsável pela visão global das mudanças no arquivo e a Lualine pelo resumo de diff.

Configuração visual:

```text
signcolumn          ligada
numhl               ligado
linehl              desligado
word diff           desligado por padrão
current line blame  desligado por padrão
```

`numhl` colore os números apenas onde existe estado Git; os demais números continuam seguindo as cores dinâmicas do modo atual. `linehl` permanece desligado para não competir com `cursorline` e com os highlights do código.

### Navegação entre hunks

```text
]h  próximo hunk
[h  hunk anterior
```

### Stage / reset

```text
<leader>gs  stage/unstage do hunk
<leader>gr  reset do hunk
```

Os mesmos atalhos funcionam em Visual mode e operam somente sobre a seleção.

### Inspeção

```text
<leader>gp  preview do hunk em float
<leader>gi  preview inline
<leader>gb  blame completo da linha
<leader>gB  ligar/desligar blame inline
```

O blame inline fica desligado normalmente para preservar a UI limpa e é ativado somente quando necessário.

### Diff

```text
<leader>gd  diff do arquivo
<leader>gD  diff contra a revisão anterior
```

### Word diff

```text
<leader>gw  ligar/desligar word diff
```

O recurso fica desligado por padrão e pode ser ativado durante revisão de alterações para destacar diferenças dentro da própria linha.

### Text object

```text
ih  selecionar hunk
```

Funciona em Visual e Operator-pending, permitindo compor operações Vim com o hunk atual.

---

## UI

### Monokai Pro

O tema principal é `monokai-pro` com filtro `classic`.

A paleta do próprio tema é reutilizada por componentes customizados para manter a interface coerente. Entre eles:

- Lualine;
- números de linha por modo;
- indent guides do Snacks;
- scope/chunk do Snacks.

Os números de linha mudam de cor conforme o modo atual:

```text
Normal   → accent5
Insert   → accent4
Visual   → accent6
Replace  → accent1
Command  → accent2
Terminal → accent3
```

Gitsigns pode sobrescrever localmente a cor do número nas linhas modificadas quando `numhl` está ativo, adicionando estado Git sem remover a identidade visual do restante do buffer.

### Snacks

Snacks centraliza várias peças de UI:

- dashboard;
- picker;
- input;
- notifier;
- indent guides;
- scope/chunk;
- imagens.

O dashboard mostra informações do sistema, versão do Neovim, plugins ativos, tempo da configuração, arquivos recentes, projetos e estado Git.

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

### Noice

Noice cuida da camada de mensagens e cmdline:

- cmdline popup;
- mensagens e histórico;
- warnings/errors;
- LSP progress;
- hover;
- signature;
- popupmenu.

As notificações usam o backend do Snacks, mantendo uma única linguagem visual.

```text
<leader>nn  histórico
<leader>np  picker
<leader>nl  última mensagem
<leader>ne  erros
<leader>nd  dispensar mensagens
```

### Lualine

A statusline reúne:

```text
mode
branch
git diff
filename
macro recording
DAP
Overseer
diagnostics
LSP
filetype
progress
location
```

As cores são derivadas dinamicamente da paleta do Monokai Pro. O status do Overseer aparece apenas durante uma task ou por alguns segundos após sua conclusão; DAP aparece apenas durante uma sessão ativa.

### Trouble

Trouble funciona como painel estruturado, sem substituir os diagnósticos inline:

```text
<leader>xx  diagnósticos globais
<leader>xb  diagnósticos do buffer
<leader>xs  símbolos
<leader>xq  quickfix
```

### Dropbar

Dropbar fornece breadcrumbs/contexto estrutural do código:

```text
<leader>;  escolher contexto
[;         início do contexto
];         próximo contexto
```

### Scrollview

Scrollview mostra no scrollbar virtual sinais distribuídos ao longo do arquivo, incluindo diagnósticos e mudanças do Gitsigns.

Janelas especiais como Trouble, Oil, Noice, pickers do Snacks e menus do Dropbar são excluídas para evitar poluição visual.

```text
<leader>vt  ligar/desligar
<leader>vl  legenda
<leader>vj  próximo sinal
<leader>vk  sinal anterior
<leader>vf  primeiro sinal
<leader>ve  último sinal
<leader>vr  atualizar
```

### Screenkey

Screenkey exibe as teclas usadas em uma janela flutuante discreta e ignora navegação simples `h/j/k/l` quando não corresponde a um mapping.

```text
<leader>ks  ligar/desligar Screenkey
```

### Smear Cursor

Adiciona animação ao movimento do cursor sem substituir motions ou keymaps.

---

## Cores

### ccc.nvim

CCC centraliza visualização, edição, criação e conversão de cores. O highlighter mostra um marcador virtual ao lado dos valores reconhecidos sem substituir a cor do texto.

Exemplo:

```text
■ #f92672
■ rgb(102 217 239)
■ hsl(80 76% 53%)
```

A integração com LSP está habilitada.

Espaços de cor disponíveis:

```text
RGB
HSL
HWB
Lab
LCH
OKLab
OKLCH
CMYK
HSLuv
OKHSL
HSV
OKHSV
XYZ
```

Formatos de saída:

```text
HEX / HEX curto
CSS RGB / RGBA
CSS HSL
CSS HWB
CSS Lab / LCH
CSS OKLab / OKLCH
Float
```

Atalhos:

```text
<leader>cp  escolher / editar uma cor
<leader>cc  converter formato da cor
<leader>ct  ligar/desligar highlighter
```

---

## Build e execução

### overseer.nvim

Overseer é o task runner da configuração. Para exercícios C++ de arquivo único ele usa o `.cpp` aberto, salva o arquivo quando necessário, chama `clang++` e gera o executável na mesma pasta com o mesmo nome sem extensão.

Exemplos:

```text
/home/user/teste/main.cpp   → /home/user/teste/main
/tmp/learncpp/hello.cpp     → /tmp/learncpp/hello
```

Flags:

```text
-std=c++20
-Wall
-Wextra
-Wpedantic
-g
-O0
```

Fluxo:

```text
arquivo.cpp
    ↓
Overseer: C++ Build
    ↓
clang++
    ↓
    ├── falhou → quickfix / diagnostics e para
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
<leader>rt  escolher/executar task
<leader>ru  abrir/fechar lista de tasks
<leader>rl  repetir task mais recente
```

`<leader>rr` abre a saída em um terminal horizontal e entra em Insert mode para permitir entrada com `std::cin`.

A task **C++ Build** também é usada pelo DAP como `preLaunchTask`.

---

## Debug

### nvim-dap + LLDB

O adaptador procura primeiro `lldb-dap` e usa `lldb-vscode` como fallback.

Fluxo principal:

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
        LLDB
           ↓
          DAP
```

O executável é resolvido a partir do arquivo aberto:

```text
${fileDirname}/${fileBasenameNoExtension}
```

Também existe a configuração **Anexar a processo C++**.

### nvim-dap-view

Exibe scopes, variáveis, breakpoints, threads, REPL e valores inline. A interface acompanha automaticamente a sessão de debug.

Atalhos:

```text
<leader>db  breakpoint
<leader>dB  breakpoint condicional
<leader>dc  iniciar/continuar
<leader>de  avaliar expressão
<leader>di  step into
<leader>do  step over
<leader>dO  step out
<leader>dl  repetir última sessão
<leader>dr  REPL
<leader>dt  encerrar
<leader>du  DAP View
```

---

## Navegação

### mini.jump2d

Jump2D fornece saltos label-first para palavras, linhas e caracteres.

Labels:

```text
asdfghjklqwertyuiopzxcvbnm
```

O mapping padrão do módulo foi desabilitado para não interferir em Enter/tags/help/quickfix.

```text
<leader>jj  início de palavra
<leader>jl  início de linha
<leader>jc  caractere
```

Os três funcionam em **Normal**, **Visual** e **Operator-pending**.

### Oil

Oil é o explorador padrão e mostra arquivos ocultos.

```text
<leader>o  abrir Oil
```

### Harpoon 2

```text
<leader>ha      adicionar arquivo
<leader>hm      abrir menu
<leader>hn      próximo
<leader>hp      anterior
<C-e>           menu rápido
<C-1>…<C-4>     itens 1 a 4
```

No menu:

```text
<C-v>  split vertical
<C-x>  split horizontal
```

### Janelas / splits

```text
<leader><Left>   janela à esquerda
<leader><Down>   janela abaixo
<leader><Up>     janela acima
<leader><Right>  janela à direita
```

Os atalhos nativos `<C-w>h/j/k/l/w` continuam disponíveis.

No terminal, `<Esc>` volta ao Normal mode. Leader + setas não é mapeado diretamente em Terminal mode para evitar atraso ao digitar espaços.

---

## Which-Key

A tecla **Leader é `Space`**.

Grupos registrados:

```text
<leader>b  Buffers
<leader>c  Colors
<leader>d  Debug
<leader>f  Find
<leader>g  Git
<leader>h  Harpoon
<leader>j  Jump
<leader>k  Keys
<leader>l  LSP
<leader>n  Noice
<leader>p  Plugins
<leader>r  Run
<leader>v  Scrollview
<leader>x  Trouble
```

```text
<leader>?  keymaps locais do buffer
```

---

# ⌨️ Keymaps

## Básicos

| Keymap | Ação |
|---|---|
| `<leader>w` | Salvar arquivo |
| `<leader>q` | Sair |
| `<leader>Q` | Sair forçado de todas as janelas |
| `<Esc>` | Limpar highlight da busca |
| `<leader>?` | Keymaps locais do buffer |

## Buffers

| Keymap | Ação |
|---|---|
| `<leader>bb` | Listar buffers |
| `<leader>bd` | Fechar buffer atual |
| `<leader>bo` | Fechar outros buffers não modificados |

## Git

| Keymap | Ação |
|---|---|
| `]h` | Próximo hunk |
| `[h` | Hunk anterior |
| `<leader>gs` | Stage/unstage hunk ou seleção |
| `<leader>gr` | Reset hunk ou seleção |
| `<leader>gp` | Preview do hunk |
| `<leader>gi` | Preview inline |
| `<leader>gb` | Blame completo da linha |
| `<leader>gB` | Toggle blame inline |
| `<leader>gd` | Diff do arquivo |
| `<leader>gD` | Diff contra revisão anterior |
| `<leader>gw` | Toggle word diff |
| `ih` | Text object do hunk |

## Find

| Keymap | Ação |
|---|---|
| `<leader>ff` | Arquivos |
| `<leader>fg` | Grep |
| `<leader>fr` | Recentes |
| `<leader>fc` | Comandos |
| `<leader>fp` | Todos os pickers |
| `<leader>ft` | TODOs |

## LSP

| Keymap | Ação |
|---|---|
| `gd` | Definição |
| `gD` | Declaração |
| `K` | Hover/documentação |
| `<leader>la` | Code action |
| `<leader>ld` | Diagnóstico da linha |
| `<leader>li` | Inlay hints |
| `<leader>lr` | Live rename |
| `<leader>ls` | Signature help |
| `<leader>lh` | C++: source/header |
| `gri` | Implementação, nativo do Neovim |
| `grr` | Referências, nativo do Neovim |
| `]d` | Próximo diagnóstico |
| `[d` | Diagnóstico anterior |

## Run

| Keymap | Ação |
|---|---|
| `<leader>rb` | Build C++ |
| `<leader>rr` | Build + run C++ |
| `<leader>rt` | Executar task |
| `<leader>ru` | Lista de tasks |
| `<leader>rl` | Repetir task |

## Plugins / UI

| Keymap | Ação |
|---|---|
| `<leader>pu` | Atualizar plugins |
| `<leader>pa` | Toggle Autopairs |
| `<leader>ks` | Toggle Screenkey |
| `<leader>.d` | Dashboard |
| `<leader>i` | Visualizar imagem |
| `<leader>o` | Oil |

### Overrides intencionais

Não existem keymaps Leader duplicados conhecidos na configuração atual. Alguns comportamentos nativos são substituídos de propósito:

- `<C-e>` em Normal mode abre o Harpoon;
- `J`, `K` e `D` em Visual mode são usados para edição de seleção;
- `K` em buffers com LSP mostra hover;
- `<Esc>` em Terminal mode volta ao Normal mode.

Os motions nativos `f`, `F`, `t`, `T`, `;`, `,`, `s` e `S` permanecem livres do sistema de saltos.

---

## C++

O suporte C++ é dividido em cinco partes:

```text
clangd        → LSP / diagnósticos / completion / navegação
Treesitter    → parsing / highlight / indentação
clang-format  → formatação
Overseer      → build / run / tasks
LLDB + DAP    → debugging
```

### clangd

```text
filetypes: c, cpp
flags:
  --background-index
  --clang-tidy
  --completion-style=detailed
```

Não são forçados standard, includes ou defines globais no LSP. Para projetos maiores, essas informações devem vir do build real, preferencialmente por `compile_commands.json`.

### Inlay hints

Os hints do clangd são ligados automaticamente quando suportados.

```text
<leader>li  ligar/desligar
```

### Source / header

```text
<leader>lh  alternar source/header
```

### Build / Run

```text
main.cpp
   ↓
clang++ -std=c++20 -Wall -Wextra -Wpedantic -g -O0
   ↓
main
```

O executável fica na mesma pasta do source. Projetos com múltiplos `.cpp` devem usar uma task de projeto/build system em vez de compilar apenas o buffer atual.

### Debug

```text
Overseer: C++ Build
        ↓
     clang++
        ↓
       LLDB
        ↓
     nvim-dap
        ↓
  nvim-dap-view
```

Ao iniciar com `<leader>dc`, o DAP usa `preLaunchTask = "C++ Build"`. Após a sessão começar, o mesmo mapping volta a funcionar como **Continue**.

---

## Lua

```text
lua-language-server → LSP
StyLua              → formatter
Treesitter lua      → parsing
```

`.stylua.toml`:

```toml
syntax = "LuaJIT"
column_width = 120
indent_type = "Spaces"
indent_width = 4
quote_style = "AutoPreferDouble"
```

---

## Opções importantes

```text
line numbers        absolute
indent              4 espaços
expandtab           ligado
wrap                desligado
cursorline          ligado
scrolloff           8 linhas
signcolumn          sempre visível
clipboard           unnamedplus
undo persistente    ligado
swapfile            desligado
search              ignorecase + smartcase
updatetime          200 ms
timeoutlen           500 ms
floating borders    rounded
listchars            ligados
```

---

## Atualização de plugins

```vim
:packupdate
```

ou:

```text
<leader>pu
```

O `init.lua` também observa mudanças no pacote do Treesitter e executa `TSUpdate` após instalação/atualização.

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
lldb-dap ou lldb-vscode
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

O workflow executa:

1. `stylua --check .`;
2. validação de sintaxe dos arquivos Lua com Neovim;
3. instalação do `tree-sitter-cli` usado no smoke test;
4. smoke test headless da configuração completa com Neovim 0.12.

---

## Filosofia

> **Uma configuração curada: recursos poderosos, responsabilidades claras e uma interface consistente.**

O objetivo não é ter poucos plugins por princípio. É evitar plugins ou módulos concorrentes quando uma solução já foi escolhida para aquela responsabilidade.

A configuração favorece:

- APIs modernas do Neovim como fundação;
- plugins especializados quando entregam uma experiência melhor;
- integração entre componentes em vez de ferramentas isoladas;
- recursos avançados sob demanda quando poderiam poluir a UI;
- uma linguagem visual compartilhada pelo tema e pelos principais componentes;
- workflows completos para edição, Git, navegação, build e debug.

---

<div align="center">

**Neovim · Lua · C++ · clangd · Blink · Snacks · Noice · Gitsigns · Trouble · Dropbar · Overseer · LLDB · Monokai Pro**

</div>
