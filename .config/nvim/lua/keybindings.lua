local wk = require "which-key"
local dap = require "dap"

wk.add {
	-- Telescope
	{'<leader>f', group = 'Telescope find'},
	{'<leader>ff', '<Cmd>Telescope find_files<CR>',   desc = 'Find file'},
	{'<leader>fg', '<Cmd>Telescope live_grep<CR>',    desc = 'Grep find'},
	{'<leader>fb', '<Cmd>Telescope buffers<CR>',      desc = 'Find buffers'},
	{'<leader>fd', '<Cmd>Telescope file_browser<CR>', desc = 'File browser'},
	{'<leader>fs', '<Cmd>Telescope git_status<CR>',   desc = 'Git modified files'},
	{'<leader>ft', '<Cmd>NvimTreeToggle<CR>',         desc = 'Toggle file tree'},


	-- Move lines
	{'<A-Up>',   '<Cmd>:move .-2<CR>',       mode = {'i', 'n'}},
	{'<A-Down>', '<Cmd>:move .+1<CR>',       mode = {'i', 'n'}},
	{'<A-Up>',   "<Cmd>:move '<-2<CR>gv=gv", mode = 'v'},
	{'<A-Down>', "<Cmd>:move '>+1<CR>gv=gv", mode = 'v'},


	--LSP
	{'<leader>l', group = 'LSP'},
	{'<leader>ll', vim.diagnostic.open_float,                          desc = 'Open float'},
	{'<leader>lq', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Diagnostics'},
	{'<leader>lb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics'},
	{'<leader>lz', '<cmd>Trouble lsp loclist<cr>',                     desc = 'Location list'},
	{'<leader>lx', '<cmd>Trouble qflist toggle<cr>',                   desc = 'Quickfix list'},
	{'<leader>ld', '<cmd>Trouble lsp toggle<cr>',                      desc = 'Definitions / references'},
	{'<leader>ly', '<cmd>Trouble symbols toggle<cr>',                  desc = 'Symbols'},


	--Debugger
	{'<leader>d',   group = 'Debugger'},
	{'<leader>db',  group = 'Breakpoints'},
	{'<leader>dc',  dap.continue,          desc = 'Continue'},
	{'<leader>dso', dap.step_out,          desc = 'Step out'},
	{'<leader>dsv', dap.step_over,         desc = 'Step in'},
	{'<leader>di',  dap.repl.open,         desc = 'Open REPL'},
	{'<leader>dbb', dap.toggle_breakpoint, desc = 'Toggle breakpoint'},

	{'<leader>dbc', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(vim.fn.input('condition: ', 'true'))
		vim.fn.inputrestore()
	end, desc = 'Conditional breakpoint'},

	{'<leader>dbn', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, vim.fn.input('hit count: ', "1"))
		vim.fn.inputrestore()
	end, desc = 'Counting breakpoint'},

	{'<leader>dbl', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, nil, vim.fn.input('log message: ', ''))
		vim.fn.inputrestore()
	end, desc = 'Log breakpoint'},
}

vim.lsp.config('lua_ls', {
	on_attach = function(client, bufnr)

		vim.api.nvim_buf_set_var(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		wk.add {
			{buffer = bufnr},

			{"<leader>lh",  vim.lsp.buf.hover,          desc = 'Hover'},
			{"<leader>ls",  vim.lsp.buf.signature_help, desc = 'View signature'},
			{"<leader>ln",  vim.lsp.buf.rename,         desc = 'Rename symbol'},

			{'<leader>lw', group = "Workspace"},
			{'<leader>lwa', vim.lsp.buf.add_workspace_folder,    desc = 'Add folder to workspace'},
			{'<leader>lwr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove fder from workspace'},
			{'<leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = 'List folders in the workspace'},
		}
	end
})
