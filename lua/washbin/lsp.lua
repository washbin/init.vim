-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('lspattach', {
  group = vim.api.nvim_create_augroup('userlspconfig', {}),
  callback = function(ev)
    -- enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- buffer local mappings.
    -- see `:help vim.lsp.*` for documentation on any of the below functions
    local keymap = function(mode, key, action, desc)
      local opts = { buffer = ev.buf, desc = desc }
      vim.keymap.set(mode, key, action, opts)
    end
    keymap('n', 'gd', vim.lsp.buf.declaration, 'go to declaration')
    keymap('n', 'gd', vim.lsp.buf.definition, 'go to definition')
    keymap('n', 'K', vim.lsp.buf.hover, 'show hover')
    keymap('n', 'gi', vim.lsp.buf.implementation, 'go to implementation')
    keymap('n', '<C-k>', vim.lsp.buf.signature_help, 'show signature help')
    keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'add workspace folder')
    keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'remove workspace folder')
    keymap(
      'n',
      '<space>wl',
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      'list workspace folders'
    )
    keymap('n', '<space>d', vim.lsp.buf.type_definition, 'go to type definition')
    keymap('n', '<space>rn', vim.lsp.buf.rename, 'rename symbol')
    keymap('n', '<space>sm', vim.lsp.buf.document_symbol, 'document symbols')
    keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, 'code action')
    keymap('n', 'gr', vim.lsp.buf.references, 'references')
    keymap('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, 'format')

    keymap('n', '<space>e', vim.diagnostic.open_float, 'show diagnostics')
    keymap('n', '[d', vim.diagnostic.goto_prev, 'go to previous diagnostic')
    keymap('n', ']d', vim.diagnostic.goto_next, 'go to next diagnostic')
    keymap('n', '<space>q', vim.diagnostic.setloclist, 'set location list')
  end,
})

local lsp = vim.lsp
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'rounded' })
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'rounded' })

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = '',
  })
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    -- header = "",
    -- prefix = "",
  },
})
