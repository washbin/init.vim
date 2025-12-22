require('conform').setup({
  formatters_by_ft = {
    c = { 'clang-format' },
    elixir = { 'mix' },
    go = { 'gofmt' },
    heex = { 'mix' },
    lua = { 'stylua' },
    python = {
      'ruff_fix',
      'ruff_format',
      'ruff_organize_imports',
    },
    rust = { 'rustfmt' },

    javascript = { 'biome', 'biome-organize-imports' },
    javascriptreact = { 'biome', 'biome-organize-imports' },
    typescript = { 'biome', 'biome-organize-imports' },
    typescriptreact = { 'biome', 'biome-organize-imports' },
  },
})

local format_group = vim.api.nvim_create_augroup('UserFormatting', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  pattern = '*',
  callback = function(args) require('conform').format({ bufnr = args.buf }) end,
})
