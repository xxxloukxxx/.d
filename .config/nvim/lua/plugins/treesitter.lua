return {
	"nvim-treesitter/nvim-treesitter",
	commit = "42fc28ba918343ebfd5565147a42a26580579482",
	build = ":TSUpdate",
	lazy = false,
	priority = 1000,

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"markdown",
				"vim",
				"vimdoc",
				"query",
				"python",
				"c",
				"cpp",
			},
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "latex", "tex" },
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		})
	end,
}
