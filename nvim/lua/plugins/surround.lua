return {
	"kylechui/nvim-surround",
	version = "*", -- for stability
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup()
	end,
}
