-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},

	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "onedark" } },

	-- automatically check for plugin updates
	checker = { enabled = true, notify = true },

	change_detection = {
		enabled = true,
		notify = true,
	},

	ui = {
		border = "rounded",
	},
})

vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

-- Removing background from telescope
vim.cmd([[
  hi TelescopeNormal guibg=NONE
  hi TelescopeBorder guibg=NONE
  hi TelescopePromptNormal guibg=NONE
  hi TelescopePromptBorder guibg=NONE
  hi TelescopeResultsNormal guibg=NONE
  hi TelescopeResultsBorder guibg=NONE
]])

-- Removing background from mini.file
vim.cmd([[
	hi MiniFilesNormal guibg=NONE
	hi MiniFilesBorder guibg=NONE
	hi MiniFilesTitle guibg=NONE
]])

-- Removing background from which-key
vim.cmd([[
  hi NormalFloat guibg=NONE
  hi FloatBorder guibg=NONE
]])
