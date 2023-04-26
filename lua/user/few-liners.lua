require("onedark").setup({
	style = "darker",
})
require("onedark").load()

require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "➤" },
		topdelete = { text = "➤" },
		changedelete = { text = "▎" },
	},
})

require("lualine").setup({
	options = { theme = "onedark" },
	tabline = {
		lualine_a = { "buffers" },
		lualine_z = { "tabs" },
	},
	extensions = { "nvim-tree" },
})

require("nvim-tree").setup({
	view = {
		side = "right",
	},
})

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
		"html",
		"rust",
		"python",
		"c",
		"vim",
		"vimdoc",
	},
})

require("dressing").setup({})
require("symbols-outline").setup()
