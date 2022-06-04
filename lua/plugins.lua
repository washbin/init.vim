local use = require("packer").use
require("packer").startup({
  function()
    -- Plugin manager
    use("wbthomason/packer.nvim")
    -- Lsp / autocompletions
    use({
      "neovim/nvim-lspconfig",
      requires = "williamboman/nvim-lsp-installer",
    })
    use("hrsh7th/nvim-cmp") -- Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
    use("jose-elias-alvarez/null-ls.nvim")
    -- Visual improvements / highlighting
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-tree").setup({ view = { side = "right" } })
      end,
    })
    use("navarasu/onedark.nvim")
    use("nvim-lualine/lualine.nvim")
    use("stevearc/dressing.nvim")
    -- Generals
    use("tpope/vim-commentary")
    use("jiangmiao/auto-pairs")
    use("APZelos/blamer.nvim")
    -- Copilot
    use("github/copilot.vim")
    -- Git
    use("lewis6991/gitsigns.nvim")
    -- Navigations / fuzzyfinding
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        {
          "nvim-lua/plenary.nvim",
          "BurntSushi/ripgrep",
          "nvim-telescope/telescope-fzf-native.nvim",
        },
      },
    })
    -- Tag Navigation
    use("preservim/tagbar")
    -- Snippets
    use("L3MON4D3/LuaSnip") -- Snippets plugin
    use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
    -- Debugging
    -- use("mfussenegger/nvim-dap")
    -- use("rcarriga/nvim-dap-ui")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})

--- Few liner settings ---
require("onedark").setup({
  style = "darker",
})
require("onedark").load()
require("gitsigns").setup()
require("lualine").setup({
  options = { theme = "onedark" },
})
require("nvim-treesitter.configs").setup({
  highlight = { enable = true, language_tree = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  refactor = { highlight_definitions = { enable = true } },
})
require("dressing").setup({})

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect,preview"

--- Import settings ---
require("lsp_config")
require("nvim_cmp_config")
require("nvim_tree_config")
