return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Permet le formatage à la sauvegarde
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Ton raccourci : <leader>f
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			-- On définit quel outil formate quel langage
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "isort", "black" }, -- Lance isort puis black
				typescript = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				tex = { "latexindent" },
				bash = { "beautysh" },
				zsh = { "beautysh" },
				json = { "clang-format" },
			},
			-- Formatage automatique quand tu sauves (:w)
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters = {
				["latexindent"] = {
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
