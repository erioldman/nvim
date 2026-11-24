-- Use the system clipboard for all yanks/pastes
vim.opt.clipboard = "unnamedplus"

-- Wrap long lines at word boundaries
vim.opt.wrap = true
vim.opt.linebreak = true

-- Let h/l cross line boundaries (h at line start goes to end of previous line, l at line end goes to start of next)
vim.opt.whichwrap:append("h,l")

