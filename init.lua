vim.g.mapleader = " "

-- Bootstrap lazy.nvim
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Load configuration
require("config.options")
require("config.keymaps")

require("lazy").setup("plugins")
require("config.lsp")

