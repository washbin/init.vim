vim.lsp.enable({
  'clangd',
  'elixirls',
  'gopls',
  'lua_ls',
  'rust_analyzer',
  'tsgo',
  'ty',
})

-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
local user_lsp_group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = user_lsp_group,
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local buffer_group = vim.api.nvim_create_augroup('UserBufLspUI', { clear = true })

    if client:supports_method('textDocument/documentHighlight') then
      vim.api.nvim_create_autocmd('CursorHold', {
        group = buffer_group,
        buffer = args.buf,
        desc = 'Highlight references under cursor',
        callback = function() vim.lsp.buf.document_highlight() end,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        group = buffer_group,
        buffer = args.buf,
        desc = 'Clear highlights on cursor move',
        callback = function() vim.lsp.buf.clear_references() end,
      })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'LSP: goto definition', buffer = args.buf })
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set(
        'n',
        'grh',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
        { desc = 'LSP: inlay hints', buffer = args.buf }
      )
    end

    if client:supports_method('textDocument/codeLens') then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        group = buffer_group,
        buffer = args.buf,
        desc = 'Refresh lsp code lens',
        callback = function() vim.lsp.codelens.refresh({ bufnr = 0 }) end,
      })
      vim.keymap.set('n', 'grc', vim.lsp.codelens.run, { desc = 'LSP: run codeLens', buffer = args.buf })
    end
  end,
})
