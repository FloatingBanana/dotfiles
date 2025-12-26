return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependecies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		require("nvim-tree").setup {}
	end
}
