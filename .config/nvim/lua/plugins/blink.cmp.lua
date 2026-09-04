return {
	"https://github.com/Saghen/blink.cmp",
	branch = "v1",
	dependencies = {"hrsh7th/vim-vsnip", "https://codeberg.org/FelipeLema/bink-cmp-vsnip.git"},

	opts = {
		snippets = {preset = "vsnip"},

		sources = {
			default = {"lsp", "path", "snippets", "buffer"}
		},

		completion = {
			list = {
				selection = {preselect = false, auto_insert = true}
			},

			documentation = {
				auto_show = true,
				auto_show_delay = 500,
			}
		},

		signature = {
			enabled = true
		},

		keymap = {
			preset = "default",

			["<Tab>"] = {"select_next", "fallback"},
			["<S-Tab>"] = {"select_prev", "fallback"},
			["<C-Tab>"] = {"show", "show_documentation", "hide_documentation", "fallback"},
			["<CR>"] = {"select_and_accept", "fallback"},
			["<C-Up>"] = {"scroll_documentation_up", "fallback"},
			["<C-Down>"] = {"scroll_documentation_down", "fallback"},
		}
	}
}
