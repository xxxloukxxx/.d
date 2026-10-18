return {
	{
		"echasnovski/mini.move",
		version = false,
		event = "VeryLazy",
		opts = {
			mappings = {
				-- Mode Normal (déplace la ligne sous le curseur)
				down = "<C-j>",
				up = "<C-k>",
				left = "",
				right = "",

				-- Mode Visuel (déplace tout le bloc sélectionné)
				line_down = "<C-j>",
				line_up = "<C-k>",
				line_left = "",
				line_right = "",
			},
		},
	},
}
