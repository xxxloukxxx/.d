-- Telescope
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8", -- Version stable pour Neovim 0.11
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		-- Configuration de base pour se rapprocher de ton fzf.vim
		require("telescope").setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!**/.git/*",
				},
			},
		})

		-- Raccourcis
		vim.keymap.set("n", "<leader><leader>m", builtin.oldfiles, { desc = "MRU" })
		vim.keymap.set("n", "<leader><leader>f", builtin.find_files, { desc = "Files" })
		vim.keymap.set("n", "<leader><leader>b", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader><leader>g", builtin.live_grep, { desc = "Grep" })
		vim.keymap.set("n", "<leader><leader>g", builtin.live_grep, { desc = "Grep" })
		vim.keymap.set(
			"n",
			"<leader><leader>l",
			builtin.current_buffer_fuzzy_find,
			{ desc = "Current buffer fuzzy find" }
		)
	end,
}
