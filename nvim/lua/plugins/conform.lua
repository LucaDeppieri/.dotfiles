return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				python = { "isort", "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				cs = { "csharpier " },
				json = { "biome" },
				jsonc = { "biome" },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				sql = { "sleek" },
				swift = { "swiftformat", formatting_options = { "--indent", "2" } },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				async = false,
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
