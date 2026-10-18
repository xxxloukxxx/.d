return {
	{
		"echasnovski/mini.misc",
		version = false,
		config = function()
			local misc = require("mini.misc")
			misc.setup_auto_root()
			misc.setup_restore_cursor()
		end,
	},
}
