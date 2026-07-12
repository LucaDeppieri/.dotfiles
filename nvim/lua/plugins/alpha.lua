return {
	"goolord/alpha-nvim",
	-- dependencies = { "nvim-web-devicons" },
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
	end,
}
