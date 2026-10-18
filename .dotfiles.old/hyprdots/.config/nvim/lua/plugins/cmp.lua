return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- On le charge seulement quand on commence à taper
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Source : LSP
			"hrsh7th/cmp-buffer", -- Source : Texte du fichier actuel
			"hrsh7th/cmp-path", -- Source : Chemins de fichiers
			"L3MON4D3/LuaSnip", -- Moteur de snippets
			"saadparwaiz1/cmp_luasnip", -- Pont entre cmp et luasnip
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- Force l'apparition du menu
					["<C-e>"] = cmp.mapping.abort(), -- Ferme le menu
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Entrée pour valider

					-- Navigation dans le menu avec Tab / S-Tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- Priorité 1 : Le LSP
					{ name = "luasnip" }, -- Priorité 2 : Snippets
				}, {
					{ name = "buffer" }, -- Priorité 3 : Mots du fichier
					{ name = "path" }, -- Priorité 4 : Chemins de fichiers
				}),
			})
		end,
	},
}
