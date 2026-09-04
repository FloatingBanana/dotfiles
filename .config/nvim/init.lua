require "config.lazy"
require "dapconfig"
require "keybindings"
require "lsp"

vim.cmd "colorscheme onedark"
vim.cmd "set nowrap"

vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect"
vim.opt.clipboard:append("unnamedplus")

require("bufferline").setup {}
require("colorizer").setup {
  '*',
  css = {rgb_fn = true}
}
require("lualine").setup {
	extensions = {'trouble', 'lazy'},

  sections = {
    lualine_c = {'filename', 'lsp_status'}
	}
}
