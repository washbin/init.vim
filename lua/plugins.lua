local use = require("packer").use
require("packer").startup({
  function()
    -- plugin manager
    use("wbthomason/packer.nvim")
    -- lsp / autocompletions
    use({
      "neovim/nvim-lspconfig",
      requires = "williamboman/nvim-lsp-installer",
    })
    use("hrsh7th/nvim-cmp") -- Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
    use("jose-elias-alvarez/null-ls.nvim") -- LSP source for null-ls
    -- snippets
    use("L3MON4D3/LuaSnip") -- Snippets plugin
    use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
    use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
    -- navigations / fuzzyfinding
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
    -- Copilot
    use("github/copilot.vim")
    -- Tag Navigation
    use("preservim/tagbar")
    -- Git
    use("lewis6991/gitsigns.nvim")
    -- visual improvements / highlighting
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
    -- generals
    use("tpope/vim-commentary")
    use("jiangmiao/auto-pairs")
    use("APZelos/blamer.nvim")
    use("nathom/filetype.nvim")
    -- use("metakirby5/codi.vim")
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

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--- Import settings ---
require("lsp_config")
require("nvim_cmp_config")
require("nvim_tree_config")
