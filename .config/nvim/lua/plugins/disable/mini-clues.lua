return {
	{
		"echasnovski/mini.clue",
		version = false,
		event = "VeryLazy",
		config = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Définit quelles touches déclenchent l'affichage du menu
					{ mode = "n", keys = "<leader>" },
					{ mode = "x", keys = "<leader>" },
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },
					{ mode = "n", keys = "<C-w>" }, -- Gestion des fenêtres
					{ mode = "n", keys = "z" }, -- Plis et orthographe
					{ mode = "n", keys = "'" }, -- Marques
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
				},
				clues = {
					-- Descriptions personnalisées pour tes groupes de touches
					{ mode = "n", keys = "<leader>b", desc = "+Buffer" },
					{ mode = "n", keys = "<leader>f", desc = "+Fichier" },
					{ mode = "n", keys = "<leader>g", desc = "+Git" },

					-- Aide intégrée pour les registres, fenêtres, etc.
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
				window = {
					delay = 400,
				},
			})
		end,
	},
}
