vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name

			if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},

			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		})
	end,

	settings = {
		Lua = {}
	}
})

vim.lsp.config('zls', {
	settings = {
		enable_build_on_save = true,
		enable_argument_placeholders = true,
	}
})

vim.lsp.config('qmlls', {cmd = {'qmlls6'}})

vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('zls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('glsl_analyzer')
vim.lsp.enable('qmlls')


vim.diagnostic.config({
	update_in_insert = true,
	underline = true,
	severity_sort = true;
	float = {source = "always"},
	virtual_text = {prefix = '●'},
})
