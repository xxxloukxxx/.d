return {
	{
		"hat0uma/csvview.nvim",
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
		opts = {
			parser = {
				async = true,
				delimiter = {
					default = { ",", ";", "|", "\t" },
				},
				comments = { "#", "//" },
			},
			view = {
				display_mode = "border",
			},
		},
		config = function(_, opts)
			require("csvview").setup(opts)
		end,
	},
}
