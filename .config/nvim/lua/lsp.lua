local keybindings = require "keybindings"
local lspconfig = require "lspconfig"
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	local bufopts = {noremap = true, silent = true, buffer = bufnr}

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	keybindings.lsp_bufferbindings(bufopts)
end

local lsp_flags = {
	debounce_text_changes = 150
}

-- Lua
lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,

	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},

			diagnostics = {
				globals = {'vim'},
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},

			telemetry = {
				enable = true
			}
		}
	}
}

-- Rust
lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
}

-- typescript
lspconfig.tsserver.setup {
	filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
	cmd = {"typescript-language-server", "--stdio"}
}

-- Vue
--lspconfig.volar.setup {
--	filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
--}
