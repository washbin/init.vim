require('lspconfig').phpactor.setup({
  init_options = {
    ['language_server_phpstan.enabled'] = false,
    ['language_server_psalm.enabled'] = false,
  },
})
require('lspconfig').lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then return end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      },
    })
  end,
  settings = {
    Lua = {},
  },
})
require('lspconfig').elixirls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      },
    },
  },
})
