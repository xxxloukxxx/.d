local opt = vim.opt
local api = vim.api

-- Apparence
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 999
opt.shortmess:append("I")
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.softtabstop = 4
opt.signcolumn = "number"
opt.numberwidth = 2
opt.timeoutlen = 400 -- Valeur recommandée (0.3 seconde)
opt.wildoptions = "pum"
opt.wildmode = { "longest:full", "full" }

-- Caractères invisibles
opt.list = true
opt.listchars = { tab = "..", trail = "_", extends = ">", precedes = "<", nbsp = "~" }

-- Comportement du Wrap
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

-- Presse-papier
if vim.fn.has("clipboard") == 1 and vim.env.DISPLAY ~= nil then
	opt.clipboard = "unnamedplus"
else
	opt.clipboard = "autoselectplus"
end
