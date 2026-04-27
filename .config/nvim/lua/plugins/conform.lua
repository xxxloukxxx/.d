return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },

		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({
						async = true,
						lsp_fallback = true,
					})
				end,
				desc = "Format buffer",
			},
		},

		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "isort", "black" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				tex = { "tex-fmt" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
			},

			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},

			formatters = {
				latexindent = {
					args = { "-c", "/tmp/" },
					stdin = true,
				},
				["tex-fmt"] = {
					args = { "--nowrap", "--usetabs", "--tabsize", "1", "--print", "$FILENAME" },
					stdin = true,
				},
			},
		},
	},
}
