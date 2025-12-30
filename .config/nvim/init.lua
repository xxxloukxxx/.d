-- ============================================================================
-- Options de base
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

opt.encoding = "utf-8"
opt.hidden = true
opt.spell = false
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.autoindent = true
opt.autowrite = true
opt.autoread = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.ruler = true
opt.smarttab = true
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.scrolloff = 999
opt.wrap = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showcmd = true
opt.showmatch = true
opt.hlsearch = true
opt.timeoutlen = 500
opt.history = 5000
opt.clipboard = "unnamedplus"
opt.shortmess:append("I")
opt.foldenable = false
opt.laststatus = 2
opt.showmode = false
opt.termguicolors = true
opt.background = "dark"

-- Répertoire undo
local undodir = vim.fn.expand("~/.config/nvim/undo-dir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir
opt.undofile = true

-- Caractères invisibles
opt.listchars = {
	tab = "..",
	trail = "_",
	extends = ">",
	precedes = "<",
	nbsp = "~",
}
opt.showbreak = "\\"
opt.list = true

-- Changer de répertoire automatiquement
opt.autochdir = true

-- ============================================================================
-- Autocommands
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Folding pour les fichiers vim/lua
augroup("filetype_config", { clear = true })
autocmd("FileType", {
	group = "filetype_config",
	pattern = "vim",
	callback = function()
		vim.opt_local.foldmethod = "marker"
	end,
})

-- Navigation dans l'aide
autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.keymap.set("n", "<CR>", "<C-]>", { buffer = true })
		vim.keymap.set("n", "<BS>", "<C-T>", { buffer = true })
	end,
})

-- Toggle relative number
augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	group = "numbertoggle",
	callback = function()
		if vim.opt.number:get() and vim.fn.mode() ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	group = "numbertoggle",
	callback = function()
		if vim.opt.number:get() then
			vim.opt.relativenumber = false
		end
	end,
})

-- ============================================================================
-- Mappings
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Déplacement visuel
keymap("n", "<down>", "gj", opts)
keymap("n", "<up>", "gk", opts)

-- Suppression sans yank
keymap("n", "d", '"_d', opts)
keymap("n", "c", '"_c', opts)
keymap("n", "<del>", '"_x', opts)
keymap("n", "dd", '"_dd', opts)

-- Sortie du mode insertion
keymap("i", "jk", "<esc>", opts)
keymap("i", "JK", "<esc>", opts)

-- ; comme :
keymap("n", ";", ":", { noremap = true })
keymap("v", ";", ":", { noremap = true })

-- Leader mappings
keymap("n", "<leader>e", ":e .<cr>", opts)
keymap("n", "<leader>n", ":bn<cr>", opts)
keymap("n", "<leader>w", ":w!<cr>", opts)
keymap("n", "<leader>q", ":q<cr>", opts)
keymap("n", "<leader><esc><esc>", ":qa!<cr>", opts)
keymap("n", "<leader>m", ":w<cr>:make<cr>", opts)
keymap("n", "<leader>x", ":bd!<cr>", opts)
keymap("n", "<leader>t", ":bot term<cr>:res 10<cr>i", opts)
keymap("t", "<leader><esc>", "<c-\\><c-n>", opts)
keymap("n", "<c-l>", ":nohlsearch<cr>", opts)

-- Gestion des fenêtres
keymap("n", "<leader>v", ":aboveleft vs<cr><c-w><c-w>:enew<cr>", opts)
keymap("n", "<leader>h", ":botright split<cr><c-w><c-w>:enew<cr>", opts)
keymap("n", "<leader>c", ":close<cr>", opts)
keymap("n", "<leader><leader>,", "5<c-w><", opts)
keymap("n", "<leader><leader>.", "5<c-w>>", opts)
keymap("n", "<leader><leader>j", "5<c-w>-", opts)
keymap("n", "<leader><leader>k", "5<c-w>+", opts)

-- Toggle wrap
keymap("n", "<leader>z", ":set wrap!<cr>", opts)

-- Déplacement de lignes
local function swap_lines(n1, n2)
	local line1 = vim.fn.getline(n1)
	local line2 = vim.fn.getline(n2)
	vim.fn.setline(n1, line2)
	vim.fn.setline(n2, line1)
end

local function swap_up()
	local n = vim.fn.line(".")
	if n == 1 then
		return
	end
	swap_lines(n, n - 1)
	vim.cmd(tostring(n - 1))
end

local function swap_down()
	local n = vim.fn.line(".")
	if n == vim.fn.line("$") then
		return
	end
	swap_lines(n, n + 1)
	vim.cmd(tostring(n + 1))
end

