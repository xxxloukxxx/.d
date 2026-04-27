-- if true then
-- 	return {}
-- end
return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_general_viewer = "zathura"
		-- vim.g.vimtex_bookings_enabled = 0
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
			-- continous = 1,
		}
	end,
}
