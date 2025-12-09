require('lint').linters_by_ft = {
  elixir = { 'credo' },
  python = { 'ruff' },

  javascript = { 'biomejs' },
  javascriptreact = { 'biomejs' },
  typescript = { 'biomejs' },
  typescriptreact = { 'biomejs' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function() require('lint').try_lint() end,
})
