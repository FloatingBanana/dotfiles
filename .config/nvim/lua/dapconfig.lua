local dap = require "dap"

--------------
-- Adapters --
--------------
dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
	name = 'lldb'
}



---------------
-- Languages --
---------------
dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {'--arch x86_64'}
	}
}

dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust
