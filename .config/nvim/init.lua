require "plugins"
require "dapconfig"
require "keybindings"
require "lsp"
require "completion"

vim.cmd "colorscheme onedark"
vim.cmd "set nowrap"

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect"
