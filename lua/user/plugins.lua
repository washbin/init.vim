local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup({
	function(use)
		-- Plugin manager
		use("wbthomason/packer.nvim")
		-- lua util functions
		use("nvim-lua/plenary.nvim")
		-- Lsp / autocompletions
		use("neovim/nvim-lspconfig")
		use("hrsh7th/nvim-cmp") -- Autocompletion plugin
		use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
		use({
			"williamboman/mason.nvim",
			run = ":MasonUpdate", -- :MasonUpdate updates registry contents
		})
		use("williamboman/mason-lspconfig.nvim")
		use("jose-elias-alvarez/null-ls.nvim")
		use("simrat39/rust-tools.nvim")
		use("p00f/clangd_extensions.nvim")
		use("b0o/schemastore.nvim")
		-- better code highlighting
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		-- Visual improvements
		use({
			"navarasu/onedark.nvim",
			config = function()
				require("onedark").setup({
					style = "deep",
				})
				require("onedark").load()
			end,
		})
		use("kyazdani42/nvim-web-devicons")
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("nvim-tree").setup({
					view = {
						side = "right",
					},
				})
			end,
		})
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					tabline = {
						lualine_a = { "buffers" },
						lualine_z = { "tabs" },
					},
					extensions = { "nvim-tree" },
				})
			end,
		})
		use({
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup({})
			end,
		})
		-- Generals
		use("tpope/vim-commentary")
		use("jiangmiao/auto-pairs")
		use("editorconfig/editorconfig-vim") -- Support for .editorconfig
		-- Copilot
		use("github/copilot.vim")
		-- Git
		use("tpope/vim-fugitive")
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup({
					signs = {
						add = { text = "▎" },
						change = { text = "▎" },
						delete = { text = "➤" },
						topdelete = { text = "➤" },
						changedelete = { text = "▎" },
					},
				})
			end,
		})
		-- Navigations / fuzzyfinding
		use("nvim-telescope/telescope.nvim")
		-- Tag Navigation
		use({
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup()
			end,
		})
		use("preservim/tagbar")
		-- Snippets
		use("L3MON4D3/LuaSnip") -- Snippets plugin
		use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
		-- Debugging
		-- use("mfussenegger/nvim-dap")
		-- use("rcarriga/nvim-dap-ui")
		-- Show Intermediate keymaps
		use({
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({})
			end,
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		profile = {
			enable = true,
			threshold = 1,
		},
	},
})
