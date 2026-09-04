local wk = require "which-key"
local dap = require "dap"
local dapwidgets = require "dap.ui.widgets"

wk.add {
	-- Files
	{'<leader>f', group = 'Telescope find'},
	{'<leader>ff', '<cmd>Telescope find_files<CR>',   desc = 'Find file'},
	{'<leader>fg', '<cmd>Telescope live_grep<CR>',    desc = 'Grep find'},
	{'<leader>fb', '<cmd>Telescope buffers<CR>',      desc = 'Find buffers'},
	{'<leader>fs', '<cmd>Telescope git_status<CR>',   desc = 'Git modified files'},
	{'<leader>fd', '<cmd>Yazi<CR>',                   desc = 'Open Yazi'},

 	{'<leader>t', require("FTerm").toggle, desc = "Toggle terminal"},


	{"<C-S-d>", "<cmd>bd<CR>",  mode = "n"},
	{"<C-s>",   "<cmd>w<CR>",   mode = "n"},
	{"<C-BS>",  "<cmd>noh<CR>", mode = "n"},
	{"<C-d>",   "<C-d>zz",      mode = "n"},
	{"<C-u>",   "<C-u>zz",      mode = "n"},
	{"jj",    	"<Esc>",        mode = "i"},
	{"n",       "nzzzv",        mode = {"n", "v"}},
	{"N",       "Nzzzv",        mode = {"n", "v"}},
	{">",       ">gv",          mode = "v"},
	{"<",       "<gv",          mode = "v"},

	{'<C-k>', "<cmd>move '<-2<CR>gv=gv", mode = 'v'},
	{'<C-j>', "<cmd>move '>+1<CR>gv=gv", mode = 'v'},

	{"<C-h>", "<C-w>h", mode = "n"},
	{"<C-j>", "<C-w>j", mode = "n"},
	{"<C-k>", "<C-w>k", mode = "n"},
	{"<C-l>", "<C-w>l", mode = "n"},

	{"<C-S-l>", "<cmd>bn<CR>", mode = "n"},
	{"<C-S-h>", "<cmd>bp<CR>", mode = "n"},
	{"<C-S-j>", "<cmd>tabNext<CR>", mode = "n"},
	{"<C-S-k>", "<cmd>tabprevious<CR>", mode = "n"},


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
	{'<leader>d',  group = 'Debugger'},
	{'<leader>dc', dap.continue,     desc = 'Continue'  },
	{'<leader>dd', dapwidgets.hover, desc = 'Hover'     },
	{'<leader>di', dap.repl.open,    desc = 'Open REPL' },

	{'<leader>dq', group = 'Entities'},
	{'<leader>dqq', function()dapwidgets.centered_float(dapwidgets.scopes)end,   desc = 'View scope'},
	{'<leader>dqf', function()dapwidgets.centered_float(dapwidgets.frames)end,   desc = 'View frames'},
	{'<leader>dqt', function()dapwidgets.centered_float(dapwidgets.threads)end,  desc = 'View threads'},
	{'<leader>dqs', function()dapwidgets.centered_float(dapwidgets.sessions)end, desc = 'View sessions'},

	{'<leader>ds',  group = 'Step'},
	{'<leader>dso', dap.step_out,  desc = 'Step out'},
	{'<leader>dsv', dap.step_over, desc = 'Step in'},

	{'<leader>db',  group = 'Breakpoints'},
	{'<leader>dbb', dap.toggle_breakpoint, desc = 'Toggle breakpoint'},

	{'<leader>dbc', desc = 'Conditional breakpoint', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(vim.fn.input('condition: ', 'true'))
		vim.fn.inputrestore()
	end},

	{'<leader>dbn', desc = 'Counting breakpoint', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, vim.fn.input('hit count: ', "1"))
		vim.fn.inputrestore()
	end},

	{'<leader>dbl', desc = 'Log breakpoint', function()
		vim.fn.inputsave()
		dap.toggle_breakpoint(nil, nil, vim.fn.input('log message: ', ''))
		vim.fn.inputrestore()
	end},
}

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_var(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	wk.add {
		{buffer = bufnr},

		{"<leader>lk",  vim.lsp.buf.hover,          desc = 'Hover'},
		{"<leader>ls",  vim.lsp.buf.signature_help, desc = 'View signature'},
		{"<leader>ln",  vim.lsp.buf.rename,         desc = 'Rename symbol'},

		{'<leader>lw', group = "Workspace"},
		{'<leader>lwa', vim.lsp.buf.add_workspace_folder,    desc = 'Add folder to workspace'},
		{'<leader>lwr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove fder from workspace'},
		{'<leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = 'List folders in the workspace'},
	}
end

vim.lsp.config('lua_ls', {on_attach = on_attach})
vim.lsp.config('zls', {on_attach = on_attach})
