return {
	{
		"neovim/nvim-lspconfig",
		version = "v0.1.8",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = false,
				update_in_insert = true,
				severity_sort = true,
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
				end,
			})

			local servers = { "lua_ls", "marksman", "pyright", "clangd", "tsserver", "texlab" }

			for _, name in ipairs(servers) do
				local opts = {
					capabilities = capabilities,
				}

				if name == "lua_ls" then
					opts.settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					}
				end

				if name == "texlab" then
					opts.settings = {
						texlab = {
							diagnostics = {
								ignoredPatterns = {
									"^Underfull \\\\hbox.*$",
									"^Overfull \\\\hbox.*$",
									"^.*[Ww]arning.*$",
								},
							},
						},
					}
				end

				lspconfig[name].setup(opts)
			end
		end,
	},
}
