return {
	{
		"echasnovski/mini.comment",
		version = false,
		event = "VeryLazy",
		opts = {
			-- Options de configuration
			options = {
				-- Utilise 'gcc' ou 'gc' par défaut, mais nous ajoutons ton mapping perso dessous
				custom_commentstring = nil,
			},
			mappings = {
				-- Définit les mappings par défaut (gc, gcc, etc.)
				basic = "gc",
				textobject = "gc",
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)

			-- Ajout de ton mapping personnel <leader>/ comme dans ton ancien vimrc
			local keymap = vim.keymap.set
			keymap("n", "<leader>/", "gcc", { remap = true, desc = "Comment line" })
			keymap("v", "<leader>/", "gc", { remap = true, desc = "Comment selection" })
		end,
	},
}
