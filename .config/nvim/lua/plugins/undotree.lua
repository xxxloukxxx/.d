return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader><leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
			local target_path = vim.fn.stdpath("data") .. "/undo"
			if vim.fn.isdirectory(target_path) == 0 then
				vim.fn.mkdir(target_path, "p", 448)
			end
			vim.opt.undodir = target_path
			vim.opt.undofile = true
		end,
	},
}
