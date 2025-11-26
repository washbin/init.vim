vim.opt.foldmethod = 'expr'
vim.opt.foldenable = false -- start with all folds disabled
vim.opt.foldlevel = 99 -- without this all fold are closed on first za
vim.opt.foldnestmax = 4 -- max nested fold
vim.opt.fillchars = {
  fold = '-', -- trailing symbol in folds
}
vim.opt.foldtext = '' -- preserves syntax highlight for fold start line

vim.api.nvim_set_hl(0, 'Folded', { italic = true }) -- make folded hl-group stand out from normal
