local dap = require "dap"

--------------
-- Adapters --
--------------
dap.adapters.codelldb = {
	type = 'executable',
	name = 'lldb',
	command = '/usr/bin/codelldb',
}
--dap.adapters.codelldb = {
--	type = "server",
--	port = "${port}",
--	executable = {
--		command = "/usr/bin/codelldb",
--		args = {"--port", "${port}"},
--	}
--}


---------------
-- Languages --
---------------
dap.configurations.zig = {
	{
		name = 'Build and launch',
		type = 'codelldb',
		request = 'launch',
		program = "/usr/bin/zig",
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {"build", "run"},
	},
	{
		name = 'Launch',
		type = 'codelldb',
		request = 'launch',
		program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}
