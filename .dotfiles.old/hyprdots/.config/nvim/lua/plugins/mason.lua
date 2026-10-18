return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	-- Serveurs LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"markdown_oxide",
					"pyright",
					"clangd",
					"ts_ls",
					"texlab",
				},
			})
		end,
	},
	-- Formateurs et autres outils
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"black",
					"isort",
					"prettierd",
					"clang-format",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
}
