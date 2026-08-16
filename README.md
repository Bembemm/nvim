<div align="center">

# ✨ Neovim

**Uma configuração moderna, pequena e direta ao ponto.**

Lua · C++ · Neovim 0.12+ · `vim.pack` · Blink v2 · Snacks · mini.jump2d · Overseer · CCC · LLDB · Monokai Remastered

![Neovim](https://img.shields.io/badge/Neovim-0.12+-57A143?logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-LuaJIT-2C2D72?logo=lua&logoColor=white)
![C++](https://img.shields.io/badge/C%2B%2B-clangd-00599C?logo=cplusplus&logoColor=white)
![Plugins](https://img.shields.io/badge/plugins-vim.pack-6E56CF)
![Build](https://img.shields.io/badge/build-Overseer-F7D51D)
![Colors](https://img.shields.io/badge/colors-ccc.nvim-66D9EF)
![Debug](https://img.shields.io/badge/debug-LLDB-6E56CF)
![Theme](https://img.shields.io/badge/theme-Monokai%20Remastered-F4005F)
[![CI](https://github.com/Bembemm/nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/Bembemm/nvim/actions/workflows/ci.yml)

</div>

---

## Visão geral

Esta configuração segue uma regra simples: **usar o máximo possível das APIs nativas do Neovim e adicionar plugins apenas quando eles resolvem um problema real**.

As linguagens configuradas atualmente são **Lua** e **C++**. Cada camada tem uma responsabilidade clara:

```text
Blink        → completion
LSP          → inteligência de código
Treesitter   → parsing / highlight / indentação
mini.jump2d  → saltos label-first em palavras, linhas e caracteres
Conform      → formatação
CCC          → visualização / edição / conversão de cores
Overseer     → build / run / tasks
DAP          → debugging
```

### Stack

- **Neovim 0.12+**
- plugins com **`vim.pack`**
- completion com **Blink.cmp v2**
- LSP nativo com **`vim.lsp.config()`** e **`vim.lsp.enable()`**
- Lua com **lua-language-server + StyLua**
- C++ com **clangd + clang-format + Treesitter cpp**
- cores com **ccc.nvim**
- build e execução C++ com **Overseer + clang++**
- debugging C++ com **nvim-dap + lldb-dap**
- UI de debug com **nvim-dap-view**
- busca de arquivos/texto com **Snacks**
- saltos rápidos por palavra, linha e caractere com **mini.jump2d**
- explorer com **Oil**
- navegação entre arquivos frequentes com **Harpoon 2**
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
    ├── ccc.lua
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

`init.lua` permanece pequeno de propósito. A declaração dos plugins fica centralizada em `lua/core/plugins.lua`, enquanto os arquivos em `plugin/` cuidam da configuração de cada plugin.

---

## Requisitos

| Dependência | Uso |
|---|---|
| **Neovim 0.12+** | APIs modernas da configuração |
| **Git** | instalação e atualização de plugins |
| **curl** | download de parsers do Treesitter |
| **tar** | extração dos parsers |
| **tree-sitter-cli >= 0.26.1** | geração/compilação de parsers |
| **Rust toolchain (`cargo` + `rustc`)** | compilação do fuzzy matcher do Blink v2 |
| **lua-language-server** | LSP para Lua |
| **StyLua** | formatação de Lua |
| **clangd** | LSP para C/C++ |
| **clang-format** | formatação de C/C++ |
| **clang++** | build automático C++ pelo Overseer |
| **lldb-dap** | debugging de C++ |
| **ripgrep (`rg`)** | grep e busca de TODOs |
| **Nerd Font** | ícones da interface |

As ferramentas externas devem estar disponíveis no `PATH`. Quando `lua-language-server`, `clangd` ou `lldb-dap`/`lldb-vscode` não são encontrados, a configuração continua iniciando e notifica qual recurso foi desativado.

A GUI usa, quando disponível:

```text
Iosevka Nerd Font 14
```

Quando o Neovim roda em um terminal, a fonte é controlada pelo próprio terminal.

---

## Plugins

Todos os plugins são declarados com `vim.pack.add()` em `lua/core/plugins.lua`.

| Categoria | Plugins |
|---|---|
| **Completion e código** | Blink.cmp, blink.lib, nvim-treesitter, conform.nvim |
| **Cores** | ccc.nvim |
| **Build / Run** | overseer.nvim |
| **Debug** | nvim-dap, nvim-dap-view |
| **Navegação** | mini.jump2d, snacks.nvim, oil.nvim, Harpoon 2 |
| **Git** | gitsigns.nvim |
| **Edição** | mini.pairs, nvim-surround, todo-comments.nvim |
| **Interface** | Which-Key, indent-blankline, Lualine, nvim-web-devicons, Smear Cursor |
| **Tema** | Monokai Remastered |
| **Bibliotecas / helpers** | plenary.nvim |

### Completion e código

#### Blink.cmp

Motor de completion. Reúne sugestões de LSP, paths, snippets e buffer. Também habilita signature help e documentação automática.

#### nvim-treesitter

Parsers instalados:

```text
lua
c
cpp
vim
vimdoc
query
```

#### conform.nvim

Formatação automática ao salvar:

```text
Lua     → StyLua
C / C++ → clang-format
```

---

## Cores

### ccc.nvim

O CCC centraliza visualização, edição, criação e conversão de cores. O highlighter é ativado automaticamente e mostra um marcador colorido ao lado dos valores reconhecidos sem substituir a cor do texto.

Exemplo:

```text
■ #f92672
■ rgb(102 217 239)
■ hsl(80 76% 53%)
```

A integração com o LSP fica habilitada. Quando um servidor fornece `textDocument/documentColor`, o CCC pode aproveitar essas informações; caso contrário, usa os próprios pickers para reconhecer formatos de cor.

Espaços de cor disponíveis no picker:

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

Formatos de saída configurados:

```text
HEX / HEX curto
CSS RGB / RGBA
CSS HSL
CSS HWB
CSS Lab / LCH
CSS OKLab / OKLCH
Float
```

O alpha aparece automaticamente quando o formato suportar transparência. O estado do picker é preservado entre usos.

Atalhos:

```text
<leader>cp  escolher / editar uma cor
<leader>cc  converter formato da cor sob o cursor
<leader>ct  ligar/desligar o highlighter
```

---

## Build e execução

### overseer.nvim

O Overseer é o task runner da configuração. Para exercícios C++ de arquivo único ele usa o `.cpp` aberto no buffer atual, salva o arquivo se necessário, chama `clang++` e gera o executável na mesma pasta com o mesmo nome sem extensão.

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

Fluxo de execução:

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

A task registrada como **C++ Build** também é usada pelo DAP como `preLaunchTask`.

---

## Debug

### nvim-dap + lldb-dap

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
        lldb-dap
           ↓
          DAP
```

O executável é resolvido automaticamente a partir do arquivo aberto:

```text
${fileDirname}/${fileBasenameNoExtension}
```

Também existe a configuração **Anexar a processo C++** para attach em um processo já em execução.

### nvim-dap-view

Exibe scopes, variáveis, breakpoints, threads, REPL e valores inline. A interface abre e fecha automaticamente com a sessão de debug.

---

## Navegação

### mini.jump2d

O `mini.jump2d` é a ferramenta de salto rápido da configuração. A ideia é simples: os labels aparecem em pontos visíveis e você escolhe diretamente o destino sem precisar digitar uma busca antes.

A configuração usa labels priorizando a home row:

```text
asdfghjklqwertyuiopzxcvbnm
```

Também mostra uma etapa futura de labels (`n_steps_ahead = 1`) e permite saltos tanto na janela atual quanto nas outras janelas visíveis da tabpage.

O mapping padrão `<CR>` do módulo foi desabilitado de propósito para não interferir em tags, help, quickfix e outros usos nativos do Enter.

Foram mantidos somente os três modos que se mostraram mais úteis no fluxo diário:

```text
<leader>jj  labels nos inícios de palavras
<leader>jl  labels nos inícios das linhas
<leader>jc  pedir um caractere e marcar suas ocorrências
```

Os três atalhos funcionam em **Normal**, **Visual** e **Operator-pending**.

Uso rápido:

```text
Quero chegar a uma palavra              → <leader>jj
Quero chegar diretamente a uma linha   → <leader>jl
Quero saltar para um caractere visível → <leader>jc
```

Os motions nativos `f`, `F`, `t`, `T`, `;`, `,`, `s` e os text objects do Neovim permanecem livres e sem substituição por plugin.

### Snacks

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

### Oil

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
<C-1>…<C-4>     abrir itens 1 a 4
```

Dentro do menu do Harpoon:

```text
<C-v>  abrir em split vertical
<C-x>  abrir em split horizontal
```

### Janelas / splits

A navegação principal entre janelas usa **Leader + setas**:

```text
<leader><Left>   janela à esquerda
<leader><Down>   janela abaixo
<leader><Up>     janela acima
<leader><Right>  janela à direita
```

Os atalhos nativos continuam disponíveis:

```text
<C-w>h
<C-w>j
<C-w>k
<C-w>l
<C-w>w
```

No terminal do Overseer, `<Esc>` volta ao Normal mode. Depois basta usar `Leader + seta` para navegar. `Leader + seta` não é mapeado diretamente em Terminal mode de propósito: como o Leader é `Space` e `timeoutlen = 500`, usar Space como prefixo dentro do terminal faria espaços digitados poderem sofrer atraso.

---

## Which-Key

A tecla **Leader é `Space`**.

Os grupos são registrados centralmente:

```text
<leader>b  Buffers
<leader>c  Colors
<leader>d  Debug
<leader>f  Find
<leader>g  Git
<leader>h  Harpoon
<leader>j  Jump
<leader>l  LSP
<leader>p  Plugins
<leader>r  Run
```

O namespace `<leader>j` ficou exclusivamente para os três atalhos do `mini.jump2d`.

As ações de navegação com `Leader + setas` também aparecem no Which-Key.

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

## Janelas

| Keymap | Ação |
|---|---|
| `<leader><Left>` | Janela à esquerda |
| `<leader><Down>` | Janela abaixo |
| `<leader><Up>` | Janela acima |
| `<leader><Right>` | Janela à direita |
| `<C-w>w` | Próxima janela, atalho nativo |
| `<Esc>` no terminal | Voltar ao Normal mode |

## Jump — mini.jump2d

| Keymap | Ação |
|---|---|
| `<leader>jj` | Jump2d em inícios de palavras |
| `<leader>jl` | Jump2d em inícios de linhas |
| `<leader>jc` | Jump2d por caractere |

## Colors — `<leader>c`

| Keymap | Ação |
|---|---|
| `<leader>cp` | Escolher / editar cor |
| `<leader>cc` | Converter formato da cor sob o cursor |
| `<leader>ct` | Ligar/desligar destaque de cores |

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

## LSP — `<leader>l`

| Keymap | Ação |
|---|---|
| `<leader>la` | Code action |
| `<leader>ld` | Diagnóstico da linha |
| `<leader>li` | Alternar inlay hints |
| `<leader>lr` | Renomear símbolo |
| `<leader>ls` | Signature help |
| `<leader>lh` | C++: alternar source/header |
| `gd` | Definição |
| `gD` | Declaração |
| `K` | Hover / documentação |
| `gri` | Implementação, nativo do Neovim |
| `grr` | Referências, nativo do Neovim |
| `]d` | Próximo diagnóstico |
| `[d` | Diagnóstico anterior |

## Run — `<leader>r`

| Keymap | Ação |
|---|---|
| `<leader>rb` | Build do arquivo C++ atual |
| `<leader>rr` | Build e executar o arquivo C++ atual |
| `<leader>rt` | Escolher e executar task do Overseer |
| `<leader>ru` | Abrir / fechar lista de tasks |
| `<leader>rl` | Repetir task mais recente |

Para exercícios C++:

```text
<leader>rr  → compilar e rodar
<leader>dc  → compilar e debugar
```

## Debug — `<leader>d`

| Keymap | Ação |
|---|---|
| `<leader>db` | Alternar breakpoint |
| `<leader>dB` | Breakpoint condicional |
| `<leader>dc` | Iniciar com Build automático / continuar |
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
| `J` / `K` em Visual | Mover seleção |
| `<` / `>` em Visual | Indentar mantendo seleção |
| `D` em Visual | Duplicar seleção |

### Observações sobre overrides

Não existem keymaps `Leader` duplicados na configuração atual. Alguns atalhos substituem comportamentos nativos de forma intencional:

- o `<CR>` padrão do `mini.jump2d` está desativado para não interferir em tags/help/quickfix;
- `<C-e>` em Normal mode abre o menu rápido do Harpoon em vez do scroll nativo;
- `J`, `K` e `D` em Visual mode foram customizados para edição de seleção;
- `K` em buffers com LSP anexado mostra hover/documentação.

Os comandos nativos `s`, `S`, `f`, `F`, `t`, `T`, `;`, `,` e os text objects do Neovim não são sobrescritos pelo sistema de saltos.

---

## C++

O suporte C++ é dividido em cinco partes:

```text
clangd        → LSP / diagnósticos / completion / navegação
Treesitter    → parsing / highlight / indentação
clang-format  → formatação
Overseer      → build / run / tasks
lldb-dap      → debugging
```

### clangd

Configuração principal:

```text
filetypes: c, cpp
flags:
  --background-index
  --clang-tidy
  --completion-style=detailed
```

Não são forçados standard, includes ou defines globais no LSP; essas opções pertencem ao projeto e devem vir da compilação real.

Para projetos C++ maiores, prefira `compile_commands.json`.

### Inlay hints

```text
<leader>li  ligar/desligar hints
```

### Source / header

```text
<leader>lh  alternar entre source e header correspondente
```

### Build / Run

Para exercícios de arquivo único:

```text
main.cpp
   ↓
clang++ -std=c++20 -Wall -Wextra -Wpedantic -g -O0
   ↓
main
```

O executável fica na mesma pasta do source. Projetos com múltiplos `.cpp` devem evoluir para uma task de projeto/build system em vez de compilar somente o buffer atual.

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

Ao iniciar uma nova sessão com `<leader>dc`, o DAP usa `preLaunchTask = "C++ Build"`. Se o build falhar, o debugger não inicia. Se terminar com sucesso, o LLDB recebe automaticamente o executável correspondente ao arquivo aberto.

Depois que a sessão já está ativa, `<leader>dc` volta ao comportamento normal de **Continue**.

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

## Atualização de plugins

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

O workflow de CI executa:

1. `stylua --check .`;
2. validação de sintaxe dos arquivos Lua;
3. smoke test headless com Neovim 0.12.

---

## Filosofia

> **Uma base pequena, compreensível e fácil de evoluir conforme novas necessidades aparecem.**

Adicionar uma linguagem não significa instalar uma distribuição inteira de plugins. A configuração adiciona apenas as ferramentas necessárias para aquela linguagem.

---

<div align="center">

**Neovim · Lua · C++ · clangd · CCC · Overseer · LLDB · vim.pack · Blink · Snacks · mini.jump2d · Which-Key · Monokai Remastered**

</div>