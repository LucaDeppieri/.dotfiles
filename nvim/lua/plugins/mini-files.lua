return {
	"echasnovski/mini.files",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- For file icons
	},
	version = "*",
	config = function()
		local mini_files = require("mini.files")

		-- Set up the file explorer to use a rounded border and title position
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowOpen",
			callback = function(args)
				local win_id = args.data.win_id
				local buf = vim.api.nvim_win_get_buf(win_id)
				local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
				if ft ~= "minifiles" then
					return
				end

				local config = vim.api.nvim_win_get_config(win_id)
				config.border = "rounded"
				config.title_pos = "right"
				vim.api.nvim_win_set_config(win_id, config)
			end,
		})

		mini_files.setup({
			options = {
				show_hidden = false,
				show_dotfiles = false,
				show_icons = true, -- Show icons for files and directories
			},
			mappings = {
				go_in = "<CR>", -- Open file or directory
				go_out = "-", -- Open file or directory
				syncronize = "=", -- Syncronize file explorer (save edits)
			},
			windows = {
				-- max_number = 4, -- Maximum number of windows opened
				preview = false,
			},
		})
	end,
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open()
			end,
			desc = "Open Mini Files",
		},
	},
}
