local telescope = require "telescope.builtin"

local opts = { noremap = true, silent = true }

-- vim.keymap.set('i', '<C-Delete>', ":dw", opts)

-- Telescope
vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope find_grep<CR>', opts)
vim.keymap.set('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', opts)

-- Move lines
vim.keymap.set('n', '<A-Up>', '<Cmd>:move .-2<CR>', opts)
vim.keymap.set('n', '<A-Down>', '<Cmd>:move .+<CR>1', opts)

-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', '<leader>lr', telescope.lsp_references, opts)
vim.keymap.set('n', '<leader>ld', telescope.lsp_definitions, opts)

-- Debugger
local dap = require "dap"
vim.keymap.set('n', '<leader>dbb', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<leader>dc', dap.continue, opts)
vim.keymap.set('n', '<leader>dso', dap.step_out, opts)
vim.keymap.set('n', '<leader>dsi', dap.step_into, opts)
vim.keymap.set('n', '<leader>dsv', dap.step_over, opts)
vim.keymap.set('n', '<leader>dsb', dap.step_back, opts)
vim.keymap.set('n', '<leader>di', dap.repl.open, opts)

vim.keymap.set('n', '<leader>dbc', function()
	vim.fn.inputsave()
	dap.toggle_breakpoint(vim.fn.input('Condition: ', 'true'))
	vim.fn.inputsave()
end, opts)

vim.keymap.set('n', '<leader>dbn', function()
	vim.fn.inputsave()
	dap.toggle_breakpoint(nil, vim.fn.input('Hit count: ', 1))
	vim.fn.inputrestore()
end, opts)

vim.keymap.set('n', '<leader>dbl', function()
	vim.fn.inputsave()
	dap.toggle_breakpoint(nil, nil, vim.fn.input('Log message: ', ''))
	vim.fn.inputrestore()
end, opts)
