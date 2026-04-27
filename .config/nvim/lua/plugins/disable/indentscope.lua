return {
	"echasnovski/mini.indentscope",
	version = false,
	event = { "BufReadPost", "BufNewFile" },
	opts = function()
		-- On récupère le plugin pour accéder à ses fonctions de génération
		local indentscope = require("mini.indentscope")

		return {
			symbol = "│",
			draw = {
				delay = 0,
				animation = indentscope.gen_animation.none(),
			},
			options = {
				try_as_border = true,
			},
		}
	end,
	init = function()
		-- Désactivation sur les fenêtres inutiles
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "toggleterm" },
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
