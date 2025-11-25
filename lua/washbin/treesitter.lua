local filetypes = {
  'c',
  'css',
  'eex',
  'elixir',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'heex',
  'html',
  'javascript',
  'json',
  'lua',
  'python',
  'rust',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}
require('nvim-treesitter').install(filetypes)

vim.opt.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false -- start with all folds disabled
vim.opt.fillchars = {
  fold = '-', -- trailing symbol in folds
}
vim.opt.foldtext = '' -- preserves syntax highlight for fold start line
vim.api.nvim_set_hl(0, 'Folded', { italic = true }) -- make folded hl-group stand out from normal

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function() vim.treesitter.start() end,
})
