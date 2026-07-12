local vim = vim

return {
	{
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"rafamadriz/friendly-snippets",
				"mlaursen/vim-react-snippets",
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"nvim-web-devicons",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("vim-react-snippets")
			local react_config = require("vim-react-snippets.config")
			-- if you do not want to wrap all props in `Readonly<T>`
			react_config.readonly_props = false

			require("luasnip.loaders.from_vscode").lazy_load()

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			cmp.setup({
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "render-markdown" },
					{ name = "luasnip" },
					{ name = "emoji" },
					{ name = "buffer" },
					{ name = "path" },
				},
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				snippet = { -- configure how nvim-cmp interacts with snippet engine
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:CmpPmenu,FloatBorder:Pmenu,CursorLine:Question,Search:None",
						scrollbar = false,
						border = border("CmpPmenu"),
					}),
					documentation = {
						border = border("CmpDocBorder"),
						winhighlight = "Normal:CmpDoc",
					},
				},
				formatting = {
					format = function(entry, vim_item)
						if vim.tbl_contains({ "path" }, entry.source.name) then
							local icon, hl_group = require("nvim-web-devicons").get_icon(entry.completion_item.label)
							if icon then
								vim_item.kind = icon
								vim_item.kind_hl_group = hl_group
								return vim_item
							end
						end
						return lspkind.cmp_format({
							with_text = true,
							mode = "symbol_text",
							menu = {
								buffer = "[buf]",
								nvim_lsp = "[LSP]",
								nvim_lua = "[api]",
								path = "[path]",
								luasnip = "[snip]",
								gh_issues = "[issues]",
							},
						})(entry, vim_item)
					end,
				},
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),

					["<C-Up>"] = cmp.mapping.scroll_docs(-4),
					["<C-Down>"] = cmp.mapping.scroll_docs(4),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item()
					-- 	elseif require("luasnip").expand_or_jumpable() then
					-- 		vim.fn.feedkeys(
					-- 			vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
					-- 			""
					-- 		)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, {
					-- 	"i",
					-- 	"s",
					-- }),
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item()
					-- 	elseif require("luasnip").jumpable(-1) then
					-- 		vim.fn.feedkeys(
					-- 			vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
					-- 			""
					-- 		)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, {
					-- 	"i",
					-- 	"s",
					-- }),

					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),

					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- Below is the default comparitor list and order for nvim-cmp
						cmp.config.compare.offset,
						-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
