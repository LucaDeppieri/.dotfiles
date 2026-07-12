-- Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.shiftwidth = 3
		vim.opt_local.tabstop = 3
		vim.opt_local.expandtab = true
	end,
})
