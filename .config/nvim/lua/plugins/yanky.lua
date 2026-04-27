return {
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({
				preserve_cursor_position = { enabled = true },
			})
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Yanky put after" })
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Yanky put before" })
			vim.keymap.set("n", "<leader>p", ":Telescope yank_history<CR>", { desc = "Yanky history" })
		end,
	},
}
