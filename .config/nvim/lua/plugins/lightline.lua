return {
	{
		"itchyny/lightline.vim",
		lazy = false,
		config = function()
			vim.g.lightline = {
				active = {
					left = { { "mode", "paste" }, { "readonly", "filename", "modified" } },
					right = { { "lineinfo" }, { "percent" }, { "filetype" } },
				},
				-- mode_map = {
				-- 	["n"] = "N",
				-- 	["i"] = "I",
				-- 	["R"] = "R",
				-- 	["v"] = "V",
				-- 	["V"] = "V-L",
				-- 	["\22"] = "V-B",
				-- 	["c"] = "C",
				-- 	["t"] = "T",
				-- },
				separator = { left = "", right = "" },
				subseparator = { left = "|", right = "|" },
			}
			vim.opt.laststatus = 2
		end,
	},
}
