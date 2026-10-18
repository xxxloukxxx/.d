return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Configuration globale des diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				signs = false,
				update_in_insert = true,
				severity_sort = true,
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Configuration globale des raccourcis
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					opts["desc"] = "Lsp references"
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
				end,
			})

			-- vim.lsp.enable
			local servers = { "lua_ls", "markdown_oxide", "pyright", "clangd", "ts_ls", "texlab" }

			for _, name in ipairs(servers) do
				vim.lsp.config(name, {
					capabilities = capabilities,
					settings = (function()
						local s = nil

						if name == "lua_ls" then
							s = { Lua = { diagnostics = { globals = { "vim" } } } }
						end

						if name == "texlab" then
							s = {
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

						return s
					end)(),
				})
				vim.lsp.enable(name)
			end
		end,
	},
}
