return {
	{
		"echasnovski/mini.hues",
		version = false,
		lazy = false, -- Le thème doit être chargé immédiatement
		priority = 1000, -- Priorité haute pour éviter le flash blanc au démarrage
		config = function()
			require("mini.hues").setup({
				-- background = "#1a1b26", -- Un fond sombre propre
				background = "#0a0b16", -- Un fond sombre propre
				foreground = "#e0e0ff", -- Texte clair
				accent = "blue",
				n_hues = 8,
				saturation = "high",
			})
		end,
	},
}
