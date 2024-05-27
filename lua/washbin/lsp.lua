-- use lspattach autocommand to only map the following keys
-- after the language server attaches to the current buffer
local keymap = function(mode, key, action, desc)
  local opts = { buffer = ev.buf, desc = desc }
  vim.keymap.set(mode, key, action, opts)
end

local user_lsp_group =
  vim.api.nvim_create_augroup('UserLSPConfig', {}), vim.api.nvim_create_autocmd('LspAttach', {
    group = user_lsp_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.supports_method('textDocument/implementation') then keymap('n', 'gi', vim.lsp.buf.implementation, 'go to implementation') end
    end,
  })

--
-- local lsp = vim.lsp
-- lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'rounded' })
-- lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'rounded' })
--
-- local sign = function(opts)
--   vim.fn.sign_define(opts.name, {
--     texthl = opts.name,
--     text = opts.text,
--     numhl = '',
--   })
-- end
-- sign({ name = 'DiagnosticSignError', text = '✘' })
-- sign({ name = 'DiagnosticSignWarn', text = '▲' })
-- sign({ name = 'DiagnosticSignHint', text = '⚑' })
-- sign({ name = 'DiagnosticSignInfo', text = '' })
--
-- vim.diagnostic.config({
--   virtual_text = false,
--   severity_sort = true,
--   float = {
--     border = 'rounded',
--     source = 'always',
--     -- header = "",
--     -- prefix = "",
--   },
-- })
