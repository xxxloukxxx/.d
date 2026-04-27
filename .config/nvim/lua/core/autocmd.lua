local opt = vim.opt
local api = vim.api

-- Autocommands
api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		opt.relativenumber = false
	end,
})

api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		opt.relativenumber = true
	end,
})

api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	pattern = "term://*", -- Ne s'applique qu'aux buffers de type terminal
	command = "startinsert",
})
