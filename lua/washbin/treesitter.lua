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

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()

    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
