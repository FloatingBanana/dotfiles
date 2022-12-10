require("packer").startup(function(use)
	use 'joshdick/onedark.vim'
	use 'sheerun/vim-polyglot'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'akinsho/bufferline.nvim'
	use 'windwp/nvim-autopairs'
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'windwp/nvim-ts-autotag'
	use 'lewis6991/gitsigns.nvim'
	use 'folke/trouble.nvim'

	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/cmp-vsnip'

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use 'mfussenegger/nvim-dap'
end)


require("bufferline").setup({})
require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})
require("gitsigns").setup({})
require("trouble").setup({})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		indent = true,
		disable = {}
	},
	ensure_installed = {
		"lua", "c", "rust", "tsx", "javascript", "typescript", "html", "css", "yaml", "toml", "json",
	}
})

