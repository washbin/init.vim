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
