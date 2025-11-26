local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch',
    'main',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  -- add('rebelot/kanagawa.nvim')
  -- vim.cmd('colorscheme kanagawa')
  add('NTBBloodbath/doom-one.nvim')
  vim.cmd.colorscheme('doom-one')
  -- require('doom-one').setup({
  --
  -- })
end)

now(function() require('mini.pairs').setup() end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function()
  require('mini.icons').setup()
  MiniIcons.tweak_lsp_kind() -- for icons in mini.completion
end)
now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)

now(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = {
      post_checkout = function() vim.cmd('TSUpdate') end,
    },
  })
  require('washbin.treesitter')
end)

now(function() add('neovim/nvim-lspconfig') end)

later(function()
  add('mfussenegger/nvim-lint')
  require('lint').linters_by_ft = {
    markdown = { 'vale' },
    javascript = { 'biomejs' }, --{ 'eslint' },
    javascriptreact = { 'biomejs' },
    typescript = { 'biomejs' },
    typescriptreact = { 'biomejs' },
    nix = { 'nix' },
    php = { 'phpcs' },
  }
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function() require('lint').try_lint() end,
  })
end)
later(function()
  add('stevearc/conform.nvim')
  local jsformat = function(bufnr)
    if require('conform').get_formatter_info('prettier', bufnr).available then
      return { 'prettier' }
    else
      return { 'biome', 'biome-organize-imports' }
    end
  end

  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixpkgs_fmt' },
      rust = { 'rustfmt' },
      elixir = { 'mix' },
      python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' }, -- { 'isort', 'black' }, stop_after_first = true },
      go = { 'goimports', 'gofmt' },
      javascript = jsformat,
      typescript = jsformat,
      javascriptreact = jsformat,
      typescriptreact = jsformat,
    },
  })
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args) require('conform').format({ bufnr = args.buf }) end,
  })
end)

later(function()
  require('mini.completion').setup({
    window = {
      info = {
        height = -1,
        width = -1,
        border = 'rounded',
      },
      signature = {
        height = -1,
        width = -1,
        border = 'rounded',
      },
    },
  })
  require('mini.snippets').setup() -- better handling of snippets
end)
later(function()
  require('mini.pick').setup()
  vim.keymap.set('n', '<Leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find files' })
  vim.keymap.set('n', '<Leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Live Grep' })
  vim.keymap.set('n', '<Leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
  vim.keymap.set('n', '<Leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find help' })
end)

later(function() require('washbin.clue') end)

later(function()
  require('mini.diff').setup()
  vim.keymap.set('n', '<Leader>t', MiniDiff.toggle_overlay, { desc = 'Toggle diff overlay' })
  require('mini.git').setup()
end)

later(function()
  require('mini.files').setup()
  local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
  end
  vim.keymap.set('n', '<Leader>e', minifiles_toggle, { desc = 'Toggle MiniFiles' })
end)

later(function()
  add({
    source = 'mikavilpas/yazi.nvim',
    depends = { 'nvim-lua/plenary.nvim' },
  })
  vim.keymap.set('n', '<leader>y', function() require('yazi').yazi() end, { desc = 'Toggle Yazi' })
  vim.g.loaded_netrwPlugin = 1
  vim.api.nvim_create_autocmd('UIEnter', {
    callback = function()
      require('yazi').setup({
        open_for_directories = true,
      })
    end,
  })
end)
--
-- later(function()
--   add('github/copilot.vim')
--   vim.g.copilot_no_tab_map = true
--   vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
--     expr = true,
--     replace_keycodes = false,
--     silent = true,
--   })
-- end)

now(function()
  add({
    source = 'm4xshen/hardtime.nvim',
    depends = { 'MunifTanjim/nui.nvim' },
  })
  require('hardtime').setup({
    max_count = 15,
  })

  add('tris203/precognition.nvim')
  -- require('precognition').toggle()
end)
