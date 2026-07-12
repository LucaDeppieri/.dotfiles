return {
	"nguyenvukhang/nvim-toggler",
	config = function()
		require("nvim-toggler").setup({
			inverses = {
				["true"] = "false",
				["on"] = "off",
			},
		})
	end,
}
