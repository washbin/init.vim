require('nvim-treesitter.configs').setup({
  highlight = { enable = true, language_tree = true },
  ensure_installed = {
    'c',
    'css',
    'eex',
    'elixir',
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
  },
})

-- Experimental -> hit zx if breaks, fold with za / For TreeSitter Folds
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
