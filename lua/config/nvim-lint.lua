require('lint').linters_by_ft = {
  elixir = { 'credo' },
  python = { 'ruff' },

  javascript = { 'biomejs' },
  javascriptreact = { 'biomejs' },
  typescript = { 'biomejs' },
  typescriptreact = { 'biomejs' },
}

local lint_group = vim.api.nvim_create_augroup('UserLinting', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = lint_group,
  callback = function() require('lint').try_lint() end,
})
