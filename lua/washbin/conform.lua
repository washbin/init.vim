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
