return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	config = function()
		require("render-markdown").setup({
			file_types = { "markdown", "copilot-chat" },
			completions = { lsp = { enabled = true } },
		})
	end,
}
