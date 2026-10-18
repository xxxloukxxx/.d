-- Treesitter : Coloration syntaxique intelligente
return {
	"nvim-treesitter/nvim-treesitter",
	commit = "69170c9", -- Cela évite de télécharger la version qui demande la 0.12
	build = ":TSUpdate",
	lazy = false,
	priority = 1000,
	opts = {
		ensure_installed = {
			"lua",
			"markdown",
			"vim",
			"vimdoc",
			"query",
			"python",
			"c",
			"cpp",
			"typescript",
			"javascript",
			"latex",
		},
		highlight = {
			enable = true,
			disable = { "latex", "tex" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	},
	config = function(_, opts)
		-- On utilise pcall pour charger le module de config en toute sécurité
		local status, configs = pcall(require, "nvim-treesitter.configs")
		if status then
			configs.setup(opts)
		else
			-- Si le module est introuvable, on informe sans bloquer Neovim
			vim.notify("Treesitter: module 'configs' introuvable.", vim.log.levels.WARN)
		end
	end,
}
