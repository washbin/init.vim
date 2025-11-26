-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
local user_lsp_group = vim.api.nvim_create_augroup('UserLSPConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_lsp_group,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'go to implementation' })
    end

    if client:supports_method('textDocument/documentHighlight') then
      vim.o.updatetime = 250

      -- vim.api.nvim_set_hl(0, 'hl-LspReferenceText', { bg="" })
      -- vim.api.nvim_set_hl(0, 'hl-LspReferenceRead', { bg="" })
      -- vim.api.nvim_set_hl(0, 'hl-LspReferenceWrite', {bg="" })

      vim.api.nvim_create_autocmd('CursorHold', {
        group = user_lsp_group,
        buffer = args.buf,
        desc = 'Highlight references under cursor',
        callback = function() vim.lsp.buf.document_highlight() end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = user_lsp_group,
        buffer = args.buf,
        desc = 'Clear highlights on cursor move',
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end

    -- if
    --   not client:supports_method('textDocument/willSaveWaitUntil')
    --   and client:supports_method('textDocument/formatting')
    -- then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = user_lsp_group,
    --     buffer = args.buf,
    --     desc = 'Format code in current buffer',
    --     callback = function() vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 }) end,
    --   })
    -- end

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'goto definition', buffer = args.buf })
    vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = 'open inline diagnostics', buffer = args.buf })
    vim.keymap.set('n', '<Leader>r', ':LspRestart<CR>', { desc = 'restart lsp', buffer = args.buf })
    vim.keymap.set(
      'n',
      '<Leader>h',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
      { desc = 'Toggle inlay hints', buffer = args.buf }
    )
  end,
})
