return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		lualine.setup({
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							hint = "󰠠 ",
							info = " ",
						},
					},
				},
				lualine_c = {
					{
						"buffers",
						symbols = {
							modified = " ●", -- modified
							alternate_file = "", -- alternate file
							directory = "", -- directory
							error = " ",
							warn = " ",
							hint = "󰠠 ",
							info = " ",
						},
						buffers_color = {
							active = { fg = "#ffffff", bg = nil, gui = "italic,bold" }, -- Colori per il buffer attivo
							inactive = { fg = "#aaaaaa", bg = nil, gui = "italic,bold" }, -- Colori per i buffer inattivi
						},
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					-- { "fileformat" },
					{ "filetype" },
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					"location",
				},
			},
		})
	end,
}
