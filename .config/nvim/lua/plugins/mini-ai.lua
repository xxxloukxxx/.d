return {
	{
		"echasnovski/mini.ai",
		version = false,
		event = "VeryLazy",
		opts = {
			-- n_lines : nombre de lignes scrutées pour trouver l'objet (par défaut 50)
			n_lines = 50,

			-- Mappings par défaut :
			-- a : around (autour)
			-- i : inner (à l'intérieur)
			mappings = {
				around = "a",
				inside = "i",

				-- Mouvements vers le prochain/précédent objet
				goto_left = "g[",
				goto_right = "g]",
			},
		},
	},
}
