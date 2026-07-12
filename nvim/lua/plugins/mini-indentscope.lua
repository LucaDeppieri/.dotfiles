return {
	"nvim-mini/mini.indentscope",
	version = "*",
	config = function()
		require("mini.indentscope").setup({
			symbol = "▏",
		})
	end,
}
