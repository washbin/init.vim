local use = require('packer').use
require('packer').startup({
    function()
        -- plugin manager
        use 'wbthomason/packer.nvim'
        -- lsp / autocompletions
        use {
            'neovim/nvim-lspconfig',
            requires = 'williamboman/nvim-lsp-installer'
        }
        use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
        use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
        -- snippets
        use 'L3MON4D3/LuaSnip' -- Snippets plugin
        use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
        -- navigations / fuzzyfinding
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                {
                    'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep',
                    'nvim-telescope/telescope-fzf-native.nvim'
                }
            }
        }
        -- visual improvements / highlighting
        use 'nvim-treesitter/nvim-treesitter'
        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require'nvim-tree'.setup {view = {side = 'right'}}
            end
        }
        use 'navarasu/onedark.nvim'
        use 'nvim-lualine/lualine.nvim'
        -- generals
        use 'tpope/vim-commentary'
        use 'jiangmiao/auto-pairs'
        use 'APZelos/blamer.nvim'
        use 'nathom/filetype.nvim'
        -- beta / nightly features
        use 'github/copilot.vim' -- Copilot
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({border = 'single'})
            end
        }
    }
})

require('onedark').setup()
require('lualine').setup()
require('nvim-treesitter.configs').setup {
    highlight = {enable = true, language_tree = true},
    incremental_selection = {enable = true},
    indent = {enable = true},
    autotag = {enable = true},
    refactor = {highlight_definitions = {enable = true}}
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    local opts = {noremap = true, silent = true}
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<space>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<space>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e',
                   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
                   opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
                   opts)
    buf_set_keymap('n', '<space>q',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                       opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f",
                       "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

-- Formatting via efm
local prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true
}
local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintSource = "eslint"
}
local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true
}
local black = {formatCommand = 'black --fast -', formatStdin = true}
local flake8 = {formatCommand = "flake8 -"}
local luaformat = {
    formatCommand = '~/.luarocks/bin/lua-format -i',
    formatStdin = true
}

local languages = {
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    ['typescript.tsx'] = {prettier, eslint},
    ['javascript.jsx'] = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    python = {isort, black, flake8},
    lua = {luaformat}
}

require('nvim-lsp-installer').on_server_ready(function(server)
    if server.name == "efm" then
        server:setup{
            filetypes = vim.tbl_keys(languages),
            init_options = {documentFormatting = true, codeAction = true},
            settings = {
                languages = languages,
                log_level = 1,
                log_file = '~/.efm.log'
            },
            on_attach = on_attach
        }
    elseif server.name == "tsserver" then
        server:setup{
            on_attach = function(client, bufnr)
                client.resolved_capabailities.document_formatting = false
                on_attach(client, bufnr)
            end,
            capabilities = capabilities
        }
    else
        server:setup{on_attach = on_attach, capabilities = capabilities}
    end
end)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end
    },
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}},
    experimental = {native_menu = true, ghost_text = true}
}
