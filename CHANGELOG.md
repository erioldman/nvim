# Changelog

All notable changes to this Neovim configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.2.1] - 2026-11-21

### Changed

- Neo-tree now opens automatically when Neovim starts via a `VimEnter` autocmd.

## [0.2.0] - 2026-11-21

### Added

- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) file explorer (v3.x), loaded at startup and toggled with `:Neotree`.
- Dependencies for Neo-tree: [plenary.nvim](https://github.com/nvim-lua/plenary.nvim), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), and [nui.nvim](https://github.com/MunifTanjim/nui.nvim).

### Changed

- Updated `lazy-lock.json` with pinned versions for Neo-tree and its dependencies.

## [0.1.0] - Initial release

### Added

- Initial configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.
- [blink.cmp](https://github.com/Saghen/blink.cmp) completion engine with LSP capabilities integration.
- LSP support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with the Ruff language server for Python.
- Tool management via [mason.nvim](https://github.com/mason-org/mason.nvim) and [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim).
- System clipboard integration (`unnamedplus`).
- `Esc` in Normal mode clears search highlights.
