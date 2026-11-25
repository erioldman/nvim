# Neovim Configuration

My personal Neovim configuration, built from scratch using Lua and [lazy.nvim](https://github.com/folke/lazy.nvim).

The goal is a lightweight, modular, and maintainable setup with full control over installed plugins and editor behavior.

## Requirements

- [Neovim](https://neovim.io/) >= 0.11.0 (built with LuaJIT)
- [Git](https://git-scm.com/) >= 2.19.0
- [LuaRocks](https://luarocks.org/)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)

## Installation

Back up your existing configuration if necessary, then clone this repository:

```bash
git clone https://github.com/erioldman/nvim.git ~/.config/nvim
```

Open Neovim:

```bash
nvim
```

lazy.nvim automatically installs the declared plugins.

## Plugin Manager

[**lazy.nvim**](https://github.com/folke/lazy.nvim) manages plugin installation, updates, dependencies, and loading.

No predefined distribution or plugin collection is used. Every plugin is explicitly declared in the configuration.

## Plugins

| Plugin | Purpose |
|---|---|
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Completion engine |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | External tool installer |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Mason and LSP integration |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer tree |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add, change, and delete surrounding pairs |

### Language Servers and Tools

| Tool | Purpose |
|---|---|
| [Pyright](https://github.com/microsoft/pyright) | Python language server |
| [Ruff](https://github.com/astral-sh/ruff) | Python linting and code actions |

## Configuration Structure

```text
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── config/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── lsp.lua
│   └── plugins/
│       ├── blink.lua
│       ├── lsp.lua
│       ├── mason.lua
│       ├── neo-tree.lua
│       └── nvim-surround.lua
└── .gitignore
```

### Configuration Files

**`init.lua`**
- Sets space as the leader key (`mapleader`).
- Bootstraps lazy.nvim.
- Loads editor options, keymaps, and LSP configuration.
- Initializes the plugin manager.

**`lua/config/options.lua`**
- Uses the system clipboard for all yanks and pastes (`unnamedplus`).
- Wraps long lines at word boundaries (`wrap`, `linebreak`).
- Lets `h` and `l` cross line boundaries (`whichwrap`).

**`lua/config/keymaps.lua`**
- Maps `Esc` in Normal mode to clear search highlights (`:nohlsearch`).
- Maps `<leader>e` to toggle (hide/unhide) the Neo-tree window.

**`lua/config/lsp.lua`**
- Configures LSP capabilities using Blink's completion capabilities.
- Enables the Ruff language server.

**`lua/plugins/neo-tree.lua`**
- Adds the Neo-tree file explorer, loaded at startup and opened automatically when Neovim starts.
- Roots the tree at the launched file's directory (current directory when no file is given) and reveals the file in the tree.
- Shows hidden (dot)files and gitignored files (e.g. `__pycache__`), so visibility is consistent everywhere.
- `Space` in the tree opens the selected file or toggles the directory under the cursor (with `nowait`, so it fires instantly).
- Toggled with `<leader>e` or `:Neotree`.

**`lua/plugins/nvim-surround.lua`**
- Adds [nvim-surround](https://github.com/kylechui/nvim-surround) with default settings, lazy-loaded on `VeryLazy`.
- Mappings: `ys{motion}{char}` adds a surrounding pair, `cs{old}{new}` changes it, `ds{char}` deletes it.

**`lua/plugins/`**
- Contains individual plugin specifications for Blink, LSP configuration, Mason, Neo-tree, and nvim-surround.

**`lazy-lock.json`**
- Records exact plugin versions and commits for reproducible installations.

---

**Philosophy:** Keep the configuration explicit, modular, and under version control. Add functionality only when needed.

