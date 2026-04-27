return {
	{
		"williamboman/mason.nvim",
		version = "v1.10.0",
		build = ":MasonUpdate",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		version = "v1.29.0",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local ok, mason_lsp = pcall(require, "mason-lspconfig")
			if not ok then
				vim.notify("mason-lspconfig not found", vim.log.levels.WARN)
				return
			end

			mason_lsp.setup({
				ensure_installed = {
					"lua_ls",
					"marksman",   -- remplace markdown_oxide
					"pyright",
					"clangd",
					"tsserver",   -- remplace ts_ls
					"texlab",
				},
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local ok, mason_tools = pcall(require, "mason-tool-installer")
			if not ok then
				vim.notify("mason-tool-installer not found", vim.log.levels.WARN)
				return
			end

			mason_tools.setup({
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
