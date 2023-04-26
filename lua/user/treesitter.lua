require("nvim-treesitter.configs").setup({
	highlight = { enable = true, language_tree = true },
	indent = { enable = true },
	autotag = { enable = true },
	refactor = { highlight_definitions = { enable = true } },
	ensure_installed = {
		"lua",
		"javascript",
		"typescript",
		"tsx",
		"css",
		"json",
		"yaml",
		"html",
		"rust",
		"python",
		"c",
		"vim",
		"vimdoc",
	},
})

-- Experimental -> hit zx if breaks, fold with za / For TreeSitter Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
