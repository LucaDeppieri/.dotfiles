return {
	"norcalli/nvim-colorizer.lua",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup()
	end,
}
