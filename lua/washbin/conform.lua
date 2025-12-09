require('conform').setup({
  formatters_by_ft = {
    c = { 'clang-format' },
    elixir = { 'mix' },
    go = { 'gofmt' },
    lua = { 'stylua' },
    nix = { 'nixfmt' },
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

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args) require('conform').format({ bufnr = args.buf }) end,
})
