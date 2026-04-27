return {
	{
		"stevearc/oil.nvim",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				-- Configuration par défaut très solide
				columns = { "icon" },
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
				},
				view_options = {
					show_hidden = true,
				},
			})
		end,
	},
}
