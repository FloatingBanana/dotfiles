local telescope = require "telescope.builtin"
local dap = require "dap"
local wk = require "which-key"

local opts = {noremap = true, silent = true}

vim.keymap.set('i', '<C-d>', "<Cmd>dw<CR>", opts)
-- Move lines
vim.keymap.set('i', '<A-Up>', '<Cmd>:move .-2<CR>', opts)
vim.keymap.set('i', '<A-Down>', '<Cmd>:move .+<CR>', opts)

wk.register({
	-- Telescope
	['<leader>f'] = "+Telescope find",
	['<leader>ff'] = {'<Cmd>Telescope find_files<CR>', "Find file"},
	['<leader>fg'] = {'<Cmd>Telescope find_grep<CR>', "Grep find"},
	['<leader>fb'] = {'<Cmd>Telescope buffers<CR>', "Find buffer"},

	-- LSP
	['<leader>l'] = "+LSP",
	['<leader>lf'] = {vim.diagnostic.open_float, "Open diagnostic float"},
	['<leader>lp'] = {vim.diagnostic.goto_prev, "Go to previous"},
	['<leader>ln'] = {vim.diagnostic.goto_next, "Go to next"},
	['<leader>lr'] = {telescope.lsp_references, "References"},
	['<leader>ld'] = {telescope.lsp_definitions, "Definitions"},

	-- Debugger
	['<leader>d'] = "+Debugger",
	['<leader>ds'] = "+Step",
	['<leader>db'] = "+Breakpoints",
	['<leader>dc'] = {dap.continue, "Continue debugging session"},
	['<leader>dso'] = {dap.step_out, "Step out"},
	['<leader>dsi'] = {dap.step_into, "Steo into"},
	['<leader>dsO'] = {dap.step_over, "Step over"},
	['<leader>dsb'] = {dap.step_back, "Step back"},
	['<leader>di'] = {dap.repl.open, "Open REPL"},
	['<leader>dbb'] = {dap.toggle_breakpoint, "Toggle breakpoint"},

	['<leader>dbc'] = {function ()
		vim.fn.inputsave()
		dap.toggle_breakpoint(vim.fn.input('Condition: ', 'true'))
		vim.fn.inputrestore()
	end, "Set conditional breakpoint"},

	["<leader>dbn"] = {function ()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, vim.fn.input('Hit count: ', 1))
		vim.fn.inputrestore()
	end, "Set counter breakpoint"},

	["<leader>dbl"] = {function ()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, nil, vim.fn.input('Log message: ', ''))
		vim.fn.inputrestore()
	end, "Set log breakpoint"}
}, opts)

return {
	lsp_bufferbindings = function(keyopts)
		wk.register({
			['gD'] = {vim.lsp.buf.declaration, "Declarations"},
			['gd'] = {vim.lsp.buf.definition, "Definitions"},
			['K'] = {vim.lsp.buf.hover, "Hover"},
			['gi'] = {vim.lsp.buf.implementation, "Implementation"},
			['<C-k>'] = {vim.lsp.buf.signature_help, "Signature"},
			['<space>wa'] = {vim.lsp.buf.add_workspace_folder, "Add workspace folder"},
			['<space>wr'] = {vim.lsp.buf.remove_workspace_folder, "Remove workspace folder"},

			['<space>wl'] = {function ()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List workspace folders"},

			['<space>D'] = {vim.lsp.buf.type_definition, "Type definition"},
			['<space>rn'] = {vim.lsp.buf.rename, "Rename symbol"},
			['<space>ca'] = {vim.lsp.buf.code_action, "Code actions"},
			['gr'] = {vim.lsp.buf.references, "References"},
			['<space>f'] = {vim.lsp.buf.formatting, "Format code"},
		}, keyopts)
	end
}
