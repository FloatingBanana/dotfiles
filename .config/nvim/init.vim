call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sonph/onehalf', {'rtp': 'vim'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

call plug#end()

" Misc
set nowrap
set number
set relativenumber
colorscheme onehalfdark


" Keybindings
nnoremap <silent> <s-c-Left> :vertical resize -1<CR>
nnoremap <silent> <s-c-Right> :vertical resize +1<CR>

" Setup bufferline.nvim
set termguicolors
lua << EOF
require("bufferline").setup({})
EOF
