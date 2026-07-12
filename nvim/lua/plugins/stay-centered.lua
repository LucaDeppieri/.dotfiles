return {
	"arnamak/stay-centered.nvim",
	event = { "BufNew", "BufWinEnter" },
	opts = function()
		local plugin = require("stay-centered")

		plugin.setup({
			-- Configuration here
			enabled = true, -- start with the plugin disabled
		})

		vim.keymap.set("n", "<leader>sc", function()
			plugin.toggle()
			local isEnabled = plugin.cfg.enabled
			if isEnabled then
				vim.notify("Now centered!", vim.log.levels.INFO)
			else
				vim.notify("Not centered anymore!", vim.log.levels.INFO)
			end
		end, { desc = "Toggle stay-centered" })
	end,
}
