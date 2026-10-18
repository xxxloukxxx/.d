return {
	{
		"tpope/vim-fugitive",
		config = function()
			local keymap = vim.keymap.set

			-- Mapping pour ouvrir le menu Git complet (équivalent de git status)
			keymap("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })

			-- Raccourcis rapides pour les actions communes
			keymap("n", "<leader>gp", ":Git push<CR>", { silent = true, desc = "Git Push" })
			keymap("n", "<leader>gf", ":Git fetch<CR>", { silent = true, desc = "Git Fetch" })

			-- Diffview intégré (pour voir les changements du fichier actuel)
			keymap("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff Split" })
		end,
	},
}
