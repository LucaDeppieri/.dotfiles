local vim = vim -- workaround

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
						},
					},
				},
			},

			-- Schema information
			"b0o/SchemaStore.nvim",
		},

		config = function()
			vim.lsp.config("sourcekit", {
				filetypes = { "swift" },
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})
			vim.lsp.enable("sourcekit")

			-- Don't do LSP stuff if we're in Obsidian Edit mode
			if vim.g.obsidian then
				return
			end

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }, -- Recognize 'vim' as a global variable
							},
						},
					},
				},

				pyright = true,

				-- Enabled biome formatting, turn off all the other ones generally
				biome = true,

				astro = true,

				ts_ls = {
					root_dir = vim.fs.dirname(vim.fs.find("package.json", { upward = true })[1]),
					single_file = false,
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},

				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				cssls = {
					filetypes = { "css" },
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							-- schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				clangd = {
					-- cmd = { "clangd", unpack(require("custom.clangd").flags) },
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },
					filetypes = { "c", "cpp" },
				},

				tailwindcss = {
					init_options = {
						userLanguages = {
							elixir = "phoenix-heex",
							eruby = "erb",
							heex = "phoenix-heex",
						},
					},
					filetypes = {
						"html",
						"css",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
						"vue",
						"ocaml.mlx", -- aggiunto da te
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									[[class: "([^"]*)]],
									[[className="([^"]*)]],
								},
							},
							includeLanguages = {
								javascript = "javascriptreact",
								typescript = "typescriptreact",
								["ocaml.mlx"] = "html", -- aggiunto da te
							},
						},
					},
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup({
				ui = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			local ensure_installed = {
				-- language servers
				"lua-language-server", -- lua
				"typescript-language-server", -- typescript, javascript
				"clangd", -- c, c++
				"roslyn-language-server", -- c#
				"sleek", -- sql
				"angular-language-server", -- angular
				"rust-analyzer", -- rust

				-- formatters
				"stylua", -- lua
				"isort", -- python (imports)
				"black", -- python
				"clang-format", -- c, c++
				"csharpier", -- c#
				"prettierd", -- css
				"prettier", -- css

				-- linters
				"luacheck", -- lua
				"pylint", -- python
				"cpplint", -- c, c++
				-- fallback to roslyn-language-server for c#
				"sqlfluff", -- sql
				"swiftlint", -- swift
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				vim.lsp.config[name] = config
				vim.lsp.enable(name)
			end

			local disable_semantic_tokens = {
				-- lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
					vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})
		end,
	},
}
