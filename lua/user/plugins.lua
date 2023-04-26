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
		-- use("simrat39/rust-tools.nvim")
		-- use("p00f/clangd_extensions.nvim")
		-- use("b0o/schemastore.nvim")
		-- better code highlighting
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		-- Visual improvements
		use("kyazdani42/nvim-tree.lua")
		use("kyazdani42/nvim-web-devicons")
		use("navarasu/onedark.nvim")
		use("nvim-lualine/lualine.nvim")
		use("stevearc/dressing.nvim")
		-- Generals
		use("tpope/vim-commentary")
		use("jiangmiao/auto-pairs")
		use("APZelos/blamer.nvim")
		use("editorconfig/editorconfig-vim") -- Support for .editorconfig
		-- Copilot
		use("github/copilot.vim")
		-- Git
		use("tpope/vim-fugitive") -- git in nvim
		use("lewis6991/gitsigns.nvim")
		-- Navigations / fuzzyfinding
		use({
			"nvim-telescope/telescope.nvim",
			requires = "nvim-lua/plenary.nvim",
		})
		-- Tag Navigation
		use("simrat39/symbols-outline.nvim")
		use("preservim/tagbar")
		-- Snippets
		use("L3MON4D3/LuaSnip") -- Snippets plugin
		use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp

		-- Debugging
		-- use("mfussenegger/nvim-dap")
		-- use("rcarriga/nvim-dap-ui")

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
