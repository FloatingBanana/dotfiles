require "config.lazy"
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

require("telescope").load_extension "file_browser"

require("bufferline").setup {}

require("lualine").setup {
	extensions = {'trouble', 'lazy'},

  sections = {
    lualine_c = {'filename', 'lsp_status'}
	}
}
