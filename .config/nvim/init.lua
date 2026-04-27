require("core.options")
require("core.keymaps")
require("core.autocmd")
require("core.usercmd")

-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	ui = {
		icons = {
			cmd = "",
			config = "",
			event = "",
			ft = "",
			init = "",
			keys = "",
			plugin = "",
			runtime = "",
			source = "",
			start = "",
			task = "",
			lazy = "",
		},
	},
})
