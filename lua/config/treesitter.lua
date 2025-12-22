local filetypes = {
  'bash',
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
  'jsx',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'regex',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'zsh',
}
require('nvim-treesitter').install(filetypes)

local treesitter_group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = treesitter_group,
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()

    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