keymap("n", "<c-k>", swap_up, opts)
keymap("n", "<c-j>", swap_down, opts)
keymap("v", "<c-k>", ":m '<-2<cr>gv", opts)
keymap("v", "<c-j>", ":m '>+1<cr>gv", opts)

-- Config
keymap("n", "<localleader>v", ":edit $MYVIMRC<cr>", opts)
-- keymap("n", "<localleader>u", ":source $MYVIMRC<cr>", opts)

-- Recherche et remplacement
keymap("n", "<leader>s", ":%s/", { noremap = true })
keymap("n", "<leader>r", ":%s/<c-r><c-w>//g<left><left>", { noremap = true })
keymap("n", "<leader>g", ":g/<c-r><c-w>/", { noremap = true })
keymap("c", "<Down>", "<C-n>", { noremap = true })
keymap("c", "<Up>", "<C-p>", { noremap = true })

-- Commentaires
keymap("n", "<leader>/", "gcc", { remap = true })
keymap("v", "<leader>/", "gc", { remap = true })

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- ============================================================================
-- Plugins
-- ============================================================================

require("lazy").setup({
	-- Colorscheme
	{
		"morhetz/gruvbox",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_contrast_dark = "hard" -- ou 'medium' ou 'soft'
			vim.cmd([[colorscheme gruvbox]])
		end,
	},

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme tokyonight-night]])
	-- 	end,
	-- },

	-- {
	-- 	"Shatur/neovim-ayu",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			mirage = false, -- false = dark, true = mirage
	-- 		})
	-- 		vim.cmd([[colorscheme ayu-dark]])
	-- 	end,
	-- },

	-- {
	--   'mcchrish/zenbones.nvim',
	--   dependencies = 'rktjmp/lush.nvim',
	--   lazy = false,
	--   priority = 1000,
	--   config = function()
	--     vim.cmd([[colorscheme wildcharm]])
	--   end,
	-- },

	-- {
	--   'pauchiner/pastelnight.nvim',
	--   lazy = false,
	--   priority = 1000,
	--   config = function()
	--     vim.cmd([[colorscheme pastelnight]])
	--   end,
	-- },

	-- LSP et autocomplétion (Neovim 0.11 compatible)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls", "texlab" },
			})

			-- Configuration LSP pour Neovim 0.11
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			end

			-- Utilisation de vim.lsp.config pour Neovim 0.11
			local configs = {
				pyright = { on_attach = on_attach },
				lua_ls = {
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				},
				texlab = { on_attach = on_attach },
			}

			for server, config in pairs(configs) do
				vim.lsp.config[server] = config
				vim.lsp.enable(server)
			end
		end,
	},

	-- Autocomplétion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>f", builtin.find_files, opts)
			vim.keymap.set("n", "<leader><leader>b", builtin.buffers, opts)
			vim.keymap.set("n", "<leader><leader>m", builtin.oldfiles, opts)
			vim.keymap.set("n", "<leader><leader>n", builtin.command_history, opts)
			vim.keymap.set("n", "<leader><leader>l", builtin.current_buffer_fuzzy_find, opts)
			vim.keymap.set("n", "<leader><leader>t", ":Telescope<cr>", opts)
		end,
	},

	-- Treesitter pour la coloration syntaxique
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	build = ":TSUpdate",
	-- 	config = function()
	-- 		-- Protection contre l'erreur si treesitter n'est pas encore installé
	-- 		local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
	-- 		if not status_ok then
	-- 			-- vim.notify("Treesitter not installed yet. Restart Neovim after installation.", vim.log.levels.WARN)
	-- 			return
	-- 		end
	--
	-- 		treesitter.setup({
	-- 			ensure_installed = { "python", "lua", "vim", "vimdoc", "latex", "markdown" },
	-- 			highlight = { enable = true },
	-- 			indent = { enable = true },
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					theme = "powerline",
					icons_enabled = false,
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {}, -- Vide au lieu de branch, diff, diagnostics
					lualine_c = { "filename" },
					-- lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	-- Git
	{ "tpope/vim-fugitive" },

	-- Commentaires
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Formatage
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					laxtex = { "latexindent" },
					markdown = { "prettier" },
					python = { "black" },
					lua = { "stylua" },
				},
			})
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true })
			end, opts)
		end,
	},

	-- UndoTree
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)
		end,
	},

	-- LaTeX
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
				},
			}
		end,
	},

	-- Multi-curseur
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},

	-- CSV
	{ "chrisbra/csv.vim", ft = "csv" },

	-- Repeat
	{ "tpope/vim-repeat" },

	-- Targets
	{ "wellle/targets.vim" },
}, {
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- ============================================================================
-- Configuration finale
-- ============================================================================

-- Highlight lors du yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Filetype specific
vim.filetype.add({
	extension = {
		tex = "tex",
	},
})
