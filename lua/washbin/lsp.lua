-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
local user_lsp_group = vim.api.nvim_create_augroup('UserLSPConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'go to implementation' })
    end
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, { desc = 'code action' })
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = 'rename symbol' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'goto definition' })
    vim.keymap.set('n', '<Leader>d', vim.lsp.buf.type_definition, { desc = 'goto type definition' })
    vim.keymap.set('n', '<Leader>sm', vim.lsp.buf.document_symbol, { desc = 'list document symbols' })
    vim.keymap.set('n', '<Leader>rf', vim.lsp.buf.references, { desc = 'list symbol references' })
  end,
})

local lsp = vim.lsp
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'rounded' })
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'rounded' })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
})
