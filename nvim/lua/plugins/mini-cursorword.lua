return {
	"echasnovski/mini.cursorword",
	version = "*",
	config = function()
		-- Set custom highlights for cursor word
		local bg_color = "#444444"
		vim.api.nvim_set_hl(0, "MiniCursorword", { underline = false, bg = bg_color })
		vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false, bg = bg_color })

		require("mini.cursorword").setup({
			delay = 1000, -- default => 100 (milliseconds)
		})
	end,
}
