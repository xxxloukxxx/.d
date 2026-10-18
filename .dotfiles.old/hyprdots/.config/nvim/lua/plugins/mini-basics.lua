return {
	{
		"echasnovski/mini.basics",
		version = false,
		lazy = false,
		config = function()
			require("mini.basics").setup({
				options = {
					basic = true,
					extra_ui = true,
					win_borders = "single",
				},

				mappings = {
					basic = false,
					windows = false,
					option_toggle_prefix = [[\]],
					move_with_alt = false,
				},

				autocommands = {
					basic = true,
					relnum_in_visual_mode = true,
				},
			})
		end,
	},
}
