-- Définition du leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap.set

-- Raccourcis d'édition / navigation
keymap("n", "dd", '"_dd')
keymap("n", "d", '"_d')
keymap("n", "c", '"_c')
keymap("n", "<down>", "gj")
keymap("n", "<up>", "gk")
keymap("n", "j", "gj")
keymap("n", "k", "gk")
keymap("i", "jk", "<esc>")
keymap("n", "<leader>z", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap" })

-- Navigation Buffers et Fenêtres (Plus simple que les commandes par défaut)
keymap("n", "<leader>n", ":bn<cr>", { silent = true, desc = "Next buffer" })
keymap("n", "<leader>x", ":bd!<cr>", { silent = true, desc = "Close buffer" })

-- Fichiers & Actions
keymap("n", "<leader>w", ":w!<cr>", { silent = true, desc = "Write" })
keymap("n", "<leader>q", ":q<cr>", { silent = true, desc = "Quit" })
keymap("n", "<leader>e", ":e .<cr>", { silent = true, desc = "File Explorer" })
keymap("n", "<leader>m", ":w<cr>:!make<cr>", { silent = true, desc = "Make" })

-- Remplacements globaux
keymap("n", "<leader>s", ":%s/", { desc = "Search and replace" })
keymap("n", "<leader>r", [[:%s/<C-r><C-w>//g<Left><Left>]], { desc = "Replace word" })

-- Terminal (Ta configuration spécifique)
keymap("n", "<leader>t", function()
	vim.cmd("botright split | term")
	vim.cmd("resize 10")
	vim.cmd("startinsert")
end, { desc = "Terminal" })
keymap("t", "<C-q>", [[<C-\><C-n>]], { silent = true, desc = "Normal mode in terminal" })
keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Terminal unfocus" })

-- Splits rapides vers de nouveaux buffers
keymap("n", "<leader>v", "<cmd>vsplit | enew<CR>", { silent = true, desc = "VSplit" })
keymap("n", "<leader>h", "<cmd>split | enew<CR>", { silent = true, desc = "HSplit" })

-- Les flêches dans le wildmenu
keymap("c", "<Down>", function()
	return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>"
end, { expr = true, replace_keycodes = true })

keymap("c", "<Up>", function()
	return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>"
end, { expr = true, replace_keycodes = true })
