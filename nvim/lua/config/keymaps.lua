local keymap = vim.keymap

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Utility
keymap.set({ "n", "v" }, "<leader>v", require("nvim-toggler").toggle, { desc = "Toggle value" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap.set(
	{ "n", "v" },
	"<leader>ca",
	vim.lsp.buf.code_action,
	{ silent = true, desc = "Code Action or range (in visual mode)" }
)
keymap.set(
	"n",
	"<leader>gd",
	"<cmd>Telescope lsp_definitions<CR>",
	{ desc = "Go to definition", noremap = true, silent = true }
)
keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "<Tab>", function()
	vim.cmd([[bnext]])
end, { desc = "Cycle to next buffer" })
keymap.set("n", "<S-Tab>", function()
	vim.cmd([[bprevious]])
end, { desc = "Cycle to prev buffer" })
keymap.set("n", "<leader>bd", function()
	local current_buf = vim.fn.bufnr("%")
	local buf_count = #vim.fn.getbufinfo({ bufloaded = true })

	if buf_count > 1 then
		vim.cmd([[bprevious]])
		vim.cmd("bdelete " .. current_buf)
	else
		vim.cmd([[bdelete]])
	end
end, { desc = "Close current buffer" })

-- Telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fh", builtin.oldfiles, { desc = "Recent files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Show buffers" })
keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Help tags" })
keymap.set("n", "<leader>fn", function()
	vim.cmd([[Telescope notify]])
end, { desc = "Show notifications" })

-- Neo Tree
-- keymap.set("n", "<C-e>", "<cmd>Neotree toggle<cr>", { desc = "Neotree toggle" })

-- Auto-session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save current session" })

-- Trouble
keymap.set(
	"n",
	"<leader>td",
	"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
	{ desc = "Open trouble document diagnostics" }
)
keymap.set("n", "<leader>tw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
keymap.set("n", "<leader>tt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })

-- Format buffer or range
keymap.set({ "n", "v" }, "<leader>=", function()
	require("conform").format({
		timeout_ms = 500,
		lsp_format = "fallback",
	})
end, { desc = "Format buffer or range (in visual mode)" })

-- Trigger linting
keymap.set("n", "<leader>l", function()
	require("lint").try_lint()
end, { desc = "Trigger linting for current buffer" })

-- No Neck Pain
keymap.set("n", "<leader>np", "<cmd>NoNeckPain<CR>", { desc = "Toggle NoNeckPain" })

-- Git Signs
keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Toggle git preview inline" })
keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle git line blame" })

-- Copilot Suggestions
keymap.set("i", "<C-y>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Accept suggestion" })
