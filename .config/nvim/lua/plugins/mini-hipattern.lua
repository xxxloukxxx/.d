return {
	{
		"echasnovski/mini.hipatterns",
		version = false,
		event = "BufReadPost",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				highlighters = {
					-- Surligne uniquement les codes Hexadécimaux (ex: #fce094)
					hex_color = hi.gen_highlighter.hex_color(),
				},
			}
		end,
	},
}
